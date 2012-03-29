<?xml version="1.0" encoding="UTF-8"?>
<!--
  =====================================================================================
  =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95  ==  Titlepage Module  =
  =====================================================================================
  
  Status:		TEST
  Contact:       mssa.systems@yale.edu, michael.rush@yale.edu
  Created:	2008-05-13
  Updated:     2010-03-15
  
-->
<xsl:stylesheet version = "1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:svg="http://www.w3.org/TR/SVG"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xml.apache.org/fop/extensions"
  xmlns:ead="urn:isbn:1-931666-22-9">
  
  <!-- Hide elements with altrender nodisplay and internal audience attributes-->
  <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="titlepage"/>-->
  <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="titlepage"/>-->
  
  
  <!-- Titlepage <publisher> Template -->
  <xsl:template match="ead:publisher" mode="titlepage">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.publisher">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage <publicationstmt> Copyright paragraph Template -->
  <xsl:template match="ead:publicationstmt/ead:p" mode="titlepage">
    <xsl:apply-templates select="." mode="block"/>
  </xsl:template>
  
  <!-- Titlepage <titleproper> Template -->
  <xsl:template match="ead:titleproper[not(@type='filing')]" mode="titlepage">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.titleproper">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage <subtitle> Template -->
  <xsl:template match="ead:subtitle" mode="titlepage">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.subtitle">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage Call Number/<unitid> Template -->
  <xsl:template name="titlepage.unitid">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.unitid">
      <xsl:choose>
        <xsl:when test="ead:filedesc/ead:titlestmt/ead:titleproper[not(@type='filing')]/ead:num">
          <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:titleproper[not(@type='filing')]/ead:num" mode="inline">
            <xsl:with-param name="titleproperInclude">
              <xsl:text>yes</xsl:text>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/ead:ead/ead:archdesc/ead:did/ead:unitid[1]"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage Image Template -->
  <xsl:template name="titlepage.image">
    <xsl:choose>
      <xsl:when test="$repository_code='mssa'">
        <xsl:element name="fo:block" use-attribute-sets="titlepage.image">
          <fo:external-graphic src="url(http://www.library.yale.edu/facc/images/yalebw.jpg)" content-height="2.5cm"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$repository_code='divinity'">
        <xsl:element name="fo:block" use-attribute-sets="titlepage.image">
          <fo:external-graphic src="url(http://www.library.yale.edu/facc/images/divshield.jpg)" content-height="2cm"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$repository_code='med'">
        <xsl:element name="fo:block" use-attribute-sets="titlepage.image">
          <fo:external-graphic src="url(http://www.library.yale.edu/facc/images/medshield.jpg)" content-height="2.5cm"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>
  
  <!-- Titlepage <note  type="frontmatter"> Template -->
  <xsl:template match="ead:note[@type='frontmatter']" mode="titlepage">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.note.frontmatter">
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage <author> Template -->
  <xsl:template match="ead:author" mode="titlepage">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.author">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage <sponsor> Template -->
  <xsl:template match="ead:sponsor" mode="titlepage">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.sponsor">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage Publication <date> Template -->
  <xsl:template name="publicationstmt.dates">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.dates">
      <xsl:for-each select="ead:filedesc/ead:publicationstmt/ead:date[@type='original']">
        <fo:block>
          <!--<xsl:value-of select="$original_date_label"/><xsl:text> </xsl:text>-->
          <xsl:apply-templates mode="inline"/>
        </fo:block>
      </xsl:for-each>
      
      <xsl:if test="not(ead:filedesc/ead:publicationstmt/ead:date[@type='original'])">
        <xsl:for-each select="ead:filedesc/ead:publicationstmt/ead:date[@type='ead']">
          <fo:block>
            <xsl:value-of select="$ead_date_label"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates mode="inline"/>
          </fo:block>
        </xsl:for-each>
      </xsl:if>
      
      <xsl:for-each select="ead:filedesc/ead:publicationstmt/ead:date[@type='copyright']">
        <fo:block>
          <xsl:value-of select="$copyright_date_label"/><xsl:text> </xsl:text>
          <xsl:apply-templates mode="inline"/>
        </fo:block>
      </xsl:for-each>
      
      <xsl:choose>
        <xsl:when
          test="/ead:ead//ead:publicationstmt/ead:date[@type='revised'] and not(/ead:ead//ead:revisiondesc/ead:change/ead:date)">
          <fo:block>
            <xsl:value-of select="$revised_date_label"/><xsl:text> </xsl:text>
            <xsl:for-each
              select="/ead:ead//ead:publicationstmt/ead:date[@type='revised']">
              <xsl:sort select="@normal" order="descending"/>
              <xsl:if test="position()=1">
                <xsl:apply-templates mode="inline"/>
              </xsl:if>
            </xsl:for-each>
          </fo:block>
        </xsl:when>
        <xsl:when
          test="not(/ead:ead//ead:publicationstmt/ead:date[@type='revised']) and /ead:ead//ead:revisiondesc/ead:change/ead:date">
          <fo:block>
            <xsl:value-of select="$revised_date_label"/><xsl:text> </xsl:text>
            <xsl:for-each
              select="/ead:ead//ead:revisiondesc/ead:change">
              <xsl:sort select="ead:date/@normal" order="descending"/>
              <xsl:if test="position()=1">
                <xsl:apply-templates select="ead:date" mode="inline"/>
              </xsl:if>
            </xsl:for-each>
          </fo:block>
        </xsl:when>
        <xsl:when
          test="/ead:ead//ead:publicationstmt/ead:date[@type='revised'] and /ead:ead//ead:revisiondesc/ead:change/ead:date">
          <xsl:variable name="revisedDateLastNormal">
            <xsl:for-each
              select="/ead:ead//ead:publicationstmt/ead:date[@type='revised']">
              <xsl:sort select="@normal" order="descending"/>
              <xsl:if test="position()=1">
                <xsl:value-of select="@normal"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="revisedDateLast">
            <xsl:choose>
              <xsl:when test="string-length(translate($revisedDateLastNormal,'-',''))=4">
                <xsl:value-of select="concat(translate($revisedDateLastNormal,'-',''),'0000')"/>
              </xsl:when>
              <xsl:when test="string-length(translate($revisedDateLastNormal,'-',''))=6">
                <xsl:value-of select="concat(translate($revisedDateLastNormal,'-',''),'00')"/>
              </xsl:when>
              <xsl:when test="string-length(translate($revisedDateLastNormal,'-',''))=8">
                <xsl:value-of select="translate($revisedDateLastNormal,'-','')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="translate($revisedDateLastNormal,'-','')"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="changeDateLastNormal">
            <xsl:for-each
              select="/ead:ead//ead:revisiondesc/ead:change">
              <xsl:sort select="ead:date/@normal" order="descending"/>
              <xsl:if test="position()=1">
                <xsl:value-of select="ead:date/@normal"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:variable>
          <xsl:variable name="changeDateLast">
            <xsl:choose>
              <xsl:when test="string-length(translate($changeDateLastNormal,'-',''))=4">
                <xsl:value-of select="concat(translate($changeDateLastNormal,'-',''),'0000')"/>
              </xsl:when>
              <xsl:when test="string-length(translate($changeDateLastNormal,'-',''))=6">
                <xsl:value-of select="concat(translate($changeDateLastNormal,'-',''),'00')"/>
              </xsl:when>
              <xsl:when test="string-length(translate($changeDateLastNormal,'-',''))=8">
                <xsl:value-of select="translate($changeDateLastNormal,'-','')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="translate($changeDateLastNormal,'-','')"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <fo:block>
            <xsl:value-of select="$revised_date_label"/><xsl:text> </xsl:text>
            <xsl:choose>
              <xsl:when test="$changeDateLast &gt; $revisedDateLast">
                <xsl:for-each
                  select="/ead:ead//ead:revisiondesc/ead:change">
                  <xsl:sort select="ead:date/@normal" order="descending"/>
                  <xsl:if test="position()=1">
                    <xsl:apply-templates select="ead:date"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:when>
              <xsl:when test="$revisedDateLast &gt; $changeDateLast">
                <xsl:for-each
                  select="/ead:ead//ead:publicationstmt/ead:date[@type='revised']">
                  <xsl:sort select="@normal" order="descending"/>
                  <xsl:if test="position()=1">
                    <xsl:apply-templates/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:message>test otherwise</xsl:message>
                <xsl:for-each
                  select="/ead:ead//ead:revisiondesc/ead:change">
                  <xsl:sort select="ead:date/@normal" order="descending"/>
                  <xsl:if test="position()=1">
                    <xsl:apply-templates select="ead:date"/>
                  </xsl:if>
                </xsl:for-each>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>
        </xsl:when>
      </xsl:choose>
      
    </xsl:element>
  </xsl:template>
  
  <!-- Titlepage Publication <address> Template -->
  <xsl:template name="publicationstmt.address">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.publicationstmt.address">
      <xsl:choose>
        <xsl:when test="ead:filedesc/ead:publicationstmt/ead:address">
          <xsl:apply-templates select="ead:filedesc/ead:publicationstmt/ead:address" mode="block"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$publishplace" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  
  <!-- Finding aid handle citation template -->
  <xsl:template name="findingAidHandleCitation">
    <xsl:element name="fo:block" use-attribute-sets="titlepage.findingAidHandleCitation">
      <xsl:text>To cite or bookmark this finding aid, use the following address: </xsl:text>
      <fo:wrapper color="{$linkcolor}">
        <xsl:element name="fo:basic-link">
          <xsl:attribute name="external-destination">
            <xsl:value-of select="$handleURL"/>
          </xsl:attribute>
          <xsl:value-of select="$handleURL"/>
        </xsl:element>
      </fo:wrapper>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
