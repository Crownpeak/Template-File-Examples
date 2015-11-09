<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.FilenameInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses OutputContext as its context class type%>
<%
	if (!context.PublishPath.EndsWith(".js", StringComparison.InvariantCultureIgnoreCase))
	{
		if (context.PublishPath.EndsWith(".aspx", StringComparison.InvariantCultureIgnoreCase))
		{
			// If it's aspx, swap to js
			context.PublishPath = context.PublishPath.Substring(0, context.PublishPath.Length - 4) + "js";
		}
		else
		{
			// Otherwise just append .js
			context.PublishPath += ".js";
		}
	}
%>
