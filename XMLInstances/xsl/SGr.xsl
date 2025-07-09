<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:sgr="http://www.smartgridready.com/ns/V0/">

    <xsl:output method="html" version="4.0" encoding="UTF-8" indent="yes" />

    <xsl:include href="GenericAttributes.xsl" />
    <xsl:include href="Helpers.xsl" />

    <xsl:include href="DeviceFrame.xsl" />
    <xsl:include href="FunctionalProfile.xsl" />
    <xsl:include href="DataPoint.xsl" />

    <xsl:include href="FunctionalProfileFrame.xsl" />

    <xsl:include href="TransportServiceModbus.xsl" />
    <xsl:include href="TransportServiceMessaging.xsl" />
    <xsl:include href="TransportServiceRestApi.xsl" />
    <xsl:include href="TransportServiceContactApi.xsl" />

    <xsl:template match="/">
        <html lang="any">
            <head>
                <title>
                    <xsl:choose>
                        <xsl:when test="/sgr:FunctionalProfileFrame">
                            SGr.
                            <xsl:value-of
                                select="/*/sgr:functionalProfile/sgr:functionalProfileIdentification/sgr:functionalProfileCategory" />.
                            <xsl:value-of
                                select="/*/sgr:functionalProfile/sgr:functionalProfileIdentification/sgr:functionalProfileType" />.
                            <xsl:value-of
                                select="/*/sgr:functionalProfile/sgr:functionalProfileIdentification/sgr:levelOfOperation" />
                        </xsl:when>
                        <xsl:otherwise> SGr EI <xsl:value-of select="/*/sgr:manufacturerName" /> - <xsl:value-of
                                select="/*/sgr:deviceName" />
                        </xsl:otherwise>
                    </xsl:choose>
                </title>
                <meta name="viewport" content="width=device-width, initial-scale=1" />
                <link rel="stylesheet" type="text/css" href="/xsl/SGr.css" />
            </head>
            <body class="any">
                <script type="text/javascript">
                    function toggleClass(className) {
                    const collection = document.getElementsByClassName(className);
                    for (let i = 0; i &lt; collection.length; i++) {
                    collection[i].style.display == "none" ? collection[i].style.display = "block" :
                    collection[i].style.display = "none";
                    }
                    }
                    function toggleClassRow(className) {
                    const collection = document.getElementsByClassName(className);
                    for (let i = 0; i &lt; collection.length; i++) {
                    collection[i].style.display == "none" ? collection[i].style.display =
                    "table-row" : collection[i].style.display = "none";
                    }
                    }
                </script>
                <div class="navigation">
                    <h2>Details</h2>
                    <div>
                        <input type="checkbox" onclick="toggleClassRow('dataPointDetails')"
                            name="showDPDetails" value="1" checked="checked" /> Data Points </div>
                    <div>
                        <input type="checkbox" onclick="toggleClassRow('genericDetails')"
                            name="showDPDetails" value="1" checked="checked" /> Generic Info </div>
                    <div>
                        <input type="checkbox" onclick="toggleClassRow('ontologyDetails')"
                            name="showDPDetails" value="1" checked="checked" /> Alternative Names </div>
                    <div>
                        <input type="checkbox" onclick="toggleClassRow('transportDetails')"
                            name="showDPDetails" value="1" checked="checked" /> Transport Layer </div>
                    <div>
                        <select name="language" id="language" title="Language"
                            onchange="document.body.className = this.value">
                            <xsl:choose>
                                <xsl:when test="/sgr:DeviceFrame">
                                    <option value="any">All Languages</option>
                                </xsl:when>
                                <xsl:otherwise>
                                    <option value="anyfp">All Languages</option>
                                </xsl:otherwise>
                            </xsl:choose>
                            <option value="en">English</option>
                            <option value="de">Deutsch</option>
                            <xsl:if test="/sgr:DeviceFrame">
                                <option value="fr">Francais</option>
                                <option value="it">Italiano</option>
                            </xsl:if>
                            <option value="none">(none)</option>
                        </select>
                    </div>
                </div>
                <div class="document">

                    <!-- Map device frames -->
                    <xsl:apply-templates select="sgr:DeviceFrame" />


                    <!-- Map  functional profiles -->
                    <xsl:apply-templates select="sgr:FunctionalProfileFrame" />
                </div>
            </body>
            <script>
                if (navigator.userAgent.match(/firefox|fxios/i))
                {
                    // get all "renderhtml" hints (HTML escaped within CDATA/text) nodes, then unescape and render HTML code
                    var nodes = document.getElementsByClassName("renderhtml");
                    for (var i = nodes.length - 1; i >= 0; i--) {
                        nodes[i].innerHTML = nodes[i].textContent;
                    }
                }
            </script>
        </html>
    </xsl:template>

</xsl:stylesheet>