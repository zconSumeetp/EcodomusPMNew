using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EnergyPlus;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Session;

public partial class App_NewUI_UtilityRateSchedules : System.Web.UI.UserControl
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


    private void BindBilling_Statements()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();

        DataSet ds = new DataSet();
        CryptoHelper crypt = new CryptoHelper();
        try
        {
            mdl_ep.Search_text_name = rtxtsearch.Text;
            ds = ctrl_ep.Get_Billing_Statements(mdl_ep, SessionController.ConnectionString);
            ds.Tables[0].Reset();
            rg_Rates.DataSource = ds;
            rg_Rates.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

