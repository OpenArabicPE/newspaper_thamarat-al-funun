<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="2.0">

    <!-- identity transform -->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:include href="../../../xslt-functions/functions_core.xsl"/>
    <xsl:template match="/">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:TEI/tei:text">
        <xsl:copy>
            <xsl:element name="tei:listBibl">
                <xsl:variable name="v_biblStructs">
                    <xsl:for-each select="descendant::tei:biblStruct">
                        <xsl:sort select="descendant::tei:biblScope[@type = 'issue']"
                            data-type="number" order="ascending"/>
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:for-each select="$v_biblStructs/descendant-or-self::tei:biblStruct">
                    <xsl:copy-of select="."/>
                    <!-- check if there is a gap between this biblStruct and the next one in terms of issue numbers -->
                    <xsl:variable name="v_issue-self" select="descendant::tei:biblScope[@unit = 'issue']/@from"/>
                    <xsl:variable name="v_issue-next" select="following-sibling::tei:biblStruct[1]/descendant::tei:biblScope[@unit = 'issue']/@from"/>
                    <xsl:if
                        test="$v_issue-self + 1 != $v_issue-next">
                        <xsl:value-of select="concat('&lt;!-- gap of ',$v_issue-next - $v_issue-self - 1,' issues between #',$v_issue-self,' and #',$v_issue-next,' --&gt;')" disable-output-escaping="yes"/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:element>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:biblStruct">
        <xsl:copy>
            <xsl:apply-templates/>
            <!-- additional parameters  -->
            <!-- $p_weekdays-published contains a comma-separated list of weekdays in English -->
            <note n="p_weekdays-published" type="param">Monday</note>
            <!--  $p_step sets incremental steps for the input to be iterated upon. Values are:
        - daily: this includes any publication cycle that is at least weekly
        - fortnightly:
        - monthly: -->
            <note n="p_step" type="param">daily</note>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:monogr">
        <xsl:copy>
            <xsl:apply-templates select="tei:title"/>
            <!-- use as many identifiers as appropriate -->
            <idno type="oclc" xml:lang="en">792755216</idno>
            <idno type="oclc" xml:lang="en">745202659</idno>
            <idno type="oclc" xml:lang="en">915538205</idno>
            <idno type="oclc" xml:lang="en">30431084</idno>
            <idno type="oclc" xml:lang="en">499946128</idno>
            <idno type="oclc" xml:lang="en">177646790</idno>
            <editor xml:lang="en" ref="viaf:88341780">
                <persName xml:lang="ar">
                    <forename>عبد القادر</forename>
                    <surname>قباني</surname>
                </persName>
                <persName xml:lang="ar-Latn-x-ijmes">
                    <forename>ʿAbd al-Qādir</forename>
                    <surname>Qabbānī</surname>
                </persName>
            </editor>
            <xsl:apply-templates select="tei:imprint"/>
            <xsl:apply-templates select="descendant::tei:biblScope"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:imprint">
        <xsl:copy>
            <publisher xml:lang="en">
                <orgName xml:lang="ar">مطبعة جمعية الفنون</orgName>
                <orgName xml:lang="ar-Latn-x-ijmes">Maṭbaʿa Jamʿiyyat al-Funūn</orgName>
            </publisher>
            <pubPlace xml:lang="en">
                <placeName xml:lang="ar">بيروت</placeName>
                <placeName xml:lang="ar-Latn-x-ijmes">Bayrūt</placeName>
                <placeName xml:lang="en">Beirut</placeName>
                <placeName xml:lang="fr">Beyrouth</placeName>
            </pubPlace>
            <xsl:apply-templates select="tei:date"/>
        </xsl:copy>
    </xsl:template>

    <!-- fix title and enrich data -->
    <xsl:template match="tei:title">
        <title level="j" xml:lang="ar">ثمرات الفنون</title>
        <title level="j" type="sub" xml:lang="ar"
            >ان هذه الصحيفة تحتوي على حوادث سياسية ومحلية وفنون</title>
        <title level="j" type="sub" xml:lang="ar">صدورها في يوم الاثنين من كل اسبوع</title>
        <title level="j" xml:lang="ar-Latn-x-ijmes">Thamarāt al-Funūn</title>
        <title level="j" type="sub" xml:lang="ar-Latn-x-ijmes"
            >Inna hadhihi al-ṣaḥīfa taḥtawī ʿalā ḥawādith siyāsiyya wa-maḥalliyya wa-funūn</title>
        <title level="j" type="sub" xml:lang="ar-Latn-x-ijmes"
            >ṣudūruhā fī yawm al-ithnayn min kull usbūʿ</title>
    </xsl:template>

    <!-- add dates from other calendars -->
    <xsl:template match="tei:date">
        <xsl:variable name="v_date" select="@when"/>
        <!-- Gregorian date -->
        <xsl:copy>
            <xsl:attribute name="datingMethod" select="'#cal_gregorian'"/>
            <xsl:attribute name="calendar" select="'#cal_gregorian'"/>
            <xsl:attribute name="when" select="$v_date"/>
            <xsl:attribute name="xml:lang" select="'en'"/>
            <xsl:attribute name="type" select="'official'"/>
            <!-- reformat the content -->
            <xsl:value-of select="format-date($v_date, '[D1]')"/>
            <xsl:text> </xsl:text>
            <xsl:call-template name="funcDateMonthNameNumber">
                <xsl:with-param name="pDate" select="$v_date"/>
                <xsl:with-param name="pLang" select="'GEnFull'"/>
                <xsl:with-param name="pMode" select="'name'"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:value-of select="format-date($v_date, '[Y1]')"/>
        </xsl:copy>
        <!-- add Islamic dates -->
        <xsl:variable name="v_date-hijri">
            <xsl:call-template name="funcDateG2H">
                <xsl:with-param name="pDateG" select="$v_date"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:element name="tei:date">
            <xsl:attribute name="type" select="'computed'"/>
            <xsl:attribute name="datingMethod" select="'#cal_islamic'"/>
            <xsl:attribute name="calendar" select="'#cal_islamic'"/>
            <xsl:attribute name="when" select="$v_date"/>
            <xsl:attribute name="when-custom" select="$v_date-hijri"/>
            <xsl:attribute name="xml:lang" select="'ar-Latn-x-ijmes'"/>
            <!-- content -->
            <xsl:value-of select="format-number(number(tokenize($v_date-hijri, '-')[3]), '0')"/>
            <xsl:text> </xsl:text>
            <xsl:call-template name="funcDateMonthNameNumber">
                <xsl:with-param name="pDate" select="$v_date-hijri"/>
                <xsl:with-param name="pLang" select="'HIjmesFull'"/>
                <xsl:with-param name="pMode" select="'name'"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:value-of select="format-number(number(tokenize($v_date-hijri, '-')[1]), '0')"/>
        </xsl:element>
        <!-- add Julian dates -->
        <xsl:variable name="v_date-julian">
            <xsl:call-template name="funcDateG2J">
                <xsl:with-param name="pDateG" select="$v_date"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:element name="tei:date">
            <xsl:attribute name="type" select="'official'"/>
            <xsl:attribute name="datingMethod" select="'#cal_julian'"/>
            <xsl:attribute name="calendar" select="'#cal_julian'"/>
            <xsl:attribute name="when" select="$v_date"/>
            <xsl:attribute name="when-custom" select="$v_date-julian"/>
            <xsl:attribute name="xml:lang" select="'ar-Latn-x-ijmes'"/>
            <!-- content -->
            <xsl:value-of select="format-number(number(tokenize($v_date-julian, '-')[3]), '0')"/>
            <xsl:text> </xsl:text>
            <xsl:call-template name="funcDateMonthNameNumber">
                <xsl:with-param name="pDate" select="$v_date-julian"/>
                <xsl:with-param name="pLang" select="'JIjmesFull'"/>
                <xsl:with-param name="pMode" select="'name'"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:value-of select="format-number(number(tokenize($v_date-julian, '-')[1]), '0')"/>
        </xsl:element>
    </xsl:template>

    <!-- fix biblScope and update to most recent TEI guidelines -->
    <xsl:template match="tei:biblScope">
        <xsl:copy>
            <xsl:attribute name="unit">
                <xsl:choose>
                    <xsl:when test="@type = 'vol'">
                        <xsl:text>volume</xsl:text>
                    </xsl:when>
                    <xsl:when test="@type = 'pp'">
                        <xsl:text>page</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@type"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <!-- add @from and @to -->
            <xsl:variable name="v_from">
                <xsl:value-of select="replace(., '(\d+)-?(\d+)?', '$1')"/>
            </xsl:variable>
            <xsl:variable name="v_to">
                <xsl:choose>
                    <xsl:when test="matches(., '\d+-\d+')">
                        <xsl:value-of select="replace(., '(\d+)-(\d+)', '$2')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$v_from"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="from" select="$v_from"/>
            <xsl:attribute name="to" select="$v_to"/>
            <xsl:value-of select="."/>
        </xsl:copy>
    </xsl:template>

    <!-- supress output -->
    <xsl:template match="tei:facsimile | tei:idno | tei:title[@level = 'a']"/>

</xsl:stylesheet>
