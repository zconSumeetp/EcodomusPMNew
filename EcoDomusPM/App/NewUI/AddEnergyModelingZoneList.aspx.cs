using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EnergyPlus;
using EcoDomus.Session;

public partial class App_NewUI_AddEnergyModelingZoneList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btn_save_Click(object sender, EventArgs e)    
    {
        try
        {
            DataSet ds = new DataSet();
            EnergyPlusModel em = new EnergyPlusModel();
            EnergyPlusClient ec = new EnergyPlusClient();
            em.ZoneListName = txt_zone_list_name.Text;
            em.ZoneListDescription = txt_zone_list_description.Text;
            em.entityname = "ZoneList";
            em.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id);
            em.User_id = new Guid(SessionController.Users_.UserId);
            ds = ec.Insert_Zones_List_Energy_Modeling(em,SessionController.ConnectionString);
            if (ds.Tables[0].Rows[0]["id"].ToString() == "00000000-0000-0000-0000-000000000000")
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "script1", "validate();", true);
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);            
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
}