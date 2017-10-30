<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
    
    <!-- identity transformation -->
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:variable name="v_bibl-master" select="document('../tei/thamarat-al-funun.TEIP5.xml')/descendant::tei:text/descendant::tei:biblStruct"/>
    
    <xsl:template match="tei:bibl">
        <xsl:variable name="v_volume" select="descendant::tei:biblScope[@unit='volume']/@from"/>
        <xsl:variable name="v_issue" select="descendant::tei:biblScope[@unit='issue']/@from"/>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                    <xsl:if test="not(descendant::tei:date) and $v_bibl-master/descendant-or-self::tei:biblStruct[descendant::tei:biblScope[@unit='volume']/@from=$v_volume][descendant::tei:biblScope[@unit='issue']/@from=$v_issue]">
                       <xsl:text>, </xsl:text>
                        <xsl:element name="tei:add">
                           <xsl:attribute name="resp" select="'#pers_TG'"/>
                           <xsl:element name="tei:date">
                               <xsl:attribute name="xml:lang" select="'en'"/>
                            <xsl:attribute name="when">
                                <xsl:value-of select="$v_bibl-master/descendant-or-self::tei:biblStruct[descendant::tei:biblScope[@unit='volume']/@from=$v_volume][descendant::tei:biblScope[@unit='issue']/@from=$v_issue]/descendant::tei:date[1]/@when"/>
                            </xsl:attribute>
                               <xsl:value-of select="format-date($v_bibl-master/descendant-or-self::tei:biblStruct[descendant::tei:biblScope[@unit='volume']/@from=$v_volume][descendant::tei:biblScope[@unit='issue']/@from=$v_issue]/descendant::tei:date[1]/@when,'[D0] [MNn] [Y0001]')"/>
                        </xsl:element>
                       </xsl:element>
                    </xsl:if>
                </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>