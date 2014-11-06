using System;
using System.Collections.Generic;
using System.Linq; 
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Facility;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;
using Asset;

public partial class App_Asset_Assign_Document : System.Web.UI.Page
{
    string flag = "";
    string tempPageSize = "";
    bool flagCheck = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            hfEntity.Value = Request.QueryString["name"].ToString();
            hfAsset_id.Value = Request.QueryString["id"].ToString();
            if (!IsPostBack)
            {
                //DataSet ds = new DataSet();
                //FacilityModel fm = new FacilityModel();
                //FacilityClient fc = new FacilityClient();
                //fm.Facility_id = new Guid(hfAsset_id.Value);
                //fm.Doc_flag = hfEntity.Value;
                //ds = fc.Get_Entity_Name_Document(fm, SessionController.ConnectionString);
                //lbl_entity_name.Text = hfEntity.Value.ToString() +" "+"Name:";
                //lbl_entity_value.Text = ds.Tables[0].Rows[0]["name"].ToString();

                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "document_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rg_document.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                hfAttributePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 2);
                tempPageSize = hfAttributePMPageSize.Value;
                bind_document();
            }
        }
        else
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        
        }
    }

    protected void bind_document()
    {
        DataSet ds = new DataSet();
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        AssetModel Asset_Model = new AssetModel();
        AssetClient Asset_Client = new AssetClient();
        DataSet ds_asset_document = new DataSet();
        try
        {
            if (flagCheck)
            {
                rg_document.AllowCustomPaging = true;
                if (tempPageSize != "")
                    rg_document.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
                rg_document.VirtualItemCount = Int32.Parse((ds_asset_document.Tables[0].Rows.Count.ToString()));
            }
                    
           
            if (hfEntity.Value == "Asset")
                {
                Asset_Model.Asset_id = new Guid(hfAsset_id.Value);
                ds_asset_document = Asset_Client.GetDocumetsForComponent(SessionController.ConnectionString, Asset_Model);
                rg_document.DataSource = ds_asset_document;
                rg_document.DataBind();
                rg_document.Visible = true;
                }
            else
                {
                fm.Fk_row_id = new Guid(hfAsset_id.Value);
                ds = fc.GetEntityDocuments(fm, SessionController.ConnectionString);
                rg_document.DataSource = ds;
                rg_document.DataBind();
                rg_document.Visible = true;
                }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btn_Search(object sender,EventArgs e)
    {
        DataSet ds = new DataSet();
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        try
        {
            fm.Facility_id = new Guid(hfAsset_id.Value);
            fm.Search_text_name = txt_search.Text;
            ds = fc.Search_Documents_Entity(fm, SessionController.ConnectionString);            
            rg_document.DataSource = ds;
            rg_document.DataBind();
            rg_document.Visible = true;
            //txt_search.Text = "";

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void rg_document_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            Guid document_id = Guid.Empty;
            if (e.CommandName == "Delete_")
            {
                document_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["document_id"].ToString());                               

                FacilityClient facObjClientCtrl = new FacilityClient();
                FacilityModel facObjFacilityModel = new FacilityModel();
                //facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                facObjFacilityModel.Document_Id = document_id;
                facObjClientCtrl.Delete_Document(facObjFacilityModel, SessionController.ConnectionString);
                bind_document();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_refresh_Click(object sender,EventArgs  e)
    {
       bind_document();
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

            //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void rg_document_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            bind_document();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_document_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)   
    {
        try
        {
            bind_document();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rg_document_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        try
        {
            bind_document();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_document_OnPreRender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                foreach (GridItem item in rg_document.MasterTableView.Items)
                {

                    ImageButton btn = item.FindControl("imgbtnDelete") as ImageButton;
                    btn.Visible = false;
                    ImageButton btn1 = item.FindControl("imgbtnEdit") as ImageButton;
                    if (btn1 != null)
                    {
                        btn1.Enabled = false;
                    }

                }
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void Page_Prerender(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {

                btn_document.Visible = false;
            }
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    SetPermissions();
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    private void SetPermissions()
    {
        try
        {
            if (Request.QueryString["name"].ToString() == "Asset")
            {
                DataSet ds_component = SessionController.Users_.Permission_ds;
                DataRow dr_component = ds_component.Tables[0].Select("name='Component'")[0];
                DataRow[] dr_submenu_component = ds_component.Tables[0].Select("fk_parent_control_id='" + dr_component["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_component)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                    if (dr_profile["name"].ToString() == "Facility")
                    {
                        SetPermissionToControl(dr_profile);

                    }
                }
            }
            else if (Request.QueryString["name"].ToString() == "Type")
            {

                DataSet ds_type = SessionController.Users_.Permission_ds;
                DataRow dr_type = ds_type.Tables[0].Select("name='Type'")[0];
                DataRow[] dr_submenu_type = ds_type.Tables[0].Select("fk_parent_control_id='" + dr_type["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_type)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                }
            }
            else if (Request.QueryString["name"].ToString() == "Space")
            {
                DataSet ds_Space = SessionController.Users_.Permission_ds;
                DataRow dr_Space = ds_Space.Tables[0].Select("name='Space'")[0];
                DataRow[] dr_submenu_Space = ds_Space.Tables[0].Select("fk_parent_control_id='" + dr_Space["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_Space)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                }
            }
            else if (Request.QueryString["name"].ToString() == "System")
            {
                DataSet ds_System = SessionController.Users_.Permission_ds;
                DataRow dr_System = ds_System.Tables[0].Select("name='System'")[0];
                DataRow[] dr_submenu_System = ds_System.Tables[0].Select("fk_parent_control_id='" + dr_System["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_System)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                }
            }
            else if (Request.QueryString["name"].ToString() == "Floor")
            {
                DataSet ds_Floor = SessionController.Users_.Permission_ds;
                DataRow dr_Floor = ds_Floor.Tables[0].Select("name='Floor'")[0];
                DataRow[] dr_submenu_Floor = ds_Floor.Tables[0].Select("fk_parent_control_id='" + dr_Floor["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_Floor)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                }
            }
            else if (Request.QueryString["name"].ToString() == "Zone")
            {
                DataSet ds_Zone = SessionController.Users_.Permission_ds;
                DataRow dr_Zone = ds_Zone.Tables[0].Select("name='Zone'")[0];
                DataRow[] dr_submenu_Zone = ds_Zone.Tables[0].Select("fk_parent_control_id='" + dr_Zone["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_Zone)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                }
            }
            else if (Request.QueryString["name"].ToString() == "Facility")
            {
                DataSet ds_Facility = SessionController.Users_.Permission_ds;
                DataRow dr_Facility = ds_Facility.Tables[0].Select("name='Facility'")[0];
                DataRow[] dr_submenu_Facility = ds_Facility.Tables[0].Select("fk_parent_control_id='" + dr_Facility["pk_project_role_controls"] + "'");
                foreach (DataRow dr_profile in dr_submenu_Facility)
                {
                    if (dr_profile["name"].ToString() == "Documents")
                    {
                        SetPermissionToControl(dr_profile);

                    }

                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        //string add_permission = dr["add_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        // Add permission
        //if (dr["Control_id"].ToString() == "btn_document")
        //{
        //    objPermission.SetEditable(btn_document, add_permission);
        //}

        // edit permission
        if (edit_permission == "N")
        {
            btn_document.Enabled = false;
            foreach (GridDataItem item in rg_document.MasterTableView.Items)
            {
                ImageButton imgbtnEdit = (ImageButton)item.FindControl("imgbtnEdit");
                imgbtnEdit.Enabled = false;

            }

        }
        else
        {
            btn_document.Enabled = true;
            foreach (GridDataItem item in rg_document.MasterTableView.Items)
            {
                ImageButton imgbtnEdit = (ImageButton)item.FindControl("imgbtnEdit");
                imgbtnEdit.Enabled = true;

            }
        }

        //delete permission
        if (delete_permission == "N")
        {
            foreach (GridDataItem item in rg_document.MasterTableView.Items)
            {
                ImageButton imgbtnDelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtnDelete.Enabled = false;
            }

        }
        else
        {
            foreach (GridDataItem item in rg_document.MasterTableView.Items)
            {
                ImageButton imgbtndelete = (ImageButton)item.FindControl("imgbtnDelete");
                imgbtndelete.Enabled = true;

            }
        }

    }




}