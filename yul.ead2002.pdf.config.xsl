<?xml version="1.0" encoding="UTF-8"?>
<!--
  ======================================================================================
  =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95  ==  CONFIG MODULE  =
  ======================================================================================

Status:		TEST
Contact:       mssa.systems@yale.edu, michael.rush@yale.edu
Created:	2006-08-25
Updated:     2012-02-13
Requires:    http://www.library.yale.edu/facc/xsl/include/yale.ead2002.id_head_values.xsl

-->
<xsl:stylesheet version = "1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:svg="http://www.w3.org/TR/SVG"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:fox="http://xml.apache.org/fop/extensions"
  xmlns:ead="urn:isbn:1-931666-22-9">

  <!--========================================================================-->
  <!--  USER DEFINED VARIABLES                                                -->
  <!--========================================================================-->

  <!--=====GENERAL=====-->
  
  <!-- Repository Parameter -->
  <xsl:param name="repository_code">
    <xsl:value-of select="substring-before(normalize-space(/ead:ead/ead:eadheader/ead:eadid),'.')"/>
  </xsl:param>
  
  <!-- Variables for Handle and PDF URLs -->
  <xsl:variable name="handleString">http://hdl.handle.net/10079/fa/</xsl:variable>
  <xsl:variable name="fedoraPID">
    <xsl:value-of select="concat(substring-before(normalize-space(/ead:ead//ead:eadid),'.'),':',substring-after(normalize-space(/ead:ead//ead:eadid),'.'))"/>
  </xsl:variable>
  <xsl:variable name="handleURL">
    <xsl:value-of select="concat($handleString,normalize-space(/ead:ead//ead:eadid))"/>
  </xsl:variable>
  <xsl:variable name="pdfURL">
    <xsl:value-of select="concat('http://drs.library.yale.edu:8083/fedora/get/',$fedoraPID,'/PDF')"/>
  </xsl:variable>
  
  <!-- place of publication-->
  <xsl:param name="publishplace">New Haven, Connecticut</xsl:param>
  
  <!--create access terms from <controlaccess>, y or n?-->
  <xsl:param name="includeAccessTerms">y</xsl:param>
  
  <!-- What is the lowest level of component that should be listed in the Table of Contents -->
  <xsl:param name="lowestTocLevel">subseries</xsl:param>
  
  <!-- Orbis Key - used in link to catalog record -->
  <xsl:param name="orbiskey">
    <xsl:value-of select="concat('(YUL)ead.', normalize-space(/ead:ead/ead:eadheader/ead:eadid))"/>
  </xsl:param>
  
  <!-- Link to corresponding record in Orbis -->
  <xsl:param name="orbisUrl">
    <!--<xsl:value-of select="concat('http://orbis.library.yale.edu/cgi-bin/Pwebrecon.cgi?Search_Arg=%22',$orbiskey,'%22&amp;DB=local&amp;Search_Code=CMD&amp;CNT=50')"/>-->
    <xsl:value-of select="concat('http://neworbis.library.yale.edu/vwebv/search?searchArg=%22',$orbiskey,'%22&amp;searchCode=CMD&amp;recCount=50&amp;searchType=1')"/>
  </xsl:param>
  
  <!-- Include DL Search Link? -->
  <xsl:param name="include_dl_search">
    <xsl:choose>
      <!-- MSSA choice -->
      <xsl:when test="$repository_code='mssa'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- BRBL choice -->
      <xsl:when test="$repository_code='beinecke'">
        <xsl:text>y</xsl:text>
      </xsl:when>
      <!-- Divinity choice -->
      <xsl:when test="$repository_code='divinity'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Music choice -->
      <xsl:when test="$repository_code='music'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Medical choice -->
      <xsl:when test="$repository_code='med'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Arts choice -->
      <xsl:when test="$repository_code='Arts'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- VRC choice -->
      <xsl:when test="$repository_code='vrc'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- YCBA choice -->
      <xsl:when test="$repository_code='ycba'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Peabody choice -->
      <xsl:when test="$repository_code='ypm'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>n</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- containers on right? -->
  <xsl:param name="containersonright">
    <xsl:choose>
      <!-- MSSA choice -->
      <xsl:when test="$repository_code='mssa'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- BRBL choice -->
      <xsl:when test="$repository_code='beinecke'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Divinity choice -->
      <xsl:when test="$repository_code='divinity'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Music choice -->
      <xsl:when test="$repository_code='music'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Medical choice -->
      <xsl:when test="$repository_code='med'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Arts choice -->
      <xsl:when test="$repository_code='arts'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- VRC choice -->
      <xsl:when test="$repository_code='vrc'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- YCBA choice -->
      <xsl:when test="$repository_code='ycba'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Peabody choice -->
      <xsl:when test="$repository_code='ypm'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>n</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- Include Request Form Link? -->
  <xsl:param name="include_requestForm_link">
    <xsl:choose>
      <!-- MSSA choice -->
      <xsl:when test="$repository_code='mssa'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- BRBL choice -->
      <xsl:when test="$repository_code='beinecke'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Divinity choice -->
      <xsl:when test="$repository_code='divinity'">
        <xsl:text>y</xsl:text>
      </xsl:when>
      <!-- Music choice -->
      <xsl:when test="$repository_code='music'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Medical choice -->
      <xsl:when test="$repository_code='med'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Arts choice -->
      <xsl:when test="$repository_code='Arts'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- VRC choice -->
      <xsl:when test="$repository_code='vrc'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- YCBA choice -->
      <xsl:when test="$repository_code='ycba'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Peabody choice -->
      <xsl:when test="$repository_code='ypm'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>n</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- Include Aeon requests? -->
  <xsl:param name="includeAeonRequests">
    <xsl:choose>
      <!-- MSSA choice -->
      <xsl:when test="$repository_code='mssa'">
        <xsl:text>y</xsl:text>
      </xsl:when>
      <!-- BRBL choice -->
      <xsl:when test="$repository_code='beinecke'">
        <xsl:text>y</xsl:text>
      </xsl:when>
      <!-- Divinity choice -->
      <xsl:when test="$repository_code='divinity'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Music choice -->
      <xsl:when test="$repository_code='music'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Medical choice -->
      <xsl:when test="$repository_code='med'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Arts choice -->
      <xsl:when test="$repository_code='arts'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- VRC choice -->
      <xsl:when test="$repository_code='vrc'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- YCBA choice -->
      <xsl:when test="$repository_code='ycba'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <!-- Peabody choice -->
      <xsl:when test="$repository_code='ypm'">
        <xsl:text>n</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>n</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- One table per <c01> or one table for all <c01>? -->
  <xsl:param name="multiple-c01-tables">
    <xsl:choose>
      <!-- 1 table per c01 (series, subseries, otherlevel) -->
      <xsl:when test="//ead:c01[@level='subgrp' or @level='series' or @level='subseries' or @level='otherlevel']">
        <xsl:text>y</xsl:text>
      </xsl:when>
      <!-- else <c01> files, items, or those without @level, 1 table per <dsc> -->
      <xsl:otherwise>
        <xsl:text>n</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  
  <!-- Set indent increment for running header -->
  <xsl:param name="head.indent" select="20"/>
  
  <!-- MSSA repository address -->
  <xsl:template name="mssaRepositoryAddress">
    <fo:block>Manuscripts and Archives</fo:block>
    <fo:block>Yale University Library</fo:block>
    <fo:block>P.O. Box 208240</fo:block>
    <fo:block>New Haven, CT 06520-8240</fo:block>
    <fo:block>tel.:   +1 (203) 432-1744</fo:block>
    <fo:block>fax.:   +1 (203) 432-7441</fo:block>
    <fo:block>email: 
      <xsl:element name="fo:basic-link">
        <xsl:attribute name="external-destination">http://www.library.yale.edu/mssa/refform.html</xsl:attribute>
        <xsl:attribute name="color"><xsl:value-of select="$linkcolor" /></xsl:attribute>
        mssa.assist@yale.edu
      </xsl:element>
    </fo:block> 
  </xsl:template>
  
  <!--=====END GENERAL=====-->
  
  <!--=====FORMATTING=====-->
  
  <!-- color to make internal & external links -->
  <xsl:param name="linkcolor">blue</xsl:param>
  
  <!-- ================ Attribute Sets ====================== -->
  
  <!-- Font Attribute Set -->
  <xsl:attribute-set name="font">
    <xsl:attribute name="font-family">
      <!--<xsl:text>Times</xsl:text>-->
      <xsl:text>ArialUnicodeMS</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:text>9pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Empahsis/Title Text Font Attribute Set -->
  <xsl:attribute-set name="font.emph">
    <xsl:attribute name="font-family">
      <!--<xsl:text>Times</xsl:text>-->
      <!--<xsl:text>Arial</xsl:text>-->
      <xsl:text>Helvetica</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:text>9pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Heading Text Font Attribute Set -->
  <!-- <xsl:attribute-set name="font.head" use-attribute-sets="font.emph"> -->
  <xsl:attribute-set name="font.head" use-attribute-sets="font">
    <xsl:attribute name="font-size">
      <xsl:text>14pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Subheading Text Font Attribute Set -->
  <!-- <xsl:attribute-set name="font.subhead" use-attribute-sets="font.emph"> -->
  <xsl:attribute-set name="font.subhead" use-attribute-sets="font">
    <xsl:attribute name="font-size">
      <xsl:text>12pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Section Heading Attribute Set -->
  <xsl:attribute-set name="heading.section" use-attribute-sets="font.head">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>24pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Subsection Heading Attribute Set -->
  <xsl:attribute-set name="heading.subsection" use-attribute-sets="font.subhead">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>12pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>12pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Page Header Align Right -->
  <xsl:attribute-set name="page.header.right" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>end</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Page Header Align Left -->
  <xsl:attribute-set name="page.header.left" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <publisher> Block Attribute Set -->
  <xsl:attribute-set name="titlepage.publisher" use-attribute-sets="font.emph">
    <xsl:attribute name="font-style">
      <xsl:text>italic</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:text>9pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <titleproper> Block Attribute Set -->
  <!-- <xsl:attribute-set name="titlepage.titleproper" use-attribute-sets="font.emph"> -->
  <xsl:attribute-set name="titlepage.titleproper" use-attribute-sets="font">
    <xsl:attribute name="font-size">
      <xsl:text>18pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>30pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <subtitle> Block Attribute Set -->
  <!-- <xsl:attribute-set name="titlepage.subtitle" use-attribute-sets="font.emph"> -->
  <xsl:attribute-set name="titlepage.subtitle" use-attribute-sets="font">
    <xsl:attribute name="font-size">
      <xsl:text>16pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>20pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page Call Number Block Attribute Set -->
  <!-- <xsl:attribute-set name="titlepage.unitid" use-attribute-sets="font"> -->
  <xsl:attribute-set name="titlepage.unitid" use-attribute-sets="font">
    <xsl:attribute name="font-size">
      <xsl:text>16pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>15pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page Image Attribute Set -->
  <xsl:attribute-set name="titlepage.image" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>15pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <author> Block Attribute Set -->
  <xsl:attribute-set name="titlepage.author" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>30pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <sponsor> Block Attribute Set -->
  <xsl:attribute-set name="titlepage.sponsor" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>15pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page Dates Block Attribute Set -->
  <xsl:attribute-set name="titlepage.dates" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>15pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <note type="frontmatter"> Block Attribute Set -->
  <xsl:attribute-set name="titlepage.note.frontmatter" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>30pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page publicationstmt/address Block Attribute Set -->
  <xsl:attribute-set name="titlepage.publicationstmt.address" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>20pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <publicationstmt> Paragraph Attribute Set -->
  <xsl:attribute-set name="titlepage.publicationstmt.p" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page <notestmt> Paragraph Attribute Set -->
  <xsl:attribute-set name="titlepage.notestmt.p" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Title Page Finding Aid Handle Citation Attribute Set -->
  <xsl:attribute-set name="titlepage.findingAidHandleCitation" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>5pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Table of Contents Cells Attribute Set -->
  <xsl:attribute-set name="toc.cells">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>5pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="color">
      <xsl:value-of select="$linkcolor"/>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Overview Label Cells Attribute Set -->
  <xsl:attribute-set name="overview.label.cells" use-attribute-sets="font.emph">
    <xsl:attribute name="font-size">
      <xsl:text>9pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-weight">
      <xsl:text>bold</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>end</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="end-indent">
      <xsl:text>15pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-transform">
      <xsl:text>uppercase</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Overview Content Cells Attribute Set -->
  <xsl:attribute-set name="overview.content.cells" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory c01 Heading Block Attribute Set -->
  <xsl:attribute-set name="inventory.c01.head.block" use-attribute-sets="font.head">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory Subgroup/Series/Subseries Block Unittitle Attribute Set -->
  <xsl:attribute-set name="inventory.seriesEtc.unittitle.block" use-attribute-sets="font">
    <xsl:attribute name="font-size">
      <xsl:text>11pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory Container Column Heading Table-Cell Attribute Set -->
  <xsl:attribute-set name="inventory.container.head.table-cell" use-attribute-sets="font.emph">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-weight">
      <xsl:text>bold</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory Column Heading Table-Cell Attribute Set -->
  <xsl:attribute-set name="inventory.head.table-cell" use-attribute-sets="font.emph">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="font-weight">
      <xsl:text>bold</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory table-body Attribute Set -->
  <xsl:attribute-set name="inventory.table-body" use-attribute-sets="font"/>
  
  <!-- Inventory Table Body Container Cell Block Attribute Set -->
  <xsl:attribute-set name="inventory.table.body.container.cell.block" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>center</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>7pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory Table Body Cell Block Attribute Set -->
  <xsl:attribute-set name="inventory.table.body.cell.block" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>7pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory <did> Block Attribute Set -->
  <xsl:attribute-set name="inventory.did.block" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="keep-together.within-page">
      <xsl:text>always</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Inventory <did> sibling Block Attribute Set -->
  <xsl:attribute-set name="inventory.did.sib.block" use-attribute-sets="font">
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Generic Paragraph Attribute Set -->
  <xsl:attribute-set name="p.generic" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <dsc> <did> Paragraph Attribute Set -->
  <!-- This just applies to component level did/note, which is not supported by the BPGs. -->
  <xsl:attribute-set name="p.dsc.did" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>7pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <dsc> <did> sibling Paragraph Attribute Set -->
  <xsl:attribute-set name="p.dsc.did.sib" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>5pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <bibref> Attribute Set -->
  <xsl:attribute-set name="bibref" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-indent">
      <xsl:text>-15pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="start-indent">
      <xsl:text>15pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <dsc> <bibref> Attribute Set -->
  <xsl:attribute-set name="bibref.dsc" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>5pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-indent">
      <xsl:text>-10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Determines the start-indent value for component bibliography/bibrefs -->
  <xsl:template name="dsc.bibref.indent">
    <xsl:attribute name="start-indent">
      <xsl:choose>
        <xsl:when test="../parent::ead:c01">
          <xsl:text>20pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c02">
          <xsl:text>40pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c03">
          <xsl:text>60pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c04">
          <xsl:text>80pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c05">
          <xsl:text>100pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c06">
          <xsl:text>120pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c07">
          <xsl:text>140pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c08">
          <xsl:text>160pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c09">
          <xsl:text>180pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c10">
          <xsl:text>200pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c11">
          <xsl:text>220pt</xsl:text>
        </xsl:when>
        <xsl:when test="../parent::ead:c12">
          <xsl:text>240pt</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  
  <!-- <blockquote> Attribute Set -->
  <xsl:attribute-set name="blockquote" use-attribute-sets="font">
    <xsl:attribute name="start-indent">
      <xsl:text>40px</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="end-indent">
      <xsl:text>40px</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-top">
      <xsl:text>12pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>12pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <addressline> Attribute Set -->
  <xsl:attribute-set name="addressline" use-attribute-sets="font"/>
  
  <!-- <list> Attribute Set -->
  <xsl:attribute-set name="list" use-attribute-sets="font">
    <xsl:attribute name="font-weight">
      <xsl:text>normal</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <listhead> Attribute Set -->
  <xsl:attribute-set name="listhead" use-attribute-sets="font.emph">
    <xsl:attribute name="font-weight">
      <xsl:text>bold</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <item> Attribute Set -->
  <xsl:attribute-set name="list.item" use-attribute-sets="font">
    <xsl:attribute name="font-weight">
      <xsl:text>normal</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="space-after">
      <xsl:text>3pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- <chronlist> Head Attribute Set -->
  <xsl:attribute-set name="head.chronlist" use-attribute-sets="font.emph">
    <xsl:attribute name="font-weight">
      <xsl:text>bold</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:text>start</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Table  <table> Attribute Set -->
  <xsl:attribute-set name="table" use-attribute-sets="font">
    <xsl:attribute name="table-layout">
      <xsl:text>fixed</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="table-omit-header-at-break">
      <xsl:text>false</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:text>20pt</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="inline-progression-dimension.optimum">
      <xsl:text>100%</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Table Head (<thead> and elsewhere) Attribute Set -->
  <xsl:attribute-set name="table.head" use-attribute-sets="font.emph">
    <xsl:attribute name="font-weight">
      <xsl:text>bold</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Table Body (<tbody> and elsewhere) Attribute Set -->
  <xsl:attribute-set name="table.body" use-attribute-sets="font"/>
  
  <!-- Table Cell Attribute Set -->
  <xsl:attribute-set name="table.cell" use-attribute-sets="font">
    <xsl:attribute name="padding">
      <xsl:text>5pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Table Cell Block Attribute Set -->
  <xsl:attribute-set name="table.cell.block" use-attribute-sets="font">
    <xsl:attribute name="margin-top">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Block <bioghist> Attribute Set -->
  <xsl:attribute-set name="block.bioghist" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Block <controlaccess> Attribute Set -->
  <xsl:attribute-set name="block.controlaccess" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Block <odd> Attribute Set -->
  <xsl:attribute-set name="block.odd" use-attribute-sets="font">
    <xsl:attribute name="margin-bottom">
      <xsl:text>10pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Block Access Term Element Attribute Set -->
  <xsl:attribute-set name="block.accessterm" use-attribute-sets="font"/>
  
  <!-- Block Link Elements (<ref> and <ptr>) Attribute Set -->
  <xsl:attribute-set name="block.links" use-attribute-sets="font"/>
  
  <!-- END Attribute Sets -->
  
  <!--=====END FORMATTING=====-->



  <!-- ********************* SECTION HEADS, LABELS, and IDs *********************** -->
  
  <xsl:include href="http://www.library.yale.edu/facc/xsl/include/yale.ead2002.id_head_values.xsl"/>
  
  <!-- ********************* Archdesc elements  *********************** -->
  <xsl:template name="bioghist_id">
    <xsl:value-of select="$bioghist_id"/><xsl:number format="1" value="count(preceding-sibling::ead:bioghist)+1"/>
  </xsl:template>
  <xsl:template name="block_bioghist_id">
    <xsl:value-of select="$bioghist_id"/><xsl:number format="1" value="count(parent::ead:bioghist/preceding-sibling::ead:bioghist)+1"/><xsl:value-of select="$block_bioghist_id"/><xsl:number format="1" value="count(preceding-sibling::ead:bioghist)+1"/>
  </xsl:template>
  <xsl:template name="arrangement_id">
    <xsl:value-of select="arrangement_id"/><xsl:number format="1" value="count(preceding-sibling::ead:arrangement)+1"/>
  </xsl:template>
  <xsl:template name="block_controlaccess_id">
    <xsl:value-of select="$block_controlaccess_id"/><xsl:number format="1" value="count(preceding-sibling::ead:controlaccess)+1"/>
  </xsl:template>
  <xsl:template name="odd_id">
    <xsl:value-of select="$odd_id"/><xsl:number format="1" value="count(preceding-sibling::ead:odd)+1"/>
  </xsl:template>
  <xsl:template name="block_odd_id">
    <xsl:value-of select="$block_odd_id"/><xsl:number format="1" value="count(preceding-sibling::ead:odd)+1"/><xsl:text>.</xsl:text><xsl:value-of select="generate-id()"/>
  </xsl:template>
  <xsl:template name="index_id">
    <xsl:value-of select="$index_id"/><xsl:number format="1" value="count(preceding-sibling::ead:index)+1"/>
  </xsl:template>
  
  <!-- ********************* END SECTION HEADS, LABELS, and IDs *********************** -->
  
  
  <!-- ********************** BEGIN RUNNING HEADER STRING LENGTHS ********************** -->
  
  <!-- Max string length for c01 running headers. -->
  <xsl:variable name="runningHeaderC01StringLength">
    <xsl:text>70</xsl:text>
  </xsl:variable>
  
  <!-- Max string length for c02 running headers. -->
  <xsl:variable name="runningHeaderC02StringLength">
    <xsl:text>65</xsl:text>
  </xsl:variable>
  
  <!-- Max string length for c03 running headers. -->
  <xsl:variable name="runningHeaderC03StringLength">
    <xsl:text>60</xsl:text>
  </xsl:variable>
  
  <!-- Max string length for c04 running headers. -->
  <xsl:variable name="runningHeaderC04StringLength">
    <xsl:text>55</xsl:text>
  </xsl:variable>
  
  <!-- Max string length for c05 running headers. -->
  <xsl:variable name="runningHeaderC05StringLength">
    <xsl:text>45</xsl:text>
  </xsl:variable>


