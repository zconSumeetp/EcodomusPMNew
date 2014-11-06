using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Collections;
using System.Data;
using EcoDomus.Session;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EnergyPlus;
using Login;
using Client;

public partial class App_NewUI_User_Controls_EnergyModelingProjects : System.Web.UI.UserControl
{
    DataSet ds_temp3 = new DataSet();
    public ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    int TotalItemCount;

    #region PageEvents
    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null)
        {

            if (!IsPostBack)
            {
               
                ViewState["SelectedComponentID"] = null;

                ViewState["PageSize"] = 10;
                ViewState["PageIndex"] = 0;
                ViewState["SortExpression"] = "project_name";
                BindProjects();
            }
        }

    }
    #endregion

    #region EventHandlers

    protected void rgProjects_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;

        }
        hfcount.Value = TotalItemCount.ToString();

    }
    protected void rgProjects_OnItemDataBound(object sender, GridItemEventArgs e)
    {

        if (e.Item is GridDataItem)
        {
            GridDataItem grditem = e.Item as GridDataItem;
            if (SessionController.Users_.Profileid == grditem["pk_energymodel_simulation_profile"].Text)
            {
                e.Item.Selected = true;
            }
        }
    }
    protected void rgProjects_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        BindProjects();
    }
    protected void rgProjects_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        BindProjects();
    }
    protected void rgProjects_OnSortCommand(object sender, GridCommandEventArgs e)
    {
        BindProjects();
    }
    protected void rgProjects_ItemCreated(object sender, GridItemEventArgs e)
    {
       // BindProjects();
    }
    protected void btn_searchimg_OnClick(object sender, EventArgs e)
    {
        BindProjects();
    }
    #endregion

    #region Private Methods
    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedComponentID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedComponentID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
     protected void BindProjects()
    {
        EnergyPlusClient ctrl_ep = new EnergyPlusClient();
        EnergyPlusModel mdl_ep = new EnergyPlusModel();
          try
        {
             DataSet ds = new DataSet();
             mdl_ep.Search_text_name = txt_search.Text;
             if (!(string.IsNullOrEmpty(Convert.ToString(SessionController.Users_.Em_facility_id))))
                 mdl_ep.Fk_facility_id = new Guid(SessionController.Users_.Em_facility_id);
             if (SessionController.Users_.Profileid != null)
                 mdl_ep.pk_profileid = new Guid( SessionController.Users_.Profileid);
             else
                 mdl_ep.pk_profileid = Guid.Empty;
                ds = ctrl_ep.GetUserProjects_NewUI(mdl_ep, SessionController.ConnectionString);
             if (ds != null && ds.Tables.Count != 0)
                {
                     rgProjects.DataSource = ds;
                      rgProjects.DataBind();
                 }
                 
           
        }
        catch (Exception ex)
        {
            throw ex;
        }


    }
    #endregion
}