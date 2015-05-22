<%@ Page Language="C#" Inherits="CrownPeak.Internal.Debug.InputInit" %>
<%@ Import Namespace="CrownPeak.CMSAPI" %>
<%@ Import Namespace="CrownPeak.CMSAPI.Services" %>
<%@ Import Namespace="CrownPeak.CMSAPI.CustomLibrary" %>
<!--DO NOT MODIFY CODE ABOVE THIS LINE-->
<%//This plugin uses InputContext as its context class type%>
<%
// input.aspx: template file to specify content entry input form

//List used for radio button and list controls
Dictionary<string, string> buttons = new Dictionary<string, string>();

buttons.Add("California", "CA");
buttons.Add("Nevada", "NV");
buttons.Add("Mississippi", "MI");

//Tab Tab
Input.StartTabbedPanel("Panels", "Basic Form Fields", "Selector and Upload Fields", "Dropdowns", "Display Only");
Input.ShowMessage("Panel types");

//Tabbed Panel
Input.StartTabbedPanel("Tabbed Panel", "Horizontal Panel", "List Panel");
//Input.ShowHeader("Input.StartTabbedPanel()...Input.NextTabbedPanel()...Input.EndTabbedPanel()");
Input.ShowMessage("Starts the tabbed panel. Similar to a windows panel, a tabbed panel (unlike an expand panel) displays a list of tabs that when selected shows the hidden panel.");

Input.NextTabbedPanel();

//Input.ShowHeader("Input.StartHorizontalWrapContainer()...Input.EndHorizontalWrapContainer().");
Input.ShowMessage("Creates a container that arranges the contained controls horizontally. If the controls can't fit in one row, they wrap to a new row below the first.");
Input.StartHorizontalWrapContainer();
Input.ShowTextBox("First name", "fname");
Input.ShowTextBox("Last name", "lname");
Input.ShowTextBox("Telephone", "telephone");
Input.EndHorizontalWrapContainer();

Input.NextTabbedPanel();
//Input.ShowHeader("Input.NextPanel()");
Input.ShowMessage("Gets the next available panel from the named list. Always returns at least one entry. Uses data already stored in the asset.");
while (Input.NextPanel("panel_var", displayName: "List Panel"))
{
    Input.ShowTextBox("Name", "name");
    Input.ShowTextBox("Telephone", "telephone");
}
Input.EndTabbedPanel();

//List  Panel
Input.StartControlPanel("List Panel");
//Input.ShowHeader("Input.NextPanel()");
Input.ShowMessage("Gets the next available panel from the named list. Always returns at least one entry. Uses data already stored in the asset.");
while (Input.NextPanel("panel_var", displayName: "List Panel"))
{
    Input.ShowTextBox("Name", "name");
    Input.ShowTextBox("Telephone", "telephone");
}
Input.EndControlPanel();


//Horizontal wrap container
Input.StartControlPanel("Horizontal Panel");
//Input.ShowHeader("Input.StartHorizontalWrapContainer()...Input.EndHorizontalWrapContainer().");
Input.ShowMessage("Creates a container that arranges the contained controls horizontally. If the controls can't fit in one row, they wrap to a new row below the first.");
Input.StartHorizontalWrapContainer();
Input.ShowTextBox("First name", "fname");
Input.ShowTextBox("Last name", "lname");
Input.ShowTextBox("Telephone", "telephone");
Input.EndHorizontalWrapContainer();
Input.EndControlPanel();


//Form Fields Tab        
Input.NextTabbedPanel();
Input.ShowMessage("Basic Form Fields");

//Textbox
Input.StartControlPanel("Text Box");
//Input.ShowHeader("Input.ShowTextBox()");
Input.ShowMessage("Adds a textbox control to the input screen. If the Optional: height, is set to a value greater than 0, ShowTextBox will render a multiline textarea.");
Input.ShowTextBox("Text box", "text box");
Input.ShowTextBox("Text box", "text box", height: 10);
Input.EndControlPanel();

//Show checkbox
Input.StartControlPanel("Check Box");
//Input.ShowHeader("Input.ShowCheckBox()");
Input.ShowMessage("Adds a checkbox control to the input screen.");
Input.ShowCheckBox("Check if necessary", "select_check", "1", "Yes");
Input.EndControlPanel();

