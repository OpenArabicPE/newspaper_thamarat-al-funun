<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    
    <!-- identify the author of the change by means of a @xml:id -->
<!--    <xsl:param name="p_id-editor" select="'pers_TG'"/>-->
    <xsl:include href="../../oxygen-project/OpenArabicPE_parameters.xsl"/>
    
    <!-- identity transformation -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:variable name="v_bibl-master" select="document('../metadata/thamarat-al-funun.TEIP5.xml')"/>
    <xsl:variable name="v_bibls" select="$v_bibl-master/descendant::tei:text/descendant::tei:biblStruct"/>
    
    <xsl:template match="tei:item">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <!-- apply directly to the containt <bibl> in order to replace wrapping <ref>s -->
            <xsl:apply-templates select="descendant::tei:bibl"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
<!--        <xsl:variable name="v_volume" select="descendant::tei:biblScope[@unit='volume']/@from"/>-->
        <xsl:variable name="v_issue" select="descendant::tei:biblScope[@unit='issue']/@from"/>
        <xsl:variable name="v_page" select="descendant::tei:biblScope[@unit='page']/@from"/>
        <xsl:choose>
            <!-- from close reading of the index it becomes clear that volume numbers are less reliable than issue numbers. I therefore removed the comparison of volume numbers -->
            <!-- the following is only applied to those <bibl>s that have an issue number which is also present in the metadata file -->
            <xsl:when test="$v_bibls/descendant-or-self::tei:biblStruct[descendant::tei:biblScope[@unit='issue']/@from=$v_issue]">
                <!-- get the link to the relevant TEI file for this issue -->
                <xsl:variable name="v_url-issue" select="concat('../xml/oclc_792755216-i_',$v_issue,'.TEIP5.xml')"/>
                <xsl:variable name="v_tei-issue" select="document($v_url-issue)"/>
                <!-- get the @xml:id of the relevant page break -->
                <xsl:variable name="v_pb-id" select="$v_tei-issue/descendant::tei:pb[@n=$v_page]/@xml:id"/>
                <!-- get the publication date of this issue from the metadata file -->
<!--                <xsl:variable name="v_bibl" select="$v_bibls/descendant-or-self::tei:biblStruct[descendant::tei:biblScope[@unit='issue']/@from=$v_issue]"/>-->
                <xsl:variable name="v_date-publication" select="$v_bibls/descendant-or-self::tei:biblStruct[descendant::tei:biblScope[@unit='issue']/@from=$v_issue]/tei:monogr/tei:imprint/tei:date[1]/@when"/>
                <!-- wrap the bibl in a link to the TEI file for this issue -->
                <xsl:element name="tei:ref">
                    <xsl:attribute name="target" select="concat($v_url-issue,'#',$v_pb-id)"/>
                    <xsl:attribute name="change" select="concat('#',$p_id-change)"/>
                    <xsl:copy>
                        <xsl:apply-templates select="@* | node()"/>
                        <!-- add publication date if not yet present -->
                        <xsl:if test="not(descendant::tei:date)">
                            <xsl:text>, </xsl:text>
                            <xsl:element name="tei:add">
                                <xsl:attribute name="resp" select="'#pers_TG'"/>
                                <xsl:element name="tei:date">
                                    <xsl:attribute name="xml:lang" select="'en'"/>
                                    <xsl:attribute name="when" select="$v_date-publication"/>
                                    <xsl:attribute name="change" select="concat('#',$p_id-change)"/>
                                    <xsl:value-of select="format-date($v_date-publication,'[D0] [MNn] [Y0001]')"/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:if>
                    </xsl:copy>
                </xsl:element>
            </xsl:when>
            <!-- fall-back option -->
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- document the changes -->
    <xsl:template match="tei:revisionDesc" priority="100">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="tei:change">
                <xsl:attribute name="when" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="who" select="concat('#',$p_id-editor)"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:text>Wrapped </xsl:text><tei:gi>bibl</tei:gi><xsl:text> nodes in </xsl:text><tei:gi>ref</tei:gi><xsl:text> pointing to a corresponding TEI file based on similar issue numbers.</xsl:text>
            </xsl:element>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>