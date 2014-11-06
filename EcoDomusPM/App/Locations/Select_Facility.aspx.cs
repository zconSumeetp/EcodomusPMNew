using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Telerik.Web.UI;
using TypeProfile;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Globalization;

public partial class App_Locations_Select_Facility : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rg_facility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    bind_data();
                }
            
            }
        
    }

    public void bind_data()
    {
        DataSet ds_facility = new DataSet();
        //LocationsClient locObj_crtl = new LocationsClient();
        //LocationsModel locObj_mdl = new LocationsModel();
        //locObj_mdl.User_id = new Guid(SessionController.Users_.UserId);
        TypeProfile.TypeProfileClient type_ctrl = new TypeProfile.TypeProfileClient();
        TypeProfile.TypeModel type_mdl = new TypeProfile.TypeModel();
        type_mdl.Organization_Id = new Guid(SessionController.Users_.OrganizationID.ToString());
        type_mdl.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
        type_mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
        type_mdl.System_Role = SessionController.Users_.UserSystemRole.ToString();
        type_mdl.Txt_Search = txtSearch.Text;


        ds_facility = type_ctrl.GetFacilityList(type_mdl, SessionController.ConnectionString);

        if (ds_facility.Tables.Count > 0)
        {
            rg_facility.DataSource = ds_facility;
            rg_facility.DataBind();
        }

        
    }

    protected void btn_select_click(Object sender, EventArgs e)
    {
        string id = "", name = "";
        try
        {
            if (rg_facility.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rg_facility.SelectedItems.Count; i++)
                {
                    id = id + rg_facility.SelectedItems[i].Cells[2].Text + ",";
                    name = name + rg_facility.SelectedItems[i].Cells[4].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_facility('" + id + "','" + name + "')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>alert_msg();</script>", false);
            }
        }

        catch (Exception ex)
        {
            Response.Write("btnSelect_Click:-" + ex.Message);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bind_data();
    }

    protected void rg_facility_sortcommand(object source, GridSortCommandEventArgs e)
    {
        bind_data();
    }
    protected void rg_facility_OnpageIndexChanged(object sender, GridPageChangedEventArgs e)
    {

        try
        {
            bind_data();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_facility_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            bind_data();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected override void InitializeCulture()
    {
        try
        {
            string culture = Session["Culture"].ToString();
            if (culture == null)
            {
                culture = "en-US";
            }
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception ex)
        {

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
}