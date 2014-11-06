using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using LocationHierarchy;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
public partial class App_Settings_Add_Edit_Custom__data : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if(SessionController.Users_.UserId!=null)
            {
                if (!IsPostBack)
                {
                    bind_custom_data();
                }
            }
        }
       catch(Exception ex)
        {
            throw ex;
        }
    }

    /***************************Function to bind the Grid*****************************************/
    protected void bind_custom_data()
    {
        
        if (Request.QueryString["pk_hierarchy_table_id"] != null)
        {
            hf_pk_hierarchy_table_id.Value = Convert.ToString(Request.QueryString["pk_hierarchy_table_id"]);
        }
        LocationHierrachyModel lm = new LocationHierrachyModel();
        LocationsHierarchyClient lc = new LocationsHierarchyClient();
        DataSet ds = new DataSet();
        lm.pk_hierarchy_table_id = hf_pk_hierarchy_table_id.Value;
        ds = lc.proc_get_custom_hierarchy_data(lm,SessionController.ConnectionString);
        rg_custom_data.DataSource = ds;
        rg_custom_data.DataBind();       
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

    /******************************Function to save the Custom data inserted*************************/
    protected void btn_save_Click(object sender, EventArgs e)
    {
        try
        {
            LocationHierrachyModel lm = new LocationHierrachyModel();
            LocationsHierarchyClient lc = new LocationsHierarchyClient();
            if (Request.QueryString["pk_hierarchy_table_id"]!=null)
            {
                hf_pk_hierarchy_table_id.Value = Convert.ToString(Request.QueryString["pk_hierarchy_table_id"]);
            }
            if (txt_name.Text == "")
            {
                lbl_validate.Visible = true;
            }
            if (txt_longitude.Text == "")
            {
                lbl_validate_lat.Visible = true;
                
            }
            if (txt_latitude.Text == "")
            {
                
                lbl_validate_long.Visible = true;
            }
            else
            {
                string pk_custom_hierarchy_data = hf_pk_custom_hierarchy_data.Value.ToString();
                lm.custom_hierarchy_data_name = txt_name.Text;
                lm.latitude = txt_latitude.Text;
                lm.longitude = txt_longitude.Text;
                lm.pk_custom_hierarchy_data_id = pk_custom_hierarchy_data;
                lm.pk_hierarchy_table_id = hf_pk_hierarchy_table_id.Value.ToString();
                Label1.Text = "";
                if (lc.proc_insert_custom_hierarchy_data(lm, SessionController.ConnectionString).Equals("True"))
                {
                    Label1.Text = "Record already exists";
                }                
                hf_pk_custom_hierarchy_data.Value = "";
                rg_custom_data.Visible = true;
                bind_custom_data();                
                txt_name.Text = "";
                txt_latitude.Text = "";
                txt_longitude.Text = "";
            }//else end
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    /********************************Function for Edit and Delete operations on the grid***************************/
    protected void rg_custom_data_OnItemCommand(object source, GridCommandEventArgs e)
    {
        if (Request.QueryString["pk_hierarchy_table_id"] != null)
        {
            hf_pk_hierarchy_table_id.Value = Convert.ToString(Request.QueryString["pk_hierarchy_table_id"]);
        }
        try
        {
            if (e.Item is GridDataItem)
            {
                if (e.CommandName == "Edit_")
                {
                    LinkButton lnkpk_custom_hierarchy_data = e.Item.FindControl("lnkpk_custom_hierarchy_data_id") as LinkButton;
                    LocationHierrachyModel lm = new LocationHierrachyModel();
                    LocationsHierarchyClient lc = new LocationsHierarchyClient();
                    lm.pk_custom_hierarchy_data_id = lnkpk_custom_hierarchy_data.Text;
                    DataSet ds = new DataSet();
                    ds = lc.proc_get_custom_hierarchy_data_by_id(lm,SessionController.ConnectionString);
                    hf_pk_custom_hierarchy_data.Value = lnkpk_custom_hierarchy_data.Text;
                    txt_name.Text = ds.Tables[0].Rows[0]["custom_hierarchy_data_name"].ToString();
                    txt_latitude.Text = ds.Tables[0].Rows[0]["latitude"].ToString();
                    txt_longitude.Text = ds.Tables[0].Rows[0]["longitude"].ToString();
                }
                else if (e.CommandName == "Delete_")
                {
                    LinkButton lnkpk_custom_hierarchy_data_value_id = e.Item.FindControl("lnkDelete") as LinkButton;
                    LocationHierrachyModel lm = new LocationHierrachyModel();
                    LocationsHierarchyClient lc = new LocationsHierarchyClient();
                    lm.pk_custom_hierarchy_data_id = lnkpk_custom_hierarchy_data_value_id.Text;
                    lc.proc_delete_custom_hierarchy_data(lm, SessionController.ConnectionString);
                    bind_custom_data();                
                }              
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /**********************************Function for Page index changed************************************************/
    protected void rg_custom_data_PageIndexChanged(object source,Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        bind_custom_data();
    }

    /**********************************Function for Page Size Changed*******************************************************/
    protected void rg_custom_data_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        bind_custom_data(); 
    }

    /**********************************Function for Sorting the grid*******************************************************/
    protected void rg_custom_data_onsort(object source,Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        bind_custom_data(); 
    }
}