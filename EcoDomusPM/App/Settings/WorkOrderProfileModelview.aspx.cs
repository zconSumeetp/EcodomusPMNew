using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WorkOrder;
using System.Data;
using System.Data.SqlClient;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;


public partial class App_Settings_WorkOrderProfileModelview : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //CheckBox chk_facility = (CheckBox)Master.FindControl("chkfacility");
        //if (chk_facility.Checked == true)
        //{
        //    hdnfacility.Value = "facilitySelected";
        //}
        //else
        //{
        //    hdnfacility.Value = "nofacilitySelected";
        //}
        if (!IsPostBack)
        {
            if (SessionController.Users_.UserId != null)
            {
                bind_status_dropdown();
                if (Request.QueryString["Work_order_id"] != null)
                {
                    string w_id = Request.QueryString["Work_order_id"].ToString();
                    bind_workorder_profile(w_id);
                }
                else if (Request.QueryString["Work_order_id"] == null)
                {
                    if (Request.QueryString["asset_id"] != null)
                    {
                        WorkOrderModel wm = new WorkOrderModel();
                        WorkOrderClient wc = new WorkOrderClient();
                        DataSet ds = new DataSet();
                        hf_asset_id.Value = Request.QueryString["asset_id"].ToString();
                        wm.Fk_Asset_Id = hf_asset_id.Value;
                        ds = wc.GetAssetName(wm, SessionController.ConnectionString);
                        lbl_asset_name.Text = ds.Tables[0].Rows[0]["name"].ToString();
                    }
                    Guid work_order_id = Guid.Empty;
                    rdpenddate.FocusedDate = DateTime.Now;
                    rdpstartdate.FocusedDate = DateTime.Now;
                }
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    protected void bind_status_dropdown()
    {
        DataSet ds = new DataSet();
        WorkOrderClient wc = new WorkOrderClient();
        try
        {
            ds = wc.GetStatusList(SessionController.ConnectionString);
            cmb_status.DataTextField = "name";
            cmb_status.DataValueField = "pk_status_id";
            cmb_status.DataSource = ds.Tables[0];
            cmb_status.DataBind();
        }
        catch (Exception)
        {
            throw;
        }
    }

    //protected void rg_assign_to_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    //{
    //    try
    //    {
    //        bind_workorder_profile(w_id);
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //protected void rg_assign_to_OnPageSizeChanged(object source,GridPageSizeChangedEventArgs e)
    //{
    //    try
    //    {
    //        bind_workorder_profile(w_id);
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //protected void rg_assign_to_OnSortCommand(object source, GridSortCommandEventArgs e)
    //{
    //    try
    //    {
    //        bind_workorder_profile(w_id);
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    protected void bind_workorder_profile(string work_order_id)
    {

        DataSet ds = new DataSet();
        WorkOrderModel wm = new WorkOrderModel();
        WorkOrderClient wc = new WorkOrderClient();
        wm.PK_Work_Order_Id = new Guid(work_order_id).ToString();

        ds = wc.GetWorkOrder(wm, SessionController.ConnectionString);

        lbl_work_order_number.Text = ds.Tables[0].Rows[0]["work_order_number"].ToString();
        lbl_work_order_number.Visible = true;
        txt_work_order_number.Visible = false;


        lbl_work_order_desc.Text = ds.Tables[0].Rows[0]["work_order_desc"].ToString();
        lbl_work_order_desc.Visible = true;
        txt_work_order_desc.Visible = false;


        lnk_asset.Visible = false;
        lbl_asset_name.Visible = false;
        lbl_req_asset.Visible = false;


        rg_asset.DataSource = ds.Tables[1];
        rg_asset.DataBind();
        rg_asset.Visible = true;

        UCComboAssigned.Visible = false;
        rg_assign_to.DataSource = ds.Tables[2];
        rg_assign_to.DataBind();
        rg_assign_to.Visible = true;


        UCLocation.Visible = false;
        rg_location.DataSource = ds.Tables[3];
        rg_location.DataBind();
        rg_location.Visible = true;

        lbl_start_date_selected.Text = ds.Tables[0].Rows[0]["startdate"].ToString();
        lbl_start_date_selected.Visible = true;
        rdpstartdate.Visible = false;

        lbl_end_date_selected.Text = ds.Tables[0].Rows[0]["enddate"].ToString();
        lbl_end_date_selected.Visible = true;
        rdpenddate.Visible = false;

        try
        
        {

            if (ds.Tables[4].Rows[0]["name"] != null)
            {
                lbl_status_selected.Text = ds.Tables[4].Rows[0]["name"].ToString();
            }
            else
            {

                lbl_status_selected.Text = "n/a";
            }
        
        }

        catch (Exception ex)
        {
            lbl_status_selected.Text = "n/a";
        
        }
        
        lbl_status_selected.Visible = true;
        cmb_status.Visible = false;
      
        btn_save.Text = "Edit";
        btn_delete.Visible = true;

        hf_pk_work_order_id.Value = wm.PK_Work_Order_Id;
        hf_asset_id.Value = ds.Tables[1].Rows[0]["pk_asset_id"].ToString();
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();
        WorkOrderModel wm = new WorkOrderModel();
        WorkOrderClient wc = new WorkOrderClient();
        RadTreeView rtvLocation = (RadTreeView)UCLocation.FindControl("rtvLocationSpaces");//For Locations

        string location_id = "";
        if (rtvLocation != null)
        {
            System.Collections.Generic.IList<RadTreeNode> locationCollection = rtvLocation.CheckedNodes;

            foreach (RadTreeNode location in locationCollection)
            {
                if (location.ParentNode != null)
                {
                    if (location.ParentNode.Value != Guid.Empty.ToString() && location.Value != Guid.Empty.ToString())
                    {
                        location_id = location_id + location.Value.ToString() + ",";
                    }
                }
            }
            if (location_id.Length > 0)
                location_id = location_id.Substring(0, location_id.Length - 1);//For removing comma at the end           
        }

        RadTreeView rtvAssignTo = (RadTreeView)UCComboAssigned.FindControl("rtvOrganizationUsers");//For Users
        string user_id = "";
        if (rtvAssignTo != null)
        {
            System.Collections.Generic.IList<RadTreeNode> userCollection = rtvAssignTo.CheckedNodes;
            foreach (RadTreeNode user in userCollection)
            {
                if (user.ParentNode.Value != Guid.Empty.ToString())
                    user_id = user_id + user.Value.ToString() + ",";
            }
            if (user_id.Length > 0)
                user_id = user_id.Substring(0, user_id.Length - 1);

        }
        if (btn_save.Text == "Save")
        {
            try
            {
                if (hf_asset_id.Value != "" && location_id != "")
                {
                    if (hf_pk_work_order_id.Value != "")
                    {
                        wm.PK_Work_Order_Id = new Guid(hf_pk_work_order_id.Value).ToString();
                    }
                    else
                    {
                        wm.PK_Work_Order_Id = Guid.Empty.ToString();
                    }
                    wm.Fk_Asset_Id = hf_asset_id.Value;
                    wm.Fk_Location_Id = location_id;
                    wm.Fk_User_Id = user_id;
                    wm.Work_Order_No = txt_work_order_number.Text;
                    wm.Work_Order_Desc = txt_work_order_desc.Text;
                    wm.Fk_Status_Id = new Guid(cmb_status.SelectedValue).ToString();
                    wm.User = new Guid(SessionController.Users_.UserId).ToString();
                    if (rdpstartdate.SelectedDate == null)
                    {
                        //wm.StartDate = "";
                        rdpstartdate.FocusedDate = DateTime.Now;
                        wm.StartDate = DateTime.Now.ToString();
                    }
                    else
                    {
                        wm.StartDate = (string)rdpstartdate.SelectedDate.Value.ToShortDateString();
                    }
                    if (rdpenddate.SelectedDate == null)
                    {

                        rdpenddate.FocusedDate = DateTime.Now;
                        wm.EndDate = DateTime.Now.ToString();
                        //wm.EndDate = "";
                    }
                    else
                    {
                        wm.EndDate = rdpenddate.SelectedDate.Value.ToShortDateString();
                    }

                    ds = wc.InsertWorkOrder(wm, SessionController.ConnectionString);
                    string pk_work_order_id = ds.Tables[0].Rows[0]["work_order_id"].ToString();
                    hf_pk_work_order_id.Value = pk_work_order_id;
                    bind_workorder_profile(hf_pk_work_order_id.Value);
                }
                else
                {
                    if (hf_asset_id.Value == "")
                    {
                        lbl_req_asset.Visible = true;
                    }
                    else
                    {
                        //   wm.Fk_Asset_Id = hf_asset_id.Value; 
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "myscript", "validate();", true);
                        lbl_asset_name.Text = hdnasset_name.Value;
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        else if (btn_save.Text == "Edit")
        {
            try
            {
                wm.PK_Work_Order_Id = hf_pk_work_order_id.Value;
                ds = wc.GetWorkOrder(wm, SessionController.ConnectionString);

                txt_work_order_number.Text = ds.Tables[0].Rows[0]["work_order_number"].ToString();
                lbl_work_order_number.Visible = false;
                txt_work_order_number.Visible = true;


                txt_work_order_desc.Text = ds.Tables[0].Rows[0]["work_order_desc"].ToString();
                lbl_work_order_desc.Visible = false;
                txt_work_order_desc.Visible = true;

                rg_asset.Visible = false;
                rg_assign_to.Visible = false;
                rg_location.Visible = false;

                lnk_asset.Visible = true;
                lbl_asset_name.Visible = true;
                lbl_asset_name.Text = ds.Tables[1].Rows[0]["asset_name"].ToString();


                /*********************************For tree of user and location******************************* **************/
                DataSet ds1 = new DataSet();
                ds1 = wc.GetWorkOrder_User(wm, SessionController.ConnectionString);
                RadTreeView rtvassignto = (RadTreeView)UCComboAssigned.FindControl("rtvOrganizationUsers");
                rtvassignto.ExpandAllNodes();
                //rtvassignto.CollapseAllNodes();                    
                if (rtvassignto != null)
                {
                    System.Collections.Generic.IList<RadTreeNode> nodes = rtvassignto.GetAllNodes();
                    foreach (RadTreeNode node in nodes)
                    {
                        for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                        {
                            if (node.Value.ToUpper() == ds1.Tables[0].Rows[i]["fk_user_id"].ToString().ToUpper())
                            {
                                node.Checked = true;
                            }
                        }
                    }
                }
                /******************************Location***************************************/
                DataSet ds2 = new DataSet();
                ds2 = wc.GetWorkOrder_Location(wm, SessionController.ConnectionString);
                RadTreeView rtvlocationto = (RadTreeView)UCLocation.FindControl("rtvLocationSpaces");
                rtvlocationto.ExpandAllNodes();
                //rtvLocation.CollapseAllNodes();
                if (rtvlocationto != null)
                {
                    System.Collections.Generic.IList<RadTreeNode> nodes = rtvlocationto.GetAllNodes();
                    foreach (RadTreeNode node in nodes)
                    {
                        for (int i = 0; i < ds2.Tables[0].Rows.Count; i++)
                        {
                            if (node.Value.ToUpper() == ds2.Tables[0].Rows[i]["pk_location_id"].ToString().ToUpper())
                            {
                                node.Checked = true;
                            }
                        }
                    }
                }
                UCComboAssigned.Visible = true;
                UCLocation.Visible = true;
                /***********************************End**************************************************************************/
                rdpstartdate.Visible = true;

                rdpstartdate.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["startdate"].ToString());

                lbl_start_date_selected.Visible = false;


                rdpenddate.Visible = true;
                rdpenddate.SelectedDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["enddate"].ToString());
                lbl_end_date_selected.Visible = false;

                cmb_status.Visible = true;

                try 
                { 
                    cmb_status.SelectedValue = ds.Tables[4].Rows[0]["pk_status_id"].ToString();
                }
                catch (Exception ex)
                {

                    cmb_status.SelectedItem.Text = "Open";
                }
               

                lbl_status_selected.Visible = false;
                btn_save.Text = "Save";
                btn_delete.Visible = false;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            WorkOrderModel wm = new WorkOrderModel();
            WorkOrderClient wc = new WorkOrderClient();
            wm.PK_Work_Order_Id = hf_pk_work_order_id.Value;
            wc.DeleteWorkOrder(wm, SessionController.ConnectionString);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "close", "closewindow();", true);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }



    protected void rg_asset_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Guid asset_id;
        try
        {
            if (e.CommandName == "Edit_")
            {
                LinkButton lnk_work_order_name = e.Item.FindControl("lnk_asset_button") as LinkButton;
                asset_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_asset_id"].ToString());
                Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + asset_id + "&pageValue=AssetProfile", false);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rg_location_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        Guid location_id;
        Guid facility_id;
        try
        {
            if (e.CommandName == "Edit_Space")
            {
                LinkButton lnk_space_button = e.Item.FindControl("lnk_space_button") as LinkButton;
                location_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_location_id"].ToString());
                Response.Redirect("~/App/Locations/FacilityMenu.aspx?&pageValue=Space Profile" + "&id=" + location_id, false);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void navigate(object sender, EventArgs e)
    {
        SessionController.Users_.facilityID = hf_facility_id.Value.ToString();
        Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + SessionController.Users_.facilityID, false);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/Asset/WorkOrder.aspx", false);
    }
}
