<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- restApiInterfaceDescription -->
    <xsl:template match="sgr:restApiInterfaceDescription">
        <tr class="transportDetails">
            <td class="restapiattribute">Interface Type</td>
            <td>
                <xsl:value-of select="sgr:restApiInterfaceSelection" />
            </td>
        </tr>

        <!-- restApiIpV4Address (1x opt )-->
        <xsl:if test="sgr:restApiIpV4Address">
            <tr class="transportDetails">
                <td class="restapiattribute">TCP/IP v4 Adress</td>
                <td>
                    <xsl:value-of select="sgr:restApiIpV4Address/sgr:ipV4n1" />
                    .
                    <xsl:value-of select="sgr:restApiIpV4Address/sgr:ipV4n2" />
                    .
                    <xsl:value-of select="sgr:restApiIpV4Address/sgr:ipV4n3" />
                    .
                    <xsl:value-of select="sgr:restApiIpV4Address/sgr:ipV4n4" />
                    :
                    <xsl:value-of select="sgr:restApiIpV4Address/sgr:ipV4portNr" />
                </td>
            </tr>
        </xsl:if>

        <!-- restApiIpV6Address (1x opt )-->
        <xsl:if test="sgr:restApiIpV6Address">
            <tr class="transportDetails">
                <td class="restapiattribute">TCP/IP v6 Adress</td>
                <td>
                    <xsl:value-of select="sgr:restApiIpV6Address/sgr:prelimStringDef" />
                </td>
            </tr>
        </xsl:if>

        <!-- restApiUri (1x opt )-->
        <xsl:if test="sgr:restApiUri">
            <tr class="transportDetails">
                <td class="restapiattribute">TCP/IP URI</td>
                <td>
                    <xsl:value-of select="sgr:restApiUri" />
                </td>
            </tr>
        </xsl:if>

        <tr class="transportDetails">
            <td class="restapiattribute">Authentication Method</td>
            <td>
                <xsl:value-of select="sgr:restApiAuthenticationMethod" />
            </td>
        </tr>


        <!-- restApiBearer (1x opt )-->
        <xsl:if test="sgr:restApiBearer">
            <tr class="transportDetails">
                <td class="restapiattribute">Bearer Security</td>
                <td>
                    <table>
                        <xsl:apply-templates select="sgr:restApiBearer/sgr:restApiServiceCall" />
                    </table>
                </td>
            </tr>
        </xsl:if>

        <!-- restApiBasic (1x opt )-->
        <xsl:if test="sgr:restApiBasic">
            <tr class="transportDetails">
                <td class="restapiattribute">Basic Security</td>
                <td>
                    Username:
                    <xsl:value-of select="sgr:restApiBasic/sgr:restBasicUsername" />
                    <br />
                    Password:
                    <xsl:value-of select="sgr:restApiBasic/sgr:restBasicPassword" />
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <!-- RestApiDataPointConfiguration -->
    <xsl:template match="sgr:restApiDataPointConfiguration">
        <tr class="transportDetails">
            <td class="restapiattribute">Data Type</td>
            <td>
                <xsl:value-of select="./sgr:dataType" />
            </td>
        </tr>
        <xsl:apply-templates select="sgr:restApiServiceCall|sgr:restApiReadServiceCall|sgr:restApiWriteServiceCall" />
    </xsl:template>

    <!-- Rest Api Service Call -->
    <xsl:template match="sgr:restApiServiceCall|sgr:restApiReadServiceCall|sgr:restApiWriteServiceCall">
        <tr class="transportDetails">
            <td>End Point</td>
            <td>
                <xsl:value-of select="sgr:requestMethod" /> &#160;
                <xsl:value-of select="sgr:requestPath" />
            </td>
        </tr>
        <xsl:if test="sgr:requestQuery">
            <tr class="transportDetails">
                <td>Request Query</td>
                <td>
                    <xsl:for-each select="sgr:requestQuery/sgr:parameter">
                        <xsl:value-of select="./sgr:name" /> = <xsl:value-of select="./sgr:value" />
                        <br />
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="sgr:requestForm">
            <tr class="transportDetails">
                <td>Request Form</td>
                <td>
                    <xsl:for-each select="sgr:requestForm/sgr:parameter">
                        <xsl:value-of select="./sgr:name" /> = <xsl:value-of select="./sgr:value" />
                        <br />
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="sgr:requestHeader">
            <tr class="transportDetails">
                <td>Header</td>
                <td>
                    <xsl:for-each select="sgr:requestHeader/sgr:header">
                        <xsl:value-of select="./sgr:headerName" /> : <xsl:value-of select="sgr:value" />
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
        <xsl:if test="sgr:requestBody">
            <tr class="transportDetails">
                <td>Body</td>
                <td>
                    <xsl:value-of select="sgr:requestBody" />
                </td>
            </tr>
        </xsl:if>
        <tr class="transportDetails">
            <td>Response</td>
            <td>
                <xsl:value-of select="sgr:responseQuery/sgr:queryType" /> &#160;
                <xsl:value-of select="sgr:responseQuery/sgr:query" />
                <xsl:if test="sgr:responseQuery/sgr:jmesPathMappings">
                    <br />
                    <xsl:for-each select="sgr:responseQuery/sgr:jmesPathMappings/sgr:mapping">
                        <xsl:value-of select="./sgr:from" /> => <xsl:value-of select="./sgr:to" />
                            <xsl:if test="./sgr:name">
                                &#160;&#160;&#160;&#160;&#160;name: <xsl:value-of select="sgr:name" />
                            </xsl:if>
                        <br />
                    </xsl:for-each>
                </xsl:if>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>