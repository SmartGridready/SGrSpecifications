<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- Generic Functional Profiles -->
    <xsl:template match="sgr:FunctionalProfileFrame">
        <table style="border:hidden;">
            <thead><tr style="border:hidden;"><td>
                <div class="documentheader">
                <img src="https://smartgridready.ch/media/images/Logos/SGR_LOGO_REDESIGN_RGB.svg" height= "134px" />
                <span style="float:right;">Functional Profile Definition</span></div>
            </td></tr></thead>
            <tbody><tr style="border:hidden;"><td>
                <div class="functionalProfile">
                    <h2>
        
                        <xsl:value-of
                            select="sgr:functionalProfile/sgr:functionalProfileIdentification/sgr:functionalProfileCategory" />
                        - <xsl:value-of
                            select="sgr:functionalProfile/sgr:functionalProfileIdentification/sgr:functionalProfileType" />
                        (Level <xsl:value-of
                            select="sgr:functionalProfile/sgr:functionalProfileIdentification/sgr:levelOfOperation" />)
                    </h2>
                    <br />
        
                    <xsl:apply-templates select="sgr:releaseNotes" />
        
                    <table>
                        <colgroup>
                            <col style="width:30%" />
                        </colgroup>
                        <tr>
                            <td class="fpHeader">
                                <h4>Classification</h4>
                            </td>
                            <td class="fpHeader">
                                <table>
                                    <colgroup>
                                        <col style="width:30%" />
                                    </colgroup>
        
                                    <xsl:apply-templates
                                        select="/*/sgr:functionalProfile/sgr:functionalProfileIdentification">
                                        <xsl:with-param name="separator" select="' - '" />
                                    </xsl:apply-templates>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br />
        
                    <!-- Functional Profile Block -->
                    <table>
                        <colgroup>
                            <col style="width:230px" />
                        </colgroup>
        
                        <!-- alternativeNames -->
                        <xsl:apply-templates select="sgr:functionalProfile/sgr:alternativeNames" />
                        <xsl:apply-templates select="sgr:functionalProfile/sgr:legibleDescription" />
                        <xsl:apply-templates select="sgr:genericAttributes" />
                    </table>
        
                    <xsl:apply-templates select="sgr:dataPointList" />

                    <xsl:if test="//sgr:genericAttributeList">
                        <div class="functionalProfile">
                            <h2>Table of Attributes</h2>
                            <!-- Generic Attributes -->
                            <table>
                                <colgroup>
                                    <col style="width:230px" />
                                    <col style="width:134px" />
                                </colgroup>
                                <tr>
                                    <th>Attribute</th>
                                    <th>Type</th>
                                    <th>Description</th>
                                </tr>
        
                                <!--//sgr:attributeList-->
                                <xsl:if test="//sgr:genericAttributeList">
                                    <xsl:for-each select="//sgr:genericAttributeList/sgr:genericAttributeListElement[not(sgr:name=preceding::sgr:name)]">
                                        <xsl:sort select="sgr:name"/>
                                        <tr class="genericDetails">
                                            <xsl:variable name="name" select="sgr:name"/> 
                                            <xsl:variable name="attribute" select="document(concat('../GenericAttributes/', $name, '.xml'))"/>
                                            <td class="genericattribute">
                                              <xsl:value-of select="$attribute/sgr:GenericAttributeFrame/sgr:name"/>
                                              <xsl:for-each select="$attribute/sgr:GenericAttributeFrame/sgr:genericAttributeList/sgr:genericAttributeListElement">
                                                <ul style="margin: 0">
                                                  <li><xsl:value-of select="sgr:name"/></li>
                                                </ul>
                                              </xsl:for-each>
                                            </td>
                                            <td>
                                              <xsl:apply-templates select="$attribute/sgr:GenericAttributeFrame/sgr:dataType" />&#160;
                                              <xsl:for-each select="$attribute/sgr:GenericAttributeFrame/sgr:genericAttributeList/sgr:genericAttributeListElement">
                                                <ul style="margin: 0">
                                                  <li><xsl:apply-templates select="sgr:dataType" /></li>
                                                </ul>
                                              </xsl:for-each>
                                            </td>
                                            <td>
                                                <xsl:for-each select="$attribute/sgr:GenericAttributeFrame/sgr:legibleDescription">
                                                    <div>
                                                        <xsl:call-template name="SGrLanguageText">
                                                            <xsl:with-param name="lang"><xsl:value-of select="sgr:language" /></xsl:with-param>
                                                            <xsl:with-param name="value"><xsl:value-of select="sgr:textElement" /></xsl:with-param>
                                                        </xsl:call-template>
                                                    </div>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </xsl:if>

                            </table>
                        </div>
                    </xsl:if>

                </div>
            </td></tr></tbody>
            <tfoot><tr style="border:hidden;"><td>
                <!-- Footer-->
                <div class="documentfooter"> Information and Support at <a
                        href="http://www.smartgridready.ch">www.smartgridready.ch</a> or email <a
                        href="mailto:deklaration@smartgridready.ch">deklaration@smartgridready.ch</a>
                        <br/><sup>1)</sup> presence level: M mandatory, R recommended, O optional
                        <br/><sup>2)</sup> data direction: R read, W write
                </div>
            </td></tr></tfoot>
        </table>
    </xsl:template>

</xsl:stylesheet>