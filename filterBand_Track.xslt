<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="common.xslt" />
        <xsl:output method="html"/>
	<xsl:param name="IN_ARTIST" />
	<xsl:param name="IN_SS" />

	<xsl:template match="batfink">
		<xsl:choose>
			<xsl:when test="$IN_ARTIST!=''">
				<xsl:call-template name="getcounts">
					<xsl:with-param name="count" select="count(event//set//track[contains(artist,$IN_ARTIST)])" />
					<xsl:with-param name="total" select="count(event//set//track)" />
				</xsl:call-template>

				<xsl:apply-templates select="event//set//track[contains(artist,$IN_ARTIST)]" mode="fullrow">
					<xsl:sort select="artist" data-type="text" lang="" />
					<xsl:sort select="tune" data-type="text" lang="" />
					<xsl:sort select="../dj" data-type="text" lang="" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="$IN_SS!=''">
				<xsl:call-template name="getcounts">
					<xsl:with-param name="count" select="count(event//set//track[contains(translate(artist, $lower, $upper), translate($IN_SS, $lower, $upper)) or contains(translate(tune, $lower, $upper), translate ($IN_SS, $lower, $upper))])" />
					<xsl:with-param name="total" select="count(event//set//track)" />
				</xsl:call-template>

				<xsl:apply-templates select="event//set//track[contains(translate(artist, $lower, $upper), translate($IN_SS, $lower, $upper)) or contains(translate(tune, $lower, $upper), translate ($IN_SS, $lower, $upper))]" mode="fullrow">
					<xsl:sort select="artist" data-type="text" lang="" />
					<xsl:sort select="tune" data-type="text" lang="" />
					<xsl:sort select="../dj" data-type="text" lang="" />
				</xsl:apply-templates>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="event//set//track" mode="fullrow">
					<xsl:sort select="artist" data-type="text" lang="" />
					<xsl:sort select="tune" data-type="text" lang="" />
					<xsl:sort select="../dj" data-type="text" lang="" />
				</xsl:apply-templates>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
