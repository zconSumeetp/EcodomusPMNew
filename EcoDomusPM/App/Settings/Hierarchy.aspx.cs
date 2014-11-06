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

public partial class App_Settings_Hierarchy : System.Web.UI.Page
{
    DataSet ds = new DataSet();
    String s;
    Guid organization_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId!=null)
            {
                if (!IsPostBack)
                {
                   bindLevels();
                }
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }


    /*************** Function to display Levels **************************/
    protected void bindLevels()
    {
        DataSet ds = new DataSet();
        LocationsHierarchyClient lc = new LocationsHierarchyClient();
        ds=lc.GetLevels(SessionController.ConnectionString);
        rg_lh.DataSource = ds;
        rg_lh.DataBind();
     }
 
    /*************** Function to save the hierarchy decided by the client  *****************************************/
    protected void btn_save_Click(object sender, EventArgs  e)
    {
        LocationHierrachyModel lm = new LocationHierrachyModel();
        LocationsHierarchyClient lc = new LocationsHierarchyClient();
        string name = hdf_value.Value;       
        /*******Grid iteration to save the hieararchy****************/
        foreach (GridDataItem item in rg_lh.Items)
        {
            string fk_level_id=item.OwnerTableView.DataKeyValues[item.ItemIndex]["fk_level_id"].ToString();
            string pk_hierarchy_table_id = item.OwnerTableView.DataKeyValues[item.ItemIndex]["pk_hierarchy_table_id"].ToString();
            HiddenField hf_anchor =item.FindControl("rg_lh_hf_anchor") as HiddenField;
            HiddenField hf_anchor_name = item.FindControl("rg_lh_hf_anchor_name") as HiddenField;
            string hierarchy_name = hf_anchor_name.Value;               
            string db_table_name = hf_anchor.Value;
            if (hierarchy_name != "" && db_table_name != "")
            {
                lm.name = hierarchy_name;
                lm.table_name = db_table_name;
                lm.fk_organization_id = SessionController.Users_.OrganizationID;
                lm.fk_level_id = fk_level_id;
                lm.pk_hierarchy_table_id = pk_hierarchy_table_id;
                lc.proc_insert_organization_hierarchy(lm, SessionController.ConnectionString);
            }           
        }
        bindLevels();
    }

    protected override void InitializeCulture()
    {
        string culture = Session["Culture"].ToString();
        if (culture == null)
        {
            culture = "en-US";
        }
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    }

    /**************************Function for sorting for grid*************************************************************/
    protected void rg_lh_sortcommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            bindLevels();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}