//Radio button
Input.StartControlPanel("Radio Button");
//Input.ShowHeader("Input.ShowRadioButton()");
Input.ShowMessage("Adds a group of radio buttons to the input screen. If the Optional: defaultValue, is provided the radio button will be initialized to the to the defaultValue. Using the Optional: helpMessage, will render help text.");
Input.ShowRadioButton("Select State", "radio_btn", buttons, helpMessage: "This is help text");
Input.EndControlPanel();

//List
Input.StartControlPanel("List");
//Input.ShowHeader("Input.ShowSelectList()");
Input.ShowMessage("Shows a list selector control, which allows the user to select values from a dictionary.");
Input.ShowSelectList("Select from list", "select_list", buttons);
Input.EndControlPanel();

//Autocomplete
Input.StartControlPanel("Autocomplete");
//Input.ShowHeader("Input.ShowSelectList()");
Input.ShowMessage("Adds an autocompletebox control to the input screen. (Try typing C, M, or N to see some options)");
Input.ShowAutoCompleteBox("Autocomplete", "auto_complete", buttons, 40);
Input.EndControlPanel();

//WCO
Input.StartControlPanel("WCO and WYSIWYG");
//Input.ShowHeader("Input.ShowWcoControls()");
Input.ShowMessage("Adds Wco controls that will bind a field on the asset with a WCO Snippet. Should be paired with an editable text fields of the same name, like a TextBox or Wysiwyg");
//Input.ShowHeader("Input.ShowWysiwyg()");
Input.ShowMessage("Shows the WYSIWYG control.");
Input.ShowWcoControls("content");

//WYSIWYG
WysiwygParams wysiwygParams = ServicesInput.FullWYSIWYG();
wysiwygParams.Stylesheet = "/" + asset.AssetPath[0] + "/Assets/css/wysiwyg.css";
Input.ShowWysiwyg("Content", "content", wysiwygParams, width: 400, height: 10);
Input.EndControlPanel();

//Password
Input.StartControlPanel("Password");
//Input.ShowHeader("Input.ShowPassword()");
Input.ShowMessage("Adds a password textbox control to the input screen. This features is provided as a convenience for developers. CrownPeak will not be responsible for the security of this password. Template developers will be responsible for handling the security of passwords submitted with this type of text box. Passwords can be handled in the post input template. They can be encrypted before storing or used and cleared depending on the usage. If they are not handled in the post_input, they will be stored in clear text in the asset content properties.");
Input.ShowPassword("Password", "password");
Input.EndControlPanel();


//Select Fields
Input.NextTabbedPanel();
Input.ShowMessage("Fields to select other assets or upload content.");

//Select color
Input.StartControlPanel("Color Select");
//Input.ShowHeader("Input.ShowSelectColor()");
Input.ShowMessage("Shows a color selector control.");
Input.ShowSelectColor("Select color", "select_color", defaultColor: "000000");
Input.EndControlPanel();

//Select date
Input.StartControlPanel("Date Select");
//Input.ShowHeader("Input.ShowSelectDate()");
Input.ShowMessage("Shows a date selector control. Dates are stored in the format \"MM/dd/yyyy\".");
Input.ShowSelectDate("Select Date", "select_date");
Input.EndControlPanel();

//Show acquire doc
Input.StartControlPanel("Select Document");
//Input.ShowHeader("Input.ShowAcquireDocument()");
Input.ShowMessage("Displays a \"select\" and \"clear\" button that is used to upload a document into the current template.");
Input.ShowAcquireDocument("Select Document", "select_doc");
Input.EndControlPanel();

//Show acquire image
Input.StartControlPanel("Select Image");
//Input.ShowHeader("Input.ShowAcquireImage()");
Input.ShowMessage("Displays a \"select\" and \"clear\" button that is used to upload an image into the current template.");
Input.ShowAcquireImage("Select Image", "select_image");
Input.EndControlPanel();

//Select Folder
Input.StartControlPanel("Select Folder");
//Input.ShowHeader("Input.ShowSelectFolder()");
Input.ShowMessage("Displays a \"select\" and \"clear\" button that is used to select a folder.");
Input.ShowSelectFolder("Select Folder", "select_folder");
Input.EndControlPanel();

 

