<?xml version="1.0" encoding="UTF-8"?>
<!--
  ==================================================================================
  =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95  ==  Inline Module  =
  ==================================================================================

Status:		TEST
Contact:       mssa.systems@yale.edu, michael.rush@yale.edu
Created:	2007-11-15
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
  <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="inline"/>-->
  <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="inline"/>-->
  
  <!--  Inline <emph> and <title> template  -->
  <xsl:template match="ead:emph | ead:title" mode="inline">
    <xsl:choose>
      <xsl:when test="@render='bold'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='italic'">
        <xsl:choose>
          <xsl:when test="local-name()='title'">
            <xsl:element name="fo:wrapper" use-attribute-sets="font">
              <xsl:attribute name="text-decoration">
                <xsl:text>underline</xsl:text>
              </xsl:attribute>
              <xsl:apply-templates mode="inline"/>
            </xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
              <xsl:attribute name="font-style">
                <xsl:text>italic</xsl:text>
              </xsl:attribute>
              <xsl:apply-templates mode="inline"/>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="@render='bolditalic'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="font-style">
            <xsl:text>italic</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='singlequote'">
        <xsl:text> '</xsl:text>
        <xsl:apply-templates mode="inline"/>
        <xsl:text>' </xsl:text>
      </xsl:when>
      <xsl:when test="@render='boldsinglequote'">
        <xsl:text> '</xsl:text>
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
        <xsl:text>' </xsl:text>
      </xsl:when>
      <xsl:when test="@render='doublequote'">
        <xsl:text> "</xsl:text>
        <xsl:apply-templates mode="inline"/>
        <xsl:text>" </xsl:text>
      </xsl:when>
      <xsl:when test="@render='bolddoublequote'">
        <xsl:text> "</xsl:text>
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
        <xsl:text>" </xsl:text>
      </xsl:when>
      <xsl:when test="@render='smcaps'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font">
          <!-- @font-variant not supported by FOP 0.95.  Turn on when supported -->
          <!--<xsl:attribute name="font-variant">
            <xsl:text>small-caps</xsl:text>
            </xsl:attribute>-->
          <!-- When @font-variant is supported, remove @text-transform -->
          <xsl:attribute name="text-transform">
            <xsl:text>uppercase</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:text>90%</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='boldsmcaps'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <!-- @font-variant not supported by FOP 0.95.  Turn on when supported -->
          <!--<xsl:attribute name="font-variant">
            <xsl:text>small-caps</xsl:text>
            </xsl:attribute>-->
          <!-- When @font-variant is supported, remove @text-transform -->
          <xsl:attribute name="text-transform">
            <xsl:text>uppercase</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:text>90%</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='underline'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font">
          <xsl:attribute name="text-decoration">
            <xsl:text>underline</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='boldunderline'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="text-decoration">
            <xsl:text>underline</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='sub'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font">
          <xsl:attribute name="baseline-shift">
            <xsl:text>sub</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:text>80%</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='super'">
        <xsl:element name="fo:wrapper" use-attribute-sets="font">
          <xsl:attribute name="baseline-shift">
            <xsl:text>super</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="font-size">
            <xsl:text>80%</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="@render='nonproport'">
       <fo:wrapper font-family="Courier, serif"><xsl:apply-templates mode="inline"/></fo:wrapper>
      </xsl:when>
      <xsl:when test="@render='altrender'">
        <xsl:apply-templates mode="inline"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
          <xsl:attribute name="font-weight">
            <xsl:text>bold</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates mode="inline"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--  Inline <lb/> template  -->
  <xsl:template match="ead:lb" mode="inline">
    <fo:block/>
  </xsl:template>
  
  <!-- Inline <abbr> and <expan> template  -->
  <!-- <abbr> and <expan> are not supported by the Yale EAD BPGs, but may appear in legacy files -->
  <xsl:template match="ead:abbr | ead:expan"  mode="inline">
    <xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!-- Inline <ref> template -->
  <!-- Changed from block to wrapper.  Removed font-style="italic" keep-together.within-page="always" text-indent="10pt". -->
  <xsl:template match="ead:ref" mode="inline">
    <fo:wrapper color="{$linkcolor}">
      <xsl:element name="fo:basic-link">
        <xsl:attribute name="internal-destination">
          <xsl:value-of select="@target" />
        </xsl:attribute>
        <xsl:apply-templates mode="inline"/>
      </xsl:element>
      <xsl:if test="not(ancestor::ead:unittitle)">
        <xsl:text> (p. </xsl:text>
      <xsl:element name="fo:page-number-citation">
        <xsl:attribute name="ref-id">
          <xsl:value-of select="@target" />
        </xsl:attribute>
      </xsl:element><xsl:text>)</xsl:text>
      </xsl:if>
    </fo:wrapper>
  </xsl:template>
  
  <!-- Inline <ptr> template -->
  <xsl:template match="ead:ptr" mode="inline">
    <xsl:variable name="ptrtarget" select="@target"/>
    <fo:wrapper color="{$linkcolor}">
      <xsl:element name="fo:basic-link">
      <xsl:attribute name="internal-destination">
        <xsl:value-of select="@target" />
      </xsl:attribute>
        <xsl:choose>
          <xsl:when test="ancestor::ead:physloc">
            <xsl:for-each select="/ead:ead//ead:*[@id=$ptrtarget]">
              <xsl:choose>
                <xsl:when test="not(ancestor::ead:dsc)">
                  <xsl:call-template name="ptr.target.head.text"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="ead:did">
                    <xsl:variable name="box_label">
                      <xsl:call-template name="ptr.box.label"/>
                    </xsl:variable>
                    <xsl:variable name="folder_label">
                      <xsl:call-template name="ptr.folder.label"/>
                    </xsl:variable>
                    <xsl:variable name="reel_label">
                      <xsl:call-template name="ptr.reel.label"/>
                    </xsl:variable>
                    <xsl:if test="ancestor::*[@level='subgrp']/ead:did//ead:unitid">
                      <xsl:apply-templates select="ancestor::*[@level='subgrp']/ead:did//ead:unitid" mode="inline"/>
                      <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:if test="ancestor::*[@level='subgrp']/ead:did//ead:unittitle[1]">
                      <xsl:apply-templates select="ancestor::*[@level='subgrp']/ead:did//ead:unittitle[1]" mode="inline"/>
                      <xsl:choose>
                        <xsl:when test="ancestor::*[@level='series']/ead:did//ead:unittitle[1]">
                          <xsl:text>, </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text> </xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:if>
                    <xsl:if test="ancestor::*[@otherlevel='accession']/ead:did//ead:unitid">
                      <xsl:apply-templates select="ancestor::*[@otherlevel='accession']/ead:did//ead:unitid" mode="inline"/>
                      <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:if test="ancestor::*[@otherlevel='accession']/ead:did//ead:unittitle[1]">
                      <xsl:apply-templates select="ancestor::*[@otherlevel='accession']/ead:did//ead:unittitle[1]" mode="inline"/>
                      <xsl:choose>
                        <xsl:when test="ancestor::*[@level='series']/ead:did//ead:unittitle[1]">
                          <xsl:text>, </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:text> </xsl:text>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:if>
                    <xsl:if test="ancestor::*[@level='series']/ead:did//ead:unitid">
                      <xsl:apply-templates select="ancestor::*[@level='series']/ead:did//ead:unitid" mode="inline"/>
                      <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:if test="ancestor::*[@level='series']/ead:did//ead:unittitle[1]">
                      <xsl:apply-templates select="ancestor::*[@level='series']/ead:did//ead:unittitle[1]" mode="inline"/>
                      <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Box'] or .//ead:container[@type='Folder'] or .//ead:container[@type='Reel']">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Box']">
                      <xsl:value-of select="$box_label"/><xsl:text> </xsl:text>
                      <xsl:apply-templates select=".//ead:container[@type='Box']" mode="inline"/>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Box'] and (.//ead:container[@type='Folder'] or .//ead:container[@type='Reel'])">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Folder']">
                      <xsl:value-of select="$folder_label"/><xsl:text> </xsl:text>
                      <xsl:apply-templates select=".//ead:container[@type='Folder']" mode="inline"/>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Reel'] and .//ead:container[@type='Folder']">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Reel']">
                      <xsl:value-of select="$reel_label"/><xsl:text> </xsl:text>
                      <xsl:apply-templates select=".//ead:container[@type='Reel']" mode="inline"/>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:for-each select="/ead:ead//ead:*[@id=$ptrtarget]">
              <xsl:choose>
                <xsl:when test="not(ancestor::ead:dsc)">
                  <xsl:call-template name="ptr.target.head.text"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="ead:did">
                    <xsl:variable name="box_label">
                      <xsl:call-template name="ptr.box.label"/>
                    </xsl:variable>
                    <xsl:variable name="folder_label">
                      <xsl:call-template name="ptr.folder.label"/>
                    </xsl:variable>
                    <xsl:variable name="reel_label">
                      <xsl:call-template name="ptr.reel.label"/>
                    </xsl:variable>
                    <xsl:if test=".//ead:unitid">
                      <xsl:apply-templates select=".//ead:unitid" mode="inline"/>
                      <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:choose>
                      <xsl:when test=".//ead:unittitle/ead:ptr">
                        <xsl:value-of select=".//ead:unittitle"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:apply-templates select=".//ead:unittitle" mode="inline"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test=".//ead:container[@type='Box'] or .//ead:container[@type='Folder'] or .//ead:container[@type='Reel']">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Box']">
                      <xsl:value-of select="$box_label"/><xsl:text> </xsl:text>
                      <xsl:apply-templates select=".//ead:container[@type='Box']" mode="inline"/>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Box'] and (.//ead:container[@type='Folder'] or .//ead:container[@type='Reel'])">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Folder']">
                      <xsl:value-of select="$folder_label"/><xsl:text> </xsl:text>
                      <xsl:apply-templates select=".//ead:container[@type='Folder']" mode="inline"/>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Reel'] and .//ead:container[@type='Folder']">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:if test=".//ead:container[@type='Reel']">
                      <xsl:value-of select="$reel_label"/><xsl:text> </xsl:text>
                      <xsl:apply-templates select=".//ead:container[@type='Reel']" mode="inline"/>
                    </xsl:if>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
      <xsl:text> (p. </xsl:text>
      <xsl:element name="fo:page-number-citation">
        <xsl:attribute name="ref-id">
          <xsl:value-of select="@target" />
        </xsl:attribute>
      </xsl:element><xsl:text>)</xsl:text>
    </fo:wrapper>
  </xsl:template>
  
  <xsl:template name="ptr.target.head.text">
    <xsl:choose>
      <xsl:when test="ead:head">
        <xsl:apply-templates select="ead:head" mode="inline"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="self::ead:did[parent::ead:archdesc]">
            <xsl:value-of select="$did_head"/>
          </xsl:when>
          <xsl:when test="self::ead:descgrp[@type='admininfo'][parent::ead:archdesc]">
            <xsl:value-of select="$admininfo_head"/>
          </xsl:when>
          <xsl:when test="self::ead:descgrp[@type='provenance'][parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$provenance_head"/>
          </xsl:when>
          <xsl:when test="self::ead:acqinfo[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$acqinfo_head"/>
          </xsl:when>
          <xsl:when test="self::ead:custodhist[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$custodhist_head"/>
          </xsl:when>
          <xsl:when test="self::ead:accessrestrict[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$accessrestrict_head"/>
          </xsl:when>
          <xsl:when test="self::ead:userestrict[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$userestrict_head"/>
          </xsl:when>
          <xsl:when test="self::ead:prefercite[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$prefercite_head"/>
          </xsl:when>
          <xsl:when test="self::ead:processinfo[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$processinfo_head"/>
          </xsl:when>
          <xsl:when test="self::ead:relatedmaterial[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$relatedmaterial_head"/>
          </xsl:when>
          <xsl:when test="self::ead:separatedmaterial[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$separatedmaterial_head"/>
          </xsl:when>
          <xsl:when test="self::ead:altformavail[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$altformavail_head"/>
          </xsl:when>
          <xsl:when test="self::ead:accruals[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$accruals_head"/>
          </xsl:when>
          <xsl:when test="self::ead:appraisal[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$appraisal_head"/>
          </xsl:when>
          <xsl:when test="self::ead:originalsloc[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$originalsloc_head"/>
          </xsl:when>
          <xsl:when test="self::ead:otherfindaid[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$otherfindaid_head"/>
          </xsl:when>
          <xsl:when test="self::ead:phystech[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$phystech_head"/>
          </xsl:when>
          <xsl:when test="self::ead:fileplan[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$fileplan_head"/>
          </xsl:when>
          <xsl:when test="self::ead:bibliography[parent::ead:descgrp[@type='admininfo']]">
            <xsl:value-of select="$bibliography_head"/>
          </xsl:when>
          <xsl:when test="self::ead:bioghist[parent::ead:archdesc]">
            <xsl:value-of select="$bioghist_head"/>
          </xsl:when>
          <xsl:when test="self::ead:scopecontent[parent::ead:archdesc]">
            <xsl:value-of select="$scopecontent_head"/>
          </xsl:when>
          <xsl:when test="self::ead:arrangement[parent::ead:archdesc]">
            <xsl:value-of select="$arrangement_head"/>
          </xsl:when>
          <xsl:when test="self::ead:controlaccess[parent::ead:archdesc]">
            <xsl:value-of select="$controlaccess_head"/>
          </xsl:when>
          <xsl:when test="self::ead:dsc[parent::ead:archdesc]">
            <xsl:value-of select="$dsc_head"/>
          </xsl:when>
          <xsl:when test="self::ead:index[parent::ead:archdesc]">
            <xsl:value-of select="$index_head"/>
          </xsl:when>
          <xsl:when test="self::ead:odd[parent::ead:archdesc]">
            <xsl:value-of select="$odd_head"/>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="ptr.box.label">
    <xsl:choose>
      <xsl:when test="ancestor::ead:c01/ead:thead//ead:entry[@colname='box']">
        <xsl:value-of select="ancestor::ead:c01/ead:thead//ead:entry[@colname='box']"/>
      </xsl:when>
      <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='box']">
        <xsl:value-of select="ancestor::ead:dsc/ead:thead//ead:entry[@colname='box']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains(ead:container[@type='Box'],'-') or contains(ead:container[@type='Box'],'–') or contains(ead:container[@type='Box'],'—')">
            <xsl:text>Boxes</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Box</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="ptr.folder.label">
    <xsl:choose>
      <xsl:when test="ancestor::ead:c01/ead:thead//ead:entry[@colname='folder']">
        <xsl:value-of select="ancestor::ead:c01/ead:thead//ead:entry[@colname='folder']"/>
      </xsl:when>
      <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='folder']">
        <xsl:value-of select="ancestor::ead:dsc/ead:thead//ead:entry[@colname='folder']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains(ead:container[@type='Folder'],'-') or contains(ead:container[@type='Folder'],'–') or contains(ead:container[@type='Folder'],'—')">
            <xsl:text>Folders</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Folder</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="ptr.reel.label">
    <xsl:choose>
      <xsl:when test="ancestor::ead:c01/ead:thead//ead:entry[@colname='reel']">
        <xsl:value-of select="ancestor::ead:c01/ead:thead//ead:entry[@colname='reel']"/>
      </xsl:when>
      <xsl:when test="ancestor::ead:dsc/ead:thead//ead:entry[@colname='reel']">
        <xsl:value-of select="ancestor::ead:dsc/ead:thead//ead:entry[@colname='reel']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains(ead:container[@type='Reel'],'-') or contains(ead:container[@type='Reel'],'–') or contains(ead:container[@type='Reel'],'—')">
            <xsl:text>Reels</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Reel</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <!-- Inline <extref> Template -->
  <xsl:template match="ead:extref" mode="inline">
    <fo:wrapper color="{$linkcolor}">
      <xsl:element name="fo:basic-link">
        <xsl:attribute name="external-destination">
          <xsl:value-of select="@xlink:href" />
        </xsl:attribute>
        <!-- @show-destination commented because it is not supported by FOP 0.20.5 -->
        <!--<xsl:attribute name="show-destination">
          <xsl:choose>
            <xsl:when test="@xlink:show='new'">
              <xsl:text>new</xsl:text>
            </xsl:when>
            <xsl:when test="@xlink:show='replace'">
              <xsl:text>replace</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>new</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>-->
        <xsl:apply-templates mode="inline"/>
      </xsl:element></fo:wrapper>
  </xsl:template>
  
  <!-- Inline <extptr> Template -->
  <!-- Includes <xsl:if> that inserts @content-width only for <extptr>s in the <dsc> of music.mss.0014.1.xml/music.mss.0014.2.xml/music.mss.0014.3.xml -->
  <xsl:template match="ead:extptr" mode="inline">
    <fo:external-graphic>
      <xsl:attribute name="src">
        <xsl:text>url("</xsl:text>
        <xsl:value-of select="@xlink:href"/>
        <xsl:text>")</xsl:text>
      </xsl:attribute>
      <xsl:if test="normalize-space(/ead:ead//ead:eadid)='music.mss.0014.1' or 
        normalize-space(/ead:ead//ead:eadid)='music.mss.0014.2' or 
        normalize-space(/ead:ead//ead:eadid)='music.mss.0014.3' and ancestor::ead:dsc">
        <xsl:attribute name="content-width">
          <xsl:text>5in</xsl:text>
        </xsl:attribute>
      </xsl:if>
    </fo:external-graphic>
  </xsl:template>
  
  <!--  Inline <persname> template  -->
  <xsl:template match="ead:persname" mode="inline">
    <xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!--  Inline <corpname> template  -->
  <xsl:template match="ead:corpname" mode="inline">
    <xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!--  Inline <subarea> template  -->
  <!-- Not supported by Yale Best Practices, but possibly present from legacy files. -->
  <xsl:template match="ead:subarea" mode="inline">
    <xsl:choose>
      <xsl:when test="ancestor::ead:repository and (preceding-sibling::text() | preceding-sibling::*)">
        <fo:block>
          <xsl:apply-templates mode="inline"/>
        </fo:block>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="inline"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--  Inline <famname> template  -->
  <xsl:template match="ead:famname" mode="inline">
    <xsl:apply-templates mode="inline"/>
    </xsl:template>
  
  <!--  Inline <name> template  -->
  <xsl:template match="ead:name" mode="inline">
    <xsl:apply-templates mode="inline"/>
    </xsl:template>
  
  <!--  Inline <subject> template  -->
  <xsl:template match="ead:subject" mode="inline">
    <xsl:apply-templates mode="inline"/>
    </xsl:template>
  
  <!--  Inline <geogname> template  -->
  <xsl:template match="ead:geogname" mode="inline">
    <xsl:apply-templates mode="inline"/>
    </xsl:template>
  
  <!--  Inline <genreform> template  -->
  <xsl:template match="ead:genreform" mode="inline">
    <xsl:apply-templates mode="inline"/>
    </xsl:template>
  
  <!--  Inline <occupation> template  -->
  <xsl:template match="ead:occupation" mode="inline">
    <xsl:apply-templates mode="inline"/>
    </xsl:template>
  
  <!--  Inline <function> template  -->
  <xsl:template match="ead:function" mode="inline">
    <xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!-- Inline <num> template -->
  <xsl:template match="ead:num" mode="inline">
    <xsl:param name="titleproperInclude"/>
    <xsl:choose>
      <xsl:when test="parent::ead:titleproper">
        <xsl:if test="$titleproperInclude='yes'">
          <xsl:apply-templates mode="inline"/>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates mode="inline"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!--  Inline <date> template  -->
  <xsl:template match="ead:date" mode="inline">
    <xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!-- Inline <unitdate> template -->
  <xsl:template match="ead:unitdate" mode="inline">
    <xsl:text> </xsl:text><xsl:apply-templates mode="inline"/>
  </xsl:template>
  
  <!-- Inline <unitid> template -->
  <xsl:template match="ead:unitid" mode="inline">
    <xsl:variable name="unitid_string">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:variable>
    <xsl:variable name="unitid_string_length">
      <xsl:value-of select="string-length($unitid_string)"/>
    </xsl:variable>
    <xsl:variable name="unitid_last">
      <xsl:value-of select="substring($unitid_string,$unitid_string_length,$unitid_string_length)"/>
    </xsl:variable>
    <xsl:apply-templates mode="inline"/>
    <xsl:if test="not($unitid_last='.')">
      <xsl:text>.</xsl:text>
    </xsl:if>
  </xsl:template>
  
  <!-- Inline <list> template -->
  <xsl:template match="ead:list" mode="inline"/>
  

</xsl:stylesheet>