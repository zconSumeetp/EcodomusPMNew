using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LocationHierarchy;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_Add_Custom_Hierarchy_data : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           if (SessionController.Users_.UserId != null)
            {
                bindpage();
            }
        }
     }

    /***************************Function to bind the entire page with the value selected on the parent page****************************************************/
    protected void bindpage()
    {       
        string hidval = string.Empty;
        string isCustome = string.Empty;
        string CustomValue = string.Empty;
        try
           {
                if (!IsPostBack)
                {
                    bindddlHieracrchy();
                }
                if (Request.QueryString["LinkButtonText"] != null)
                {
                    hf_selected_crtl_id.Value = Convert.ToString(Request.QueryString["LinkButtonText"]);//control id        
                    hf_hyp_id.Value = Convert.ToString(Request.QueryString["LinkButtonText"]);
                }
                if (Request.QueryString["HiddenFieldValue"] != null)
                {
                    hidval = Convert.ToString(Request.QueryString["HiddenFieldValue"]);

                    if (hidval != "NA")
                    {
                        ddl.SelectedValue = hidval;
                    }

                    if (Request.QueryString["HiddenFieldCustValue"] != null)
                    {
                        isCustome = Convert.ToString(Request.QueryString["HiddenFieldCustValue"]);
                    }

                    if (Request.QueryString["LinkButtonValue"] != null)
                    {
                        CustomValue = Convert.ToString(Request.QueryString["LinkButtonValue"]);
                    }

                    if (isCustome == "Y")
                    {
                        trCustom.Visible = true;                                             
                        txt_name.Text = CustomValue;
                        
                    }
                    else
                    {
                        trCustom.Visible = false;                                            
                        txt_name.Text = "";
                    }
                }
                if (Request.QueryString["HiddenFieldId"] != null)
                {
                    hf_id.Value = Convert.ToString(Request.QueryString["HiddenFieldId"]);
                    hf_hid_id.Value = Convert.ToString(Request.QueryString["HiddenFieldId"]);
                }

                if (Request.QueryString["HiddenFieldCustId"] != null)
                {

                    hf_Cust_id.Value = Convert.ToString(Request.QueryString["HiddenFieldCustId"]);
                }

                if (Request.QueryString["hfnid"] != null)
                {
                    hf_name.Value = Convert.ToString(Request.QueryString["hfnid"]);
                }
            }
            catch (Exception)
            {                            
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

    /*************************Function to bind the DropDowns**********************************************/
    protected void bindddlHieracrchy()
    {
        LocationsHierarchyClient lc = new LocationsHierarchyClient();
        DataSet ds = new DataSet();
        try
        {
                ddl.DataTextField = "hierarchy_name";
                ddl.DataValueField = "db_table_name";
                ds = lc.GetHierarchyData(SessionController.ConnectionString);
                ddl.DataSource = ds.Tables[0];
                ddl.DataBind();
        }
        catch (Exception)
        {
            
            throw;
        }
    }
    /**************************Function to get the  Dropdown value selected *******************************/
    protected void ddl_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList rc = new DropDownList();
        rc = (DropDownList)sender;
        try
        {
            if (rc.SelectedItem.Text == "Custom" )
            {
                trCustom.Visible = true;
             }
            else
            {
                trCustom.Visible = false;                
            }
            hf_selected_value.Value = rc.SelectedItem.Text;
            hf_no.Value = Convert.ToString(rc.SelectedItem.Value);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}