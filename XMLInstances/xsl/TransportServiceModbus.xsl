<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- modbusInterfaceDescription -->
    <xsl:template match="sgr:modbusInterfaceDescription">
        <tr class="genericDetails">
            <td class="modbusattribute">Interface Type</td>
            <td>
                <xsl:value-of select="sgr:modbusInterfaceSelection" />
            </td>
        </tr>

        <!-- modbusTcp (1x opt) -->
        <xsl:if test="sgr:modbusTcp">
            <tr class="transportDetails">
                <td class="modbusattribute">TCP</td>
                <td>
                    <xsl:value-of select="sgr:modbusTcp/sgr:address" />
                    :
                    <xsl:value-of select="sgr:modbusTcp/sgr:port" />
                    - SlaveID
                    <xsl:value-of select="sgr:modbusTcp/sgr:slaveId" />
                </td>
            </tr>
        </xsl:if>

        <!-- modbusRtu (1x opt) -->
        <xsl:if test="sgr:modbusRtu">
            <tr class="transportDetails">
                <td class="modbusattribute">RTU</td>
                <td>
                    Slave Adress:
                    <xsl:value-of select="sgr:modbusRtu/sgr:slaveAddr" />
                    <br />
                    Port Name (COM):
                    <xsl:value-of select="sgr:modbusRtu/sgr:portName" />
                    <br />
                    Baud Rate:
                    <xsl:value-of select="sgr:modbusRtu/sgr:baudRateSelected" />
                    <br />
                    Data Bits:
                    <xsl:value-of select="sgr:modbusRtu/sgr:byteLenSelected" />
                    <br />
                    Parity:
                    <xsl:value-of select="sgr:modbusRtu/sgr:paritySelected" />
                    <br />
                    Stop Bit:
                    <xsl:value-of select="sgr:modbusRtu/sgr:stopBitLenSelected" />
                    <br />

                    <h3>Capabilities</h3>
                    Baud Rate:
                    <xsl:call-template name="join">
                        <xsl:with-param name="valueList" select="sgr:modbusRtu/sgr:serialInterfaceCapability/sgr:baudRatesSupported" />
                        <xsl:with-param name="separator" select="','" />
                    </xsl:call-template>
                    <br />
                    Data Bits:
                    <xsl:call-template name="join">
                        <xsl:with-param name="valueList" select="sgr:modbusRtu/sgr:serialInterfaceCapability/sgr:byteLenSupported" />
                        <xsl:with-param name="separator" select="','" />
                    </xsl:call-template>
                    <br />
                    Parity:
                    <xsl:call-template name="join">
                        <xsl:with-param name="valueList" select="sgr:modbusRtu/sgr:serialInterfaceCapability/sgr:paritySupported" />
                        <xsl:with-param name="separator" select="','" />
                    </xsl:call-template>
                    <br />
                    Stop Bit:
                    <xsl:call-template name="join">
                        <xsl:with-param name="valueList" select="sgr:modbusRtu/sgr:serialInterfaceCapability/sgr:stopBitLenSupported" />
                        <xsl:with-param name="separator" select="','" />
                    </xsl:call-template>
                    <br />
                </td>
            </tr>
        </xsl:if>

        <!-- firstRegisterAddressIsOne -->
        <tr class="transportDetails">
            <td class="modbusattribute">First Register Address</td>
            <td>
                <xsl:choose>
                    <xsl:when test="sgr:firstRegisterAddressIsOne='true'">1 </xsl:when>
                    <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>

        <!-- bitOrder -->
        <tr class="transportDetails">
            <td class="modbusattribute">Conversion Scheme</td>
            <td>
                <xsl:call-template name="join">
                    <xsl:with-param name="valueList" select="sgr:bitOrder" />
                    <xsl:with-param name="separator" select="', '" />
                </xsl:call-template>
            </td>
        </tr>

        <!-- masterFunctionsSupported -->
        <xsl:if test="sgr:masterFunctionsSupportedList/sgr:masterFunctionsSupported">
            <tr class="transportDetails">
                <td class="modbusattribute">Supports</td>
                <td>
                    <xsl:for-each select="sgr:masterFunctionsSupportedList/sgr:masterFunctionsSupported">
                        <xsl:value-of select="." />
                        <br />
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

    <!-- ModbusDataPointConfiguration -->
	<xsl:template match="sgr:modbusDataPointConfiguration">
		<!-- modbusDataType (opt 1x) -->
        <tr class="transportDetails">
			<td class="modbusattribute">Data Type</td>
			<td>
				<xsl:if test="sgr:modbusDataType">
					<xsl:apply-templates select="sgr:modbusDataType" />
				</xsl:if>
			</td>
		</tr>

		<tr class="transportDetails">
			<td class="modbusattribute">Register</td>
			<td>
				<xsl:value-of select="sgr:registerType" />&#160; <xsl:value-of
					select="sgr:address" />
				<xsl:choose>
					<xsl:when test="sgr:registerType = 'Coil'"> bit <xsl:value-of
							select="sgr:bitRank" />
					</xsl:when>

					<xsl:when
						test="sgr:registerType = 'DiscreteInput'"> bit <xsl:value-of
							select="sgr:bitRank" />
					</xsl:when>
				</xsl:choose>
				(Size <xsl:value-of select="sgr:numberOfRegisters" />) </td>
		</tr>
	</xsl:template>

    <!-- Attributes Modbus -->
    <xsl:template match="sgr:modbusAttributes">
        <!--scalingFactor-->
        <xsl:if test="sgr:scalingFactor">
            <tr class="transportDetails">
                <td class="modbusattribute">Scaling</td>
                <td>
                    <xsl:value-of select="sgr:scalingFactor/sgr:multiplicator" />
                    x 10e
                    <xsl:value-of select="sgr:scalingFactor/sgr:powerof10" />
                </td>
            </tr>
        </xsl:if>

        <!--stepByIncrement-->
        <xsl:if test="sgr:stepByIncrement">
            <tr class="transportDetails">
                <td class="modbusattribute">Step by Increment</td>
                <td>
                    <xsl:value-of select="sgr:stepByIncrement" />
                    ms
                </td>
            </tr>
        </xsl:if>

        <!--sunssf-->
        <xsl:if test="sgr:sunssf">
            <tr class="transportDetails">
                <td class="modbusattribute">Sunspec Scale Factor</td>
                <td>
                    <xsl:value-of select="sgr:sunssf" />
                    ms
                </td>
            </tr>
        </xsl:if>

        <!--pollingLatencyMs-->
        <xsl:if test="sgr:pollingLatencyMs">
            <tr class="transportDetails">
                <td class="modbusattribute">Polling Latency</td>
                <td>
                    <xsl:value-of select="sgr:pollingLatencyMs" />
                    ms
                </td>
            </tr>
        </xsl:if>

        <!--accessProtection-->
        <xsl:if test="sgr:accessProtection">
            <tr class="transportDetails">
                <td class="modbusattribute">Access Protection</td>
                <td>
                    <xsl:choose>
                        <xsl:when test="sgr:accessProtection/sgr:isEnabled">Enabled: </xsl:when>
                        <xsl:otherwise>Disabled: </xsl:otherwise>
                    </xsl:choose>
                    <xsl:for-each select="sgr:accessProtection/sgr:modbusExceptionCode">
                        <xsl:value-of select="." />
                        &#160;
                    </xsl:for-each>
                </td>
            </tr>
        </xsl:if>

        <!--layer6Deviation-->
        <xsl:if test="sgr:layer6Deviation">
            <tr class="transportDetails">
                <td class="modbusattribute">ISO/OSI Layer 6 Data Type</td>
                <td>
                    <xsl:value-of select="sgr:layer6Deviation" />
                </td>
            </tr>
        </xsl:if>

    </xsl:template>

    <!-- Time Sync Blocks -->
    <xsl:template match="sgr:timeSyncBlockNotification">
        <tr class="transportDetails">
                <td class="modbusattribute">Time Sync Block</td>
                <td>
                    <table>
                        <tr>
                            <td>Identifier</td>
                            <td><xsl:value-of select="sgr:blockCacheIdentification" /></td>
                        </tr>
                        <tr>
                            <td>Register</td>
                            <td>
                                <xsl:value-of select="sgr:registerType" />&#160;
                                <xsl:value-of select="sgr:firstAddress" />
				                (Size <xsl:value-of select="sgr:size" />)
                            </td>
                        </tr>
                        <tr>
                            <td>Time to Live</td>
                            <td><xsl:value-of select="sgr:timeToLiveMs" /> ms</td>
                        </tr>
                    </table>
                </td>
            </tr>
    </xsl:template>

    <xsl:template match="sgr:blockCacheIdentification">
        <tr class="transportDetails">
            <td>Time Sync Block</td>
            <td><xsl:value-of select="." /></td>
        </tr>
    </xsl:template>

    <xsl:template match="sgr:modbusDataType">
        <xsl:choose>
            <xsl:when test="sgr:boolean/sgr:falseValue">boolean (false=<xsl:value-of select="sgr:boolean/sgr:falseValue"/>)</xsl:when>
            <xsl:when test="sgr:boolean/sgr:trueValue">boolean (true=<xsl:value-of select="sgr:boolean/sgr:trueValue"/>)</xsl:when>
            <xsl:when test="sgr:boolean">boolean</xsl:when>
            <xsl:when test="sgr:int8">byte</xsl:when>
            <xsl:when test="sgr:int16">short</xsl:when>
            <xsl:when test="sgr:int32">integer</xsl:when>
            <xsl:when test="sgr:int64">long</xsl:when>
            <xsl:when test="sgr:int8U">unsigned byte</xsl:when>
            <xsl:when test="sgr:int16U">unsigned short</xsl:when>
            <xsl:when test="sgr:int32U">unsigned int</xsl:when>
            <xsl:when test="sgr:int64U">unsigned long</xsl:when>
            <xsl:when test="sgr:float32">float</xsl:when>
            <xsl:when test="sgr:float64">double</xsl:when>
            <xsl:when test="sgr:dateTime">date time</xsl:when>
            <xsl:when test="sgr:string">string</xsl:when>
            <xsl:when test="sgr:enum"><xsl:apply-templates select="sgr:enum" /></xsl:when> <!-- TODO Simon: map enum -->
            <xsl:when test="sgr:enum2bitmapIndex">bitmap</xsl:when> <!-- TODO Simon: render the differnet bitmap types -->
            <xsl:when test="sgr:json">JSon</xsl:when>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>  