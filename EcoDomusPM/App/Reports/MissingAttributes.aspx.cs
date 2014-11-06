using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Telerik.Web.UI;
using EcoDomus.Session;
using AttributeTemplate;
using Facility;
using System.Threading;
using System.Globalization;
using Report;
using Winnovative.WnvHtmlConvert;
 



public partial class App_Reports_MissingAttributes : System.Web.UI.Page
{
    private const string MissingAttributeIdsKey = "MissingAttributeIds";

    private List<Guid> MissingAttributeIds
    {
        get { return Session[MissingAttributeIdsKey] as List<Guid>; }
        set { Session[MissingAttributeIdsKey] = value; }
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!IsPostBack)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "omniclassname";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rg_missing_attribute_reports.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    bindentity();
                    SetButtonAddForAllText();
                    SetConfirmationMessage();
                    bindfacility();
                    //hf_entity_name.Value = cmbentity.SelectedItem.Text;
                    //  hf_facility_id.Value = cmbfacility.SelectedValue;
                    // hf_facility_name.Value = cmbfacility.SelectedItem.Text;
                    BindMissingAttributes();
                    rdBtnOmniClass.Visible = false;
                    rdBtnOmniClass2.Visible = false;
                }
            }
            hf_page_size.Value = (SessionController.Users_.DefaultPageSizeGrids);
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx");
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
            ds = ac.BindEntity(am,SessionController.ConnectionString);
            cmbentity.DataTextField = "entity_name";
            cmbentity.DataValueField = "pk_entity_id";
            cmbentity.DataSource = ds;
            cmbentity.DataBind();
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
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds;
                cmbfacility.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindMissingAttributes()
    {
       
        ReportModel rm = new ReportModel();
        ReportClient rc = new ReportClient();
        DataSet ds = new DataSet();
        try
        {
            if (rdBtnOmniClass.Checked)
            {
                rm.Standardname = "OmniClass 2010";
            }
            else if (rdBtnOmniClass2.Checked)
            {
                rm.Standardname = "OmniClass 2006";

            }
            
            //rm.Entity_id=new Guid(cmbentity.SelectedValue.ToString());

            hf_entity_name.Value = cmbentity.SelectedValue.ToString();
            rm.Entity_id = new Guid(hf_entity_name.Value.ToString());
            rm.Facility_id = cmbfacility.SelectedValue.ToString();
            rm.Search_text = txtSearch.Text;
            if (ckbox_major.Checked)
                rm.majorflag = "Y";
            else
                rm.majorflag = "N";
            ds = rc.GetMissingAttributes(rm, SessionController.ConnectionString);


            if (ds.Tables.Count > 0)
            {
                rg_missing_attribute_reports.Visible = true;
                if (ds.Tables.Count == 3)
                {
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        if (ds.Tables[1].Rows[0]["flag"].ToString() == "Y")
                        {
                            rg_missing_attribute_reports.DataSource = ds;
                            rg_missing_attribute_reports.DataBind();

                            SaveMissingAttributeIds(ds);

                            if (ds.Tables[2].Rows[0]["template_id"].ToString() != Guid.Empty.ToString())
                            {
                                hf_template_id.Value = ds.Tables[2].Rows[0]["template_id"].ToString();

                            }
                            else
                            {

                                hf_template_id.Value = Guid.Empty.ToString();
                            }
                        }
                    }
                }
                else if (ds.Tables[0].Rows.Count > 0)
                {
                    if (ds.Tables[0].Rows[0]["flag"].ToString() == "N")
                    {
                        
                      //  rg_missing_attribute_reports.DataSource = ds;
                        //rg_missing_attribute_reports.DataBind();

                        SessionController.Users_.facilityID = cmbfacility.SelectedValue.ToString();
                        SessionController.Users_.facilityName = cmbfacility.SelectedItem.Text;

                        hf_facility_id.Value = cmbfacility.SelectedValue.ToString();
                        hf_facility_name.Value = cmbfacility.SelectedItem.Text;

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "validate('" + hf_facility_id.Value + "','" + hf_facility_name.Value + "');", true);
                    }
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SaveMissingAttributeIds(DataSet ds)
    {
        var dataTable = ds.Tables[0];
        MissingAttributeIds = dataTable.AsEnumerable().Select(t => (Guid)t["id"]).ToList();
    }

    protected void rdBtnOmniClass2_CheckedChanged(object sender, EventArgs e)
    {
        BindMissingAttributes();
    }

    protected void rdBtnOmniClass_CheckedChanged(object sender, EventArgs e)
    {
        BindMissingAttributes();
    }

    protected void cmbfacility_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
      //  hf_facility_id.Value = cmbfacility.SelectedValue;
       // hf_facility_name.Value = cmbfacility.SelectedItem.Text;
        BindMissingAttributes();
    }

    protected void rg_omniclass_sort_command(object source,GridSortCommandEventArgs e)
    {
           BindMissingAttributes();
    }

    protected void rg_missing_attribute_pagesizechanged(object source, GridPageSizeChangedEventArgs e)
    {
        BindMissingAttributes();
    }

    protected void rg_missing_attribute_pageindexchanged(object source, GridPageChangedEventArgs e)
    {
        BindMissingAttributes();
    }
        
    protected void btn_search_click(object sender,EventArgs e)
    {
        BindMissingAttributes();
    }

    protected void cmbentity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        hf_entity_name.Value = cmbentity.SelectedValue;//earlier

        SetButtonAddForAllText();
        SetConfirmationMessage();

        BindMissingAttributes();
    }

    private PdfConverter GetPdfConverter()
    {
        try
        {
            PdfConverter pdfConverter = new PdfConverter();



            pdfConverter.LicenseKey = "NB8FFAUUBBQBGgQUBwUaBQYaDQ0NDQ==";

            pdfConverter.PdfDocumentOptions.PdfCompressionLevel = PdfCompressionLevel.Normal;
            pdfConverter.PdfDocumentOptions.PdfPageOrientation = PDFPageOrientation.Portrait;
            pdfConverter.PdfDocumentOptions.ShowHeader = false;
            pdfConverter.PdfDocumentOptions.ShowFooter = true;
            pdfConverter.PdfDocumentOptions.LeftMargin = 20;
            pdfConverter.PdfDocumentOptions.RightMargin = 10;
            pdfConverter.PdfDocumentOptions.TopMargin = 10;
            pdfConverter.PdfDocumentOptions.BottomMargin = 10;
            pdfConverter.PdfDocumentOptions.GenerateSelectablePdf = true;
            pdfConverter.PdfDocumentOptions.LiveUrlsEnabled = false;
            pdfConverter.PdfDocumentOptions.FitWidth = true;
            pdfConverter.PdfDocumentOptions.AutoSizePdfPage = false;
            pdfConverter.PdfDocumentOptions.EmbedFonts = true;



            pdfConverter.PageWidth = 1500;

            pdfConverter.AvoidImageBreak = false;

            pdfConverter.PdfFooterOptions.FooterText = "";
            pdfConverter.PdfFooterOptions.DrawFooterLine = false;
            pdfConverter.PdfFooterOptions.PageNumberText = "Page";
            pdfConverter.PdfFooterOptions.ShowPageNumber = true;

            pdfConverter.PdfBookmarkOptions.TagNames = false ? new string[] { "h1", "h2" } : null;

            return pdfConverter;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_pdf_click(object sender, EventArgs e)
    {
        try
        {
            string entity = "";
            string facility_id = "";
            string omniclass = "";
            string txtsearch = "";
            string querystring = "";
            string filter = "";
            string majorflag = "";
            

            entity = cmbentity.SelectedValue.ToString();
            facility_id = cmbfacility.SelectedValue.ToString();
            if (rdBtnOmniClass.Checked)
            {
                omniclass = "OmniClass 2010";
            }
            else if (rdBtnOmniClass2.Checked)
            {
                omniclass = "OmniClass 2006";
            }
            txtsearch = txtSearch.Text;

            string user_id = SessionController.Users_.UserId.ToString();

            if (ckbox_major.Checked)
                majorflag = "Y";
            else
                majorflag = "N";




            querystring = "?filter=" + filter + "&entity=" + entity + "&facilityid=" + facility_id + "&omniclass=" + omniclass + "&text=" + txtsearch + "&userid=" + user_id + "&connectionstring=" + SessionController.ConnectionString + "&ismajor=" + majorflag + "";

            string param = Request.Url.AbsoluteUri.ToString() + querystring;
            param = param.Replace("MissingAttributes", "MissingAttributesPDFs");

            string urlToConvert = param;
            string url = Request.Url.AbsoluteUri.ToString();
            string downloadName = "MissingAttributesPDF.pdf";

            if (!Page.IsValid)
                return;
            byte[] downloadBytes = null;

            PdfConverter pdfConverter = GetPdfConverter();            
            downloadBytes = pdfConverter.GetPdfBytesFromUrl(urlToConvert);

            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Cache.SetCacheability(HttpCacheability.Private);
            Response.Expires = -1;
            Response.Buffer = false;
            System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;

            response.AddHeader("Content-Type", "binary/octet-stream");
            response.AddHeader("Content-Disposition",
                "attachment; filename=" + downloadName + "; size=" + downloadBytes.Length.ToString());

            Response.BinaryWrite(downloadBytes);
            Response.End();
        }
        catch (Exception ex)
        {
        }
    }

    protected void rg_missing_attribute_reports_itemcommand(object source, GridCommandEventArgs e)
    {

        Guid id;
        string name="";
        try
        {
            if (e.CommandName == "Edit_")
            {
                LinkButton lnk_work_order_name = e.Item.FindControl("linkEntityName") as LinkButton;
                id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["id"].ToString());
                if (cmbentity.SelectedItem.Text== "Type")
                {                    
                    Response.Redirect("~/App/Asset/TypeProfileMenu.aspx?type_id=" + id, false);
                }
                else if (cmbentity.SelectedItem.Text == "Component")
                {                    
                    //Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + id + "&pagevalue=AssetProfile", false);
                    Response.Redirect("~/App/Asset/AssetMenu.aspx?assetid=" + id, false);
                }
                else if (cmbentity.SelectedItem.Text == "Space")
                {                    
                    Response.Redirect("~/App/Locations/FacilityMenu.aspx?pagevalue=Space Profile&id=" + id, false);
                }
                else if (cmbentity.SelectedItem.Text == "System")
                {                 
                    Response.Redirect("~/App/Asset/SystemMenu.aspx?system_id=" + id, false);
                }
                else if (cmbentity.SelectedItem.Text == "Facility")
                {   
                   name=(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["name"].ToString());
                   SessionController.Users_.facilityID = cmbfacility.SelectedValue.ToString();
                   Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + cmbfacility.SelectedValue.ToString() + "&FacilityName=" + name, false);
                    //Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + cmbfacility.SelectedValue+"&FacilityName="+name,false);                    
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_add_click(object sender, EventArgs e)
    {
        ReportModel rm = new ReportModel();
        ReportClient rc = new ReportClient();
         
        string type_id = "";

        try
        {
            if (rg_missing_attribute_reports.SelectedItems.Count > 0)
            {
                for (int i = 0; i < rg_missing_attribute_reports.SelectedItems.Count; i++)
                {                   
                    type_id = rg_missing_attribute_reports.SelectedItems[i].Cells[3].Text;
                    rm.RowId = new Guid(type_id);
                    //rm.Attributenames = rg_missing_attribute_reports.SelectedItems[i].Cells[7].Text.Trim();
                    rm.Attributenames = rg_missing_attribute_reports.SelectedItems[i].Cells[8].Text.Trim();
                    rm.Entity_id = new Guid(cmbentity.SelectedValue);
                    //rm.Omniclass_id =new Guid(rg_missing_attribute_reports.SelectedItems[i].Cells[2].Text);
                    rm.UserId = new Guid(SessionController.Users_.UserId);
                    //rm.Attribute_template_id = hf_template_id.Value.ToString();
                    rc.proc_insert_missing_attributes(rm, SessionController.ConnectionString);
                }
                //lbl_add.Text = Resources.Resource.Attributes_added_successfully;
                ShowAlert();
                BindMissingAttributes();
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
            //BindMissingAttributes();
            if (SessionController.Users_.Permission_ds != null)
            {
                if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                {
                    {
                        SetPermissions();
                    }
                }
            }
        }
        catch (Exception)
        {

            throw;
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Facility'")[0];
            SetPermissionToControl(dr_component);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();

        string delete_permission = dr["delete_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();

        if (edit_permission == "N")
        {
            btn_add.Enabled = false;
        }
        else
        {
            btn_add.Enabled = true;
        }

    }

    protected void ckbox_major_CheckedChanged(object sender, EventArgs e)
    {
        BindMissingAttributes();
    }

    protected void ButtonAddForAll_OnClick(object sender, EventArgs e)
    {
        if (MissingAttributeIds != null && MissingAttributeIds.Count > 0)
        {
            var missingAttributeIds = MissingAttributeIds;

            var reportModel = new ReportModel
            {
                Attributenames = String.Empty,
                Entity_id = new Guid(cmbentity.SelectedValue),
                UserId = new Guid(SessionController.Users_.UserId)
            };

            var progress = RadProgressContext.Current;
            progress.PrimaryPercent = 0;

            int i = 0;

            foreach (var missingAttributeId in missingAttributeIds)
            {
                i++;

                progress.PrimaryPercent = i * 100 / MissingAttributeIds.Count;

                reportModel.RowId = missingAttributeId;
                
                using (var reportClient = new ReportClient())
                {
                    reportClient.proc_insert_missing_attributes(reportModel, SessionController.ConnectionString);
                }
            }

            ShowAlert();
            
            BindMissingAttributes();

            progress.PrimaryPercent = 0;
        }

       
    }

    private void SetButtonAddForAllText()
    {
        switch (cmbentity.SelectedItem.Text)
        {
            case "Type":
                ButtonAddForAll.Text = Resources.Resource.Add_Required_Attributes_to_Model_for_all_Types;
                break;

            case "Component":
                ButtonAddForAll.Text = Resources.Resource.Add_Required_Attributes_to_Model_for_all_Components;
                break;

            case "Facility":
                ButtonAddForAll.Text = Resources.Resource.Add_Required_Attributes_to_Model_for_all_Facilities;
                break;

            case "Space":
                ButtonAddForAll.Text = Resources.Resource.Add_Required_Attributes_to_Model_for_all_Spaces;
                break;

            case "System":
                ButtonAddForAll.Text = Resources.Resource.Add_Required_Attributes_to_Model_for_all_Systems;
                break;
        }
    }

    private void SetConfirmationMessage()
    {
        switch (cmbentity.SelectedItem.Text)
        {
            case "Type":
                HiddenFieldConfirmationMessage.Value = Resources.Resource.Are_you_sure_to_add_required_attributes_to_model_for_all_types;
                break;

            case "Component":
                HiddenFieldConfirmationMessage.Value = Resources.Resource.Are_you_sure_to_add_required_attributes_to_model_for_all_components;
                break;

            case "Facility":
                HiddenFieldConfirmationMessage.Value = Resources.Resource.Are_you_sure_to_add_required_attributes_to_model_for_all_facilities;
                break;

            case "Space":
                HiddenFieldConfirmationMessage.Value = Resources.Resource.Are_you_sure_to_add_required_attributes_to_model_for_all_spaces;
                break;

            case "System":
                HiddenFieldConfirmationMessage.Value = Resources.Resource.Are_you_sure_to_add_required_attributes_to_model_for_all_systems;
                break;
        }
    }

    private void ShowAlert()
    {
        const string script = "ShowAlert();";
        ScriptManager.RegisterStartupScript(Page, typeof(Page), "ShowAlert", script, true);
    }
}