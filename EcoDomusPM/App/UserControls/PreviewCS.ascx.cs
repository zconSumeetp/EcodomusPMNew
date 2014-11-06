using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class Setup_Sync_PreviewCS : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, System.EventArgs e)
    {
        try
        {
            if (Request.QueryString["pk_external_system_configuration_id"].ToString() != Guid.Empty.ToString())
            {
                imgSycProfile.Visible = true;
                imgFacility.Visible = true;
                imgAssetType.Visible = true;
                imgSpaceType.Visible = true;
                imgMapIntegration.Visible = true;
                imgScheduler.Visible = true;                
            }
        } 
        catch (Exception ex)
        {
            
            throw ex;
        }
    }

    

    
    
}