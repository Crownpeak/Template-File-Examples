<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.FilenameInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses OutputContext as its context class type%>
<%
	if (!context.PublishPath.EndsWith(".css", StringComparison.InvariantCultureIgnoreCase))
	{
		if (context.PublishPath.EndsWith(".aspx", StringComparison.InvariantCultureIgnoreCase))
		{
			// If it's aspx, swap to css
			context.PublishPath = context.PublishPath.Substring(0, context.PublishPath.Length - 4) + "css";
		}
		else
		{
			// Otherwise just append .css
			context.PublishPath += ".css";
		}
	}
%>
