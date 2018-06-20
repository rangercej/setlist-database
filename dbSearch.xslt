<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="common.xslt" />
	<xsl:output method="html"/>

	<xsl:key name="djs" match="dj" use="translate(., $lower, $upper)" />
	<xsl:key name="artists" match="artist" use="translate(., $lower, $upper)" />

	<xsl:variable name="backToFink">0</xsl:variable>

	<xsl:template match="/batfink">
		<tr>
			<td><b>Simple &quot;Ronseal&quot; text search:</b></td>
			<td>
				<form action="{$urlCGI}" method="get">
					<input type="hidden" name="X" value="filterBand_Track" />
					<input type="text" name="IN_SS" size="40" />
					<button type="submit">Search!</button>
				</form>
			</td>
		</tr>
		<tr>
			<td><b>Choose band:</b></td>
			<td>
				<form action="{$urlCGI}" method="get">
					<input type="hidden" name="X" value="filterBand_Track" />
					<select name="IN_ARTIST">
						<xsl:apply-templates select="//artist[count(. | key('artists', translate(., $lower, $upper))[1]) = 1]">
							<xsl:sort select="." lang="" />
						</xsl:apply-templates>
					</select>
					<button type="submit">Search!</button>
				</form>
			</td>
		</tr>
		<tr>
			<td><b>Choose deejay:</b></td>
			<td>
				<form action="{$urlCGI}" method="get">
					<input type="hidden" name="X" value="filterDj_Band_Track" />
					<select name="IN_DJ">
						<xsl:apply-templates select="//dj[count(. | key('djs', translate(., $lower, $upper))[1]) = 1]">
							<xsl:sort select="." lang="" />
						</xsl:apply-templates>
					</select>	
					<button type="submit">Search!</button>
				</form>
			</td>
		</tr>
		<tr>
			<td><b>Choose event:</b></td>
			<td>
				<form action="{$urlCGI}" method="get">
					<input type="hidden" name="X" value="filterEvent_Dj" />
					<select name="IN_EVENT">
						<xsl:apply-templates select="//event">
							<xsl:sort select="@date" order="descending" lang="" />
						</xsl:apply-templates>
					</select>	
					<button type="submit">Fetch!</button>
				</form>
			</td>
		</tr>
		<tr>
			<td><b>Choose other listing:</b></td>
			<td>
				<form action="{$urlCGI}" method="get">
					<select name="X">
						<option value="filterEvent_Dj">All events (as it happened)</option>
						<option value="countBands">Most played bands</option>
						<option value="countTracks">Most played tracks (per-mix)</option>
						<option value="countTracksCombineMix">Most played tracks (combining mixes)</option>
						<option value="countBandsReq">Most requested bands</option>
						<option value="countTracksReq">Most requested tracks</option>
						<option value="filterBand_Track">All bands/tracks (ordered by band/track)</option>
						<option value="filterTrack_Band">All bands/tracks (ordered by track/band)</option>
						<option value="filterDj_Band_Track">All bands/tracks (ordered by DJ/band/track)</option>
						<option value="filterDj_Track_Band">All bands/tracks (ordered by DJ/track/band)</option>
					</select>	
					<button type="submit">Fetch!</button>
				</form>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<hr />
				<p>Welcome to the <a href="https://www.facebook.com/groups/Batfink/">Batfink!</a>
				Setlist Database. <a href="https://www.facebook.com/groups/Batfink/">Batfink!</a>
				is based in Sheffield, and plays "more goth than you could shake a
				nicely carved walking stick at!" <!-- ... see its 
				{a href="http://www.batfink.net/"}website{/a} for all the details
				of where, when, why and how -->.</p>

				<p>Most of the listings returned by this database are hyperlinked, so if
				you go clicky-clicky on bands, tunes, DJs or dates in <i>any</i> listing,
				you'll be taken to a listing of that item. The latest setlist is always
				available by linking straight to
				<a href="http://cej.nightwolf.org.uk/batfink/latest.html">latest.html</a></p>

				<p>If there's a problem with the setlists, could you please let me know at
				<a href="mailto:cej-fink@nightwolf.org.uk">cej-fink@nightwolf.org.uk</a>.
				Cheers!</p>
				<hr />
				<p><i>Powered by
				<a href="http://www.gingerall.com/charlie/ga/xml/p_sab.xml">Sablotron
				XSLT</a></i></p>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="dj">
		<option><xsl:value-of select="." /></option>
	</xsl:template>

	<xsl:template match="artist">
		<option><xsl:value-of select="." /></option>
	</xsl:template>

	<xsl:template match="event">
		<xsl:variable name="rawdate" select="@date" />
		<xsl:variable name="nicedate">
			<xsl:call-template name="formatdate">
				<xsl:with-param name="datestring" select="@date" />
			</xsl:call-template>
		</xsl:variable>
		<option value="{$rawdate}"><xsl:value-of select="$nicedate" /></option>
	</xsl:template>
</xsl:stylesheet>
