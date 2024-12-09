<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- Helper templates -->
    <!-- template 'join' accepts valueList and separator -->
    <xsl:template name="join">
        <xsl:param name="valueList" select="''" />
        <xsl:param name="separator" select="','" />
        <xsl:for-each select="$valueList">
            <xsl:choose>
                <xsl:when test="position() = 1">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($separator, .) " />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!-- release notes -->
    <xsl:template match="sgr:releaseNotes">
        <table>
            <colgroup>
                <col style="width:230px" />
            </colgroup>
            <!-- Release State -->
            <tr>
                <td class="fpHeader">
                    <h4>Release State</h4>
                </td>
                <td class="fpHeader">
                    <table>
                        <tr>
                            <td>
                                <xsl:value-of select="sgr:state" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <!-- Remarks -->
            <xsl:if test="sgr:remarks">
                <tr>
                    <td class="fpHeader">
                        <h4>Remarks</h4>
                    </td>
                    <td class="fpHeader">
                        <table>
                            <tr>
                                <td>
                                    <xsl:value-of select="sgr:remarks" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </xsl:if>

            <!-- Change Log -->
            <xsl:if test="sgr:changeLog">
                <tr>
                    <td class="fpHeader">
                        <h4>Change Log</h4>
                    </td>
                    <td class="fpHeader">
                        <table>
                            <colgroup>
                                <col style="width:16%" />
                                <col style="width:16%" />
                                <col style="width:16%" />
                                <col style="width:52%" />
                            </colgroup>
                            <tr>
                                <th>Version</th>
                                <th>Date</th>
                                <th>Author</th>
                                <th>Comment</th>
                            </tr>
                            <xsl:for-each select="sgr:changeLog">
                                <tr>
                                    <td>
                                        <xsl:value-of select="sgr:version" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="sgr:date" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="sgr:author" />
                                    </td>
                                    <td>
                                        <xsl:value-of select="sgr:comment" />
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </table>
                    </td>
                </tr>
            </xsl:if>
        </table>        
    </xsl:template>

    <!-- version number -->
    <xsl:template match="sgr:versionNumber">
        <xsl:value-of select="sgr:primaryVersionNumber" />.<xsl:value-of select="sgr:secondaryVersionNumber" />.<xsl:value-of select="sgr:subReleaseVersionNumber" />
    </xsl:template>

    <!-- AlternativeNames-->
    <xsl:template match="sgr:alternativeNames">
        <xsl:if test="sgr:sLV1Name">
            <tr class="ontologyDetails">
                <td>SGr label V1 (legacy)</td>
                <td>
                    <xsl:value-of select="sgr:sLV1Name" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:workName">
            <tr class="ontologyDetails">
                <td>Temporary Work Name</td>
                <td>
                    <xsl:value-of select="sgr:workName" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:manufName">
            <tr class="ontologyDetails">
                <td>Manufacturers Name</td>
                <td>
                    <xsl:value-of select="sgr:manufName" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:IEC61850Name">
            <tr class="ontologyDetails">
                <td>IEC 61850 Name </td>
                <td>
                    <xsl:value-of select="sgr:IEC61850Name" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:SAREFName">
            <tr class="ontologyDetails">
                <td>SAREF Name</td>
                <td>
                    <xsl:value-of select="sgr:SAREFName" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:EEBUSName">
            <tr class="ontologyDetails">
                <td>EEBUS Name</td>
                <td>
                    <xsl:value-of select="sgr:EEBUSName" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:sunSpecName">
            <tr class="ontologyDetails">
                <td>SUNSPEC Name</td>
                <td>
                    <xsl:value-of select="sgr:sunSpecName" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:hpBwpName">
            <tr class="ontologyDetails">
                <td>bwp HP Name</td>
                <td>
                    <xsl:value-of select="sgr:hpBwpName" />
                </td>
            </tr>
        </xsl:if>

        <xsl:if test="sgr:EN17609Name">
            <tr class="ontologyDetails">
                <td>EN17609 Name</td>
                <td>
                    <xsl:value-of select="sgr:EN17609Name" />
                </td>
            </tr>
        </xsl:if>
    </xsl:template>

  	<!-- LegibleDescription -->
	<xsl:template match="sgr:legibleDescription">
		<tr>
			<xsl:attribute name="lang">
				<xsl:value-of select="sgr:language" />
			</xsl:attribute>
			<td colspan="2">
                <img width="20px" height="14px">
                    <xsl:attribute name="src" alt="Lang">/xsl/ressources/<xsl:value-of select="sgr:language" />.png</xsl:attribute>
                </img>
                &#160;
                <span class="renderhtml">
                  <xsl:value-of select="sgr:textElement" disable-output-escaping="yes" />
                </span>
                <xsl:apply-templates select="sgr:uri" />
			</td>
		</tr>
	</xsl:template>

	<!-- ProgrammerHints -->
	<xsl:template match="sgr:programmerHints">
		<tr class="transportDetails">
			<xsl:attribute name="lang">
				<xsl:value-of select="sgr:language" />
			</xsl:attribute>
			<td colspan="2" style="background-color:#E4E4E4">
                <div style="padding-top:0.3em;padding-bottom:0.3em">
                    <img width="20px" height="14px">
                        <xsl:attribute name="src" alt="Lang">/xsl/ressources/<xsl:value-of select="sgr:language" />.png</xsl:attribute>
                    </img>&#160;
                    Programmer Hint 
                    &#160;<img src="/xsl/ressources/hint.png" alt="Hint" width="16px" height="16px" />
                </div>
                <span class="renderhtml">
                  <xsl:value-of select="sgr:textElement" disable-output-escaping="yes" />
                </span>
                <xsl:apply-templates select="sgr:uri" />
			</td>
		</tr>
	</xsl:template>
    <xsl:template match="sgr:uri">
        <div style="padding-top:0.5em;">
        <a target="_blank">
            <xsl:attribute name="href">
                <xsl:value-of select="sgr:uri" />
            </xsl:attribute>
            <img src="/xsl/ressources/link.png" alt="Link.." width="16pt" height="16pt" />&#160;
            <xsl:value-of select="." />
        </a>
    </div>
    </xsl:template>

    <!-- Data Types -->
    <xsl:template match="sgr:dataType">
        <xsl:choose>
            <xsl:when test="sgr:boolean/sgr:falseValue">boolean (false=<xsl:value-of select="sgr:boolean/sgr:falseValue"/>)</xsl:when>
            <xsl:when test="sgr:boolean/sgr:trueValue">boolean (true=<xsl:value-of select="sgr:boolean/sgr:trueValue"/>)</xsl:when>
            <xsl:when test="sgr:boolean">boolean</xsl:when>
            <xsl:when test="sgr:int8">byte</xsl:when>
            <xsl:when test="sgr:int16">int16</xsl:when>
            <xsl:when test="sgr:int32">int32</xsl:when>
            <xsl:when test="sgr:int64">int64</xsl:when>
            <xsl:when test="sgr:int8U">int8U</xsl:when>
            <xsl:when test="sgr:int16U">int16U</xsl:when>
            <xsl:when test="sgr:int32U">int32U</xsl:when>
            <xsl:when test="sgr:int64U">int64U</xsl:when>
            <xsl:when test="sgr:float32">float</xsl:when>
            <xsl:when test="sgr:float64">double</xsl:when>
            <xsl:when test="sgr:dateTime">date time BB</xsl:when>
            <xsl:when test="sgr:string">string</xsl:when>
            <xsl:when test="sgr:enum">enum</xsl:when>
            <xsl:when test="sgr:bitmap">bitmap</xsl:when>
            <xsl:when test="sgr:json">JSon</xsl:when>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="sgr:enum">
        <div>
          <ul>
            <xsl:for-each select="sgr:enumEntry">
                <li>
                    <strong><xsl:value-of select="sgr:literal" /></strong>
                    <xsl:if test="sgr:ordinal"> = <xsl:value-of select="sgr:ordinal" /></xsl:if>
                    <xsl:if test="sgr:description">: <xsl:value-of select="sgr:description" /></xsl:if>
                </li>
            </xsl:for-each>
          </ul>
        <xsl:if test="sgr:hexMask">
            <div>Hex Mask: 0x<xsl:value-of select="sgr:hexMask"/></div>
        </xsl:if>        
        </div>
    </xsl:template>

    <xsl:template match="sgr:bitmap">
        <div style="padding-left:1em;">
            <ul>
            <xsl:for-each select="sgr:bitmapEntry">
                <li>
                    <strong><xsl:value-of select="sgr:literal" /></strong>
                    <xsl:if test="sgr:hexMask"> = 0x<xsl:value-of select="sgr:hexMask" /></xsl:if>
                    <xsl:if test="sgr:description">: <xsl:value-of select="sgr:description" /></xsl:if>
                </li>
            </xsl:for-each>
            </ul>
        </div>       
    </xsl:template>

    <!-- LegibleDescription -->
    <xsl:template name="SGrLanguageText">
        <xsl:param name="lang" select="NONE" />
        <xsl:param name="value" select="NONE" />
        <xsl:param name="label" select="NONE" />
        <xsl:attribute name="lang">
            <xsl:value-of select="$lang" />
        </xsl:attribute>
        <img width="20px" height="14px">
            <xsl:attribute name="src" alt="Lang">/xsl/ressources/<xsl:value-of select="$lang" />.png</xsl:attribute>
        </img>
        &#160;
          <xsl:if test="$label != ''">
              Label:
              <span class="renderhtml">
                  <xsl:value-of select="$label" disable-output-escaping="yes" />
              </span>
              <br/>
          </xsl:if>
          <xsl:value-of select="$value" disable-output-escaping="yes" />
        <xsl:apply-templates select="sgr:uri" />
    </xsl:template>

    <!-- Units -->
    <xsl:template name="SGrUnits">
        <xsl:param name="value" select="NONE" />
        <xsl:param name="none" select="NONE" />
        <xsl:choose>
            <xsl:when test="$value = 'AMPERE_SQUARE_METERS'">A m2</xsl:when>
            <xsl:when test="$value = 'AMPERES'">A</xsl:when>
            <xsl:when test="$value = 'AMPERES_PER_METER'">A/m</xsl:when>
            <xsl:when test="$value = 'AMPERES_PER_SQUARE_METER'">A/m2</xsl:when>
            <xsl:when test="$value = 'BARS'">bar</xsl:when>
            <xsl:when test="$value = 'BTUS'">BTU</xsl:when>
            <xsl:when test="$value = 'BTUS_PER_HOUR'">BTU/h</xsl:when>
            <xsl:when test="$value = 'BTUS_PER_POUND'">BTU/lb</xsl:when>
            <xsl:when test="$value = 'BTUS_PER_POUND_DRY_AIR'">BUT/lb dry air</xsl:when>
            <xsl:when test="$value = 'CANDELAS'">cd</xsl:when>
            <xsl:when test="$value = 'CANDELAS_PER_SQUARE_METER'">cd/m2</xsl:when>
            <xsl:when test="$value = 'CENTIMETERS'">cm</xsl:when>
            <xsl:when test="$value = 'CENTIMETERS_OF_MERCURY'">cmHg</xsl:when>
            <xsl:when test="$value = 'CENTIMETERS_OF_WATER'">cmH2O</xsl:when>
            <xsl:when test="$value = 'CUBIC_FEET'">cu ft</xsl:when>
            <xsl:when test="$value = 'CUBIC_FEET_PER_MINUTE'">cu ft/min</xsl:when>
            <xsl:when test="$value = 'CUBIC_FEET_PER_SECOND'">cu ft/sec</xsl:when>
            <xsl:when test="$value = 'CUBIC_METERS'">m3</xsl:when>
            <xsl:when test="$value = 'CUBIC_METERS_PER_HOUR'">m3/h</xsl:when>
            <xsl:when test="$value = 'CUBIC_METERS_PER_MINUTE'">m2/min</xsl:when>
            <xsl:when test="$value = 'CUBIC_METERS_PER_SECOND'">m3/s</xsl:when>
            <xsl:when test="$value = 'CURRENCY1'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY10'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY2'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY3'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY4'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY5'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY6'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY7'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY8'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CURRENCY9'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CYCLES_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'CYCLES_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DAYS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREE_DAYS_CELSIUS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREE_DAYS_FAHRENHEIT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_ANGULAR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_CELSIUS'"><sup>o</sup>C</xsl:when>
            <xsl:when test="$value = 'DEGREES_CELSIUS_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_CELSIUS_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_FAHRENHEIT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_FAHRENHEIT_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_FAHRENHEIT_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_KELVIN'">K</xsl:when>
            <xsl:when test="$value = 'DEGREES_KELVIN_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_KELVIN_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DEGREES_PHASE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DELTA_DEGREES_FAHRENHEIT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'DELTA_DEGREES_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'FARADS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'FEET'">ft</xsl:when>
            <xsl:when test="$value = 'FEET_PER_MINUTE'">ft/min</xsl:when>
            <xsl:when test="$value = 'FEET_PER_SECOND'">ft/sec</xsl:when>
            <xsl:when test="$value = 'FOOT_CANDLES'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'GIGAJOULES'">GJ</xsl:when>
            <xsl:when test="$value = 'GRAMS_OF_WATER_PER_KILOGRAM_DRY_AIR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'GRAMS_PER_MINUTE'">g/min</xsl:when>
            <xsl:when test="$value = 'GRAMS_PER_SECOND'">g/sec</xsl:when>
            <xsl:when test="$value = 'HECTOPASCALS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'HENRYS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'HERTZ'">Hz</xsl:when>
            <xsl:when test="$value = 'HORSEPOWER'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'HOURS'">h</xsl:when>
            <xsl:when test="$value = 'HUNDREDTHS_SECONDS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'IMPERIAL_GALLONS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'IMPERIAL_GALLONS_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'INCHES'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'INCHES_OF_MERCURY'">inHg</xsl:when>
            <xsl:when test="$value = 'INCHES_OF_WATER'">inH2O</xsl:when>
            <xsl:when test="$value = 'JOULE_SECONDS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'JOULES'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'JOULES_PER_DEGREE_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'JOULES_PER_KILOGRAM_DEGREE_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'JOULES_PER_KILOGRAM_DRY_AIR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'KILO_BTUS'">kBTU</xsl:when>
            <xsl:when test="$value = 'KILO_BTUS_PER_HOUR'">kBUT/h</xsl:when>
            <xsl:when test="$value = 'KILOGRAMS'">kg</xsl:when>
            <xsl:when test="$value = 'KILOGRAMS_PER_CUBIC_METER'">kg/m3</xsl:when>
            <xsl:when test="$value = 'KILOGRAMS_PER_HOUR'">kg/h</xsl:when>
            <xsl:when test="$value = 'KILOGRAMS_PER_MINUTE'">kg/min</xsl:when>
            <xsl:when test="$value = 'KILOGRAMS_PER_SECOND'">kg/s</xsl:when>
            <xsl:when test="$value = 'KILOHERTZ'">kHz</xsl:when>
            <xsl:when test="$value = 'KILOOHMS'">kOhm</xsl:when>
            <xsl:when test="$value = 'KILOJOULES'">kJ</xsl:when>
            <xsl:when test="$value = 'KILOJOULES_PER_DEGREE_KELVIN'">kJ/K</xsl:when>
            <xsl:when test="$value = 'KILOJOULES_PER_KILOGRAM'">kJ/kg</xsl:when>
            <xsl:when test="$value = 'KILOJOULES_PER_KILOGRAM_DRY_AIR'">kJ/kg dry air</xsl:when>
            <xsl:when test="$value = 'KILOMETERS_PER_HOUR'">km/h</xsl:when>
            <xsl:when test="$value = 'KILOPASCALS'">kPa</xsl:when>
            <xsl:when test="$value = 'KILOVOLT_AMPERES'">kVA</xsl:when>
            <xsl:when test="$value = 'KILOVOLT_AMPERES_REACTIVE'">kVAR</xsl:when>
            <xsl:when test="$value = 'KILOVOLTS'">kV</xsl:when>
            <xsl:when test="$value = 'KILOWATT_HOURS'">kWh</xsl:when>
            <xsl:when test="$value = 'KILOWATTS'">kW</xsl:when>
            <xsl:when test="$value = 'KW_HOURS_PER_SQUARE_FOOT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'KW_HOURS_PER_SQUARE_METER'">kWh/m2</xsl:when>
            <xsl:when test="$value = 'LITERS'">l</xsl:when>
            <xsl:when test="$value = 'LITERS_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'LITERS_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'LITERS_PER_SECOND'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'LUMENS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'LUXES'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MEGA_BTUS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MEGAHERTZ'">MHz</xsl:when>
            <xsl:when test="$value = 'MEGAJOULES'">MJ</xsl:when>
            <xsl:when test="$value = 'MEGAJOULES_PER_DEGREE_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MEGAJOULES_PER_KILOGRAM_DRY_AIR'">MJ/kg dry air</xsl:when>
            <xsl:when test="$value = 'MEGAJOULES_PER_SQUARE_FOOT'">MJ / sq ft</xsl:when>
            <xsl:when test="$value = 'MEGAJOULES_PER_SQUARE_METER'">MJ/m2</xsl:when>
            <xsl:when test="$value = 'MEGAVOLT_AMPERES'">MA</xsl:when>
            <xsl:when test="$value = 'MEGAVOLT_AMPERES_REACTIVE'">MAR</xsl:when>
            <xsl:when test="$value = 'MEGAVOLTS'">MV</xsl:when>
            <xsl:when test="$value = 'MEGAWATT_HOURS'">MWh</xsl:when>
            <xsl:when test="$value = 'MEGAWATTS'">MW</xsl:when>
            <xsl:when test="$value = 'MEGOHMS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'METERS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'METERS_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'METERS_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'METERS_PER_SECOND'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'METERS_PER_SECOND_PER_SECOND'">m/s2</xsl:when>
            <xsl:when test="$value = 'MILES_PER_HOUR'">mph</xsl:when>
            <xsl:when test="$value = 'MILLIAMPERES'">mA</xsl:when>
            <xsl:when test="$value = 'MILLIBARS'">mBar</xsl:when>
            <xsl:when test="$value = 'MILLIMETERS'">mm</xsl:when>
            <xsl:when test="$value = 'MILLIMETERS_OF_MERCURY'">mmHg</xsl:when>
            <xsl:when test="$value = 'MILLIMETERS_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MILLIMETERS_PER_SECOND'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MILLIOHMS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MILLISECONDS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MILLIVOLTS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MILLIWATTS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MINUTES'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'MONTHS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'NEWTON'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'NEWTON_METERS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'NEWTON_SECONDS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'NEWTONS_PER_METER'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'NO_UNITS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'OHM_METERS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'OHMS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PARTS_PER_BILLION'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PARTS_PER_MILLION'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PASCALS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PER_SECOND'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PERCENT'">%</xsl:when>
            <xsl:when test="$value = 'PERCENT_OBSCURATION_PER_FOOT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PERCENT_OBSCURATION_PER_METER'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PERCENT_PER_SECOND'">%/s</xsl:when>
            <xsl:when test="$value = 'PERCENT_RELATIVE_HUMIDITY'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'POUNDS_FORCE_PER_SQUARE_INCH'"><xsl:value-of select="$value" />lb/??</xsl:when>
            <xsl:when test="$value = 'POUNDS_MASS'">lb</xsl:when>
            <xsl:when test="$value = 'POUNDS_MASS_PER_HOUR'">lb/h</xsl:when>
            <xsl:when test="$value = 'POUNDS_MASS_PER_MINUTE'">lb/min</xsl:when>
            <xsl:when test="$value = 'POUNDS_MASS_PER_SECOND'">lb/sec</xsl:when>
            <xsl:when test="$value = 'POWER_FACTOR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'PSI_PER_DEGREE_FAHRENHEIT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'RADIANS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'RADIANS_PER_SECOND'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'REVOLUTIONS_PER_MINUTE'">rpm</xsl:when>
            <xsl:when test="$value = 'SECONDS'">s</xsl:when>
            <xsl:when test="$value = 'SIEMENS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'SIEMENS_PER_METER'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'SQUARE_CENTIMETERS'">cm2</xsl:when>
            <xsl:when test="$value = 'SQUARE_FEET'">sq ft</xsl:when>
            <xsl:when test="$value = 'SQUARE_INCHES'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'SQUARE_METERS'">m2</xsl:when>
            <xsl:when test="$value = 'SQUARE_METERS_PER_NEWTON'">m2/N</xsl:when>
            <xsl:when test="$value = 'TESLAS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'THERMS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'TON_HOURS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'TONS'">T</xsl:when>
            <xsl:when test="$value = 'TONS_PER_HOUR'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'TONS_REFRIGERATION'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'US_GALLONS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'US_GALLONS_PER_MINUTE'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'VOLT_AMPERES'">VA</xsl:when>
            <xsl:when test="$value = 'VOLT_AMPERES_REACTIVE'">VAR</xsl:when>
            <xsl:when test="$value = 'VOLTS'">V</xsl:when>
            <xsl:when test="$value = 'VOLTS_PER_DEGREE_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'VOLTS_PER_METER'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'WATT_HOURS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'WATTS'">W</xsl:when>
            <xsl:when test="$value = 'WATTS_PER_METER_PER_DEGREE_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'WATTS_PER_SQUARE_FOOT'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'WATTS_PER_SQUARE_METER'">W/m2</xsl:when>
            <xsl:when test="$value = 'WATTS_PER_SQUARE_METER_DEGREE_KELVIN'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'WEBERS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'WEEKS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'YEARS'"><xsl:value-of select="$value" /></xsl:when>
            <xsl:when test="$value = 'NONE'"><xsl:value-of select="$none" /></xsl:when>
            <xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet> 
