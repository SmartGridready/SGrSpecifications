<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <xsl:template match="sgr:genericAttributeList">

        <!--genericAttributeList-->
        <xsl:for-each select="sgr:genericAttributeListElement">
            <xsl:variable name="name" select="sgr:name"/>
            <xsl:variable name="attribute" select="document(concat('../GenericAttributes/', $name, '.xml'))"/>
            <tr class="genericDetails">
                <td class="genericattribute">
                  <xsl:value-of select="$attribute/sgr:GenericAttributeFrame/sgr:name" />
                </td>
                <td>
                  <xsl:choose>
                    <xsl:when test="sgr:genericAttributeList/sgr:genericAttributeListElement">
                      <xsl:for-each select="sgr:genericAttributeList/sgr:genericAttributeListElement">
                        <ul style="margin: 0">
                          <li>
                            <xsl:value-of select="sgr:name" />:
                            <xsl:value-of select="sgr:value" />&#160;<xsl:call-template name="SGrUnits">
                              <xsl:with-param name="value" select="sgr:unit" />
                              <xsl:with-param name="none" select="''" />
                            </xsl:call-template>
                          </li>
                        </ul>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="sgr:value" />&#160;<xsl:call-template name="SGrUnits">
                        <xsl:with-param name="value" select="sgr:unit" />
                        <xsl:with-param name="none" select="''" />
                      </xsl:call-template>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
            </tr>
        </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>