<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!--
    Contains the style sheets for the generic functional profile, including
    - sgr:alternativeNames
    -->

    <xsl:template match="sgr:functionalProfileList">
        <xsl:for-each select="sgr:functionalProfileListElement">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="sgr:functionalProfileListElement">
        <div class="functionalProfile">
            <h2 style="float:left;"> Functional Profile - <xsl:value-of
                    select="sgr:functionalProfile/sgr:functionalProfileName" />
            </h2>

            <!-- Functional Profile Block -->
            <table>
                <colgroup>
                    <col style="width:230px" />
                </colgroup>

                <xsl:apply-templates select="sgr:functionalProfile" />
                <xsl:apply-templates select="sgr:genericAttributes" />
                <xsl:apply-templates select="sgr:genericAttributeList" />
                <xsl:apply-templates select="sgr:modbusAttributes" />
                <xsl:apply-templates select="sgr:messagingAttributes" />
            </table>

            <xsl:apply-templates select="sgr:dataPointList" />

        </div>
    </xsl:template>

    <xsl:template match="sgr:functionalProfile">
        <xsl:apply-templates select="sgr:functionalProfileIdentification" />

        <tr><td class="noborder" /></tr>

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
            <td><strong>Category</strong></td>
            <td>
                <xsl:value-of select="sgr:functionalProfileCategory" />
            </td>
        </tr>
        <tr>
            <td><strong>Type</strong></td>
            <td>
                <xsl:value-of select="sgr:functionalProfileType" />
            </td>
        </tr>
        <tr>
            <td><strong>Level</strong></td>
            <td>
                <xsl:value-of select="sgr:levelOfOperation" />
            </td>
        </tr>
        <tr>
            <td><strong>Version</strong></td>
            <td>
                <xsl:apply-templates select="sgr:versionNumber" />
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>