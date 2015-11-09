<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.PostInputInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses PostInputContext as its context class type%>
<%
	if (context.UIType == UIType.Volte)
	{
		var panels = context.InputForm.GetPanels("source_panel");
		for (int i = 0, len = panels.Count; i < len; i++)
		{
			PanelEntry panel = panels[i];

			string sourceType = panel["source_type"];
			if (!context.InputForm.HasField(panel.GetFieldName("source_" + sourceType)) || string.IsNullOrWhiteSpace(panel["source_" + sourceType]))
			{
				context.ValidationErrorFields.Add("source_" + sourceType + ":" + (i + 1), string.Format("{0} is a required field.", Util.StartCase(sourceType)));
			}
			if (string.IsNullOrWhiteSpace(panel[sourceType + "_type"]))
			{
				context.ValidationErrorFields.Add(sourceType + "_type" + ":" + (i + 1), "Type is a required field.");
			}
		}
	}
	else
	{
		foreach (var panel in context.InputForm.GetPanels("source_panel"))
		{
			string sourceType = panel["source_type"];
			if (!context.InputForm.HasField(panel.GetFieldName("source_" + sourceType)) || string.IsNullOrWhiteSpace(panel["source_" + sourceType]))
			{
				context.ValidationError = "Error";
				context.ValidationErrorFields.Add(panel.GetFieldName("source_" + sourceType), string.Format("{0} is a required field.", Util.StartCase(sourceType)));
			}
			if (string.IsNullOrWhiteSpace(panel[sourceType + "_type"]))
			{
				context.ValidationError = "Error";
				context.ValidationErrorFields.Add(panel.GetFieldName(sourceType + "_type"), "Type is a required field.");
			}
		}
	}
%>
