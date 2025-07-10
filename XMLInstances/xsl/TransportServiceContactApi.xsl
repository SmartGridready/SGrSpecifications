<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <!-- contactApiInterfaceDesc -->
    <xsl:template match="sgr:contactInterfaceDescription">
        <tr class="transportDetails">
            <td class="contactapiattribute">Number of Contacts</td>
            <td>
                <xsl:value-of select="sgr:numberOfContacts" />
            </td>
        </tr>
        <tr class="transportDetails">
            <td class="contactapiattribute">Contact Stabilization Time</td>
            <td>
                <xsl:value-of select="sgr:contactStabilisationTimeMs" />
                ms
            </td>
        </tr>
    </xsl:template>
</xsl:stylesheet>