<!--========================================================================-->
<!--  END USER DEFINED VARIABLES                                                -->
<!--========================================================================-->


<!-- column heaing in box, folder listing-->
<xsl:template name="column_heading">
  <xsl:param name="head" />
  <fo:table-cell>
    <xsl:element name="fo:block" use-attribute-sets="font.emph">
      <xsl:attribute name="font-weight">
        <xsl:text>bold</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="text-decoration">
        <xsl:text>underline</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="margin-top">
        <xsl:text>10pt</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="margin-bottom">
        <xsl:text>10pt</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="text-align">
        <xsl:text>start</xsl:text>
      </xsl:attribute>
      <xsl:value-of select="$head" />
    </xsl:element>
  </fo:table-cell>
</xsl:template>


<!--section (did, descgrp[@type='admininfo'], bioghist, scopecontent, arrangement, dsc, controlaccess, odd, index) headings-->
<xsl:template name="section_heading">
  <xsl:param name="head" />
  <xsl:param name="id" />
  <fo:block>
    <fo:block keep-with-next.within-page="always">
      <fo:leader leader-pattern="rule" id="{$id}"
                 rule-thickness="1.0pt"
                 leader-length="17cm"
                 margin-top="12pt"
                 margin-bottom="12pt"
                 start-indent="1.5cm"
                 end-indent="2cm"
                 color="black" />
    </fo:block>
    <xsl:element name="fo:block" use-attribute-sets="heading.section">
      <xsl:value-of select="$head" />
    </xsl:element>
  </fo:block>
