using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using BIMModel;
using System.Globalization;
using System.Collections;
using System.Threading;
using EcoDomus.Session;

public partial class App_Settings_FacilityTypes : System.Web.UI.Page
{

    public System.Collections.ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
   
    #region Page events

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindTypes();
        }

    }

    #endregion


    #region Private Methods

    private void BindTypes()
    {
        DataSet ds = new DataSet();
        BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
        BIMModels BIMModels = new BIMModel.BIMModels();
        DataSet ds_ComponentCount = new DataSet();
        BIMModels.Fk_facility_id = new Guid(Request.QueryString["facility_id"]);
        BIMModels.Search_text = txtClass.Text.Trim().ToString();
        ds = BIMModelClient.proc_get_facility_types_for_bim(BIMModels, SessionController.ConnectionString);
        rg_type.DataSource = ds;
        rg_type.DataBind();

        
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

    public void BindComponent_view_state()
    {
       
    }



    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();


            foreach (GridDataItem item in rg_type.Items)
            {
                string strIndex = rg_type.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("Assetid").ToString();
                string comp_id = item["pk_type_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Add(comp_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(comp_id.ToString()))
                    {
                        arrayList.Remove(comp_id.ToString());
                    }
                }
            }

            ViewState["SelectedassetID"] = arrayList;
            ArrayList comp_list = (ArrayList)ViewState["SelectedassetID"];
            string id = "";
            if (comp_list.Count > 0)
            {
                for (int i = 0; i < comp_list.Count; i++)
                {
                    id = id + comp_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                hf_asset_id.Value = id;

            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rg_type.Items)
            {
                string systems_id = Convert.ToString(item.GetDataKeyValue("pk_type_id"));//item["Assetid"].Text;

                if (arrayList.Contains(systems_id.ToString()))
                {
                    item.Selected = true;

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedassetID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedassetID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    #endregion


    #region Grid Events



    protected void rg_component_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindTypes();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_component_SortCommand(object source, GridSortCommandEventArgs e)
    {
        GetSelectedRows();
        BindTypes();
    }

    protected void rg_component_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            BindTypes();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
  

    protected void rgassets_OnItemEvent(object sender, GridItemEventArgs e)
    {


    }

    protected void rgassetd_OnItemDataBound(object sender, GridItemEventArgs e)
    {

        try
        {

            ReSelectedRows();

        }
        catch (Exception ex)
        {
            throw ex;
        }


    }



    #endregion


    #region Event Handlers


    protected void btnSelect_Click(Object sender, EventArgs e)
    {      
        try
        {
            if (rg_type.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                         
               BIMModelClient BIMModelClient = new BIMModelClient();
               BIMModels BIMModels = new BIMModels();
               BIMModels.Attribute_name = Request.QueryString["attribute_name"];
               BIMModels.Attribute_value = Request.QueryString["attribute_value"];
               BIMModels.Pk_attribute_id = Guid.Empty; //new Guid(Request.QueryString["attribute_id"]);
               BIMModels.Fk_row_id = Guid.Empty;
               BIMModels.Table_name = Request.QueryString["table_name"];
               BIMModels.Fk_type_id = new Guid(rg_type.SelectedValue.ToString());
               BIMModels.User_id = new Guid(SessionController.Users_.UserId);
               BIMModels.File_id = new Guid(Request.QueryString["file_id"]);
               BIMModels.Fk_uom_id = Guid.Empty;
               BIMModels.Model_id = Request.QueryString["element_numeric_id"];
               BIMModelClient.InsertUpdateAssetAttributeForModelViewer(BIMModels, SessionController.ConnectionString);
               ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>sendTypeId()</script>");
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindTypes();
    }


   
    #endregion
}