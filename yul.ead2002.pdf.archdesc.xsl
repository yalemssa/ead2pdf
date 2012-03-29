<?xml version="1.0" encoding="UTF-8"?>
<!--
  =======================================================================================
  =   YUL Common XSLT for presenting XSD-Valid EAD 2002 as PDF USING FOP 0.95  ==  <archdesc> Module  =
  =======================================================================================

Status:		TEST
Contact:       mssa.systems@yale.edu, michael.rush@yale.edu
Created:	2007-11-15
Updated:     2012-02-13

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
  <!--<xsl:template match="ead:*[@audience='internal']" priority="1" mode="archdesc"/>-->
  <!--<xsl:template match="ead:*[@altrender='nodisplay']" priority="2" mode="archdesc"/>-->
  
  <!-- Aeon Requesting Instructions -->
  <xsl:template name="aeonPagingInstructions">
    <xsl:call-template name="section_heading">
      <xsl:with-param name="head">
        <xsl:value-of select="$aeonPagingInstructions_head"/>
      </xsl:with-param>
      <xsl:with-param name="id">
        <xsl:value-of select="$aeonPagingInstructions_id"/>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
      <xsl:when test="$repository_code='beinecke'">
        <xsl:element name="fo:block" use-attribute-sets="p.generic">
          <xsl:text>To request items from this collection for use in the 
            Beinecke Library reading room, please use the request links in the 
            HTML version of this finding aid, available at </xsl:text>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:value-of select="$handleURL"/>
              </xsl:attribute>
              <xsl:value-of select="$handleURL"/>
            </xsl:element>
          </fo:wrapper>
          <xsl:text>.</xsl:text>
        </xsl:element>
        <xsl:element name="fo:block" use-attribute-sets="p.generic">
          <xsl:text>To order reproductions from this collection, please 
            send an email with the call number, box number(s), and folder number(s) to  </xsl:text>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:text>mailto:beinecke.images@yale.edu</xsl:text>
              </xsl:attribute>
              <xsl:text>beinecke.images@yale.edu</xsl:text>
            </xsl:element>
          </fo:wrapper>
          <xsl:text>.</xsl:text>
        </xsl:element>
      </xsl:when>
      <xsl:when test="$repository_code='mssa'">
        <xsl:element name="fo:block" use-attribute-sets="p.generic">
          <xsl:text>To request items from this collection for use in 
            the Manuscripts and Archives reading room, please use the 
            request links in the HTML version of this finding aid, available at </xsl:text>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:value-of select="$handleURL"/>
              </xsl:attribute>
              <xsl:value-of select="$handleURL"/>
            </xsl:element>
          </fo:wrapper>
          <xsl:text>.</xsl:text>
        </xsl:element>
        <xsl:element name="fo:block" use-attribute-sets="p.generic">
          <xsl:text>To order reproductions from this collection, please go to </xsl:text>
          <fo:wrapper color="{$linkcolor}">
            <xsl:element name="fo:basic-link">
              <xsl:attribute name="external-destination">
                <xsl:text>http://www.library.yale.edu/mssa/ifr_copy_order.html</xsl:text>
              </xsl:attribute>
              <xsl:text>http://www.library.yale.edu/mssa/ifr_copy_order.html</xsl:text>
            </xsl:element>
          </fo:wrapper>
          <xsl:text>.  The information you will need to submit an order 
            includes: the collection call number, collection title, 
            series or accession number, box number, and folder number or name.</xsl:text>
        </xsl:element>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did -->
  <xsl:template match="ead:did" mode="archdesc">
    <xsl:call-template name="section_heading">
      <xsl:with-param name="head">
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
    <fo:table table-layout="fixed" width="100%">
      <fo:table-column column-width="5cm" />
      <fo:table-column column-width="11cm" />
      <xsl:element name="fo:table-body" use-attribute-sets="font">
        <xsl:apply-templates select="ead:repository" mode="archdesc"/>
        <xsl:apply-templates select="ead:unitid" mode="archdesc"/>
        <xsl:apply-templates select="ead:origination" mode="archdesc"/>
        <xsl:apply-templates select="ead:unittitle" mode="archdesc"/>
        <xsl:apply-templates select="ead:unitdate[@type='inclusive']" mode="archdesc"/>
        <xsl:apply-templates select="ead:unitdate[@type='bulk']" mode="archdesc"/>
        <xsl:apply-templates select="ead:physdesc" mode="archdesc"/>
        <xsl:apply-templates select="ead:langmaterial" mode="archdesc"/>
        <xsl:apply-templates select="../ead:bioghist[@encodinganalog='545']" mode="archdesc"/>
        <xsl:apply-templates select="ead:abstract" mode="archdesc"/>
        <xsl:apply-templates select="ead:physloc" mode="archdesc"/>
        <xsl:apply-templates select="ead:materialspec" mode="archdesc"/>
        <xsl:apply-templates select="ead:note" mode="archdesc"/>
        <!--<xsl:call-template name="did.orbis.search"/>-->
        <!--<xsl:call-template name="did.dl.search"/>-->
        <xsl:call-template name="did.fa.handle.link"/>
        <xsl:call-template name="did.requestForm.link"/>
      </xsl:element>
    </fo:table>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:unitid -->
  <xsl:template match="ead:unitid" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$unitid_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:origination -->
  <xsl:template match="ead:origination" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$origination_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:unittitle -->
  <xsl:template match="ead:unittitle" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$unittitle_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:unitdate[@type='inclusive'] -->
  <xsl:template match="ead:unitdate[@type='inclusive']" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$unitdate_label_inclusive" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:unitdate[@type='bulk'] -->
  <xsl:template match="ead:unitdate[@type='bulk']" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$unitdate_label_bulk" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:physdesc -->
  <xsl:template match="ead:physdesc" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$physdesc_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:langmaterial -->
  <xsl:template match="ead:langmaterial" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$langmaterial_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:abstract -->
  <xsl:template match="ead:abstract" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$abstract_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:physloc -->
  <xsl:template match="ead:physloc" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$physloc_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:materialspec -->
  <xsl:template match="ead:materialspec" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$materialspec_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:note -->
  <xsl:template match="ead:note[not(@id='locNote') and not(@id='genNote')]" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$note_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:did/ead:repository -->
  <xsl:template match="ead:repository" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="@label">
            <xsl:value-of select="@label"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$repository_label" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- Orbis Search Template -->
  <xsl:template name="did.orbis.search">
    <fo:table-row keep-together.within-page="always">
      <!-- the label cell-->
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="overview.label.cells">
          <xsl:value-of select="$catalog_record_label"/>
        </xsl:element>
      </fo:table-cell>
      <!-- the element content cell-->
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="overview.content.cells">
            <fo:wrapper color="{$linkcolor}">
              <xsl:element name="fo:basic-link">
                <xsl:attribute name="external-destination">
                  <xsl:value-of select="$orbisUrl"/>
                </xsl:attribute>
                <xsl:text>A record for this collection may be available in Orbis, the Yale University Library catalog.</xsl:text>
              </xsl:element>
            </fo:wrapper>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>
  
  <!-- DL Search Template -->
  <xsl:template name="did.dl.search">
    <xsl:if test="$include_dl_search='y'">
      <fo:table-row keep-together.within-page="always">
        <!-- the label cell-->
        <fo:table-cell>
          <xsl:element name="fo:block" use-attribute-sets="overview.label.cells">
            <xsl:value-of select="$dl_search_label"/>
          </xsl:element>
        </fo:table-cell>
        <!-- the element content cell-->
        <fo:table-cell>
          <xsl:element name="fo:block" use-attribute-sets="overview.content.cells">
            <xsl:choose>
              <xsl:when test="$repository_code='mssa'">
                <xsl:choose>
                  <xsl:when test="contains(/ead:ead/ead:eadheader/ead:eadid, '.ms.')">
                    <fo:wrapper color="{$linkcolor}">
                      <xsl:element name="fo:basic-link">
                        <xsl:attribute name="external-destination">
                          <xsl:text>http://images.library.yale.edu/madid/showthumb.aspx?q1=</xsl:text><xsl:value-of select="substring-after(normalize-space(/ead:ead/ead:eadheader/ead:eadid), '.ms.')"/><xsl:text>&amp;qc1=contains&amp;qf1=subject1&amp;qx=1004.2</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Search for digital images from this collection.</xsl:text>
                      </xsl:element>
                    </fo:wrapper>
                  </xsl:when>
                  <xsl:when test="contains(/ead:ead/ead:eadheader/ead:eadid, '.ru.')">
                    <fo:wrapper color="{$linkcolor}">
                      <xsl:element name="fo:basic-link">
                        <xsl:attribute name="external-destination">
                          <xsl:text>http://images.library.yale.edu/madid/showthumb.aspx?q1=</xsl:text><xsl:value-of select="substring-after(normalize-space(/ead:ead/ead:eadheader/ead:eadid), '.ru.')"/><xsl:text>&amp;qc1=contains&amp;qf1=subject1&amp;qx=1004.1</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Search for digital images from this collection.</xsl:text>
                      </xsl:element>
                    </fo:wrapper>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="$repository_code='beinecke'">
                <fo:wrapper color="{$linkcolor}">
                  <xsl:element name="fo:basic-link">
                    <xsl:attribute name="external-destination">
                      <xsl:text>http://beinecke.library.yale.edu/dl_crosscollex/callnumSRCHXC.asp?callnum=</xsl:text><xsl:value-of select="translate(normalize-space(/ead:ead/ead:archdesc/ead:did/ead:unitid[1]),' ','_')"/>
                    </xsl:attribute>
                    <xsl:text>Search for digital images from this collection.</xsl:text>
                  </xsl:element>
                </fo:wrapper>
              </xsl:when>
            </xsl:choose>
          </xsl:element>
        </fo:table-cell>
      </fo:table-row>
    </xsl:if>
  </xsl:template>
  
  <!-- Request Form Link Template -->
  <xsl:template name="did.requestForm.link">
    <xsl:if test="$include_requestForm_link='y'">
    <fo:table-row keep-together.within-page="always">
      <!-- the label cell-->
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="overview.label.cells">
          <xsl:value-of select="$requestForm_link_label"/>
        </xsl:element>
      </fo:table-cell>
      <!-- the element content cell-->
      <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="overview.content.cells">
          <xsl:choose>
            <xsl:when test="$repository_code='divinity'">
              <xsl:text>To view manuscript and archival materials at the Yale Divinity Library, please submit the request form at </xsl:text>
              <fo:wrapper color="{$linkcolor}">
                <xsl:element name="fo:basic-link">
                  <xsl:attribute name="external-destination">
                    <xsl:text>http://www.library.yale.edu/div/request.htm</xsl:text>
                  </xsl:attribute>
                <xsl:text>http://www.library.yale.edu/div/request.htm</xsl:text>
                  </xsl:element>
                </fo:wrapper>
              <xsl:text>.</xsl:text>
            </xsl:when>
          </xsl:choose>
        </xsl:element>
      </fo:table-cell>
    </fo:table-row>
      </xsl:if>
  </xsl:template>
  
  <!-- Finding Aid Handle Link Template -->
  <xsl:template name="did.fa.handle.link">
      <fo:table-row keep-together.within-page="always">
        <!-- the label cell-->
        <fo:table-cell>
        <xsl:element name="fo:block" use-attribute-sets="overview.label.cells">
          <xsl:value-of select="$faHandle_link_label"/>
        </xsl:element>
        </fo:table-cell>
        <!-- the element content cell-->
        <fo:table-cell>
          <xsl:element name="fo:block" use-attribute-sets="overview.content.cells">
            <xsl:text>To cite or bookmark this finding aid, use the following address: </xsl:text>
            <fo:block>
                <fo:wrapper color="{$linkcolor}">
                  <xsl:element name="fo:basic-link">
                    <xsl:attribute name="external-destination">
                      <xsl:value-of select="$handleURL"/>
                    </xsl:attribute>
                    <xsl:value-of select="$handleURL"/>
                  </xsl:element>
                </fo:wrapper>
                <xsl:text>.</xsl:text>
              </fo:block>
          </xsl:element>
        </fo:table-cell>
      </fo:table-row>
    
  </xsl:template>
  
  <!-- ead:archdesc/ead:bioghist[@encodinganalog='545'] -->
  <xsl:template match="ead:bioghist[@encodinganalog='545']" mode="archdesc">
    <xsl:call-template name="overview_cell">
      <xsl:with-param name="label">
        <xsl:choose>
          <xsl:when test="ead:head">
            <xsl:variable name="headVal" select="normalize-space(ead:head)"/>
            <xsl:variable name="headValLength" select="string-length($headVal)"/>
            <xsl:variable name="headValLastChar" select="substring($headVal,$headValLength,$headValLength)"/>
            <xsl:value-of select="$headVal"/>
            <xsl:if test="$headValLastChar!=':'">
              <xsl:text>:</xsl:text>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$bioghist_545_label"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="value">
        <xsl:apply-templates select="ead:*[not(self::ead:head)]" mode="inline"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type='admininfo'] -->
  <xsl:template match="ead:descgrp[@type='admininfo']" mode="archdesc">
    <!--<fo:block break-before="page">-->
    <fo:block>
      <xsl:call-template name="section_heading">
        <xsl:with-param name="head">
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
    </fo:block>
    <xsl:apply-templates select="ead:descgrp[@type='provenance']" mode="archdesc"/>
    <xsl:apply-templates select="ead:acqinfo" mode="archdesc"/>
    <xsl:apply-templates select="ead:custodhist" mode="archdesc"/>
    <xsl:apply-templates select="ead:accessrestrict" mode="archdesc"/>
    <xsl:apply-templates select="ead:userestrict" mode="archdesc"/>
    <xsl:apply-templates select="ead:prefercite" mode="archdesc"/>
    <xsl:apply-templates select="ead:processinfo" mode="archdesc"/>
    <xsl:apply-templates select="ead:altformavail" mode="archdesc"/>
    <xsl:apply-templates select="ead:relatedmaterial" mode="archdesc"/>
    <xsl:apply-templates select="ead:separatedmaterial" mode="archdesc"/>
    <xsl:apply-templates select="ead:accruals" mode="archdesc"/>
    <xsl:apply-templates select="ead:appraisal" mode="archdesc"/>
    <xsl:apply-templates select="ead:originalsloc" mode="archdesc"/>
    <xsl:apply-templates select="ead:otherfindaid" mode="archdesc"/>
    <xsl:apply-templates select="ead:phystech" mode="archdesc"/>
    <xsl:apply-templates select="ead:fileplan" mode="archdesc"/>
    <xsl:apply-templates select="ead:bibliography" mode="archdesc"/>
        
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:descgrp[@type="provenance"] -->
  <xsl:template match="ead:descgrp[@type='provenance']" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates select="ead:acqinfo/ead:*" mode="block"/>
    <xsl:apply-templates select="ead:custodhist/ead:*" mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:acqinfo -->
  <xsl:template match="ead:acqinfo" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:custodhist -->
  <xsl:template match="ead:custodhist" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:accessrestrict -->
  <!-- Adds boilerplate paragraph for BRBL finding aids. -->
  <xsl:template match="ead:accessrestrict" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
    <xsl:if test="$repository_code='beinecke'">
      <xsl:element name="fo:block" use-attribute-sets="p.generic">
        <xsl:text>This collection may be housed off-site at Yale’s Library Shelving Facility (LSF).  
          To determine if all or part of this collection is housed off-site please check the library’s online catalog, </xsl:text>
        <fo:wrapper color="{$linkcolor}">
          <xsl:element name="fo:basic-link">
            <xsl:attribute name="external-destination">
              <xsl:value-of select="$orbisUrl"/>
            </xsl:attribute>
            <xsl:text>Orbis</xsl:text>
          </xsl:element></fo:wrapper>
        <xsl:text>; material for which the location is given as “LSF” must be requested 36 hours in advance.  
                            Please consult with Beinecke Access Services for more information.</xsl:text>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:userestrict -->
  <xsl:template match="ead:userestrict" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:prefercite -->
  <xsl:template match="ead:prefercite" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:processinfo -->
  <xsl:template match="ead:processinfo" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:relatedmaterial -->
  <xsl:template match="ead:relatedmaterial" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:separatedmaterial -->
  <xsl:template match="ead:separatedmaterial" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:altformavail -->
  <xsl:template match="ead:altformavail" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:accruals -->
  <xsl:template match="ead:accruals" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:appraisal -->
  <xsl:template match="ead:appraisal" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:originalsloc -->
  <xsl:template match="ead:originalsloc" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:otherfindaid -->
  <xsl:template match="ead:otherfindaid" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:phystech -->
  <xsl:template match="ead:phystech" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:fileplan -->
  <xsl:template match="ead:fileplan" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:descgrp[@type="admininfo"]/ead:bibliography -->
  <xsl:template match="ead:bibliography" mode="archdesc">
    <xsl:call-template name="subsection_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:bioghist  -->
  <xsl:template match="ead:bioghist[not(@encodinganalog='545')]" mode="archdesc">
    <fo:block>
      <xsl:call-template name="section_heading">
        <xsl:with-param name="head">
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
    </fo:block>
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:scopecontent -->
  <xsl:template match="ead:scopecontent" mode="archdesc">
    <fo:block>
      <xsl:call-template name="section_heading">
        <xsl:with-param name="head">
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
    </fo:block>
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:arrangement -->
  <xsl:template match="ead:arrangement" mode="archdesc">
    <xsl:call-template name="section_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:controlaccess -->
  <xsl:template match="ead:controlaccess" mode="archdesc">
    <xsl:call-template name="section_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates mode="block"/>
  </xsl:template>
  
  <!-- ead:archdesc/ead:odd -->
  <xsl:template match="ead:odd" mode="archdesc">
      <xsl:call-template name="section_heading">
      <xsl:with-param name="head">
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
      <!--</xsl:if>-->
    <xsl:apply-templates mode="block" />       
  </xsl:template>
  
  <!-- ead:archdesc/ead:index -->
  <xsl:template match="ead:index" mode="archdesc">
    <xsl:call-template name="section_heading">
      <xsl:with-param name="head">
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
    <xsl:apply-templates select="ead:p" mode="block"/>
    <xsl:if test="ead:list">
      <xsl:apply-templates select="ead:list" mode="block" />
    </xsl:if>
    <xsl:if test="ead:indexentry">
      <fo:table table-layout="fixed" width="100%" table-omit-header-at-break="false">
        <fo:table-column column-width="5cm" />
        <fo:table-column column-width="1cm" />
        <fo:table-column column-width="11cm" />
        <xsl:if test="ead:listhead">
          <fo:table-header>
            <fo:table-row>
              <fo:table-cell>
                <xsl:element name="fo:block" use-attribute-sets="listhead">
                  <xsl:attribute name="space-before.optimum">
                    <xsl:text>10pt</xsl:text>
                  </xsl:attribute>
                  <xsl:apply-templates select="ead:listhead/ead:head01" mode="inline"/>
                </xsl:element>
              </fo:table-cell>
              <fo:table-cell>
                <fo:block space-before.optimum="10pt" text-align="start" />
              </fo:table-cell>
              <fo:table-cell>
                <xsl:element name="fo:block" use-attribute-sets="listhead">
                  <xsl:attribute name="space-before.optimum">
                    <xsl:text>10pt</xsl:text>
                  </xsl:attribute>
                  <xsl:apply-templates select="ead:listhead/ead:head02" mode="inline"/>
                </xsl:element>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-header>
        </xsl:if>
        <fo:table-body>
          <xsl:for-each select="ead:indexentry">
            <fo:table-row>
              <xsl:for-each select="ead:namegrp">
                <fo:table-cell>
                  <xsl:if test="../@id">
                    <xsl:attribute name="id">
                      <xsl:value-of select="../@id"/>
                    </xsl:attribute>
                  </xsl:if>
                  <fo:block space-before.optimum="10pt" text-align="start" >
                  <xsl:apply-templates mode="block"/>
                  </fo:block>
                </fo:table-cell>
              </xsl:for-each>
              <fo:table-cell>
                <fo:block space-before.optimum="10pt" text-align="start" />
              </fo:table-cell>
              <xsl:for-each select="ead:ptrgrp">
                <fo:table-cell>
                  <fo:block space-before.optimum="10pt" text-align="start">
                    <xsl:apply-templates mode="block"/>
                  </fo:block>
                </fo:table-cell>
              </xsl:for-each>
            </fo:table-row>
          </xsl:for-each>
        </fo:table-body>
      </fo:table>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>