<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="common.xslt" />
	<xsl:output method="html"/>

	<xsl:key name="tunes" match="track" use="concat(artist,'!',tune,'!',mix)" />

	<xsl:template match="batfink">
		<xsl:for-each select="//track[generate-id() = generate-id(key('tunes', concat(artist,'!',tune,'!',mix))[1])]">
			<xsl:sort select="count(key('tunes', concat(artist,'!',tune,'!',mix)))" data-type="number" order="descending" lang="" />
			<xsl:sort select="artist" data-type="text" lang="" />
			<xsl:sort select="tune" data-type="text" lang="" />
			<xsl:sort select="mix" data-type="text" lang="" />
			<tr class="row{position() mod 2}">
				<td><xsl:apply-templates select="artist" /> - <xsl:apply-templates select="tune" /> <xsl:apply-templates select="mix" /></td>
				<td><xsl:value-of select="count(key('tunes', concat(artist,'!',tune,'!',mix)))" /></td>
				<td><img src="{$staticDir}/bar.jpg" height="15" width="{15 * count(key('tunes', concat(artist,'!',tune,'!',mix)))}" /></td>
			</tr>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