</xsl:template>
  
  <!--subsection (descgrp[@type='provenance'], acqinfo, custodhist, accessrestrict, useresrict, 
    prefercite, processinfo, relatedmaterial, separatedmaterial, altformavail, accruals, appraisal, 
    originalsloc, otherfindaid, phystech, bioghist/bioghist, controlaccess/controlaccess) headings-->
  <xsl:template name="subsection_heading">
    <xsl:param name="head" />
    <xsl:param name="id" />
    <fo:block id="{$id}" keep-with-next.within-page="always">
      <xsl:element name="fo:block" use-attribute-sets="heading.subsection">
        <xsl:value-of select="$head" />
      </xsl:element>
    </fo:block>
  </xsl:template>

  <!--adds first level contents page links-->
  <xsl:template name="contents_cell_1">
    <xsl:param name="label"/>
    <xsl:param name="id"/>
    <fo:table-row>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <fo:basic-link internal-destination="{$id}">
            <xsl:value-of select="$label"/>
          </fo:basic-link>
        </xsl:element>
      </fo:table-cell>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <fo:page-number-citation ref-id="{$id}"/>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <!--adds second level contents page links-->
  <xsl:template name="contents_cell_2">
    <xsl:param name="label" />
    <xsl:param name="id" />
    <fo:table-row>
        <fo:table-cell>
          <xsl:element name="fo:block" use-attribute-sets="toc.cells">
            <xsl:attribute name="start-indent">
              <xsl:text>12pt</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="end-indent">
              <xsl:text>12pt</xsl:text>
            </xsl:attribute>
            <fo:basic-link internal-destination="{$id}">
              <xsl:value-of select="$label"/>
            </fo:basic-link>
          </xsl:element>
        </fo:table-cell>
        <fo:table-cell>
          <xsl:element name="fo:block" use-attribute-sets="toc.cells">
            <fo:page-number-citation ref-id="{$id}"/>
          </xsl:element>
        </fo:table-cell>
      </fo:table-row>
  </xsl:template>
  
  <!--adds third level contents page links-->
  <xsl:template name="contents_cell_3">
    <xsl:param name="label" />
    <xsl:param name="id" />
    <fo:table-row>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <xsl:attribute name="start-indent">
            <xsl:text>24pt</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="end-indent">
            <xsl:text>12pt</xsl:text>
          </xsl:attribute>
          <fo:basic-link internal-destination="{$id}">
            <xsl:value-of select="$label"/>
          </fo:basic-link>
        </xsl:element>
      </fo:table-cell>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <fo:page-number-citation ref-id="{$id}"/>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <!--adds fourth level contents page links-->
  <xsl:template name="contents_cell_4">
    <xsl:param name="label" />
    <xsl:param name="id" />
    <fo:table-row>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <xsl:attribute name="start-indent">
            <xsl:text>36pt</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="end-indent">
            <xsl:text>12pt</xsl:text>
          </xsl:attribute>
          <fo:basic-link internal-destination="{$id}">
            <xsl:value-of select="$label"/>
          </fo:basic-link>
        </xsl:element>
      </fo:table-cell>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <fo:page-number-citation ref-id="{$id}"/>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <!--adds fifth level contents page links-->
  <xsl:template name="contents_cell_5">
    <xsl:param name="label" />
    <xsl:param name="id" />
    <fo:table-row>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <xsl:attribute name="start-indent">
            <xsl:text>48pt</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="end-indent">
            <xsl:text>12pt</xsl:text>
          </xsl:attribute>
          <fo:basic-link internal-destination="{$id}">
            <xsl:value-of select="$label"/>
          </fo:basic-link>
        </xsl:element>
      </fo:table-cell>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <fo:page-number-citation ref-id="{$id}"/>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <!--adds sixth level contents page links-->
  <xsl:template name="contents_cell_6">
    <xsl:param name="label" />
    <xsl:param name="id" />
    <fo:table-row>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <xsl:attribute name="start-indent">
            <xsl:text>60pt</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="end-indent">
            <xsl:text>12pt</xsl:text>
          </xsl:attribute>
          <fo:basic-link internal-destination="{$id}">
            <xsl:value-of select="$label"/>
          </fo:basic-link>
        </xsl:element>
      </fo:table-cell>
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="toc.cells">
          <fo:page-number-citation ref-id="{$id}"/>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>


