<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- Device Frames -->
    <xsl:template match="sgr:DeviceFrame">
        <table style="border:hidden;">
            <thead><tr style="border:hidden;"><td>
                <div class="documentheader">
                <img src="https://smartgridready.ch/media/images/Logos/SGR_LOGO_REDESIGN_RGB.svg" height= "134px" />
                <span style="float:right;">Product Declaration</span></div>
            </td></tr></thead>
            <tbody><tr style="border:hidden;"><td>
                <div class="product">
                    <h1>
                        <xsl:value-of select="sgr:manufacturerName" /> -
                        <xsl:value-of select="sgr:deviceName" />
                        
                        <xsl:if test="sgr:deviceInformation/sgr:levelOfOperation">
                            (Level <xsl:value-of select="sgr:deviceInformation/sgr:levelOfOperation" />)
                        </xsl:if>
                    </h1>
        
                    <xsl:apply-templates select="sgr:releaseNotes" />
        
                    <table>
                        <colgroup>
                            <col style="width:230px" />
                        </colgroup>
                        <tr>
                            <td>Name</td>
                            <td>
                                <xsl:value-of select="sgr:deviceName" />
                            </td>
                        </tr>
                        <tr>
                            <td>Manufacturer</td>
                            <td>
                                <xsl:value-of select="sgr:manufacturerName" />
                            </td>
                        </tr>
                        <xsl:if test="sgr:deviceInformation/sgr:versionNumber">
                            <tr>
                                <td>Version</td>
                                <td>
                                    <xsl:apply-templates select="sgr:deviceInformation/sgr:versionNumber" />
                                </td>
                            </tr>
                        </xsl:if>

                        <tr>
                            <td class="noborder" />
                        </tr>
        
                        <xsl:apply-templates select="sgr:deviceInformation" />
                        <xsl:apply-templates select="sgr:genericAttributeList" />
                        <xsl:apply-templates select="sgr:genericAttributes" />
        
                    </table>
        
                    <xsl:for-each select="sgr:interfaceList/*">
                        <div class="interface">
                            <table>
                                <colgroup>
                                    <col style="width:230px" />
                                </colgroup>
        
                                <!-- Modbus Device -->
                                <xsl:if test="sgr:modbusInterfaceDescription">
                                    <h1 class="modbusattribute">Modbus Interface</h1>
                                    <xsl:apply-templates select="sgr:modbusInterfaceDescription" />
                                    <xsl:apply-templates select="sgr:modbusAttributes" />
                                    <xsl:apply-templates select="sgr:timeSyncBlockNotification" />
                                </xsl:if>
        
                                <!-- Messaging Device -->
                                <xsl:if test="sgr:messagingInterfaceDescription">
                                    <h1 class="messagingattribute">Messaging Interface</h1>
                                    <xsl:apply-templates select="sgr:messagingInterfaceDescription" />
                                    <xsl:apply-templates select="sgr:messagingAttributes" />
                                </xsl:if>
        
                                <!-- Rest Device -->
                                <xsl:if test="sgr:restApiInterfaceDescription">
                                    <h1 class="restapiattribute">RestApi Interface</h1>
                                    <xsl:apply-templates
                                        select="sgr:restApiInterfaceDescription" />
                                </xsl:if>
        
                                <!-- Contact Device -->
                                <xsl:if test="sgr:contactInterfaceDescription">
                                    <h1 class="contactapiattribute">Contact Interface</h1>
                                    <xsl:apply-templates
                                        select="sgr:contactInterface/sgr:contactInterfaceDescription" />
                                </xsl:if>
                            </table>
        
                            <!-- Functiol Profiles -->
                            <xsl:apply-templates select="sgr:functionalProfileList" />
                        </div>
        
                    </xsl:for-each>

                    <xsl:if test="//sgr:configurationList">
                        <div class="product">
                            <h2>Table of Configurations</h2>
                            <!-- Configurations -->
                            <table>
                                <colgroup>
                                    <col style="width:200px" />
                                    <col style="width:80px" />
                                    <col style="width:80px" />
                                </colgroup>
                                <tr>
                                    <th>Name</th>
                                    <th>Type</th>
                                    <th>Default</th>
                                    <th>Description</th>
                                </tr>
        
                                <xsl:for-each select="//sgr:configurationList/sgr:configurationListElement[not(sgr:name=preceding::sgr:name)]">
                                    <tr class="genericDetails">
                                        <td>
                                            <xsl:value-of select="sgr:name"/> 
                                        </td>
                                        <td>
                                            <xsl:apply-templates select="sgr:dataType" /> 
                                        </td>
                                        <td>
                                            <xsl:value-of select="sgr:defaultValue"/> 
                                        </td>
                                        <td>
                                            <xsl:for-each select="sgr:configurationDescription">
                                                <div>
                                                    <xsl:call-template name="SGrLanguageText">
                                                        <xsl:with-param name="lang"><xsl:value-of select="sgr:language" /></xsl:with-param>
                                                        <xsl:with-param name="value"><xsl:value-of select="sgr:textElement" /></xsl:with-param>
                                                        <xsl:with-param name="label"><xsl:value-of select="sgr:label" /></xsl:with-param>
                                                    </xsl:call-template>
                                                </div>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                </xsl:for-each>

                            </table>
                        </div>
                    </xsl:if>

                </div>
            </td></tr></tbody>
            <tfoot><tr style="border:hidden;"><td>
                <!-- Footer-->
                <div class="documentfooter">
				    <sup>1)</sup> data direction: R read, W write, P persistent, C constant
				</div>
            </td></tr></tfoot>
        </table>
    </xsl:template>

    <!-- Device information -->
    <xsl:template match="sgr:deviceInformation">

        <xsl:apply-templates select="sgr:alternativeNames" />

        <xsl:apply-templates select="sgr:legibleDescription" />
        <xsl:apply-templates select="sgr:programmerHints" />

        <!-- isLocalControl -->
        <tr class="genericDetails">
            <td>Type</td>
            <td>
                <xsl:choose>
                    <xsl:when test="sgr:isLocalControl = 'true'">
                        <img src="/xsl/ressources/lan.png" alt="" width="16pt" height="16pt" />
                        Local area
                    </xsl:when>
                    <xsl:otherwise>
                        <img src="/xsl/ressources/cloud.png" alt="" width="16pt" height="16pt" />
                        Cloud device
                     </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>

        <!-- Device Kind -->
        <tr class="genericDetails">
            <td>Device Type</td>
            <td>
                <xsl:value-of select="sgr:deviceCategory" />
            </td>
        </tr>

        <!-- softwareRevision -->
        <tr class="genericDetails">
            <td>Software Rev.</td>
            <td>
                <xsl:value-of select="sgr:softwareRevision" />
            </td>
        </tr>

        <!-- hardwareRevision (1x opt)-->
        <xsl:if test="sgr:hardwareRevision">
            <tr class="genericDetails">
                <td>Hardware Rev.</td>
                <td>
                    <xsl:value-of select="sgr:hardwareRevision" />
                </td>
            </tr>
        </xsl:if>

        <!-- brandName -->
        <xsl:if test="sgr:brandName">
            <tr class="genericDetails">
                <td>Brand</td>
                <td>
                    <xsl:value-of select="sgr:brandName" />
                </td>
            </tr>
        </xsl:if>

        <!-- powerSource (1x opt) -->
        <xsl:if test="sgr:powerSource">
            <tr class="genericDetails">
                <td>Power Source</td>
                <td>
                    <xsl:value-of select="sgr:powerSource" />
                </td>
            </tr>
        </xsl:if>

        <!-- nominalPower (1x opt) -->
        <xsl:if test="sgr:nominalPower">
            <tr class="genericDetails">
                <td>Nominal Power</td>
                <td>
                    <xsl:value-of select="sgr:nominalPower" />
                </td>
            </tr>
        </xsl:if>

        <!-- manufacturerSpecificationIdentification (1x opt) -->
        <xsl:if test="sgr:manufSpecIsdent">
            <tr class="genericDetails">
                <td>Secification ID</td>
                <td>
                    <xsl:value-of select="sgr:manufacturerSpecificationIdentification" />
                </td>
            </tr>
        </xsl:if>

        <!-- manufacturerLabel (1x opt) -->
        <xsl:if test="sgr:manufacturerLabel">
            <tr class="genericDetails">
                <td>Manufcaturer Label</td>
                <td>
                    <xsl:value-of select="sgr:manufacturerLabel" />
                </td>
            </tr>
        </xsl:if>

        <!-- generalRemarks (1x opt) -->
        <xsl:if test="sgr:generalRemarks">
            <tr class="genericDetails">
                <td>Author Remarks</td>
                <td>
                    <xsl:value-of select="sgr:generalRemarks" />
                </td>
            </tr>
        </xsl:if>

        <!-- levelOfOperation (1x opt) -->
        <xsl:if test="sgr:levelOfOperation">
            <tr class="genericDetails">
                <td>Level</td>
                <td>
                    <xsl:value-of select="sgr:levelOfOperation" />
                </td>
            </tr>
        </xsl:if>

        <!-- testState (1x opt)-->
        <xsl:if test="sgr:testState">
            <tr class="genericDetails">
                <td>Test State</td>
                <td>
                    <xsl:value-of select="sgr:testState" />
                </td>
            </tr>
        </xsl:if>

        <!-- generalRemarks (1x opt) -->
        <xsl:if test="sgr:generalRemarks">
            <tr class="genericDetails">
                <td>Author Remarks</td>
                <td>
                    <xsl:value-of select="sgr:generalRemarks" />
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>