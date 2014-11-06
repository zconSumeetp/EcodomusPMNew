using System;
using System.Web.UI;
using Attributes;

namespace App.Asset
{
    public partial class Attribute : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var typeId = new Guid(Request.QueryString["entity_id"]);
            
            AttributesControl.EntityType = EntityType.Type;
            AttributesControl.EntityId = typeId;

            var scriptManager = ScriptManager.GetCurrent(Page);
            scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/PropertyValueControl/PropertyValueControl.js") });
            scriptManager.Scripts.Add(new ScriptReference { Path = ResolveUrl("~/App/UserControls/YesNoRadioControl/YesNoRadioControl.js") });
        }

        protected void RadScriptManager1_OnAsyncPostBackError(object sender, AsyncPostBackErrorEventArgs e)
        {
            var asyncPostBackErrorMessage = e.Exception.Message + e.Exception.StackTrace;
            RadScriptManager1.AsyncPostBackErrorMessage = asyncPostBackErrorMessage;
        }
    }
}