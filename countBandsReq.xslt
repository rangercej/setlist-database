<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="common.xslt" />
	<xsl:output method="html"/>

	<xsl:key name="artists" match="artist[../@type!='']" use="." />

	<xsl:template match="batfink">
		<xsl:for-each select="//artist[generate-id() = generate-id(key('artists', .)[1])]">
			<xsl:sort select="count(key('artists',.))" data-type="number" order="descending" lang="" />
			<xsl:sort select="." data-type="text" lang="" />
			<tr class="row{position() mod 2}">
				<td><xsl:apply-templates select="." /></td>
				<td><xsl:value-of select="count(key('artists', .))" /></td>
				<td><img src="{$staticDir}/bar.jpg" height="15" width="{15 * count(key('artists', .))}" /></td>
			</tr>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
