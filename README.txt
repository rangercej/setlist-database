This is the Batfink Setlist Database.

Batfink was a monthly clubnight in Sheffield playing all manner of goth, EDM,
80s, and cheese. I managed the setlist database for it, which consists of an
XML file, and a large number of XSLT stylesheets to render the HTML.

The night itself closed in 2007, but came back for the odd special night every
now and then.

It is sorely missed :-)

The core setlist is an XML file in batfink.xwx. The rendering engine was my
own extension for Apache - xslt-cgi, which can be found on Github at
https://github.com/rangercej/xslt-cgi (hence the .xwx extension, rather than
.xml).

The default stylesheet is batfink.xslt, but others could be used on demand,
allowing for the setlist to order by DJ, provide top-ten lists, etc. See the
docs on xslt-cgi for setup instructions.

