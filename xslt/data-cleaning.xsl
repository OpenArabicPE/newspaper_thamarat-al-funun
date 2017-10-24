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
    
    <!-- add page breaks -->
    <xsl:template match="tei:list">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:for-each-group select="tei:item" group-by=" replace(tei:bibl/text()[1],'(\d+)\s*.+$','$1')">
                <xsl:variable name="v_page-no" select="current-grouping-key()"/>
                <xsl:message>
                    <xsl:value-of select="$v_page-no"/>
                </xsl:message>
                <xsl:element name="pb">
                    <xsl:attribute name="ed" select="'print'"/>
                    <xsl:attribute name="n" select="$v_page-no"/>
                </xsl:element>
                <xsl:apply-templates select="current-group()"/>
            </xsl:for-each-group>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>