<!--adds labels in overview cells-->
<xsl:template name="overview_cell">
  <xsl:param name="label" />
  <xsl:param name="value" />

  <fo:table-row keep-together.within-page="always">
    <!-- the label cell-->
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="overview.label.cells">
        <xsl:value-of select="$label" />
      </xsl:element>
    </fo:table-cell>
    <!-- the element content cell-->
    <fo:table-cell>
      <xsl:element name="fo:block" use-attribute-sets="overview.content.cells">
        <xsl:choose>
          <xsl:when test="$value">
            <xsl:value-of select="$value"/>
          </xsl:when>
          <xsl:when test="self::ead:repository">
                <xsl:apply-templates mode="block"/>
          </xsl:when>
          <xsl:when test="self::ead:note">
            <xsl:apply-templates mode="block"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:apply-templates mode="inline"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:table-cell>
   </fo:table-row>
</xsl:template>

<!-- set indent levels for compnent <did> elements-->
<xsl:template name="c0x.did.indent">
  <xsl:choose>
    <xsl:when test="self::ead:c02">
      <xsl:attribute name="start-indent">20pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c03">
      <xsl:attribute name="start-indent">40pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c04">
      <xsl:attribute name="start-indent">60pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c05">
      <xsl:attribute name="start-indent">80pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c06">
      <xsl:attribute name="start-indent">100pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c07">
      <xsl:attribute name="start-indent">120pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c08">
      <xsl:attribute name="start-indent">140pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c09">
      <xsl:attribute name="start-indent">160pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c10">
      <xsl:attribute name="start-indent">180pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c11">
      <xsl:attribute name="start-indent">200pt</xsl:attribute>
    </xsl:when>
    <xsl:when test="self::ead:c12">
      <xsl:attribute name="start-indent">220pt</xsl:attribute>
    </xsl:when>
    <xsl:otherwise />
  </xsl:choose>
</xsl:template>
  
  <!-- set indent levels for compnent <did> sibling elements-->
  <xsl:template name="c0x.did.sib.indent">
    <xsl:choose>
      <xsl:when test="self::ead:c01">
        <xsl:attribute name="start-indent">10pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c02">
        <xsl:attribute name="start-indent">30pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c03">
        <xsl:attribute name="start-indent">50pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c04">
        <xsl:attribute name="start-indent">70pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c05">
        <xsl:attribute name="start-indent">90pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c06">
        <xsl:attribute name="start-indent">110pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c07">
        <xsl:attribute name="start-indent">130pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c08">
        <xsl:attribute name="start-indent">150pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c09">
        <xsl:attribute name="start-indent">170pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c10">
        <xsl:attribute name="start-indent">190pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c11">
        <xsl:attribute name="start-indent">210pt</xsl:attribute>
      </xsl:when>
      <xsl:when test="self::ead:c12">
        <xsl:attribute name="start-indent">230pt</xsl:attribute>
      </xsl:when>
      <xsl:otherwise />
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>