<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <xsl:template match="sgr:dataPointList">
        <!-- Data Points -->
        <div class="dataPoint">
            <table>
                <colgroup>
                    <col style="width:231px" />
                    <xsl:choose>
                        <xsl:when test="/sgr:DeviceFrame">
                            <col style="width:368px" />
                            <col style="width:54px" />
    						<col style="width:75px" />
    						<col style="width:44px" />
                        </xsl:when>
                        <xsl:otherwise>
                            <col style="width:324px" />
                            <col style="width:54px" />
                            <col style="width:75px" />
                            <col style="width:44px" />
                            <col style="width:44px" />
                        </xsl:otherwise>
                    </xsl:choose>
                </colgroup>
                <tr>
                    <th>Datapoint</th>
                    <th>Description</th>
                    <th>Unit</th>
                    <th>Type</th>
                    <xsl:choose>
                        <xsl:when test="/sgr:DeviceFrame">
    						<th>RWPC<sup>1)</sup></th>
                        </xsl:when>
                        <xsl:otherwise>
    						<th>MRO<sup>1)</sup></th>
    						<th>RW<sup>2)</sup></th>
                        </xsl:otherwise>
                    </xsl:choose>
                </tr>
                <xsl:for-each select="sgr:dataPointListElement">
                    <xsl:apply-templates select="." />
                </xsl:for-each>
            </table>
        </div>
    </xsl:template>

    <xsl:template match="sgr:dataPointListElement">
        <xsl:apply-templates select="sgr:dataPoint" />
        <tr class="dataPointDetails">
            <td colspan="6" class="noborder">
                <table style="margin-left:35px; width:737px">
                    <colgroup>
                        <col style="width:194px" />
                    </colgroup>
                    
                    <xsl:apply-templates select="sgr:dataPoint/sgr:programmerHints" />

                    <xsl:if test="sgr:dataPoint/sgr:minimumValue">
                        <tr class="genericDetails">
                            <td>Minimum Value</td>
                            <td>
                                <xsl:value-of select="sgr:dataPoint/sgr:minimumValue" />&#160;<xsl:call-template name="SGrUnits">
                                    <xsl:with-param name="value" select="sgr:dataPoint/sgr:unit" />
                                    <xsl:with-param name="none" select="'-'" />
                                </xsl:call-template>
                            </td>
                        </tr>
                    </xsl:if>

                    <xsl:if test="sgr:dataPoint/sgr:maximumValue">
                        <tr class="genericDetails">
                            <td>Maximum Value</td>
                            <td>
                                <xsl:value-of select="sgr:dataPoint/sgr:maximumValue" />&#160;<xsl:call-template name="SGrUnits">
                                    <xsl:with-param name="value" select="sgr:dataPoint/sgr:unit" />
                                    <xsl:with-param name="none" select="'-'" />
                                </xsl:call-template>
                            </td>
                        </tr>
                    </xsl:if>

                    <xsl:if test="sgr:dataPoint/sgr:unitConversionMultiplicator">
                        <tr class="genericDetails">
                            <td>Value Multiplier</td>
                            <td>
                                <xsl:value-of select="sgr:dataPoint/sgr:unitConversionMultiplicator" />
                            </td>
                        </tr>
                    </xsl:if>

                    <xsl:apply-templates select="sgr:dataPoint/sgr:alternativeNames" />
                    <xsl:apply-templates select="sgr:genericAttributeList" />
                    <xsl:apply-templates select="sgr:genericAttributes" />

                    <!-- transport service details-->
                    <xsl:if test="/sgr:DeviceFrame">
                        <xsl:choose>
                            <xsl:when test="sgr:modbusDataPointConfiguration">
                                <xsl:if test="sgr:dataPoint/sgr:dataDirection = 'C'">
                                    <tr>
                            			<td></td>
                                        <td style="color:red"><b>Constant data points cannot have a configuration</b></td>
                            		</tr>
                                </xsl:if>
                                <xsl:apply-templates select="sgr:modbusDataPointConfiguration" />
                                <xsl:apply-templates select="sgr:blockCacheIdentification" />
                                <xsl:apply-templates select="sgr:modbusAttributes" />
                            </xsl:when>
                            <xsl:when test="sgr:messagingDataPointConfiguration">
                                <xsl:if test="sgr:dataPoint/sgr:dataDirection = 'C'">
                                    <tr>
                                  <td></td>
                                        <td style="color:red"><b>Constant data points cannot have a configuration</b></td>
                                </tr>
                                </xsl:if>
                                <xsl:apply-templates select="sgr:messagingDataPointConfiguration" />
                                <xsl:apply-templates select="sgr:blockCacheIdentification" />
                                <xsl:apply-templates select="sgr:messagingAttributes" />
                            </xsl:when>
                            <xsl:when test="sgr:restApiDataPointConfiguration">
                                <xsl:if test="sgr:dataPoint/sgr:dataDirection = 'C'">
                                    <tr>
                                        <td></td>
                                        <td style="color:red"><b>Constant data points cannot have a configuration</b></td>
                                    </tr>
                                </xsl:if>
                                <xsl:apply-templates select="sgr:restApiDataPointConfiguration" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:if test="not(/sgr:DeviceFrame/sgr:interfaceList/sgr:contactInterface)">
	                                <xsl:if test="sgr:dataPoint/sgr:dataDirection != 'C'">
	                                    <tr>
	                                        <td></td>
	                                        <td style="color:red"><b>Non-constant data points must have a configuration</b></td>
	                                    </tr>
	                                </xsl:if>
                                </xsl:if>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </table>
            </td>
        </tr>
    </xsl:template>

    <xsl:template match="sgr:dataPoint">
        <!-- Renders a data point table row (dataPointName, unit, dataType, presenceLevel, dataDirection) -->
        <xsl:variable name="dpname">
            <xsl:value-of select="sgr:dataPointName" />
        </xsl:variable>
        <xsl:variable name="borderstyle">
            <xsl:choose>
                <xsl:when test="contains($dpname, '.')">
                    solid 2px white
                </xsl:when>
                <xsl:otherwise>
                    solid 1px
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <tr style="border-left: {$borderstyle}">
            <td style="border-bottom: {$borderstyle}">
                <xsl:value-of select="sgr:dataPointName" />
            </td>
            <td>
                <xsl:for-each select="sgr:legibleDescription">
                    <div>
                        <xsl:attribute name="lang">
                          <xsl:value-of select="sgr:language" />
                        </xsl:attribute>
                        <img width="20px" height="14px">
                            <xsl:attribute name="src" alt="Lang">/xsl/ressources/<xsl:value-of select="sgr:language" />.png</xsl:attribute>
                        </img>
                        &#160;
                        <span class="renderhtml">
                          <xsl:value-of select="sgr:textElement" disable-output-escaping="yes" />
                        </span>
                        <xsl:apply-templates select="sgr:uri" />
                    </div>
                </xsl:for-each>
                <xsl:apply-templates select="sgr:dataType/sgr:enum" />
                <xsl:apply-templates select="sgr:dataType/sgr:bitmap" />
                <xsl:if test="sgr:parameterList" >
                    <p />
                    Dynamic parameters to provide when reading the Datapoint:
                    <table style="margin-left:10px;">
                        <xsl:for-each select="sgr:parameterList/sgr:parameterListElement">
                            <tr>
                                <td class="noborder" style="padding-left:10px;">
                                    <b><xsl:value-of select="sgr:name" />:</b><br />
                                    <xsl:value-of select="name(sgr:dataType/*[1])" />
                                </td>
                                <td class="noborder" style="padding-left:10px;">
                                    <xsl:for-each select="sgr:parameterDescription" >
                                        <xsl:value-of select="sgr:textElement[position()]" />
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </xsl:if>
            </td>
            <td>
                <xsl:call-template name="SGrUnits">
                    <xsl:with-param name="value" select="sgr:unit" />
                    <xsl:with-param name="none" select="'-'" />
                </xsl:call-template>
            </td>
            <td>
                <xsl:if test="sgr:arrayLength">
                    <xsl:value-of select="sgr:arrayLength" /> x </xsl:if>

                <xsl:apply-templates select="sgr:dataType" />
            </td>
				<xsl:if test="not(/sgr:DeviceFrame)">
					<td>
						<xsl:value-of select="sgr:presenceLevel" />
					</td>
				</xsl:if>
            <td>
                <xsl:value-of select="sgr:dataDirection" />
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>