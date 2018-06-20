<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="common.xslt" />
	<xsl:output method="html" />

	<xsl:template match="batfink">
		<xsl:apply-templates select="event[not(@date &lt; ../event/@date)]" />
	</xsl:template>

	<xsl:template match="event">
		<tr>
			<td colspan="5">
				<xsl:if test="position()!=1">
					<hr />
				</xsl:if>
				<table border="0">
					<tr>
						<td><b>Batcave:</b> <xsl:value-of select="venue" /></td>
						<td style="text-align: right">
							<b>Batdate:</b> <xsl:apply-templates select="@date" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<xsl:apply-templates select="set">
			<xsl:sort select="@order" data-type="number" lang="" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="set">
		<xsl:variable name="trackcount"><xsl:value-of select="count(track)" /></xsl:variable>
		<tr><td><xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text></td></tr>
		<tr>
			<td rowspan="{$trackcount}">
				<xsl:apply-templates select="dj" />
				<xsl:if test="@room!=''">
					<br />(Room <xsl:value-of select="@room" />)
				</xsl:if>
			</td>
			<td rowspan="{$trackcount}">
				<xsl:value-of select="time-start" /> - 
				<xsl:value-of select="time-end" />
			</td>
			<xsl:apply-templates select="track[@order=0]" />
		</tr>
		<xsl:for-each select="track[@order > 0]">
			<xsl:sort select="@order" data-type="number" lang="" />
			<tr><xsl:apply-templates select="." /></tr>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="track">
			<td><xsl:apply-templates select="artist" /></td>
			<td><xsl:apply-templates select="tune" /> <xsl:apply-templates select="mix" /></td>
			<td><xsl:apply-templates select="@type" /></td>
	</xsl:template>
</xsl:stylesheet>
