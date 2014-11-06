using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facility;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI.Skins;
using Telerik.Web.UI;
using EnergyPlus;
using System.Collections;
using System.Web.Configuration;
using System.IO;

public partial class App_NewUI_User_Controls_EnergyModelingFacilities : System.Web.UI.UserControl
{

    public ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    #region Page Events
    protected void Page_Load(object sender, EventArgs e)
    {
        btn_searchimg.Focus();
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;

                ViewState["SelectedFacilityID"] = null;
                ViewState["PageSize"] = 10;
                ViewState["PageIndex"] = 0;
                ViewState["SortExpression"] = "name";
                BindFacilities();


            }
            else
            {
                ViewState["SelectedFacilityID"] = null;
            }


        }

    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        try
        {
            string str = rg_facility.PagerStyle.PagerTextFormat.ToString();
            rg_facility.PagerStyle.PagerTextFormat = str.Replace("Page", "Go To:");
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion

    #region eventhandler
    protected void rg_facility_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs  e)
    {

        if (e.Item is GridPagerItem)
        {
            string lbl = (e.Item as GridPagerItem).Paging.DataSourceCount.ToString();

            Control txtGotoPage = (e.Item as GridPagerItem).FindControl("txtgotopage");
            TextBox txtRows = txtGotoPage as TextBox;


            TextBox items = new TextBox();
            items.Attributes.Add("ownerTableViewId", rg_facility.MasterTableView.ClientID);


        }
    }
    protected void rg_facility_ItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridPagerItem)

        {
            string lbl = (e.Item as GridPagerItem).Paging.DataSourceCount.ToString();

            Control txtGotoPage = (e.Item as GridPagerItem).FindControl("txtgotopage");
            TextBox txtRows = txtGotoPage as TextBox;
           

            TextBox items =new TextBox();
            items.Attributes.Add("ownerTableViewId",rg_facility.MasterTableView.ClientID);

           
        }
        if (e.Item is GridDataItem)
        {
            GridDataItem grditem = e.Item as GridDataItem;
            string id = Convert.ToString(grditem["pk_facility_id"].Text);
            if (SessionController.Users_.Em_facility_id == id)
            {
                e.Item.Selected = true;
            }
        }
    }
   
    protected void txtgotopage_textChanged(object sender, EventArgs e)
    {
        try
        {
            TextBox txt = (TextBox)rg_facility.MasterTableView.FindControl("txtgotopage");



        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_facility_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            BindFacilities();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_facility_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindFacilities();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_facility_ItemCommand(object source, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "expandcolumn")
            {

            }

            if (e.CommandName == "delete")
            {
                EnergyPlusClient ctrl_ep = new EnergyPlusClient();
                EnergyPlusModel mdl_ep = new EnergyPlusModel();
                mdl_ep.Fk_em_facility_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString());
                ctrl_ep.Delete_EnergyModeling_Facility(mdl_ep, SessionController.ConnectionString);

                //string newfilePath = Server.MapPath(WebConfigurationManager.AppSettings["EnergyPlusFilePath"] + e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_facility_id"].ToString());
                //if (Directory.Exists(newfilePath))
                //{
                //    Array.ForEach(Directory.GetFiles(newfilePath), File.Delete);
                //    Directory.Delete(newfilePath);
                //}

                BindFacilities();
            }
           
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_facility_OnSortCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            BindFacilities();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void OnClick_BtnSearch(object sender, EventArgs e)
    {
       
        BindFacilities();

    }
    protected void btnGoto_Click(object sender, EventArgs e)
    { 
    
    }

    protected void OnClick_lbtn_edit_save(object sender, EventArgs e)
    {

        string str;

    }
    #endregion

    #region private 

    protected void BindFacilities()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();


        DataSet ds = new DataSet();
        try
        {
            string txt_Search = Convert.ToString(txt_search.Text);
            mdl_ep.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
           mdl_ep.Search_text_name = txt_Search;
            mdl_ep.Doc_flag = "floor";
            if (SessionController.Users_.Em_facility_id != null)
                mdl_ep.Fk_facility_id = new Guid(Convert.ToString(SessionController.Users_.Em_facility_id));
            else
                mdl_ep.Fk_facility_id = Guid.Empty;
            mdl_ep.Pk_project_id = new Guid(SessionController.Users_.ProjectId);
            ds = ctrl_ep.GetFacilitiesNewUI(mdl_ep, SessionController.ConnectionString);
            rg_facility.DataSource = ds;
            rg_facility.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion
}