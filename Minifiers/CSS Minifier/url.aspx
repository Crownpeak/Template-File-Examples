<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.UrlInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses OutputContext as its context class type%>
<%
	if (!context.PublishUrl.EndsWith(".css", StringComparison.InvariantCultureIgnoreCase))
	{
		if (context.PublishUrl.EndsWith(".aspx", StringComparison.InvariantCultureIgnoreCase))
		{
			// If it's aspx, swap to css
			context.PublishUrl = context.PublishUrl.Substring(0, context.PublishUrl.Length - 4) + "css";
		}
		else
		{
			// Otherwise just append .css
			context.PublishUrl += ".css";
		}
	}
%>
