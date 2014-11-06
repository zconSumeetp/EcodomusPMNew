using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace App.UserControls.YesNoRadioControl
{
    public partial class YesNoRadioControl : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //ScriptManager.RegisterClientScriptInclude(Page, typeof(Page), "YesNoRadioControl", ResolveClientUrl("YesNoRadioControl.js"));

            //var scriptManager = ScriptManager.GetCurrent(Page);
            //scriptManager.Scripts.Add(new ScriptReference{Path = "YesNoRadioControl.js"});

            const bool needToAddScriptTags = true;
            var clientIdWithoutInvalidCharacters = GetClientIdWithoutInvalidCharacters();

            var radButtonYesOnClientLoadFunctionName = "RadButtonYesOnClientLoad" + clientIdWithoutInvalidCharacters;

            var radButtonYesOnClientLoadFunctionScript =
                "function " + radButtonYesOnClientLoadFunctionName + "(s, e){" +
                    "var yesNoRadioControl = window.$find(\"" + ClientID + "\");" +
                    "yesNoRadioControl.initializeLogic();" +
                "}";

            ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), radButtonYesOnClientLoadFunctionName, radButtonYesOnClientLoadFunctionScript, needToAddScriptTags);

            RadButtonYes.OnClientLoad = radButtonYesOnClientLoadFunctionName;

            var clientId = ClientID;
            RadButtonYes.GroupName = clientId;
            RadButtonNo.GroupName = clientId;
        }

        public string OnClientBlur { get; set; }

        public bool Value
        {
            get { return RadButtonYes.Checked; }
            set
            {
                if (value)
                {
                    RadButtonYes.Checked = true;
                    RadButtonNo.Checked = false;
                }
                else
                {
                    RadButtonYes.Checked = false;
                    RadButtonNo.Checked = true;
                }
            }
        }

        public FontInfo Font
        {
            get { return RadButtonYes.Font; }
            set
            {
                RadButtonYes.Font.CopyFrom(value);
                RadButtonNo.Font.CopyFrom(value);
            }
        }
    }
}