<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.SmtpImportInit" %>

<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses SmtpImportContext as its context class type%>
<%
    //Stop CMS from creating asset on its own
    context.AutoCreateAsset = false;

    //Folder that imported assets will be saved
    Asset importFolder = Asset.Load("/Sandbox/TDW Example/Imports");
    //Model for imported assets
    Asset assetModel = Asset.Load("/System/Models/Sandbox/SMTP Import Model/CD Import Model");

    //Email token for SMTP Import Example
    string szToken = context.Subject.Contains("TKX6nRezoPvuKLXB") ? "TKX6nRezoPvuKLXB" : "";

    foreach (EmailAttachment eaData in context.EmailAttachments)
    {
        if (eaData.Extension.ToLower() == "xml")
        {
            //Create string to hold content of xml file
            string contentAttachment = (eaData.StringValue.Substring(0, 1) == "?") ? eaData.StringValue.Substring(1, eaData.StringValue.Length - 1) : eaData.StringValue;


            int nodeCount = 1;

            foreach (XmlNode xnRow in Util.LoadXml(contentAttachment.Replace("&", "&amp;"), "CATALOG"))
            {
                foreach (XmlNode cd in xnRow.XmlNodes)
                {
                    //Create Dictionary to hold tags and respective content 
                    Dictionary<string, string> contentFields = new Dictionary<string, string>();
                    
                    //Default asset name in case title is not available
                    string assetName = "CD " + nodeCount; ;

                    foreach (XmlNode xnfield in cd.XmlNodes)
                    {

                        contentFields.Add(xnfield.Name.ToLower(), Util.EscapeItem(xnfield.Value));
                        //Out.DebugWriteLine("item: " + xnfield.Name + " " + xnfield.Value);//DEBUG STATEMENT
                        //Set title of the CD as the name of the asset
                        if (String.Equals(xnfield.Name/*.ToString()*/, "title", StringComparison.OrdinalIgnoreCase))
                        {
                            assetName = xnfield.Value;
                        }
                    }

                    // Create Asset                    
                    contentFields.Add("source", Util.EscapeItem(cd.Value));

                    if (importFolder.IsLoaded && assetModel.IsLoaded)
                    {
                        contentFields.Add("email_import_token", szToken);

                        contentFields.Add("imported", "true");

                        string cmsLabel = assetName; //(This code causes error)=> Util.FilterFilename(assetName + "_" + DateTime.Now.ToString()).Replace("/", "_");

                        //Check that asset does not already exist
                        Asset checkAsset = Asset.Load(importFolder + cmsLabel);
                        if (!checkAsset.IsLoaded)
                        {
                            Asset newAsset = Asset.CreateNewAsset(cmsLabel, importFolder, assetModel, contentFields);
                        }
                    }
                    nodeCount++;
                }

            }

        }


    }

%>
