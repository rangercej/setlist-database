<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="common.xslt" />
	<xsl:output method="html"/>
	<xsl:param name="IN_DJ" />

	<xsl:template match="batfink">
		<xsl:choose>
			<xsl:when test="$IN_DJ!=''">
				<xsl:call-template name="getcounts">
					<xsl:with-param name="count" select="count(event//set//track[../dj=$IN_DJ])" />
					<xsl:with-param name="total" select="count(event//set//track)" />
				</xsl:call-template>

				<xsl:apply-templates select="event//set//track[../dj=$IN_DJ]" mode="fullrow">
					<xsl:sort select="../dj" data-type="text" lang="" />
					<xsl:sort select="artist" data-type="text" lang="" />
					<xsl:sort select="tune" data-type="text" lang="" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="event//set//track" mode="fullrow">
					<xsl:sort select="../dj" data-type="text" lang="" />
					<xsl:sort select="artist" data-type="text" lang="" />
					<xsl:sort select="tune" data-type="text" lang="" />
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
