<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.OutputInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses OutputContext as its context class type%>
<%
	foreach (var peSource in asset.GetPanels("source_panel"))
	{
		var sourceType = peSource["source_type"];
		FilterParams searchParams;
		switch (sourceType)
		{
			case "folder":
				var folder = Asset.Load(peSource["source_folder"]);

				if (folder.IsLoaded && folder.IsFolder)
				{
					searchParams = new FilterParams();
					searchParams.Add(AssetPropertyNames.Label, Comparison.EndsWith, ".js");
					searchParams.FilterStatus = Util.MakeList(asset.WorkflowStatus.ToString());
					ProcessAssets(folder.GetFilterList(searchParams), peSource["folder_type"]);
				}
				break;
			case "asset":
				var a = Asset.Load(peSource["upload#source_asset"]);
				ProcessAsset(a, peSource["asset_type"]);
				break;
			case "template":
				var templateFolder = Asset.Load(peSource["source_template"]);
				if (templateFolder.IsLoaded && templateFolder.IsFolder)
				{
					var rootFolder = Asset.LoadByIdPath("/");
					searchParams = new FilterParams();
					searchParams.Add(AssetPropertyNames.TemplateId, Comparison.Equals, templateFolder.Id);
					searchParams.FilterStatus = Util.MakeList(asset.WorkflowStatus.ToString());
					ProcessAssets(rootFolder.GetFilterList(searchParams), peSource["template_type"]);
				}
				break;
		}
	}
%>
<script runat="server" data-cpcode="true">

	public void ProcessAssets(ICollection<Asset> assets, string includeType)
	{
		var processedIds = new List<int>();
		foreach (var childAsset in assets)
		{
			// Mmake sure we don't process ourself
			if (asset.Id == childAsset.Id || asset.BranchId == childAsset.Id || asset.ChildId == childAsset.Id) return;

			// Make sure we don't process any asset more than once (i.e. branches)
			if (!processedIds.Contains(childAsset.BranchId))
			{
				processedIds.Add(childAsset.BranchId);
				ProcessAsset(childAsset, includeType);
			}
		}
	}

	public void ProcessAsset(Asset thisAsset, string includeType)
	{
		if (!context.IsPublishing)
		{
			Out.WriteLine("{3}: {0} (child id: {1}) {2}<br/>", thisAsset.AssetPath, thisAsset.ChildId, thisAsset.BranchId, includeType);
		}
		else
		{
			try
			{
				// Make sure we don't recurse and process this asset
				if (asset.Id == thisAsset.Id || asset.BranchId == thisAsset.Id || asset.ChildId == thisAsset.Id) return;

				if (includeType == "compress")
				{
					Out.WriteLine(Util.MinifyJS(thisAsset.Show()));
				}
				else
				{
					Out.WriteLine(thisAsset.Show());
				}
			}
			catch (Exception ex)
			{
				Out.DebugWriteLine("Failed to process js for {0} ({1}), error {2} in {3}", thisAsset.AssetPath, thisAsset.Id, ex.Message, ex.Source);
				Out.WriteLine("/* Failed to process js for {0} ({1}), error {2} in {3} */", thisAsset.AssetPath, thisAsset.Id, ex.Message, ex.Source);
			}
		}
	}


</script>

