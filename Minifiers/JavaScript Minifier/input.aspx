<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.InputInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses InputContext as its context class type%>
<%
	//    Input.StartControlPanel("JS minifier");

	if (context.UIType == UIType.Classic)
		Input.ShowHeader("JavaScript Minifier: Choose source files");

	while (Input.NextPanel("source_panel", displayName: "JavaScript Minifier: Choose source files"))
	{
		var sourceTypes = new Dictionary<string, string>()
		{
			{ "Folder", "folder" },
			{ "Asset", "asset" },
			{ "Template", "template" }
		};

		var includeTypes = new Dictionary<string, string>()
		{
			{ "Include", "include" },
			{ "Compress", "compress" }
		};

		Input.StartDropDownContainer("Choose source type", "source_type", sourceTypes, "asset");

		// Folder dropdown
		Input.ShowSelectFolder("Choose folder", "source_folder", defaultFolder: asset.AssetPath.ToString());
		Input.ShowDropDown("Type", "folder_type", includeTypes, new string[] { "compress" }.ToList());

		Input.NextDropDownContainer();
		// Asset dropdown
		Input.ShowAcquireDocument("Choose asset", "source_asset", new ShowAcquireParams()
		{
			Extensions = new string[] { "js" }.ToList(),
			ShowUpload = false
		});
		Input.ShowDropDown("Type", "asset_type", includeTypes, new string[] { "compress" }.ToList());

		Input.NextDropDownContainer();
		// Template dropdown
		Input.ShowSelectFolder("Choose template", "source_template", defaultFolder: "/System/Templates");
		Input.ShowDropDown("Type", "template_type", includeTypes, new string[] { "compress" }.ToList());

		Input.EndDropDownContainer();
	}

	//    Input.EndControlPanel();
%>
