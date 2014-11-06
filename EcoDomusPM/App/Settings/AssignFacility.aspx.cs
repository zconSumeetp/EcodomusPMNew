using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Login;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Facility;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;

public partial class App_Settings_AssignFacility : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {

                if (!IsPostBack)
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "Name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    GetFacilities();
                }
            }
            else
            {
                redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception)
        {
            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
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

    //public void redirect_page(string url)
    //{

    //    Response.Redirect(url, false);

    //}

    protected void GetFacilities()
    {
        FacilityClient facility_crtl = new FacilityClient();
        FacilityModel facility_mdl = new FacilityModel();
        DataSet ds = new DataSet();
        try
        {
            facility_mdl.User_Id =new Guid(Request.QueryString["OrganizationPrimaryuserId"].ToString());
            facility_mdl.Client_id = Guid.Empty;
            facility_mdl.Search_text_name = srch_txt_box.Text.ToString();
            facility_mdl.Role = "OAA";
            ds = facility_crtl.GetUserFacility(facility_mdl, SessionController.ConnectionString.ToString());
            rgFacility.DataSource = ds;
            rgFacility.DataBind();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetFacilities :- " + ex.Message.ToString();
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            GetFacilities();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "btnSearch_Click :- " + ex.Message.ToString();

        }
    }

    void ReBindDataSet()
    {
        DataSet ds = new DataSet();
        ds = (DataSet)ViewState["TempDataset"];
        rgFacility.DataSource = ds;
        rgFacility.DataBind();
    }


    protected void rgFacility_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            GetFacilities();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_PageIndexChanged :- " + ex.Message.ToString();
        }

    }

    protected void rgFacility_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            GetFacilities();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_OnSortCommand :- " + ex.Message.ToString();
        }
    }

    protected void rgFacility_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetFacilities();
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "rgFacility_PageSizeChanged :- " + ex.Message.ToString();
        }
    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }
    protected void btnAssign_Click(object sender, EventArgs e)
    {
        string id = "", name="";
        try
        {
            if (rgFacility.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rgFacility.SelectedItems.Count; i++)
                {
                    id = id + rgFacility.SelectedItems[i].Cells[3].Text + ",";
                    name = name + rgFacility.SelectedItems[i].Cells[4].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Get_Assigned_Facilities('" + id + "','"+name+"')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>validate();</script>", false);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}