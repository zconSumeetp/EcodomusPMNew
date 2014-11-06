using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EnergyPlus;
using System.Data;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;
using Telerik.Web.UI;

public partial class App_NewUI_AddUtilityData : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            
            if (!IsPostBack)
            {

                BindBilling_Statements();
            }
        }
    }
    public void btn_searchimg_OnClick(object sender, ImageClickEventArgs e)
    {
        BindBilling_Statements();

    }
    protected void rgStatements_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindBilling_Statements();
    }
    protected void rgStatements_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindBilling_Statements();
    }
    protected void rgStatements_OnSortCommand(object sender, GridCommandEventArgs e)
    {
        BindBilling_Statements();
    }
    private void BindBilling_Statements()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();

        DataSet ds = new DataSet();
        CryptoHelper crypt = new CryptoHelper();
        try
        {

            mdl_ep.Search_text_name = txt_search.Text;
            ds = ctrl_ep.Get_Billing_Statements(mdl_ep, SessionController.ConnectionString);
            rgStatements.DataSource = ds;
            rgStatements.DataBind();
            //ds.Tables[0].Reset();
           
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}