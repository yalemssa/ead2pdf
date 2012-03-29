<?xml version="1.0" encoding="UTF-8"?>
<!--
  =================================================================================
  =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95  ==  c0x Module   =
  =================================================================================

Status:		TEST
Contact:       mssa.systems@yale.edu, michael.rush@yale.edu
Created:	2007-11-15
Updated:     2010-05-26

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
  <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="c0x"/>-->
  <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="c0x"/>-->
  
  <!-- pattern for $containerpattern, which keys test for which container columns to include, when it tests just the current c01. -->
  <xsl:template name="containerpatternParamC01">
    <xsl:choose>
      <xsl:when
        test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>bfr</xsl:text>
      </xsl:when>
      <xsl:when
        test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>bf</xsl:text>
      </xsl:when>
      <xsl:when
        test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>br</xsl:text>
      </xsl:when>
      <xsl:when
        test="(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>b</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>fr</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and (ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>f</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and (ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>r</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:c01//ead:container[@type='Box']) and not(ancestor-or-self::ead:c01//ead:container[@type='Folder']) and not(ancestor-or-self::ead:c01//ead:container[@type='Reel'])">
        <xsl:text>none</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>none</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- pattern for $containerpattern, which keys test for which container columns to include, when it tests the entire dsc. -->
  <xsl:template name="containerpatternParamDsc">
    <xsl:choose>
      <xsl:when
        test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>bfr</xsl:text>
      </xsl:when>
      <xsl:when
        test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>bf</xsl:text>
      </xsl:when>
      <xsl:when
        test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>br</xsl:text>
      </xsl:when>
      <xsl:when
        test="(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>b</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>fr</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and (ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>f</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and (ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>r</xsl:text>
      </xsl:when>
      <xsl:when
        test="not(ancestor-or-self::ead:dsc//ead:container[@type='Box']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Folder']) and not(ancestor-or-self::ead:dsc//ead:container[@type='Reel'])">
        <xsl:text>none</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>none</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- This template uses $containerpattern to create sets of <fo:table-column> elements for each container pattern -->
  <xsl:template name="container.table-columns">
    <xsl:param name="containerpattern">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:call-template name="containerpatternParamC01"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="containerpatternParamDsc"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$containerpattern='bfr'">
        <fo:table-column column-width="1.5cm" />
        <fo:table-column column-width="1.5cm" />
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='bf'">
        <fo:table-column column-width="1.5cm" />
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='br'">
        <fo:table-column column-width="1.5cm" />
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='b'">
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='fr'">
        <fo:table-column column-width="1.5cm" />
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='f'">
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='r'">
        <fo:table-column column-width="1.5cm" />
      </xsl:when>
      <xsl:when test="$containerpattern='none'"/>
    </xsl:choose>
  </xsl:template>
  
  <!-- This template uses both $containerpattern and $includeunitdatecolumn to create sets of <fo:table-column> 
    elements for the Description column and when necessary the Dates column -->
  <xsl:template name="desc.table-columns">
    <xsl:param name="includeunitdatecolumn"/>
    <xsl:param name="containerpattern">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:call-template name="containerpatternParamC01"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="containerpatternParamDsc"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="($includeunitdatecolumn='y') and ($containerpattern='bfr')">
        <fo:table-column column-width="9.5cm" />
        <fo:table-column column-width="3cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='y') and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr')">
        <fo:table-column column-width="11cm" />
        <fo:table-column column-width="3cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='y') and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r')">
        <fo:table-column column-width="12.5cm" />
        <fo:table-column column-width="3cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='y') and ($containerpattern='none')">
        <fo:table-column column-width="14cm" />
        <fo:table-column column-width="3cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='n') and ($containerpattern='bfr')">
        <fo:table-column column-width="12.5cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='n') and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr')">
        <fo:table-column column-width="14cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='n') and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r')">
        <fo:table-column column-width="15.5cm" />
      </xsl:when>
      <xsl:when test="($includeunitdatecolumn='n') and ($containerpattern='none')">
        <fo:table-column column-width="17cm" />
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- This template includes tests to combine container.table-columns and desc.table-columns as appropriate into a master set of <fo:table-column>s -->
  <xsl:template name="dsc.table.columns">
    <xsl:param name="includeunitdatecolumn"/>
    <xsl:if test="$containersonright='n'">
      <xsl:call-template name="container.table-columns"/>
    </xsl:if>
    <xsl:call-template name="desc.table-columns">
      <xsl:with-param name="includeunitdatecolumn">
        <xsl:value-of select="$includeunitdatecolumn"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="$containersonright='y'">
      <xsl:call-template name="container.table-columns"/>
    </xsl:if>
  </xsl:template>
  
  <!-- This template uses $containerpattern to create sets of table-head table-cells for container headings as appropriate -->
  <xsl:template name="container.column.headers">
    <xsl:param name="containerpattern">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:call-template name="containerpatternParamC01"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="containerpatternParamDsc"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$containerpattern='bfr'">
        <xsl:call-template name="container.column.header.box"/>
        <xsl:call-template name="container.column.header.folder"/>
        <xsl:call-template name="container.column.header.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='bf'">
        <xsl:call-template name="container.column.header.box"/>
        <xsl:call-template name="container.column.header.folder"/>
      </xsl:when>
      <xsl:when test="$containerpattern='br'">
        <xsl:call-template name="container.column.header.box"/>
        <xsl:call-template name="container.column.header.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='b'">
        <xsl:call-template name="container.column.header.box"/>
      </xsl:when>
      <xsl:when test="$containerpattern='fr'">
        <xsl:call-template name="container.column.header.folder"/>
        <xsl:call-template name="container.column.header.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='f'">
        <xsl:call-template name="container.column.header.folder"/>
      </xsl:when>
      <xsl:when test="$containerpattern='r'">
        <xsl:call-template name="container.column.header.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='none'"/>
    </xsl:choose>
  </xsl:template>
  
  <!-- This template determines the proper value for the @number-columns-spanned in the Description cell in the table-row for did siblings. -->
  <xsl:template name="desc.colspanParam">
    <xsl:param name="includeunitdatecolumn"/>
    <xsl:param name="containerpattern">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:call-template name="containerpatternParamC01"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="containerpatternParamDsc"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$includeunitdatecolumn='n' and $containersonright='n'">
        <xsl:number value="1"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='y' and $containersonright='n'">
        <xsl:number value="2"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and $containerpattern='bfr'">
        <xsl:number value="4"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr')">
        <xsl:number value="3"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r')">
        <xsl:number value="2"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='n' and $containersonright='y' and $containerpattern='none'">
        <xsl:number value="1"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='bfr')">
        <xsl:number value="5"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='bf' or $containerpattern='br' or $containerpattern='fr')">
        <xsl:number value="4"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='b' or $containerpattern='f' or $containerpattern='r')">
        <xsl:number value="3"/>
      </xsl:when>
      <xsl:when test="$includeunitdatecolumn='y' and $containersonright='y' and ($containerpattern='none')">
        <xsl:number value="2"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- Table cell for Description header -->
  <xsl:template name="desc.column.header">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.head.table-cell">
        <xsl:choose>
          <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='desc']">
            <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='desc']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='desc']">
                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='desc']"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>Description</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table cell for Dates header -->
  <xsl:template name="unitdate.column.header">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.head.table-cell">
        <xsl:choose>
          <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='dates']">
            <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='dates']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='dates']">
                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='dates']"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>Date(s)</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table cell for Box header -->
  <xsl:template name="container.column.header.box">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.container.head.table-cell">
        <xsl:choose>
          <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='box']">
            <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='box']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='box']">
                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='box']"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>Box</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table cell for Folder header -->
  <xsl:template name="container.column.header.folder">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.container.head.table-cell">
        <xsl:choose>
          <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='folder']">
            <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='folder']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='folder']">
                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='folder']"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>Folder</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table cell for Reel header -->
  <xsl:template name="container.column.header.reel">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.container.head.table-cell">
        <xsl:choose>
          <xsl:when test="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='reel']">
            <xsl:value-of select="ancestor-or-self::ead:dsc/ead:thead//ead:entry[@colname='reel']"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="self::ead:c01/ead:thead//ead:entry[@colname='reel']">
                <xsl:value-of select="self::ead:c01/ead:thead//ead:entry[@colname='reel']"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>Reel</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- This table creates the table header, with appropriate containers on right or left -->
  <xsl:template name="dsc.table.header">
    <xsl:param name="includeunitdatecolumn"/>
    <fo:table-header>
      <fo:table-row line-height="14pt">
        <xsl:if test="$containersonright='n'">
          <xsl:call-template name="container.column.headers"/>
        </xsl:if>
        <xsl:call-template name="desc.column.header"/>
        <xsl:if test="$includeunitdatecolumn='y'">
          <xsl:call-template name="unitdate.column.header"/>
        </xsl:if>
        <xsl:if test="$containersonright='y'">
          <xsl:call-template name="container.column.headers"/>
        </xsl:if>
      </fo:table-row>
    </fo:table-header>
  </xsl:template>
  
  <!-- This tempate creates sets of table body cells for containers -->
  <xsl:template name="container.table-cells">
    <xsl:param name="containerpattern">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:call-template name="containerpatternParamC01"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="containerpatternParamDsc"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:choose>
      <xsl:when test="$containerpattern='bfr'">
        <xsl:call-template name="container.table-cell.box"/>
        <xsl:call-template name="container.table-cell.folder"/>
        <xsl:call-template name="container.table-cell.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='bf'">
        <xsl:call-template name="container.table-cell.box"/>
        <xsl:call-template name="container.table-cell.folder"/>
      </xsl:when>
      <xsl:when test="$containerpattern='br'">
        <xsl:call-template name="container.table-cell.box"/>
        <xsl:call-template name="container.table-cell.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='b'">
        <xsl:call-template name="container.table-cell.box"/>
      </xsl:when>
      <xsl:when test="$containerpattern='fr'">
        <xsl:call-template name="container.table-cell.folder"/>
        <xsl:call-template name="container.table-cell.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='f'">
        <xsl:call-template name="container.table-cell.folder"/>
      </xsl:when>
      <xsl:when test="$containerpattern='r'">
        <xsl:call-template name="container.table-cell.reel"/>
      </xsl:when>
      <xsl:when test="$containerpattern='none'"/>
    </xsl:choose>
  </xsl:template>
  
  <!-- Table Body cell for unitdate -->
  <xsl:template name="unitdate.table-cell">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.cell.block">
        <xsl:for-each select="ead:did//ead:unitdate[not(parent::ead:unittitle)][not(@type)]">
          <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.cell.block">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='inclusive']">
          <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.cell.block">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="ead:did//ead:unitdate[not(parent::ead:unittitle)][@type='bulk']">
          <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.cell.block">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table Body cell for Box -->
  <xsl:template name="container.table-cell.box">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.container.cell.block">
      <xsl:apply-templates select="ead:did//ead:container[@type='Box']" mode="inline"/>
      </xsl:element>
  </fo:table-cell>
  </xsl:template>
  
  <!-- Table Body cell for Folder -->
  <xsl:template name="container.table-cell.folder">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.container.cell.block">
        <xsl:apply-templates select="ead:did//ead:container[@type='Folder']" mode="inline"/>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table Body cell for Reel -->
  <xsl:template name="container.table-cell.reel">
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.container.cell.block">
        <xsl:apply-templates select="ead:did//ead:container[@type='Reel']" mode="inline"/>
        <xsl:if test="ead:did//ead:container[@type='Frame']">
          <xsl:text>:</xsl:text>
          <xsl:value-of select="normalize-space(ead:did//ead:container[@type='Frame'])"/>
        </xsl:if>
      </xsl:element>
    </fo:table-cell>
  </xsl:template>
  
  <!-- Table that is called when all c01s go into a single table. -->
  <xsl:template name="single-dsc-table">
    <xsl:param name="includeunitdatecolumn">
      <xsl:call-template name="includeUnitdateColumnParamTemplate"/>
    </xsl:param>
    <fo:table space-before.optimum="12pt" table-layout="fixed"  width="100%"
      table-omit-header-at-break="false">
      <xsl:call-template name="dsc.table.columns">
        <xsl:with-param name="includeunitdatecolumn">
          <xsl:value-of select="$includeunitdatecolumn"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="dsc.table.header">
        <xsl:with-param name="includeunitdatecolumn">
          <xsl:value-of select="$includeunitdatecolumn"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:element name="fo:table-body" use-attribute-sets="inventory.table-body">
        <xsl:for-each select="ead:c01">
          <xsl:call-template name="dsc_table_row">
            <xsl:with-param name="includeunitdatecolumn">
              <xsl:value-of select="$includeunitdatecolumn"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:apply-templates select="ead:c02" mode="c0x">
            <xsl:with-param name="includeunitdatecolumn">
              <xsl:value-of select="$includeunitdatecolumn"/>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:for-each>
      </xsl:element>
    </fo:table>
  </xsl:template>
  
  <!-- Template that is called when each c01 gets its own table -->
  <xsl:template match="ead:c01" mode="c0x">
    <xsl:param name="includeunitdatecolumn">
      <xsl:call-template name="includeUnitdateColumnParamTemplate"/>
    </xsl:param>
    <xsl:choose>
      <!-- for <c01> files, items, or those without @level, do not create heading -->
      <xsl:when test="$multiple-c01-tables='n'"/>
      <!-- else, c01 (series, subseries, otherlevel)  heading -->
      <xsl:when test="$multiple-c01-tables='y'">
        <xsl:element name="fo:block" use-attribute-sets="inventory.c01.head.block">
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:if test="preceding-sibling::ead:c01">
            <xsl:attribute name="break-before">
              <xsl:text>page</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="ead:did//ead:unitid">
            <xsl:apply-templates select="ead:did//ead:unitid" mode="inline"/>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
        </xsl:element>
      </xsl:when>
    </xsl:choose>

    <fo:table space-before.optimum="12pt" table-layout="fixed"  width="100%" table-omit-header-at-break="false">
      <xsl:call-template name="dsc.table.columns">
        <xsl:with-param name="includeunitdatecolumn">
          <xsl:value-of select="$includeunitdatecolumn"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="dsc.table.header">
        <xsl:with-param name="includeunitdatecolumn">
          <xsl:value-of select="$includeunitdatecolumn"/>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:element name="fo:table-body" use-attribute-sets="inventory.table-body">
        <xsl:call-template name="dsc_table_row">
          <xsl:with-param name="includeunitdatecolumn">
            <xsl:value-of select="$includeunitdatecolumn"/>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates select="ead:c02" mode="c0x">
          <xsl:with-param name="includeunitdatecolumn">
            <xsl:value-of select="$includeunitdatecolumn"/>
          </xsl:with-param>
        </xsl:apply-templates>
      </xsl:element>
    </fo:table>
  </xsl:template>
  
  <!-- Template for all components c02 and below to c12 -->
  <xsl:template match="ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12" mode="c0x">
    <xsl:param name="includeunitdatecolumn"/>
    <xsl:call-template name="dsc_table_row">
      <xsl:with-param name="includeunitdatecolumn">
        <xsl:value-of select="$includeunitdatecolumn"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates select="ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12" mode="c0x">
      <xsl:with-param name="includeunitdatecolumn">
        <xsl:value-of select="$includeunitdatecolumn"/>
      </xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>
  
  <!-- Creates separate table rows for component <did> elements and component <did> siblings -->
  <xsl:template name="dsc_table_row">
    <xsl:param name="includeunitdatecolumn"/>
    <xsl:param name="containerpattern">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:call-template name="containerpatternParamC01"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="containerpatternParamDsc"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:param>
    <xsl:param name="desc.colspan">
      <xsl:call-template name="desc.colspanParam">
        <xsl:with-param name="includeunitdatecolumn">
          <xsl:value-of select="$includeunitdatecolumn"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:param>
    
    <fo:table-row keep-together.within-page="always">
      <xsl:if test="$containersonright='n'">
        <xsl:call-template name="container.table-cells"/>
      </xsl:if>
      <fo:table-cell>
        <xsl:choose>
          <xsl:when test="self::ead:c01 and $multiple-c01-tables='y'"/>
          <xsl:otherwise>
            <xsl:choose>
              <!-- new faids comming from oo2ead have did@id equal to the id referenced by a ref@target, therefore check to see which we have. 
                recognise that this is not a generic solution, may need modification for others using this.   -->
              <xsl:when test="ead:did/@id">
                <xsl:attribute name="id">
                  <xsl:value-of select="ead:did/@id" />
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="id">
                  <xsl:value-of select="@id" />
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
        <!-- == SB ADDED: MARKER ==
          See template write-marker for explanation. -->
        <xsl:call-template name="write-marker"/>
        <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.cell.block">
            <xsl:attribute name="end-indent">
              <xsl:text>45pt</xsl:text>
            </xsl:attribute>
            <!-- specified indent level-->
            <xsl:call-template name="c0x.did.indent"/>
            <xsl:element name="fo:block" use-attribute-sets="inventory.did.block">
              <xsl:apply-templates select="ead:did//ead:origination" mode="c0x"/>
              <xsl:choose>
                <xsl:when test="ead:did//ead:unittitle">
                  <xsl:apply-templates select="ead:did//ead:unittitle" mode="c0x"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:apply-templates select="ead:did//ead:unitid" mode="c0x"/>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:apply-templates select="ead:did//ead:physdesc" mode="c0x"/>
              <xsl:apply-templates select="ead:did//ead:langmaterial" mode="c0x"/>
              <xsl:apply-templates select="ead:did//ead:materialspec" mode="c0x"/>
              <xsl:apply-templates select="ead:did//ead:physloc" mode="c0x"/>
              <xsl:apply-templates select="ead:did//ead:daogrp" mode="c0x"/>
              <xsl:apply-templates select="ead:did//ead:dao" mode="c0x"/>
              <xsl:apply-templates select="ead:did//ead:note" mode="c0x"/>
            </xsl:element>
        </xsl:element>
      </fo:table-cell>
      <xsl:if test="$includeunitdatecolumn='y'">
        <xsl:call-template name="unitdate.table-cell"/>
      </xsl:if>
      <xsl:if test="$containersonright='y'">
        <xsl:call-template name="container.table-cells"/>
      </xsl:if>
    </fo:table-row>
    
    <xsl:if test="ead:arrangement or ead:scopecontent or ead:bioghist or ead:accessrestrict 
      or ead:userestrict or ead:processinfo or ead:relatedmaterial or ead:separatedmaterial 
      or ead:note or ead:acqinfo or ead:custodhist or ead:altformavail or ead:originalsloc 
      or ead:otherfindaid or ead:phystech or ead:fileplan or ead:bibliography 
      or ead:accruals or ead:appraisal or ead:prefercite or ead:controlaccess">
      
      <fo:table-row keep-with-previous.within-page="auto">
        <xsl:if test="$containersonright='n'">
          <xsl:choose>
            <xsl:when test="$containerpattern='b' or $containerpattern='f' or $containerpattern='r'">
              <fo:table-cell>
                <fo:block><xsl:text> </xsl:text></fo:block>
              </fo:table-cell>
            </xsl:when>
            <xsl:when test="$containerpattern='bf' or $containerpattern='br' or $containerpattern='fr'">
              <fo:table-cell>
                <fo:block><xsl:text> </xsl:text></fo:block>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block><xsl:text> </xsl:text></fo:block>
              </fo:table-cell>
            </xsl:when>
            <xsl:when test="$containerpattern='bfr'">
              <fo:table-cell>
                <fo:block><xsl:text> </xsl:text></fo:block>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block><xsl:text> </xsl:text></fo:block>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block><xsl:text> </xsl:text></fo:block>
              </fo:table-cell>
            </xsl:when>
            <xsl:when test="$containerpattern='none'"/>
          </xsl:choose>
        </xsl:if>
        <fo:table-cell>
          <xsl:attribute name="number-columns-spanned">
            <xsl:value-of select="$desc.colspan"/>
          </xsl:attribute>
          <xsl:element name="fo:block" use-attribute-sets="inventory.table.body.cell.block">
            <xsl:attribute name="end-indent">
              <xsl:text>45pt</xsl:text>
            </xsl:attribute>
            <!-- specified indent level-->
            <xsl:call-template name="c0x.did.sib.indent"/>
            <xsl:apply-templates select="ead:arrangement" mode="c0x"/>
            <xsl:apply-templates select="ead:bioghist" mode="c0x"/>
            <xsl:apply-templates select="ead:scopecontent" mode="c0x"/>
            <xsl:apply-templates select="ead:accessrestrict" mode="c0x"/>
            <xsl:apply-templates select="ead:userestrict" mode="c0x"/>
            <xsl:apply-templates select="ead:processinfo" mode="c0x"/>
            <xsl:apply-templates select="ead:relatedmaterial" mode="c0x"/>
            <xsl:apply-templates select="ead:separatedmaterial" mode="c0x"/>
            <xsl:apply-templates select="ead:note" mode="c0x"/>
            <xsl:apply-templates select="ead:acqinfo" mode="c0x"/>
            <xsl:apply-templates select="ead:custodhist" mode="c0x"/>
            <xsl:apply-templates select="ead:altformavail" mode="c0x"/>
            <xsl:apply-templates select="ead:originalsloc" mode="c0x"/>
            <xsl:apply-templates select="ead:otherfindaid" mode="c0x"/>
            <xsl:apply-templates select="ead:phystech" mode="c0x"/>
            <xsl:apply-templates select="ead:fileplan" mode="c0x"/>
            <xsl:apply-templates select="ead:bibliography" mode="c0x"/>
            <xsl:apply-templates select="ead:accruals" mode="c0x"/>
            <xsl:apply-templates select="ead:appraisal" mode="c0x"/>
            <xsl:apply-templates select="ead:prefercite" mode="c0x"/>
            <xsl:apply-templates select="ead:controlaccess" mode="c0x"/>
          </xsl:element>
        </fo:table-cell>
      </fo:table-row>
    </xsl:if>
  </xsl:template>
  
  <!-- ead:origination c0x Template -->
  <xsl:template match="ead:origination" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="inline"/>
    </fo:block>
  </xsl:template>
  
  <!-- ead:unitid c0x Template -->
  <xsl:template match="ead:unitid" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="inline"/>
    </fo:block>
  </xsl:template>
  
  <!-- ead:unittitle c0x Template -->
  <!-- Also catches component <unitid>s -->
  <xsl:template match="ead:unittitle" mode="c0x">
    <xsl:choose>
      <xsl:when test="ancestor::ead:did/parent::*[@level='subgrp' or @level='series' or @level='subseries' or @otherlevel='accession']">
        <xsl:element name="fo:block" use-attribute-sets="inventory.seriesEtc.unittitle.block">
          <xsl:call-template name="c0x.did.unittitle.1"/>
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="fo:block">
          <xsl:call-template name="c0x.did.unittitle.1"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ead:unittitle c0x call Template 1 -->
  <xsl:template name="c0x.did.unittitle.1">
    <xsl:choose>
      <xsl:when test="../ead:dao[not(@xlink:actuate='none') and normalize-space(../ead:dao/@xlink:href)]">
        <fo:wrapper color="{$linkcolor}">
          <xsl:element name="fo:basic-link">
            <xsl:attribute name="external-destination">
              <xsl:value-of select="../ead:dao/@xlink:href"/>
            </xsl:attribute>
            <xsl:call-template name="c0x.did.unittitle.2"/>
          </xsl:element>
        </fo:wrapper>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="c0x.did.unittitle.2"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- ead:unittitle c0x call Template 2 -->
  <xsl:template name="c0x.did.unittitle.2">
    <xsl:if test="not(preceding-sibling::ead:unittitle) and ancestor::ead:did//ead:unitid">
      <xsl:apply-templates select="ancestor::ead:did//ead:unitid" mode="inline"/><xsl:text> </xsl:text>
    </xsl:if>
    <xsl:if test="@type='alternative'">
      <xsl:choose>
        <xsl:when test="@label">
          <xsl:value-of select="@label"/><xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>Alternate title: </xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!-- ead:unitdate c0x Template -->
  <xsl:template match="ead:unitdate[not(parent::ead:unittitle)]" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="inline"/>
    </fo:block>
  </xsl:template>
  
  <!-- ead:physdesc c0x Template -->
  <xsl:template match="ead:physdesc" mode="c0x">
    <xsl:element name="fo:block">
      <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
        <xsl:attribute name="font-style">
          <xsl:text>italic</xsl:text>
        </xsl:attribute>
        <xsl:apply-templates mode="inline"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <!-- ead:langmaterial c0x Template -->
  <xsl:template match="ead:langmaterial" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="inline"/>
    </fo:block>
  </xsl:template>
  
  <!-- ead:materialspec c0x Template -->
  <xsl:template match="ead:materialspec" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="inline"/>
    </fo:block>
  </xsl:template>
  
  <!-- ead:physloc c0x Template -->
  <xsl:template match="ead:physloc" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="inline"/>
    </fo:block>
  </xsl:template>
  
  <!-- ead:dao c0x Template -->
  <xsl:template match="ead:dao" mode="c0x">
    <!--<xsl:if test="@xlink:actuate='none'">
      <xsl:choose>
        <xsl:when test="$repository_code='mssa'">
          <fo:block>
            <xsl:text>TEST TEST TEST TEST</xsl:text>
          </fo:block>
        </xsl:when>
        <xsl:otherwise/>
      </xsl:choose>
    </xsl:if>-->
  </xsl:template>
  
  <!-- ead:daogrp c0x Template -->
  <xsl:template match="ead:daogrp" mode="c0x">
    <xsl:for-each select="ead:daodesc/ead:p">
      <fo:block>
        <xsl:apply-templates mode="inline"/>
      </fo:block>
    </xsl:for-each>
    <fo:block>
      <xsl:choose>
        <!-- Embed first arc, link to second -->
        <xsl:when test="ead:arc[@xlink:from='start' and @xlink:to='thumb'] and ead:arc[@xlink:from='thumb' and @xlink:to='reference']">
          <xsl:choose>
            <xsl:when test="ead:arc[@xlink:to='reference'][@xlink:actuate='none']">
              <fo:external-graphic>
                <xsl:attribute name="src">
                  <xsl:text>url("</xsl:text>
                  <xsl:value-of select="ead:daoloc[@xlink:label='thumb']/@xlink:href"/>
                  <xsl:text>")</xsl:text>
                </xsl:attribute>
              </fo:external-graphic>
              <xsl:if test="ead:daoloc[@xlink:label='reference']/@xlink:title">
                <xsl:text>  </xsl:text>
                <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="fo:basic-link">
                <xsl:if test="not(ead:arc[@xlink:to='reference'][@xlink:actuate='none'])">
                  <xsl:attribute name="external-destination">
                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:href"/>
                  </xsl:attribute>
                </xsl:if>
                <fo:external-graphic>
                  <xsl:attribute name="src">
                    <xsl:text>url("</xsl:text>
                    <xsl:value-of select="ead:daoloc[@xlink:label='thumb']/@xlink:href"/>
                    <xsl:text>")</xsl:text>
                  </xsl:attribute>
                </fo:external-graphic>
                <xsl:if test="ead:daoloc[@xlink:label='reference']/@xlink:title">
                  <xsl:text>  </xsl:text>
                  <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                </xsl:if>
              </xsl:element>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <!-- Link to single arc -->
        <xsl:when test="ead:arc[@xlink:from='start' and @xlink:to='reference']">
          <xsl:choose>
            <xsl:when test="ead:arc[@xlink:actuate='none']">
              <xsl:choose>
                <xsl:when test="ead:resource[@xlink:label='start']/text()">
                  <xsl:apply-templates select="ead:resource[@xlink:label='start']" mode="inline"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <fo:wrapper color="{$linkcolor}">
                <xsl:element name="fo:basic-link">
                  <xsl:attribute name="external-destination">
                    <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:href"/>
                  </xsl:attribute>
                  <xsl:choose>
                    <xsl:when test="ead:resource[@xlink:label='start']/text()">
                      <xsl:apply-templates select="ead:resource[@xlink:label='start']" mode="inline"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="ead:daoloc[@xlink:label='reference']/@xlink:title"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:element>
              </fo:wrapper>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
      </xsl:choose>
    </fo:block>
  </xsl:template>
  
  <!-- ead:did/ead:note c0x Template -->
  <xsl:template match="ead:did//ead:note" mode="c0x">
    <fo:block>
      <xsl:apply-templates mode="block"/>
    </fo:block>
  </xsl:template>
  
  <!-- component did sibling c0x Template -->
  <!-- Does not support: dao, daogrp, dsc, head, index, odd,  -->
  <xsl:template match="ead:arrangement|ead:scopecontent|ead:bioghist|
    ead:accessrestrict|ead:userestrict|ead:processinfo|ead:relatedmaterial|
    ead:separatedmaterial|ead:note|ead:acqinfo|
    ead:custodhist|ead:altformavail|ead:originalsloc|ead:otherfindaid|
    ead:phystech|ead:fileplan|ead:bibliography|
    ead:accruals|ead:appraisal|ead:prefercite" mode="c0x">
    <xsl:element name="fo:block" use-attribute-sets="inventory.did.sib.block">
      <xsl:apply-templates mode="block" />
    </xsl:element>
  </xsl:template>
  
  <!-- component did sibling controlaccess Template -->
  <xsl:template match="ead:controlaccess" mode="c0x">
      <xsl:if test="ead:persname|ead:corpname|ead:famname|ead:name
        |ead:subject|ead:geogname|ead:occupation|ead:function|ead:title">
      <xsl:element name="fo:block" use-attribute-sets="inventory.did.sib.block">
        <xsl:element name="fo:block" use-attribute-sets="p.dsc.did.sib">
          <xsl:text>Subjects:</xsl:text>
        </xsl:element>
        <xsl:apply-templates
          select="ead:persname|ead:corpname
          |ead:famname|ead:name|ead:subject|ead:geogname
          |ead:occupation|ead:function|ead:title"
          mode="block"/>
      </xsl:element>
      </xsl:if>
      <xsl:if test="ead:genreform">
      <xsl:element name="fo:block" use-attribute-sets="inventory.did.sib.block">
        <xsl:element name="fo:block" use-attribute-sets="p.dsc.did.sib">
          <xsl:text>Type of material:</xsl:text>
        </xsl:element>
        <xsl:apply-templates select="ead:genreform" mode="block"/>
      </xsl:element>
      </xsl:if>
  </xsl:template>
  
  <!-- ead:dsc/ead:head c0x Template -->
  <xsl:template match="ead:head" mode="c0x"/>
  
  <!-- ead:dsc/ead:p c0x Template -->
  <xsl:template match="ead:p" mode="c0x"/>
  
  <!-- Template that is called to create the includeunitdatecolumn parameter -->
  <xsl:template name="includeUnitdateColumnParamTemplate">
    <xsl:choose>
      <xsl:when test="descendant-or-self::ead:c01//ead:unitdate[not(parent::ead:unittitle)]">
        <xsl:text>y</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>n</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>