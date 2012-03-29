<?xml version="1.0" encoding="UTF-8"?>
<!--
  ==================================================================================
  =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95  ==  Block Module  =
  ==================================================================================

Status:		TEST
Contact:       mssa.systems@yale.edu, michael.rush@yale.edu
Created:	2007-11-15
Updated:     2011-11-21

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
  <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="block"/>-->
  <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="block"/>-->
  
  <!-- Block <head> Templates -->
  <xsl:template match="ead:head" mode="block"/>
  
  <!-- Block <p> Template -->
  <xsl:template match="ead:p" mode="block">
      <xsl:choose>
        <xsl:when test="ancestor::ead:publicationstmt">
          <xsl:element name="fo:block" use-attribute-sets="titlepage.publicationstmt.p">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:when>
        <xsl:when test="ancestor::ead:notestmt">
          <xsl:element name="fo:block" use-attribute-sets="titlepage.notestmt.p">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:when>
        <xsl:when test="ancestor::ead:dsc and not(ancestor::ead:did)">
          <xsl:element name="fo:block" use-attribute-sets="p.dsc.did.sib">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:when>
        <xsl:when test="ancestor::ead:dsc and ancestor::ead:did">
          <xsl:element name="fo:block" use-attribute-sets="p.dsc.did">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="fo:block" use-attribute-sets="p.generic">
            <xsl:apply-templates mode="inline"/>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  <!-- Block <bibref> Template -->
  <xsl:template match="ead:bibref" mode="block">
    <xsl:choose>
      <xsl:when test="ancestor::ead:dsc">
        <xsl:element name="fo:block" use-attribute-sets="bibref.dsc">
          <xsl:call-template name="dsc.bibref.indent"/>
          <xsl:apply-templates mode="inline" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="fo:block" use-attribute-sets="bibref">
          <xsl:apply-templates mode="inline" />
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <!-- Block <blockquote> Template -->
  <xsl:template match="ead:blockquote" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="blockquote">
      <xsl:apply-templates mode="block" />
    </xsl:element>
  </xsl:template>
  
  <!-- Block <address> Template -->
  <xsl:template match="ead:address" mode="block">
    <xsl:apply-templates select="ead:addressline" mode="block"/>
  </xsl:template>
  
  <!-- Block <addressline> Template -->
  <xsl:template match="ead:addressline" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="addressline">
      <xsl:choose>
        <xsl:when test="starts-with(normalize-space(.),'Email') or starts-with(normalize-space(.),'email')">
          <xsl:variable name="addressline_string" select="normalize-space(.)"/>
          <xsl:variable name="addressline_string_before_space" select="substring-before($addressline_string,' ')"/>
          <xsl:variable name="addressline_string_after_space_normal" select="normalize-space(substring-after($addressline_string,' '))"/>
          <xsl:value-of select="$addressline_string_before_space"/><xsl:text> </xsl:text>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:text>mailto:</xsl:text>
                <xsl:value-of select="$addressline_string_after_space_normal"/>
              </xsl:attribute>
              <xsl:value-of select="$addressline_string_after_space_normal"/>
            </xsl:element>
          </fo:wrapper>
        </xsl:when>
        <xsl:when test="starts-with(normalize-space(.),'Web') or starts-with(normalize-space(.),'web')">
          <xsl:variable name="addressline_string" select="normalize-space(.)"/>
          <xsl:variable name="addressline_string_before_space" select="substring-before($addressline_string,' ')"/>
          <xsl:variable name="addressline_string_after_space_normal" select="normalize-space(substring-after($addressline_string,' '))"/>
          <xsl:value-of select="$addressline_string_before_space"/><xsl:text> </xsl:text>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:value-of select="$addressline_string_after_space_normal"/>
              </xsl:attribute>
              <xsl:value-of select="$addressline_string_after_space_normal"/>
            </xsl:element>
          </fo:wrapper>
        </xsl:when>
        <xsl:when test="starts-with(normalize-space(.),'http') and not(contains(normalize-space(.),' '))">
          <xsl:variable name="addressline_string" select="normalize-space(.)"/>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:value-of select="$addressline_string"/>
              </xsl:attribute>
              <xsl:value-of select="$addressline_string"/>
            </xsl:element>
          </fo:wrapper>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="inline"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <list> Template -->
  <xsl:template match="ead:list" mode="block">
    <xsl:variable name="listType">
      <xsl:value-of select="@type"/>
    </xsl:variable>    
    <xsl:element name="fo:list-block" use-attribute-sets="list">
      <xsl:if test="ead:head">
        <!--THE HEAD-->
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <fo:block />
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:element name="fo:block" use-attribute-sets="listhead">
              <xsl:apply-templates select="ead:head" mode="inline"/>
            </xsl:element>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:if>
      <xsl:if test="ead:listhead">
        <!--THE LISTHEAD-->
        <fo:list-item>
          <fo:list-item-label end-indent="label-end()">
            <xsl:element name="fo:block" use-attribute-sets="listhead">
              <xsl:apply-templates select="ead:listhead/ead:head01" mode="inline"/>
            </xsl:element>
          </fo:list-item-label>
          <fo:list-item-body start-indent="body-start()">
            <xsl:element name="fo:block" use-attribute-sets="listhead">
              <xsl:apply-templates select="ead:listhead/ead:head02" mode="inline"/>
            </xsl:element>
          </fo:list-item-body>
        </fo:list-item>
      </xsl:if>
      <xsl:for-each select="ead:item|ead:defitem/ead:item">
        <xsl:element name="fo:list-item" use-attribute-sets="list.item">
          <xsl:if test="ancestor::ead:list[1][ancestor::ead:list] and position()=1">
            <xsl:attribute name="space-before.optimum">
              <xsl:text>5pt</xsl:text>
            </xsl:attribute>
          </xsl:if>
          <xsl:if test="@id">
            <xsl:attribute name="id">
              <xsl:value-of select="@id"/>
            </xsl:attribute>
          </xsl:if>
          <!--an icon (bullet &#x2022;, pointy-digit &#x261e; right caret &#8250 lct;)  -->
          <fo:list-item-label end-indent="label-end()">
            <!--<fo:block space-after="6pt">-->
            <xsl:element name="fo:block">
              <!--<fo:inline font-family="Symbol">&#x2022;</fo:inline>-->
              <!--<fo:inline font-family="ZapfDingbats">&#x261e;</fo:inline>-->
              <!--2006-07-26 sy-->
              <xsl:choose>
                <xsl:when test="$listType='simple'"/>
                <xsl:when test="$listType='deflist'"/>
                <xsl:when test="$listType='marked'">&#x2022;</xsl:when>
                <xsl:when test="$listType='ordered'">
                  <!--<xsl:number format="normalize-space($numeration_format)"/>-->
                  <!--<xsl:number format="1" />-->
                  <xsl:choose>
                    <xsl:when test="ancestor::ead:list[1][@numeration='arabic']">
                      <xsl:number format="1" /><xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::ead:list[1][@numeration='upperalpha']">
                      <xsl:number format="A" /><xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::ead:list[1][@numeration='loweralpha']">
                      <xsl:number format="a" /><xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::ead:list[1][@numeration='upperroman']">
                      <xsl:number format="I" /><xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:when test="ancestor::ead:list[1][@numeration='lowerroman']">
                      <xsl:number format="i" /><xsl:text>)</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:number format="1" /><xsl:text>)</xsl:text>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:when test="@altrender='nobullet'"/>
              </xsl:choose>
            </xsl:element>
          </fo:list-item-label>
          <!-- thing itself-->
          <fo:list-item-body start-indent="body-start()">
            <!--<fo:block space-after="6pt">-->
            <xsl:element name="fo:block">
              <xsl:if test="parent::ead:defitem/ead:label">
                <xsl:element name="fo:wrapper" use-attribute-sets="font.emph">
                  <xsl:attribute name="font-weight">
                    <xsl:text>bold</xsl:text>
                  </xsl:attribute>
                  <xsl:value-of select="parent::ead:defitem/ead:label" /><xsl:text>   </xsl:text>
                </xsl:element>
              </xsl:if>
              <xsl:apply-templates mode="inline"/>
            </xsl:element>
            <xsl:if test="ead:list">
              <xsl:apply-templates select="ead:list" mode="block"/>
            </xsl:if>
          </fo:list-item-body>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <chronlist> Template -->
  <xsl:template match="ead:chronlist" mode="block">
      <xsl:choose>
        <xsl:when test="ead:head">
          <xsl:element name="fo:block" use-attribute-sets="font.subhead">
            <xsl:apply-templates select="ead:head" mode="inline"/>
          </xsl:element>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="not(../ead:head)">
            <xsl:element name="fo:block" use-attribute-sets="head.chronlist">
              <xsl:value-of select="$chronlist_head"/>
            </xsl:element>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>
    <fo:table table-layout="fixed" width="100%" space-after.optimum="15pt">
      <fo:table-column column-width="3cm" />
      <fo:table-column column-width="1cm" />
      <fo:table-column column-width="13cm" />
      <xsl:element name="fo:table-body" use-attribute-sets="table.body">
        <xsl:apply-templates select="ead:chronitem" mode="block"/>
      </xsl:element>
    </fo:table>
  </xsl:template>
  
  <!-- Block <chronitem> Template -->
  <xsl:template match="ead:chronitem" mode="block">
      <fo:table-row>
        <fo:table-cell>
          <fo:block space-before.optimum="10pt" text-align="start">
            <xsl:choose>
              <xsl:when test="ead:date">
                <xsl:apply-templates select="ead:date" mode="inline"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>no date</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block space-before.optimum="10pt" text-align="start" />
        </fo:table-cell>
        <fo:table-cell>
          <fo:block space-before.optimum="10pt" text-align="start">
            <xsl:for-each select="ead:eventgrp/ead:event">
              <fo:block>
                <xsl:apply-templates mode="inline"/>
              </fo:block>
            </xsl:for-each>
            <xsl:for-each select="ead:event">
              <fo:block>
                <xsl:apply-templates mode="inline"/>
              </fo:block>
            </xsl:for-each>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
  </xsl:template>
  
  <!-- Block <table> Template -->
  <xsl:template match="ead:table" mode="block">
    <xsl:element name="fo:table" use-attribute-sets="table">
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <tgroup> Template -->
  <xsl:template match="ead:tgroup" mode="block">
    <xsl:call-template name="table-column">
      <xsl:with-param name="cols">
        <xsl:value-of select="@cols"/>
      </xsl:with-param>
      <xsl:with-param name="width_percent">
        <xsl:value-of select="100 div @cols"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- Template called by Block <tgroup> Template--> 
  <!-- Inserts <fo:table-column>s necessary to set columns widths. -->
  <xsl:template name="table-column">
    <xsl:param name="cols"/>
    <xsl:param name="width_percent"/>
    <xsl:if test="$cols > 0">
      <xsl:element name="fo:table-column">
        <xsl:attribute name="column-width">
          <xsl:value-of select="$width_percent"/><xsl:text>%</xsl:text>
        </xsl:attribute>
      </xsl:element>
      <xsl:call-template name="table-column">
        <xsl:with-param name="cols">
          <xsl:value-of select="$cols - 1"/>
        </xsl:with-param>
        <xsl:with-param name="width_percent">
          <xsl:value-of select="$width_percent"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  <!-- Block <thead> Template -->
  <xsl:template match="ead:thead" mode="block">
    <xsl:element name="fo:table-header" use-attribute-sets="table.head">
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <tbody> Template -->
  <xsl:template match="ead:tbody" mode="block">
    <xsl:element name="fo:table-body" use-attribute-sets="table.body">
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <row> Template -->
  <xsl:template match="ead:row" mode="block">
    <xsl:element name="fo:table-row">
      <xsl:apply-templates select="ead:entry" mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <entry> Template -->
  <xsl:template match="ead:entry" mode="block">
    <xsl:element name="fo:table-cell" use-attribute-sets="table.cell">
      <xsl:if test="@align">
        <xsl:attribute name="text-align">
          <xsl:choose>
            <xsl:when test="@align='left'">
              <xsl:text>start</xsl:text>
            </xsl:when>
            <xsl:when test="@align='right'">
              <xsl:text>end</xsl:text>
            </xsl:when>
            <xsl:when test="@align='center'">
              <xsl:text>center</xsl:text>
            </xsl:when>
            <xsl:when test="@align='justify'">
              <xsl:text>justify</xsl:text>
            </xsl:when>
            <xsl:when test="@align='char'">
              <xsl:text>start</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:if
        test="@valign|parent::ead:row/@valign|parent::ead:row/parent::ead:tbody/@valign|parent::ead:row/parent::ead:thead/@valign">
        <xsl:attribute name="display-align">
          <xsl:choose>
            <xsl:when test="@valign">
              <xsl:call-template name="valign.choose"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="parent::ead:row/@valign">
                  <xsl:for-each select="parent::ead:row">
                    <xsl:call-template name="valign.choose"/>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="parent::ead:row/parent::ead:tbody/@valign">
                      <xsl:for-each select="parent::ead:row/parent::ead:tbody">
                        <xsl:call-template name="valign.choose"/>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:for-each select="parent::ead:row/parent::ead:thead">
                        <xsl:call-template name="valign.choose"/>
                      </xsl:for-each>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
      </xsl:if>
      <xsl:element name="fo:block" use-attribute-sets="table.cell.block">
        <xsl:apply-templates mode="inline"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>
  
  <!-- Template that is called to assign a display-align attribute value. -->
  <xsl:template name="valign.choose">
    <xsl:choose>
      <xsl:when test="@valign='top'">
        <xsl:text>before</xsl:text>
      </xsl:when>
      <xsl:when test="@valign='middle'">
        <xsl:text>center</xsl:text>
      </xsl:when>
      <xsl:when test="@valign='bottom'">
        <xsl:text>after</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- Block <div> Template -->
  <xsl:template match="ead:div" mode="block">
    <xsl:message>ead:div not rendered. </xsl:message>
  </xsl:template>
  
  <!-- Block <bioghist> template. -->
  <xsl:template match="ead:bioghist" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.bioghist">
      <xsl:call-template name="subsection_heading">
        <xsl:with-param name="head">
          <xsl:value-of select="ead:head"/>
        </xsl:with-param>
        <xsl:with-param name="id">
          <xsl:choose>
            <xsl:when test="@id">
              <xsl:value-of select="@id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="block_bioghist_id"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <controlaccess> template. -->
  <xsl:template match="ead:controlaccess" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.controlaccess">
      <xsl:call-template name="subsection_heading">
        <xsl:with-param name="head">
          <xsl:value-of select="ead:head"/>
        </xsl:with-param>
        <xsl:with-param name="id">
          <xsl:choose>
            <xsl:when test="@id">
              <xsl:value-of select="@id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="block_controlaccess_id"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <odd> template. -->
  <xsl:template match="ead:odd" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.odd">
      <xsl:call-template name="subsection_heading">
        <xsl:with-param name="head">
          <xsl:value-of select="ead:head"/>
        </xsl:with-param>
        <xsl:with-param name="id">
          <xsl:choose>
            <xsl:when test="@id">
              <xsl:value-of select="@id"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="block_odd_id"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates mode="block"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <persname> template  -->
  <xsl:template match="ead:persname" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <corpname> template  -->
  <xsl:template match="ead:corpname" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <famname> template  -->
  <xsl:template match="ead:famname" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <name> template  -->
  <xsl:template match="ead:name" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <subject> template  -->
  <xsl:template match="ead:subject" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <geogname> template  -->
  <xsl:template match="ead:geogname" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <genreform> template  -->
  <xsl:template match="ead:genreform" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <occupation> template  -->
  <xsl:template match="ead:occupation" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <function> template  -->
  <xsl:template match="ead:function" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <title> template  -->
  <xsl:template match="ead:title" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.accessterm">
      <xsl:apply-templates select="." mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <ref> template  -->
  <xsl:template match="ead:ref" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.links">
      <xsl:apply-templates select="." mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <ptr> template  -->
  <xsl:template match="ead:ptr" mode="block">
    <xsl:element name="fo:block" use-attribute-sets="block.links">
      <xsl:apply-templates select="." mode="inline"/>
    </xsl:element>
  </xsl:template>
  
  <!-- Block <c01> template  -->
  <xsl:template match="ead:c01" mode="block"/>
  
</xsl:stylesheet>