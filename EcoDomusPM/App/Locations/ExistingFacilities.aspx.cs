using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facility;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;
using Locations;
using System.Threading;
using System.Globalization;

public partial class App_Locations_ExistingFacilities : System.Web.UI.Page
{
    string facility_ids = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rgExistingFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                BindFacilities();
            }
            catch (Exception)
            {

                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }

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

            Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    protected void BindFacilities()
    {
        Facility.FacilityModel fm = new Facility.FacilityModel();
        Facility.FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
            fm.Search_text_name = txt_search.Text;
            ds = fc.GetExistingFacilitiesPM(fm, SessionController.ConnectionString);
            rgExistingFacility.DataSource = ds;
            rgExistingFacility.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rgExistingFacility_OnSortCommand(object sender, GridSortCommandEventArgs e)
    {
        BindFacilities();
    }

    protected void rgExistingFacility_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindFacilities();
    }


    protected void btn_search_click(object sender, EventArgs e)
    {
        BindFacilities();

    }

    protected void btnShowAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (hf_Facility_ids.Value != "")
            {
                facility_ids = hf_Facility_ids.Value;
                facility_ids = facility_ids.Substring(0, facility_ids.Length - 1);
                Facility.FacilityModel fm = new Facility.FacilityModel();
                Facility.FacilityClient fc = new FacilityClient();
                fm.Project_id = new Guid(SessionController.Users_.ProjectId);
                fm.Facility_Ids = facility_ids;
                fc.InsertExisting_FacilitiesPM(fm, SessionController.ConnectionString);
                BindFacilities();
               
                 ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NevigateToFacilityPM();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
         
            
            }
            

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rgExistingFacility_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindFacilities();
    }
}