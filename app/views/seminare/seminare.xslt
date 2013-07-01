<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
      <html>
        <body>
          <table>
            <tr>
              <th>Link LV</th>
              <th>Titel</th>
              <th>Organisation</th>
            </tr>

            <xsl:for-each select="//course">
              <xsl:if test="contains(courseName/text, 'IN0012')">
                <tr>
                  <td>
                    <a>
                      <xsl:attribute name="href">
                        <xsl:value-of select="concat('https://campus.tum.de/tumonline/lv.detail?clvnr=', courseID)"/>
                      </xsl:attribute>

                      Link
                    </a>
                  </td>
                  
                  <td>
                    <xsl:value-of select="courseName/text"/>
                  </td>

                  <td>
                    <xsl:value-of select="../orgUnitName/text"/>
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>
        </body>
      </html>
    </xsl:template>
</xsl:stylesheet>
