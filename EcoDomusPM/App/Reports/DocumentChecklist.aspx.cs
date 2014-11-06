using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using AttributeTemplate; 
using EcoDomus.Session;
using Facility;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Reports_DocumentChecklist : System.Web.UI.Page
{
    Guid omniclass_ID = new Guid();
    Guid project_id = new Guid();
    Guid entity_id = new Guid();
    Guid facility_id = new Guid();
    Guid Entity_detail_id = new Guid();
    Guid doc_type_id = new Guid();
    string flag_sheet_name;
    string tempPageSize = "";
    bool flag = false;
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
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {

                    project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                    if (!IsPostBack)
                    {
                        this.txtSearch.Focus();
                        bindentity();
                        bindfacility();
                        hfUserPMPageSize.Value = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids));
                        tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                        tempPageSize = Convert.ToString(Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids));

                        BindOmniclassNames();
                        rdBtnOmniClass.Visible = false;
                        rdBtnOmniClass2.Visible = false;
                    }
                }
            }
            else
            {
                redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception ex)
        {
            throw ex;
            //lblMsg.Text = "Page_Load:" + ex.ToString();
        }

    }

    protected void bindentity()
    {
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        DataSet ds = new DataSet();
        try
        {
            am.Flag = "template";
            ds = ac.BindEntity(am, SessionController.ConnectionString);
            cmb_entity.DataTextField = "entity_name";
            cmb_entity.DataValueField = "pk_entity_id";
            cmb_entity.DataSource = ds;
            cmb_entity.DataBind();
            
            
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void BindOmniclassNames()
    {
        try
        {

      
        AttributeTemplateModel am = new AttributeTemplateModel();
        AttributeTemplateClient ac = new AttributeTemplateClient();
        
        DataSet ds = new DataSet();
        am.ProjectId = project_id;
        am.Facility_Id = new Guid(cmb_facility.SelectedValue);
        am.Txt_search = txtSearch.Text;
        am.Entity_id = new Guid(cmb_entity.SelectedValue);
        if (rdBtnOmniClass.Checked)
        {
            am.Omniclassversion = "OmniClass 2010";
        }
        else if (rdBtnOmniClass2.Checked)
        {
            am.Omniclassversion = "OmniClass 2006";
        }
        ds = ac.Get_omniclass_names_for_document_checklist(am,SessionController.ConnectionString);
        if (ds.Tables[1].Rows.Count > 0)
        {
            if (ds.Tables[1].Rows[0][0].ToString() == "" || ds.Tables[1].Rows[0][0] == null  )
            {
                if (cmb_facility.SelectedValue.ToString() != "00000000-0000-0000-0000-000000000000")
                {
                    SessionController.Users_.facilityID = cmb_facility.SelectedValue.ToString();
                    SessionController.Users_.facilityName = cmb_facility.SelectedItem.Text;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "validate('" + cmb_facility.SelectedItem.Value + "','" + cmb_facility.SelectedItem.Text + "');", true);
                }
            }
        }
        rg_document_checklist.DataSource = ds;
        rg_document_checklist.AllowCustomPaging = true;
        if (tempPageSize != "")
            rg_document_checklist.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
        rg_document_checklist.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));
        rg_document_checklist.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void cmb_entity_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindOmniclassNames(); 
    }
    protected void cmb_facility_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "validate('" + cmb_facility.SelectedItem.Value + "','" + cmb_facility.SelectedItem.Text + "');", true);
        BindOmniclassNames(); 
    }
    protected void rdBtnOmniClass2_CheckedChanged(object sender, EventArgs e)
    {
        BindOmniclassNames(); 
    }

    protected void rdBtnOmniClass_CheckedChanged(object sender, EventArgs e)
    {
        BindOmniclassNames(); 
    }
    protected void rg_document_checklist_OnItemCommand(object source, GridCommandEventArgs e)
    {
        if (e.CommandName == "refresh")
        {
            e.Item.Expanded = !e.Item.Expanded;
            e.Item.Expanded = !e.Item.Expanded;

        }
       
        //if (e.Item.OwnerTableView.Name.Equals("omniclass_name"))
        //{
        //    omniclass_ID = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["omniclass_detail_id"].ToString());
        //}
        if (e.Item.OwnerTableView.Name.Equals("doc_type_grid"))
        {
            Guid omniclassid = new Guid(ViewState["omniclass_id"].ToString());
            doc_type_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_type_id"].ToString());
        
           //int intMyID = Convert.ToInt32(RadGrid1.MasterTableView.Items[intItemIndex].GetDataKeyValue("ItemID").ToString());


            string strTypeName;
            if ((e.Item is Telerik.Web.UI.GridDataItem))
            {
                if (cmb_entity.Text == "Component")
                {
                    flag_sheet_name = "c";
                }
                if (cmb_entity.Text == "Space")
                {
                    flag_sheet_name = "S";
                }
                if (cmb_entity.Text == "Type")
                {
                    flag_sheet_name = "T";
                }
                if (cmb_entity.Text == "Facility")
                {
                    flag_sheet_name = "F";
                }
                if (cmb_entity.Text == "System")
                {
                    flag_sheet_name = "Sys";
                }
                Entity_detail_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["Id"].ToString());
                entity_id = new Guid(cmb_entity.SelectedValue);
                facility_id = new Guid(cmb_facility.SelectedValue);
                //Label lblTypeName = (System.Web.UI.WebControls.Label)e.Item.FindControl("lblGrdTypeName");
                System.Web.UI.WebControls.Label lblTypeName = (System.Web.UI.WebControls.Label)e.Item.FindControl("lblGrdTypeName");
                strTypeName = lblTypeName.Text.ToString();

 
                //if (strTypeName == "Closeout Submittals")
                 //{
                //    call_java_script_popup(entity_id, "closeout_submittal", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Request for Information")
                //{
                //    call_java_script_popup(entity_id, "Request_for_Information", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Contract Specifications")
                //{
                //    call_java_script_popup(entity_id, "Contract_Specifications", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Client Requirements")
                //{
                //    call_java_script_popup(entity_id, "Client_Requirements", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                 
                //}
                //if (strTypeName == "Manufacturer Instructions")
                //{
                //    call_java_script_popup(entity_id, "Manufacturer_Instructions", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Contract Modifications")
                //{
                //    call_java_script_popup(entity_id, "Contract_Modifications", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Test Reports")
                //{
                //    call_java_script_popup(entity_id, "Test_Reports", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Samples")
                //{
                //    call_java_script_popup(entity_id, "sample", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Design Data")
                //{
                //    call_java_script_popup(entity_id, "Design_Data", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Preconstruction Submittals")
                //{
                //    call_java_script_popup(entity_id, "Preconstruction_Submittals", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Specifications")
                //{
                //    call_java_script_popup(entity_id, "s", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Design Review Comment")
                //{
                //    call_java_script_popup(entity_id, "Design_Review_Comment", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Manufacturer Field Reports")
                //{
                //    call_java_script_popup(entity_id, "Manufacturer_Field_Reports", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Product Data")
                //{
                //    call_java_script_popup(entity_id, "Product_Data", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Certificates")
                //{
                //    call_java_script_popup(entity_id, "Certificates", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);


                //}
                //if (strTypeName == "Operation and Maintenance")
                //{
                //    call_java_script_popup(entity_id, "om", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Warranty Documents")
                //{
                //    call_java_script_popup(entity_id, "w", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Punch List Items")
                //{
                //    call_java_script_popup(entity_id, "Punch_List_Items", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);

                //}
                //if (strTypeName == "Contract Drawings")
                //{
                //    call_java_script_popup(entity_id, "Contract_Drawings", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);
                //}
                //if (strTypeName == "Shop Drawings")
                //{
                //    call_java_script_popup(entity_id, "Shop_Drawings", flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);
                //}
                //else //By Pratik
                //{
                    call_java_script_popup(entity_id, strTypeName, flag_sheet_name, Entity_detail_id, doc_type_id, facility_id);
                //}
         
            }
         
        }
         
    }
    public void call_java_script_popup(Guid entity_id, string flag, string flag_sheet_name, Guid Entity_detail_id, Guid omniclassid, Guid facility_id)
    {
        string Updatedvalue = "<script type='text/javascript' language='javascript'>openadddocumentpopup('" + entity_id + "','" + flag + "','" + flag_sheet_name + "','" + Entity_detail_id + "','" + omniclassid + "','"+facility_id+"')</script>";
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", Updatedvalue, false);
    }
     protected void rg_document_checklist_OnDetailTableDataBind(object source, GridDetailTableDataBindEventArgs e)
    {
        try
        {
            GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

            if (e.DetailTableView.Name.Equals("category_grid"))
            {
                e.DetailTableView.DataSource = get_categories(dataItem.GetDataKeyValue("omniclass_detail_id").ToString());
                ViewState["omniclass_id"] = dataItem.GetDataKeyValue("omniclass_detail_id").ToString();

            }
            if (e.DetailTableView.Name.Equals("doc_type_grid"))
            {
               e.DetailTableView.DataSource = Get_doc_types(dataItem.GetDataKeyValue("Id").ToString());
            }

        }
        catch (Exception ex)
        {
            Response.Write("rg_document_checklist_OnDetailTableDataBind :- " + ex.Message.ToString());
        }
    }
     protected DataSet Get_doc_types(string entity_detail_id)
     {
         try
         {
             AttributeTemplateModel am = new AttributeTemplateModel();
             AttributeTemplateClient ac = new AttributeTemplateClient();
             
             DataSet ds = new DataSet();

             am.Facility_Id = new Guid(cmb_facility.SelectedValue);
             am.Entity_id = new Guid(cmb_entity.SelectedValue);
             am.Fk_row_id= new Guid(entity_detail_id);
             am.Omniclass_id = new Guid(ViewState["omniclass_id"].ToString());
             ds = ac.Get_get_doc_type_list_document_checklist(am,SessionController.ConnectionString);
             return ds;
         }
         catch (Exception ex)
         {
             throw ex;
         }

     }
     protected DataSet get_categories(string omniclass_ID)
     {
         try
         {

            // ProjectComponentModel proj_compo_model = new ProjectComponentModel();
             //ProjectComponentControl proj_compo_control = new ProjectComponentControl(SystemConstants.getConnectionFile());
             AttributeTemplateModel am = new AttributeTemplateModel();
             AttributeTemplateClient ac = new AttributeTemplateClient();
             DataSet ds = new DataSet();

             am.Omniclass_id = new Guid(omniclass_ID);
             am.Facility_Id = new Guid(cmb_facility.SelectedValue);
             am.Entity_id = new Guid(cmb_entity.SelectedValue);
             ds = ac.Get_get_omniclass_entity_list_document_checklist(am,SessionController.ConnectionString);
             return ds;
         }
         catch (Exception ex)
         {
             throw ex;
         }

     }
    protected void bindfacility()
    {
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        DataSet ds = new DataSet();
        DataSet ds1 = new DataSet();
        try
        {
            fm.Project_id = new Guid(SessionController.Users_.ProjectId);
            fm.Search_text_name = "";
            fm.Doc_flag = "floor";
            ds = fc.GetFacilitiesPM(fm, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                cmb_facility.DataTextField = "name";
                cmb_facility.DataValueField = "pk_facility_id";
                cmb_facility.DataSource = ds;
                cmb_facility.DataBind();
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindOmniclassNames();
    }
    //protected void rg_document_checklist_sort_command(object source, GridSortCommandEventArgs e)
    //{
    //    BindOmniclassNames();
    //}
    protected void rg_document_checklist_pageindexchanged(object source, GridPageChangedEventArgs e)
    {
        BindOmniclassNames();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

    }
    protected void rg_document_checklist_pagesizechanged(object source, GridPageSizeChangedEventArgs e)
    {
        BindOmniclassNames();
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

    }
    protected void rg_document_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "doc_type_grid")
        {

            Button btn = e.Item.FindControl("btnupload") as Button;
            if (btn != null && SessionController.Users_.UserSystemRole == "PA")
            {
                btn.Visible = false;
            }
        }
    }
}