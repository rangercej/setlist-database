<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- Configuration constants -->
	<xsl:variable name="urlCGI">/batfink/batfink.xwx</xsl:variable>
	<xsl:variable name="staticDir">/batfink</xsl:variable>

	<!-- Globals -->
	<xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:variable name="backToFink">1</xsl:variable>

	<xsl:template match="/">
		<html>
			<head>
				<title>Batfink Setlist Database!</title>
				<link type="text/css" rel="stylesheet" href="{$staticDir}/batfink.css" />
			</head>
			<body>
				<p class="header">
					<img alt="[Batfink Logo!]" src="{$staticDir}/logo_comicspurple.gif" />
				</p>
				<xsl:if test="$backToFink = 1">
					<i><a href="{$urlCGI}?X=dbSearch">Back to Batfink!</a></i>
				</xsl:if>
				<hr />
				<table style="width: 100%" border="0">
					<xsl:apply-templates select="/batfink" />
				</table>
				<xsl:if test="$backToFink = 1">
					<hr />
					<i><a href="{$urlCGI}?X=dbSearch">Back to Batfink!</a></i>
				</xsl:if>
			</body>
		</html>
	</xsl:template>

	<xsl:template name="formatdate">
		<xsl:param name="datestring" />

		<xsl:variable name="year"><xsl:value-of select="substring($datestring,1,4)" /></xsl:variable>
		<xsl:variable name="mnth"><xsl:value-of select="substring($datestring,5,2)" /></xsl:variable>
		<xsl:variable name="date"><xsl:value-of select="substring($datestring,7,2)" /></xsl:variable>

		<xsl:variable name="mnthname">
			<xsl:choose>
				<xsl:when test="$mnth='01'">Jan</xsl:when>
				<xsl:when test="$mnth='02'">Feb</xsl:when>
				<xsl:when test="$mnth='03'">Mar</xsl:when>
				<xsl:when test="$mnth='04'">Apr</xsl:when>
				<xsl:when test="$mnth='05'">May</xsl:when>
				<xsl:when test="$mnth='06'">Jun</xsl:when>
				<xsl:when test="$mnth='07'">Jul</xsl:when>
				<xsl:when test="$mnth='08'">Aug</xsl:when>
				<xsl:when test="$mnth='09'">Sep</xsl:when>
				<xsl:when test="$mnth='10'">Oct</xsl:when>
				<xsl:when test="$mnth='11'">Nov</xsl:when>
				<xsl:when test="$mnth='12'">Dec</xsl:when>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$date" />
		<xsl:text disable-output-escaping="yes"> </xsl:text>
		<xsl:value-of select="$mnthname" />
		<xsl:text disable-output-escaping="yes"> </xsl:text>
		<xsl:value-of select="$year" />
	</xsl:template>

	<xsl:template match="artist">
		<xsl:if test="string(.)!=''">
		<a class="listing" href="{$urlCGI}?X=filterBand_Track&amp;IN_ARTIST={string(.)}"><xsl:value-of select="." /></a>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tune">
		<xsl:if test="string(.)!=''">
		<a class="listing" href="{$urlCGI}?X=filterTrack_Band&amp;IN_TUNE={string(.)}"><xsl:value-of select="." /></a>
		</xsl:if>
	</xsl:template>

	<xsl:template match="dj">
		<xsl:if test="string(.)!=''">
		<a class="listing" href="{$urlCGI}?X=filterDj_Band_Track&amp;IN_DJ={string(.)}"><xsl:value-of select="." /></a>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@date">
		<a class="listing" href="{$urlCGI}?X=filterEvent_Dj&amp;IN_EVENT={string(.)}">
			<xsl:call-template name="formatdate">
				<xsl:with-param name="datestring" select="." />
			</xsl:call-template>
		</a>
	</xsl:template>

	<xsl:template match="@type">
		<xsl:choose>
			<xsl:when test="string(.)='r'"><a class="listing" href="{$urlCGI}?X=countBandsReq">Request</a></xsl:when>
			<xsl:when test="string(.)='br'"><a class="listing" href="{$urlCGI}?X=countBandsReq">BandReq</a></xsl:when>
			<xsl:when test="string(.)='tr'"><a class="listing" href="{$urlCGI}?X=countTracksReq">TrackReq</a></xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="track" mode="fullrow">
		<xsl:variable name="cname" select="position() mod 2" />
		<tr class="row{$cname}">
			<td><xsl:apply-templates select="artist" /></td>
			<td>
				<xsl:apply-templates select="tune" />
				<xsl:apply-templates select="mix" />
			</td>
			<td><xsl:apply-templates select="@type" /></td>
			<td><xsl:apply-templates select="../dj" /></td>
			<td><xsl:apply-templates select="../../@date" /></td>
		</tr>
	</xsl:template>

	<xsl:template match="mix">
		<xsl:if test="string(.) != ''">
			(<xsl:copy-of select="." />)
		</xsl:if>
	</xsl:template>

	<xsl:template name="getcounts">
		<xsl:param name="count" select="'0'" />
		<xsl:param name="total" select="'0'" />
		<tr>
			<td colspan="5">
				<xsl:value-of select="$count" />
				matches found out of
				<xsl:value-of select="$total" />
				<xsl:if test="$total &gt; 0">
					(<xsl:value-of select="round(($count div $total) * 10000) div 100" />%)
				</xsl:if>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
	</xsl:template>

</xsl:stylesheet>
