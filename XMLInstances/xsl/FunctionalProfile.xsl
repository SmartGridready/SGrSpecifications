<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!--
    Contains the style sheets for the generic functional profile, including
    - sgr:alternativeNames
-->

    <xsl:template match="sgr:functionalProfileListElement">
        <div class="functionalProfile">
            <h2 style="float:left;"> Functional Profile - <xsl:value-of
                    select="sgr:functionalProfile/sgr:functionalProfileName" />
            </h2>

            <!-- Functional Profile Block -->
            <table>
                <colgroup>
                    <col style="width:30%" />
                </colgroup>

                <xsl:apply-templates select="sgr:functionalProfile" />
                <xsl:apply-templates select="sgr:genericAttributes" />
                <xsl:apply-templates select="sgr:modbusAttributes" />
            </table>

        </div>
    </xsl:template>

    <xsl:template match="sgr:functionalProfile">
        <xsl:apply-templates select="sgr:functionalProfileIdentification" />

        <tr><td class="noborder">&#160;</td></tr>

        <xsl:apply-templates select="sgr:alternativeNames" />
        <xsl:apply-templates select="sgr:legibleDescription" />
        <xsl:apply-templates select="sgr:programmerHints" />

    </xsl:template>

    <!-- Generic Functional Profile -->
    <xsl:template match="sgr:functionalProfileIdentification">

        <!--tr>
            <td>Owner</td>
            <td>
                <xsl:choose>
                    <xsl:when test="sgr:specificationOwnerIdentification = 0">SGr</xsl:when>
                    <xsl:otherwise><xsl:value-of select="sgr:specificationOwnerIdentification" /></xsl:otherwise>
                </xsl:choose>        
            </td>
        </tr-->
        <tr>
            <td>Category</td>
            <td>
                <xsl:apply-templates select="sgr:functionalProfileCategory">
                    <xsl:with-param name="separator" select="' - '" />
                </xsl:apply-templates>
            </td>
        </tr>
        <tr>
            <td>Type</td>
            <td>
                <xsl:apply-templates select="sgr:functionalProfileType">
                    <xsl:with-param name="separator" select="' - '" />
                </xsl:apply-templates>
            </td>
        </tr>
        <tr>
            <td>Level</td>
            <td>
                <xsl:value-of select="sgr:levelOfOperation" />
            </td>
        </tr>
        <tr>
            <td>Version</td>
            <td>
                <xsl:apply-templates select="sgr:versionNumber" />
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>