//Drop Downs
Input.NextTabbedPanel();

Input.ShowMessage("Dropdown types");
//Drop Down
Input.StartControlPanel("Dropdown");
//Input.ShowHeader("Input.ShowDropDown()");
Input.ShowMessage("Shows a drop down menu selector control.");
Input.ShowDropDown("Select option", "select_dd", "One,Two,Three,Four", "1,2,3,4");
Input.EndControlPanel();

//dropdown container
Input.StartControlPanel("Dropdown Container");
//Input.ShowHeader("Input.StartDropDownContainer()");
Input.ShowMessage("Creates a dropdown that will show the controls associated with the currently selected value, while hiding those that are not. All controls that fall under the StartDropDownContainer will correspond to the first item in the rows dictionary. Supports nesting, so calling StartDropDownContainer within another DropDownConntainer will work as expected.");
String fieldName = "link";
Input.StartDropDownContainer("Links", fieldName + "_type", new Dictionary<string, string> { { "internal", "internal" }, { "external", "external" }, { "title only", "title_only" } }, firstRowLabel: "None");

Input.ShowTextBox("Title", fieldName + "_internal_title", width: 45, helpMessage: "Link Text");

ShowAcquireParams aParams = new ShowAcquireParams();
aParams.ShowUpload = false;
aParams.DefaultFolder = "/" + asset.AssetPath[0];

Input.ShowAcquireDocument("Target", fieldName + "_internal_link", aParams, "<br />Select internal asset.");


Input.NextDropDownContainer();

//external link
Input.ShowTextBox("Title", fieldName + "_external_title", width: 45, helpMessage: "Link Text");
Input.ShowTextBox("URL", fieldName + "_external_link", width: 45, helpMessage: "Enter external URL.");

Input.NextDropDownContainer();

//title only

Input.ShowTextBox("Title", fieldName + "_titleonly_title", width: 45, helpMessage: "Text");

Input.EndDropDownContainer();
//Drop Down
Input.EndControlPanel();


//Display only
Input.NextTabbedPanel();
Input.ShowMessage("For display only");

//Popup message
Input.StartControlPanel("Popup message");
//Input.ShowHeader("Input.ShowLink()");
Input.ShowMessage("The popup help message, to the right of the text box, is available for most Basic and Selector input fields");
Input.ShowTextBox("Text box", "text box", popupMessage: "Popup help message is available for most Basic and Selector input fields");
Input.EndControlPanel();

//Link
Input.StartControlPanel("Link");
//Input.ShowHeader("Input.ShowLink()");
Input.ShowMessage("Creates a link to another asset from the input form");
Input.ShowLink(5884, "Homepage");
Input.EndControlPanel();

//Header
Input.StartControlPanel("Header");
//Input.ShowHeader("//Input.ShowHeader()");
Input.ShowMessage("Adds a section header to the input screen. Useful for highlighting groups of controls.");
//Input.ShowHeader("This is header text");
Input.EndControlPanel();

//Show message
Input.StartControlPanel("Message");
//Input.ShowHeader("Input.ShowMessage()");
Input.ShowMessage("Adds a section message to the input screen. Useful for adding a message to groups of controls.");
Input.ShowMessage("This is a message");
Input.EndControlPanel();

//Control Panel
Input.StartControlPanel("Control Panel.  Click here to open.");
//Input.ShowHeader("Input.StartControlPanel()...Input.EndControlPanel().");
Input.ShowMessage("Creates an control panel. It is used to group a set of controls. You must close the control panel with an EndControlPanel.");
Input.EndControlPanel();

//Expand panel
Input.StartExpandPanel("Expand Panel.  Click here to open.");
//Input.ShowHeader("Input.StartExpandPanel()...Input.EndExpandPanel().");
Input.ShowMessage("Creates an expand panel. The expand panel presents itself as a single gray line that when clicked reveals the set of input controls that it wraps. You must close the expand panel with an EndExpandPanel.");
Input.EndExpandPanel();   


    
Input.EndTabbedPanel();


%>
