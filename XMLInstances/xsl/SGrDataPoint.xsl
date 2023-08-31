<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sgr="http://www.smartgridready.com/ns/V0/">

	<!--
    Contains the style sheets for data point, including
    - sgr:alternativeNames
-->

	<xsl:import href="SGrDeviceTypeModbus.xsl" />
	<xsl:import href="SGrDeviceTypeRestAPI.xsl" />

	<xsl:import href="SGrGenericAttributes.xsl" />
	<xsl:import href="SGrGenericDataPointDefinitions.xsl" />
	<xsl:import href="SGrGenericHelpers.xsl" />
	<xsl:import href="SGrGenericLegibDocumentationType.xsl" />
	<xsl:import href="SGrGenericNamelistType.xsl" />


	<!-- SGrDataPointType -->
	<xsl:template match="sgr:dataPointListElement">
		<tr>
			<td colspan="2">
				<xsl:value-of select="sgr:dataPoint/@datapointName" />
			</td>
			<td>
				<xsl:call-template name="SGrUnits">
					<xsl:with-param name="value" select="sgr:dataPoint/@unit" />
				</xsl:call-template>
			</td>
			<td>
				<xsl:if test="sgr:dataPoint/sgr:arrayLength">
					<xsl:value-of select="sgr:dataPoint/sgr:arrayLength" /> x
				</xsl:if>

				<xsl:if test="sgr:dataPoint/sgr:dataType">
					<xsl:apply-templates select="sgr:dataPoint/sgr:dataType" />
				</xsl:if>
			</td>
			<td>
				<xsl:value-of select="sgr:dataPoint/@presenceLevel" />
			</td>
			<td>
				<xsl:value-of select="sgr:dataPoint/@dataDirection" />
			</td>
		</tr>
		<tr class="dataPointDetails">
			<td class="noborder"></td>
			<td colspan="5">
				<table>
					<colgroup>
						<col style="width:25.8%" />
					</colgroup>

					<!-- alternativeNames (1x opt)-->
					<xsl:if test="sgr:dataPoint/sgr:alternativeNames">
						<xsl:apply-templates select="sgr:dataPoint/sgr:alternativeNames" />
					</xsl:if>

					<!-- legibleDescription (4x opt) -->
					<xsl:apply-templates select="sgr:dataPoint/sgr:legibleDescription" />

					<!-- dpPrgDesc (4x opt)-->
	                <xsl:apply-templates select="sgr:dataPoint/sgr:dpPrgDesc" />


					<!-- Generic Attributes -->
					<xsl:apply-templates select="sgr:genericAttributes" />

					<!-- Modbus Device -->
					<xsl:if test="sgr:modbusDataPoint">
						<tr class="transportDetails">
							<td colspan="2" class="noborder">
								<h3>
									<img src="/xsl/modbus.png" alt="Modbus" width="100px" />
								</h3>
							</td>
						</tr>
						<xsl:apply-templates select="sgr:modbusDataPoint" />
						<xsl:if test="sgr:blockCacheId">
							<tr>
								<td>Time Sync Block</td>
								<td><xsl:value-of select="sgr:blockCacheId" /></td>
							</tr>
						</xsl:if>
						<xsl:apply-templates select="sgr:modbusAttr" />
					</xsl:if>

					<!-- Rest Device -->
					<xsl:if test="sgr:restApiDataPoint">
						<tr class="transportDetails">
							<td colspan="2" class="noborder">
								<h3>
									<img src="/xsl/rest.png" alt="Rest" width="100px" />
								</h3>
							</td>
						</tr>
						<xsl:apply-templates select="sgr:restApiDataPoint" />
						<xsl:apply-templates select="sgr:restApiAttribute" />
					</xsl:if>
				</table>
			</td>
		</tr>
	</xsl:template>

	<!-- alternativeNames -->
	<xsl:template match="sgr:alternativeNames">
		<xsl:call-template name="AlternativeNameList" />
	</xsl:template>

	<!-- LegibleDescription -->
	<xsl:template match="sgr:legibleDescription">
		<tr>
			<xsl:attribute name="lang">
				<xsl:value-of select="sgr:language" />
			</xsl:attribute>
			<td colspan="2">
				<xsl:call-template name="LegibleDescription" />
			</td>
		</tr>
	</xsl:template>

	<!-- LegibleDescription -->
	<xsl:template match="sgr:dpPrgDesc">
		<tr>
			<xsl:attribute name="lang">
				<xsl:value-of select="sgr:language" />
			</xsl:attribute>
			<td colspan="2">
				<xsl:call-template name="LegibleDescription" />
			</td>
		</tr>
	</xsl:template>

	<!-- ModbusDataPointDescription -->
	<xsl:template match="sgr:modbusDataPoint">
		<!-- ModbusDataType (opt 1x) -->
		<tr class="transportDetails">
			<td>Data Type</td>
			<td>
				<xsl:if test="sgr:ModbusDataType">
					<xsl:apply-templates select="sgr:ModbusDataType" />
				</xsl:if>
			</td>
		</tr>

		<tr class="transportDetails">
			<td>Register</td>
			<td>
				<xsl:value-of select="sgr:modbusFirstRegisterReference/@registerType" />&#160; <xsl:value-of
					select="sgr:modbusFirstRegisterReference/@addr" />
				<xsl:choose>
					<xsl:when test="sgr:modbusFirstRegisterReference/@registerType = 'Coil'"> bit <xsl:value-of
							select="sgr:modbusFirstRegisterReference/@bitRank" />
					</xsl:when>

					<xsl:when
						test="sgr:modbusFirstRegisterReference/@registerType = 'DiscreteInput'"> bit <xsl:value-of
							select="sgr:modbusFirstRegisterReference/@bitRank" />
					</xsl:when>
				</xsl:choose>
				(Size <xsl:value-of select="sgr:dpSizeNrRegisters" />) </td>
		</tr>

		<!-- bitmask (opt 1x) -->
		<xsl:if test="sgr:bitmask">
			<tr class="transportDetails">
				<td>Bit Mask</td>
				<td>
					<xsl:value-of select="sgr:bitmask" /> h </td>
			</tr>
		</xsl:if>

		<tr class="transportDetails">
			<td>Supports</td>
			<td>
				<xsl:call-template name="join">
					<xsl:with-param name="valueList" select="sgr:masterFunctionsSupported" />
					<xsl:with-param name="separator" select="', '" />
				</xsl:call-template>
			</td>
		</tr>

		<!-- modbusJMESPath (opt 1x) -->
		<xsl:if test="sgr:modbusJMESPath">
			<tr class="transportDetails">
				<td>JMES Path</td>
				<td>
					<xsl:value-of select="sgr:modbusJMESPath" /> h </td>
			</tr>
		</xsl:if>
	</xsl:template>

	<!-- RestApiDataPointDescription -->
	<xsl:template match="sgr:restApiDataPoint">
		<tr class="transportDetails">
			<td>Data Type</td>
			<td>
				<xsl:apply-templates select="./@dataType" />
			</td>
		</tr>
		<xsl:apply-templates select="sgr:restServiceCall" />
	</xsl:template>

</xsl:stylesheet>
