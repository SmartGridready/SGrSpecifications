<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- messagingInterfaceDescription -->
    <xsl:template match="sgr:messagingInterfaceDescription">
        <tr class="genericDetails">
            <td class="messagingattribute">Platform</td>
            <td>
                <xsl:value-of select="sgr:platform" />
            </td>
        </tr>

        <!-- broker list -->
        <xsl:if test="sgr:messageBrokerList">
            <tr class="transportDetails">
                <td class="messagingattribute">Broker List</td>
                <td>
                    <xsl:for-each select="sgr:messageBrokerList/sgr:messageBrokerListElement">
                        <xsl:choose>
                            <xsl:when test="position() = 1">
                                <xsl:value-of select="concat(./sgr:host, ':', ./sgr:port)" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(', ', ./sgr:host, ':', ./sgr:port)" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                    <!--
                    <xsl:call-template name="join">
                        <xsl:with-param name="valueList" select="sgr:messageBrokerList/sgr:messageBrokerListElement/sgr:host" />
                        <xsl:with-param name="separator" select="','" />
                    </xsl:call-template>
                    -->
                </td>
            </tr>
        </xsl:if>

        <!-- clientId (1x opt) -->
        <xsl:if test="sgr:clientId">
            <tr class="transportDetails">
                <td class="messagingattribute">Client Id</td>
                <td>
                    <xsl:value-of select="sgr:clientId" />
                </td>
            </tr>
        </xsl:if>

        <!-- messageBrokerAuthentication -->
        <xsl:if test="sgr:messageBrokerAuthentication">
            <xsl:if test="sgr:messageBrokerAuthentication/sgr:basicAuthentication">
                <tr class="transportDetails">
                    <td class="messagingattribute">Authentication Basic</td>
                    <td>
                        Username: <xsl:value-of select="sgr:messageBrokerAuthentication/sgr:basicAuthentication/sgr:username" />
                        , Password: <xsl:value-of select="sgr:messageBrokerAuthentication/sgr:basicAuthentication/sgr:password" />
                    </td>
                </tr>
            </xsl:if>
            <xsl:if test="sgr:messageBrokerAuthentication/sgr:clientCertificateAuthentication">
                <tr class="transportDetails">
                    <td class="messagingattribute">Authentication Basic</td>
                    <td>
                        KeyStore: <xsl:value-of select="sgr:messageBrokerAuthentication/sgr:clientCertificateAuthentication/sgr:keystorePath" />
                        , Password: <xsl:value-of select="sgr:messageBrokerAuthentication/sgr:clientCertificateAuthentication/sgr:keystorePassword" />
                        <br></br>
                        TrustStore: <xsl:value-of select="sgr:messageBrokerAuthentication/sgr:clientCertificateAuthentication/sgr:truststorePath" />
                        , Password: <xsl:value-of select="sgr:messageBrokerAuthentication/sgr:clientCertificateAuthentication/sgr:truststorePassword" />
                    </td>
                </tr>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <!-- messagingDataPointConfiguration -->
    <xsl:template match="sgr:messagingDataPointConfiguration">
        <!-- messagingDataType (opt 1x) -->
        <tr class="transportDetails">
            <td class="messagingattribute">Data Type</td>
            <td>
                <xsl:if test="sgr:messagingDataType">
                    <xsl:apply-templates select="sgr:messagingDataType" />
                </xsl:if>
            </td>
        </tr>

        <!-- readCmdMessage (1x opt) -->
        <xsl:if test="sgr:readCmdMessage">
            <tr class="transportDetails">
                <td class="messagingattribute">Read Message</td>
                <td>
                    <xsl:value-of select="sgr:readCmdMessage" />
                </td>
            </tr>
        </xsl:if>

        <!-- writeCmdMessage (1x opt) -->
        <xsl:if test="sgr:writeCmdMessage">
            <tr class="transportDetails">
                <td class="messagingattribute">Write Message</td>
                <td>
                    <xsl:value-of select="sgr:writeCmdMessage" />
                </td>
            </tr>
        </xsl:if>

        <!-- inMessage (1x opt) -->
        <xsl:if test="sgr:inMessage">
            <tr class="transportDetails">
                <td class="messagingattribute">In Message</td>
                <td>
                    <xsl:value-of select="sgr:inMessage" />
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="sgr:messagingDataType">
        <xsl:choose>
            <xsl:when test="sgr:number">number</xsl:when>
            <xsl:when test="sgr:string">string</xsl:when>
            <xsl:when test="sgr:JSON_array">JSON array</xsl:when>
            <xsl:when test="sgr:JSON_object">JSON object</xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>