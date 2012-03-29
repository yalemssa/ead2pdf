<?xml version="1.0" encoding="UTF-8"?>
<!--
 ====================================================================
 =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95   =
 ====================================================================

Status:		    TEST
Contact:      mssa.systems@yale.edu, michael.rush@yale.edu
Created:	    2006-08-25
Updated:      2012-02-13
Requires:     FOP 0.95, 
              yul.ead2002.pdf.config.xsl
              yul.ead2002.pdf.titlepage.xsl
              yul.ead2002.pdf.inline.xsl
              yul.ead2002.pdf.block.xsl
              yul.ead2002.pdf.archdesc.xsl
              yul.ead2002.pdf.c0x.xsl
              http://www.library.yale.edu/facc/xsl/include/yale.ead2002.id_head_values.xsl
  
-->
<xsl:stylesheet version = "1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:svg="http://www.w3.org/TR/SVG"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:ead="urn:isbn:1-931666-22-9">
  
  <xsl:output indent="yes" method="xml" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>
  
  <xsl:include href="yul.ead2002.pdf.config.xsl" />
  <xsl:include href="yul.ead2002.pdf.titlepage.xsl"/>
  <xsl:include href="yul.ead2002.pdf.inline.xsl"/>
  <xsl:include href="yul.ead2002.pdf.block.xsl"/>
  <xsl:include href="yul.ead2002.pdf.archdesc.xsl"/>
  <xsl:include href="yul.ead2002.pdf.c0x.xsl"/>
  
  <xsl:variable name="file" select="normalize-space(//ead:eadid)" />
  
  
  <!--========== PAGE SETUP =======-->
  <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
      <fo:layout-master-set>
        <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
          margin-top="1cm" master-name="TitlePage" page-height="27.94cm" page-width="21.59cm">
          <fo:region-body margin-top="2cm" />
          <fo:region-before extent="2cm" />
          <fo:region-after extent="1.5cm" />
        </fo:simple-page-master>

        <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
          margin-top="1cm" master-name="ContentsPage" page-height="27.94cm" page-width="21.59cm">
          <fo:region-body margin-top="1.5cm" />
          <fo:region-before extent="2cm" />
          <fo:region-after extent="1.5cm" />
        </fo:simple-page-master>

        <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
          margin-top="1cm" master-name="Overview" page-height="27.94cm" page-width="21.59cm">
          <fo:region-body margin-top="1.5cm" />
          <fo:region-before extent="2cm" />
          <fo:region-after extent="1.5cm" />
        </fo:simple-page-master>

        <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
          margin-top="1cm" master-name="Inventory" page-height="27.94cm" page-width="21.59cm">
          <fo:region-body margin-top="1.5cm" />
          <fo:region-before extent="6cm"/>
          <fo:region-after extent="1.5cm" />
        </fo:simple-page-master>

        <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
          margin-top="1cm" master-name="Appendix" page-height="27.94cm" page-width="21.59cm">
          <fo:region-body margin-top="1.5cm" />
          <fo:region-before extent="6cm" />
          <fo:region-after extent="1.5cm" />
        </fo:simple-page-master>

        <xsl:if test="$includeAccessTerms='y'">
          <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
            margin-top="1cm" master-name="AccessTerms" page-height="27.94cm" page-width="21.59cm">
            <fo:region-body margin-top="1.5cm" />
            <fo:region-before extent="2cm" />
            <fo:region-after extent="1.5cm" />
          </fo:simple-page-master>
        </xsl:if>
        
        <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
          margin-top="1cm" master-name="blank-page" page-height="27.94cm" page-width="21.59cm">
          <fo:region-body margin-top="1.5cm" region-name="blank-body" />
          <fo:region-before extent="6cm" />
          <fo:region-after extent="1.5cm" />
        </fo:simple-page-master>

        <fo:page-sequence-master master-name="Repeats">
          <fo:repeatable-page-master-alternatives>
            <fo:conditional-page-master-reference blank-or-not-blank="blank"
              master-reference="blank-page" />
            <fo:conditional-page-master-reference master-reference="Inventory" odd-or-even="odd" />
            <fo:conditional-page-master-reference master-reference="Appendix" odd-or-even="odd" />
          </fo:repeatable-page-master-alternatives>

          <fo:repeatable-page-master-reference master-reference="Overview" />
          <fo:repeatable-page-master-reference master-reference="Appendix" />
          <!--this works but no "blank"<fo:repeatable-page-master-reference master-reference="Inventory" odd-or-even="odd"/>-->

        </fo:page-sequence-master>
      </fo:layout-master-set>
      <xsl:apply-templates select="ead:ead/ead:eadheader" mode="pdf"/>
      <xsl:apply-templates select="ead:ead/ead:archdesc" mode="pdf"/>
    </fo:root>
  </xsl:template>
  <!--========== END PAGE SETUP =======-->
  
  <!-- ead:filedesc Template - Creates Title Page -->
  <xsl:template match="ead:ead/ead:eadheader" mode="pdf">
    <!--========================= TitlePage Page Sequence  =========================-->
    <!--========================================================================-->
    <fo:page-sequence master-reference="TitlePage">
      <fo:static-content flow-name="xsl-region-before">
        <!-- FO header -->
        <xsl:apply-templates select="ead:filedesc/ead:publicationstmt/ead:publisher" mode="titlepage"/>
      </fo:static-content>
      <fo:static-content flow-name="xsl-region-after">
        <!--FO footer-->
        <xsl:choose>
          <xsl:when test="ead:filedesc/ead:publicationstmt/ead:p">
            <xsl:apply-templates select="ead:filedesc/ead:publicationstmt/ead:p" mode="titlepage"/>
          </xsl:when>
          <xsl:otherwise>
            <fo:block/>
          </xsl:otherwise>
        </xsl:choose>
      </fo:static-content>
      <fo:flow flow-name="xsl-region-body">
        
        <!--FO Titlepage body-->
        <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:titleproper[not(@type='filing')]" mode="titlepage"/>
        <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:subtitle" mode="titlepage"/>
        <xsl:call-template name="titlepage.unitid"/>
        <xsl:call-template name="titlepage.image"/>
        <xsl:if test="ead:filedesc/ead:notestmt/ead:note[@type='frontmatter'][descendant::ead:extptr]">
          <xsl:apply-templates select="ead:filedesc/ead:notestmt/ead:note[@type='frontmatter']" mode="titlepage"/>
        </xsl:if>
        <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:author" mode="titlepage"/>
        <xsl:apply-templates select="ead:filedesc/ead:titlestmt/ead:sponsor" mode="titlepage"/>
        <xsl:call-template name="publicationstmt.dates"/>
        <xsl:call-template name="publicationstmt.address"/>
        <xsl:if test="ead:filedesc/ead:notestmt/ead:note[@type='frontmatter'][not(descendant::ead:extptr)]">
          <xsl:apply-templates select="ead:filedesc/ead:notestmt/ead:note[@type='frontmatter']" mode="titlepage"/>
        </xsl:if>
      </fo:flow>
      
    </fo:page-sequence>
    <!-- END: TitlePage Page Sequence -->
  </xsl:template>
  <!-- END: ead:filedesc Template -->
  
  <!-- ead:archdesc Template - Creates Contents Page, Collection-Level Pages, Inventory, Appendices, and Access Terms   -->
  <xsl:template match="ead:ead/ead:archdesc" mode="pdf">
    
    <!--===================== ContentsPage Page Sequence ===================== -->
    <!--=================================================================== -->
    <fo:page-sequence master-reference="ContentsPage">
      
      <fo:static-content flow-name="xsl-region-before">
        <xsl:element name="fo:block" use-attribute-sets="page.header.right">
          <xsl:call-template name="staticHeader" />
        </xsl:element>
      </fo:static-content>
      
      <fo:flow flow-name="xsl-region-body">
        <!--SECTION HEAD-->
        <xsl:call-template name="section_heading">
          <xsl:with-param name="head">
            <xsl:value-of select="$tableOfContents_head"/>
          </xsl:with-param>
          <xsl:with-param name="id">
            <xsl:value-of select="$tableOfContents_id"/>
          </xsl:with-param>
        </xsl:call-template>

        <!-- Here starts the first table -->
        <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="15cm" />
          <fo:table-column column-width="1cm" />
          <xsl:element name="fo:table-body" use-attribute-sets="font">
            
            <!-- Aeon Paging Instructions -->
            <xsl:if test="$includeAeonRequests='y'">
              <xsl:call-template name="contents_cell_1">
                <xsl:with-param name="label">
                  <xsl:value-of select="$aeonPagingInstructions_head"/>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:value-of select="$aeonPagingInstructions_id"/>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:if>
            
              <!-- ead:archdesc/ead:did Contents Entry-->
              <xsl:for-each select="ead:did">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$did_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$did_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
              
              <!-- ead:archdesc/ead:descgrp[@type='admininfo'] Contents Entry-->
              <xsl:for-each select="ead:descgrp[@type='admininfo']">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$admininfo_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$admininfo_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
            
          </xsl:element>
        </fo:table>
        
        <!-- Second Table, for Admin Info Subsections -->
        <xsl:if test="ead:descgrp[@type='admininfo']/*[not(self::ead:head)]">
          <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="15cm" />
          <fo:table-column column-width="1cm" />
          <xsl:element name="fo:table-body" use-attribute-sets="font">
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:descgrp[@type='provenance'] Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:descgrp[@type='provenance']">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$provenance_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$provenance_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:acqinfo Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:acqinfo">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$acqinfo_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$acqinfo_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:custodhist Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:custodhist">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$custodhist_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$custodhist_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:accessrestrict Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:accessrestrict">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$accessrestrict_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$accessrestrict_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:userestrict Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:userestrict">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$userestrict_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$userestrict_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:prefercite Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:prefercite">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$prefercite_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$prefercite_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:processinfo Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:processinfo">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$processinfo_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$processinfo_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:altformavail Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:altformavail">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$altformavail_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$altformavail_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:relatedmaterial Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:relatedmaterial">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$relatedmaterial_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$relatedmaterial_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:separatedmaterial Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:separatedmaterial">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$separatedmaterial_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$separatedmaterial_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:accruals Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:accruals">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$accruals_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$accruals_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:appraisal Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:appraisal">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$appraisal_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$appraisal_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:originalsloc Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:originalsloc">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$originalsloc_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$originalsloc_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:otherfindaid Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:otherfindaid">
              <xsl:call-template name="contents_cell_2">
              <xsl:with-param name="label">
                <xsl:choose>
                  <xsl:when test="ead:head">
                    <xsl:value-of select="ead:head"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$otherfindaid_head"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
              <xsl:with-param name="id">
                <xsl:choose>
                  <xsl:when test="@id">
                    <xsl:value-of select="@id"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$otherfindaid_id"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:with-param>
            </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:phystech Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:phystech">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$phystech_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$phystech_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:fileplan Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:fileplan">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$fileplan_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$fileplan_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
            <!-- ead:archdesc/ead:descgrp[@type='admininfo']/ead:bibliography Contents Entry-->
            <xsl:for-each select="ead:descgrp[@type='admininfo']/ead:bibliography">
              <xsl:call-template name="contents_cell_2">
                <xsl:with-param name="label">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$bibliography_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$bibliography_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
            </xsl:for-each>
            
          </xsl:element>
        </fo:table>
        </xsl:if>
            
         
         <!-- Third  Table for Contents Entries-->
        <xsl:if test="ead:bioghist[not(@encodinganalog='545')]|ead:scopecontent|ead:arrangement|ead:dsc">
          <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="15cm" />
          <fo:table-column column-width="1cm" />
          <xsl:element name="fo:table-body" use-attribute-sets="font">
            
              <!-- ead:archdesc/ead:bioghist Contents Entry-->
            <xsl:for-each select="ead:bioghist[not(@encodinganalog='545')]">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$bioghist_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="bioghist_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
              
              <!-- ead:archdesc/ead:scopecontent Contents Entry-->
              <xsl:for-each select="ead:scopecontent">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$scopecontent_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$scopecontent_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
              
              <!-- ead:archdesc/ead:arrangement Contents Entry-->
              <xsl:for-each select="ead:arrangement">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$arrangement_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="arrangement_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
              
              <!-- ead:archdesc/ead:dsc Contents Entry-->
              <xsl:for-each select="ead:dsc">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$dsc_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$dsc_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
          </xsl:element>
          </fo:table>
        </xsl:if>
        
        
        <!-- Table for Series Contents Entries -->
        <xsl:if test="($multiple-c01-tables='y' and ead:dsc) or ead:index or ead:odd or ($includeAccessTerms='y' and ead:controlaccess)">
          <fo:table table-layout="fixed" width="100%">
          <fo:table-column column-width="15cm" />
          <fo:table-column column-width="1cm" />
          <xsl:element name="fo:table-body" use-attribute-sets="font">
            
            <!-- ead:archdesc/ead:dsc/ead:c01 Contents Entry -->
            <xsl:if test="$multiple-c01-tables='y'">
              <xsl:for-each select="ead:dsc/ead:c01">
                <xsl:call-template name="contents_cell_2">
                  <xsl:with-param name="label">
                    <xsl:if test="ead:did//ead:unitid">
                      <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                      <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:choose>
                      <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
                        <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="ead:did//ead:unitdate">
                      <xsl:text>, </xsl:text>
                      <xsl:apply-templates select="ead:did//ead:unitdate[1]" mode="inline"/>
                    </xsl:if>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:value-of select="@id" />
                  </xsl:with-param>
                </xsl:call-template>
                
                <xsl:choose>
                  
                  <xsl:when test="$lowestTocLevel='series'">
                    <xsl:if test="ead:c02[@level='series']">
                      <xsl:for-each select="ead:c02">
                        <xsl:call-template name="contents_cell_3">
                          <xsl:with-param name="label">
                            <xsl:if test="ead:did//ead:unitid">
                              <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                              <xsl:text> </xsl:text>
                            </xsl:if>
                            <xsl:choose>
                              <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
                                <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="ead:did//ead:unitdate">
                              <xsl:text>, </xsl:text>
                              <xsl:apply-templates select="ead:did//ead:unitdate[1]" mode="inline"/>
                            </xsl:if>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:value-of select="@id" />
                          </xsl:with-param>
                        </xsl:call-template>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:when>
                  
                  <xsl:when test="$lowestTocLevel='subseries'">
                    <xsl:if test="ead:c02[@level='subseries'] | ead:c02[@level='series']">
                      <xsl:for-each select="ead:c02">
                        <xsl:call-template name="contents_cell_3">
                          <xsl:with-param name="label">
                            <xsl:if test="ead:did//ead:unitid">
                              <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                              <xsl:text> </xsl:text>
                            </xsl:if>
                            <xsl:choose>
                              <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
                                <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
                              </xsl:when>
                              <xsl:otherwise>
                                <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
                              </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="ead:did//ead:unitdate">
                              <xsl:text>, </xsl:text>
                              <xsl:apply-templates select="ead:did//ead:unitdate[1]" mode="inline"/>
                            </xsl:if>
                          </xsl:with-param>
                          <xsl:with-param name="id">
                            <xsl:value-of select="@id" />
                          </xsl:with-param>
                        </xsl:call-template>
                        <xsl:if test="ead:c03[@level='subseries']">
                          <xsl:for-each select="ead:c03">
                            <xsl:call-template name="contents_cell_4">
                              <xsl:with-param name="label">
                                <xsl:if test="ead:did//ead:unitid">
                                  <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                                  <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:choose>
                                  <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
                                    <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="ead:did//ead:unitdate">
                                  <xsl:text>, </xsl:text>
                                  <xsl:apply-templates select="ead:did//ead:unitdate[1]" mode="inline"/>
                                </xsl:if>
                              </xsl:with-param>
                              <xsl:with-param name="id">
                                <xsl:value-of select="@id" />
                              </xsl:with-param>
                            </xsl:call-template>
                            <xsl:if test="ead:c04[@level='subseries']">
                              <xsl:for-each select="ead:c04">
                                <xsl:call-template name="contents_cell_5">
                                  <xsl:with-param name="label">
                                    <xsl:if test="ead:did//ead:unitid">
                                      <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                                      <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <xsl:choose>
                                      <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
                                        <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
                                      </xsl:when>
                                      <xsl:otherwise>
                                        <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
                                      </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="ead:did//ead:unitdate">
                                      <xsl:text>, </xsl:text>
                                      <xsl:apply-templates select="ead:did//ead:unitdate[1]" mode="inline"/>
                                    </xsl:if>
                                  </xsl:with-param>
                                  <xsl:with-param name="id">
                                    <xsl:value-of select="@id" />
                                  </xsl:with-param>
                                </xsl:call-template>
                                <xsl:if test="ead:c05[@level='subseries']">
                                  <xsl:for-each select="ead:c05">
                                    <xsl:call-template name="contents_cell_6">
                                      <xsl:with-param name="label">
                                        <xsl:if test="ead:did//ead:unitid">
                                          <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                                          <xsl:text> </xsl:text>
                                        </xsl:if>
                                        <xsl:choose>
                                          <xsl:when test="ead:did//ead:unittitle[1]/ead:*">
                                            <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
                                          </xsl:when>
                                          <xsl:otherwise>
                                            <xsl:value-of select="normalize-space(ead:did//ead:unittitle[1])"/>
                                          </xsl:otherwise>
                                        </xsl:choose>
                                        <xsl:if test="ead:did//ead:unitdate">
                                          <xsl:text>, </xsl:text>
                                          <xsl:apply-templates select="ead:did//ead:unitdate[1]" mode="inline"/>
                                        </xsl:if>
                                      </xsl:with-param>
                                      <xsl:with-param name="id">
                                        <xsl:value-of select="@id" />
                                      </xsl:with-param>
                                    </xsl:call-template>
                                  </xsl:for-each>
                                </xsl:if>
                              </xsl:for-each>
                            </xsl:if>
                          </xsl:for-each>
                        </xsl:if>
                      </xsl:for-each>
                    </xsl:if>
                  </xsl:when>
                </xsl:choose>
              </xsl:for-each>
            </xsl:if>
              
              <!-- ead:archdesc/ead:odd Contents Entry-->
              <xsl:for-each select="ead:odd">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$odd_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="odd_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
              
              <!-- ead:archdesc/ead:index Contents Entry-->
              <xsl:for-each select="ead:index">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$index_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:call-template name="index_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
            
            <!-- ead:archdesc/ead:controlaccess Contents Entry-->
            <xsl:if test="$includeAccessTerms='y'">
              <xsl:for-each select="ead:controlaccess">
                <xsl:call-template name="contents_cell_1">
                  <xsl:with-param name="label">
                    <xsl:choose>
                      <xsl:when test="ead:head">
                        <xsl:value-of select="ead:head"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$controlaccess_head"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                  <xsl:with-param name="id">
                    <xsl:choose>
                      <xsl:when test="@id">
                        <xsl:value-of select="@id"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$controlaccess_id"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:for-each>
            </xsl:if>
            
          </xsl:element>
          
        </fo:table>
        </xsl:if>
      </fo:flow>
    </fo:page-sequence>
    <!-- END: ContentsPage Page Sequence -->
    
    
    <!--======================== Overview Page Sequence ========================-->
    <!--=====================================================================-->
    <fo:page-sequence master-reference="Overview">

      <fo:static-content flow-name="xsl-region-before">
        <xsl:element name="fo:block" use-attribute-sets="page.header.right">
          <xsl:call-template name="staticHeader" />
        </xsl:element>
      </fo:static-content>

      <fo:flow flow-name="xsl-region-body">
        <!-- Aeon requesting instructions -->
        <xsl:if test="$includeAeonRequests='y'">
          <xsl:call-template name="aeonPagingInstructions"/>
        </xsl:if>
        <!-- <did> -->
        <xsl:apply-templates select="ead:did" mode="archdesc"/>
        <!-- <descgrp type="admininfo"> -->
        <xsl:apply-templates select="ead:descgrp[@type='admininfo']" mode="archdesc"/>
        <!-- <bioghist> -->
        <xsl:apply-templates select="ead:bioghist[not(@encodinganalog='545')]" mode="archdesc"/>
        <!-- <scopecontent> -->
        <xsl:apply-templates select="ead:scopecontent" mode="archdesc"/>
        <!-- <arrangement> -->
        <xsl:apply-templates select="ead:arrangement" mode="archdesc"/>
      </fo:flow>
    </fo:page-sequence>
    <!-- END: Overview Page Sequence -->
    
  
  <!--=================== Inventory Page-Sequence ================-->
  <!--============================================================-->
    <xsl:for-each select="ead:dsc">
      <xsl:choose>
        <xsl:when test="$multiple-c01-tables='n'">
          <fo:page-sequence  master-reference="Inventory">
            <fo:static-content flow-name="xsl-region-before">
              <xsl:element name="fo:block" use-attribute-sets="page.header.right">
                <xsl:call-template name="runningHeader"/>
              </xsl:element>
            </fo:static-content>
            <fo:flow flow-name="xsl-region-body">
              <xsl:call-template name="section_heading">
                <xsl:with-param name="head">
                  <xsl:choose>
                    <xsl:when test="ead:head">
                      <xsl:value-of select="ead:head"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$dsc_head"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="id">
                  <xsl:choose>
                    <xsl:when test="@id">
                      <xsl:value-of select="@id"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$dsc_id"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:with-param>
              </xsl:call-template>
              <xsl:apply-templates select="*[not(self::ead:thead)]" mode="block"/>
              <xsl:call-template name="single-dsc-table"/>
            </fo:flow>
          </fo:page-sequence>
        </xsl:when>
        <xsl:when test="$multiple-c01-tables='y'">
          <xsl:for-each select="ead:c01">
            <fo:page-sequence master-reference="Inventory">
              <fo:static-content flow-name="xsl-region-before">
                <xsl:element name="fo:block" use-attribute-sets="page.header.right">
                  <xsl:call-template name="runningHeader"/>
                </xsl:element>
              </fo:static-content>
              <fo:flow flow-name="xsl-region-body">
                <xsl:if test="not(preceding-sibling::ead:c01)">
                  <xsl:call-template name="section_heading">
                    <xsl:with-param name="head">
                      <xsl:choose>
                        <xsl:when test="../ead:head">
                          <xsl:value-of select="../ead:head"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$dsc_head"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:with-param>
                    <xsl:with-param name="id">
                      <xsl:choose>
                        <xsl:when test="../@id">
                          <xsl:value-of select="../@id"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select="$dsc_id"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:apply-templates select="../*[not(self::ead:thead)]" mode="block"/>
                </xsl:if>
                <xsl:apply-templates select="." mode="c0x"/>
              </fo:flow>
            </fo:page-sequence>
          </xsl:for-each>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
    
  <!-- END: Inventory Page Sequence -->
  
  
  <!--===================== Appendix Page-Sequence ==================-->
  <!--============================================================-->
  <xsl:if test="ead:odd or ead:index">
    <fo:page-sequence master-reference="Appendix">
      <fo:static-content flow-name="xsl-region-before">
        <xsl:element name="fo:block" use-attribute-sets="page.header.right">
          <xsl:call-template name="staticHeader" />
        </xsl:element>
    </fo:static-content>
    <fo:flow flow-name="xsl-region-body">
      <!-- <odd> -->
      <xsl:apply-templates select="ead:odd" mode="archdesc"/>
      <!-- <index> -->
      <xsl:apply-templates select="ead:index" mode="archdesc"/>
    </fo:flow>
  </fo:page-sequence>
  </xsl:if>
  <!-- END: Appendix Page Sequence -->
  
    <!--=================== Access Terms Page-Sequence ================-->
    <!--============================================================-->
    <xsl:if test="ead:controlaccess and $includeAccessTerms='y'">
      <fo:page-sequence master-reference="AccessTerms">
        <fo:static-content flow-name="xsl-region-before">
          <xsl:element name="fo:block" use-attribute-sets="page.header.right">
            <xsl:call-template name="staticHeader" />
          </xsl:element>
        </fo:static-content>
        <fo:flow flow-name="xsl-region-body">
          <!-- <controlaccess> -->
          <xsl:apply-templates select="ead:controlaccess" mode="archdesc"/>
        </fo:flow>
      </fo:page-sequence>
    </xsl:if>
    <!-- END: Access Terms Page Sequence -->
    
  </xsl:template>
  <!-- END ead:archdesc Template -->
  
  <!--Generica-->

  <xsl:template name="staticHeader">
    <fo:block><xsl:apply-templates select="//ead:archdesc/ead:did/ead:unittitle[1]" mode="inline"/> 
    <xsl:text> </xsl:text>
     </fo:block>
    <fo:block>
      <xsl:value-of select="//ead:archdesc/ead:did/ead:unitid[1]"/>
      <xsl:text> - </xsl:text>
      <xsl:text>Page </xsl:text><fo:page-number />
    </fo:block>
  </xsl:template>
  
  <xsl:template name="runningHeader">
    <fo:table table-layout="fixed" width="100%">
      <fo:table-column column-width="11cm" />
      <fo:table-column column-width="6cm" />
      <xsl:element name="fo:table-body" use-attribute-sets="font">
        <fo:table-row>
          <fo:table-cell>
            <xsl:element name="fo:block" use-attribute-sets="page.header.left">
              <!-- === SB ADDED: RUNNING HEAD LOOK-UP ===
                For each c01, we write a retrieve-marker of that heading, and then subsequent
                retrieve-markers to the necessary level. Note the class name uses the GI of
                the component, so it is easily produced by a for-each. This will result in, for
                instance 
                <fo:retrieve-marker retrieve-class-name="running-head-c01"/>
                <fo:retrieve-marker retrieve-class-name="running-head-c02"/>
                <fo:retrieve-marker retrieve-class-name="running-head-c03"/>
                <fo:retrieve-marker retrieve-class-name="running-head-c04"/>
                for a four-level component. At the start of each new page, this static content
                is used, and these are effectively instructions to look back up the file to the
                previous marker of the relevant clasee, and to output that content.
              -->
              <fo:block>
                <fo:retrieve-marker retrieve-class-name="running-head-c01"/>
              </fo:block>
              <xsl:if test=".//ead:c02">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c02"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c03">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c03"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c04">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c04"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c05">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c05"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c06">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c06"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c07">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c07"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c08">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c08"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c09">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c09"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c10">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c10"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c11">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c11"/>
                </fo:block>
              </xsl:if>
              <xsl:if test=".//ead:c12">
                <fo:block>
                  <fo:retrieve-marker retrieve-class-name="running-head-c12"/>
                </fo:block>
              </xsl:if>
            </xsl:element>
          </fo:table-cell>
          <fo:table-cell>
            <xsl:element name="fo:block" use-attribute-sets="page.header.right">
              <fo:block>
                <xsl:apply-templates select="//ead:archdesc/ead:did/ead:unittitle[1]" mode="inline"/> 
              </fo:block>
              <fo:block>
                <xsl:value-of select="//ead:archdesc/ead:did/ead:unitid[1]"/>
                <xsl:text> - </xsl:text>
                <xsl:text>Page </xsl:text><fo:page-number />
              </fo:block>
            </xsl:element>
          </fo:table-cell>
        </fo:table-row>
      </xsl:element>
      
    </fo:table>
  </xsl:template>
  
  <xsl:template name="write-marker">  
    <xsl:variable name="this.component" select="local-name()"/> 
    <xsl:call-template name="write-local-marker"/>
    <xsl:choose>
      <xsl:when test="self::ead:c12">
        <!-- Lowest possible level, so no need to write blank markers-->
      </xsl:when>
      <!--<xsl:when test="self::ead:c01">-->
        <!-- If this is c01 (top-level): no need to write blank markers as this is 
          a fresh page layout.-->
      <!--</xsl:when>-->
      <xsl:otherwise>
        <xsl:call-template name="write-blank-marker">
          <xsl:with-param name="level">
            <xsl:value-of select="number(translate($this.component,'c','') + 1)"/>
          </xsl:with-param>
        </xsl:call-template>
        <!-- For every component child of the preceding-sibling. output blank headers. -->
        <!--<xsl:for-each select="preceding-sibling::*[1][local-name()=$this.component]">
          <xsl:for-each select="descendant::ead:c02[1]|descendant::ead:c03[1]|descendant::ead:c04[1]|descendant::ead:c05[1]|descendant::ead:c06[1]|
            descendant::ead:c07[1]|descendant::ead:c08[1]|descendant::ead:c09[1]|descendant::ead:c10[1]|descendant::ead:c11[1]|
            descendant::ead:c12[1]">
            <xsl:call-template name="write-blank-marker"/>
          </xsl:for-each>
        </xsl:for-each>-->
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>    
  
  <xsl:template name="write-local-marker">
    <xsl:variable name="this.component" select="local-name()"/> 
    <!-- Markers are not output by the FO processor at their position within the body
      flow; rather they are looked up by fo:retrieve-marker (in the static content).
      Thus for every component we output the heading should this component fall at
      the top of a page, and the static content retrieves those it needs. We also
      need to output *blank* markers for lower levels to override previous branches
      of the tree. -->
    <fo:marker marker-class-name="running-head-{$this.component}">
      <xsl:element name="fo:block" use-attribute-sets="page.header.left">
        <xsl:attribute name="start-indent">
          <!-- The top-level (c01) outputs flush left; the remainder output
            indented by $head.indent points per ancestor. We use the component GI to 
            get the level to avoid having to actaully look around the tree, which
            is very expensive in large files.-->
          <xsl:value-of select="(number(translate(local-name(),'c','')) -1 ) * $head.indent"/>
          <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test="ead:c02|ead:c03|ead:c04|ead:c05|ead:c06|ead:c07|ead:c08|ead:c09|ead:c10|ead:c11|ead:c12">
            <xsl:variable name="unitidStringLength">
              <xsl:choose>
                <xsl:when test="normalize-space(ead:did//ead:unitid[1])">
                  <xsl:value-of select="string-length(normalize-space(ead:did//ead:unitid[1]))"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="0"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="unitidUnittitleCombinedStringLength">
              <xsl:value-of select="string-length(concat(normalize-space(ead:did//ead:unitid[1]),normalize-space(ead:did//ead:unittitle[1])))"/>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="self::ead:c01 and $unitidUnittitleCombinedStringLength > $runningHeaderC01StringLength">
                <xsl:variable name="unittitleSubstringLength">
                  <xsl:value-of select="$runningHeaderC01StringLength - $unitidStringLength"/>
                </xsl:variable>
                <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(normalize-space(ead:did//ead:unittitle[1]),1,$unittitleSubstringLength)"/>
                <xsl:text> [...]</xsl:text>
              </xsl:when>
              <xsl:when test="self::ead:c02 and $unitidUnittitleCombinedStringLength > $runningHeaderC02StringLength">
                <xsl:variable name="unittitleSubstringLength">
                  <xsl:value-of select="$runningHeaderC02StringLength - $unitidStringLength"/>
                </xsl:variable>
                <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(normalize-space(ead:did//ead:unittitle[1]),1,$unittitleSubstringLength)"/>
                <xsl:text> [...]</xsl:text>
              </xsl:when>
              <xsl:when test="self::ead:c03 and $unitidUnittitleCombinedStringLength > $runningHeaderC03StringLength">
                <xsl:variable name="unittitleSubstringLength">
                  <xsl:value-of select="$runningHeaderC03StringLength - $unitidStringLength"/>
                </xsl:variable>
                <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(normalize-space(ead:did//ead:unittitle[1]),1,$unittitleSubstringLength)"/>
                <xsl:text> [...]</xsl:text>
              </xsl:when>
              <xsl:when test="self::ead:c04 and $unitidUnittitleCombinedStringLength > $runningHeaderC04StringLength">
                <xsl:variable name="unittitleSubstringLength">
                  <xsl:value-of select="$runningHeaderC04StringLength - $unitidStringLength"/>
                </xsl:variable>
                <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(normalize-space(ead:did//ead:unittitle[1]),1,$unittitleSubstringLength)"/>
                <xsl:text> [...]</xsl:text>
              </xsl:when>
              <xsl:when test="self::ead:c05 and $unitidUnittitleCombinedStringLength > $runningHeaderC05StringLength">
                <xsl:variable name="unittitleSubstringLength">
                  <xsl:value-of select="$runningHeaderC05StringLength - $unitidStringLength"/>
                </xsl:variable>
                <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="substring(normalize-space(ead:did//ead:unittitle[1]),1,$unittitleSubstringLength)"/>
                <xsl:text> [...]</xsl:text>
              </xsl:when>
              <xsl:when test="self::ead:c06|self::ead:c07|self::ead:c08|self::ead:c09|self::ead:c10|self::ead:c11|self::ead:c12">
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="ead:did//ead:unitid[1]" mode="inline"/>
                <xsl:text> </xsl:text>
                <xsl:apply-templates select="ead:did//ead:unittitle[1]" mode="inline"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text> </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:element>
    </fo:marker>
    <xsl:if test="not(parent::ead:dsc)">
      <xsl:for-each select="parent::ead:*">
        <xsl:call-template name="write-local-marker"/>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template name="write-blank-marker">
    <xsl:param name="level"/>
    <xsl:param name="lowestLevel">
      <xsl:for-each select="/ead:ead//ead:dsc">
        <xsl:choose>
          <xsl:when test="descendant::ead:c12">
            <xsl:text>12</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c11 and not(descendant::ead:c12)">
            <xsl:text>11</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c10 and not(descendant::ead:c11)">
            <xsl:text>10</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c09 and not(descendant::ead:c10)">
            <xsl:text>9</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c08 and not(descendant::ead:c09)">
            <xsl:text>8</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c07 and not(descendant::ead:c08)">
            <xsl:text>7</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c06 and not(descendant::ead:c07)">
            <xsl:text>6</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c05 and not(descendant::ead:c06)">
            <xsl:text>5</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c04 and not(descendant::ead:c05)">
            <xsl:text>4</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c03 and not(descendant::ead:c04)">
            <xsl:text>3</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c02 and not(descendant::ead:c03)">
            <xsl:text>2</xsl:text>
          </xsl:when>
          <xsl:when test="descendant::ead:c01 and not(descendant::ead:c02)">
            <xsl:text>1</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
    </xsl:param>
    <xsl:variable name="level-name">
      <xsl:choose>
        <xsl:when test="$level=11 or $level=12">
          <xsl:value-of select="concat('c',$level)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('c0',$level)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:comment>BLANK MARKER</xsl:comment>
    <fo:marker marker-class-name="running-head-{$level-name}">
      <fo:block>
        <xsl:text> </xsl:text>
      </fo:block>
    </fo:marker>
    <xsl:if test="$level &lt; $lowestLevel">
      <xsl:call-template name="write-blank-marker">
        <xsl:with-param name="lowestLevel">
          <xsl:value-of select="$lowestLevel"/>
        </xsl:with-param>
        <xsl:with-param name="level">
          <xsl:value-of select="$level + 1"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
