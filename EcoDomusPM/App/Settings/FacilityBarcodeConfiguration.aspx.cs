using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.ServiceModel;
using Facility;
using EcoDomus.Session;
using Aspose.BarCode;
using Aspose.Words.Fields;
using Aspose.Words;
using System.Threading;
using System.Globalization;
using Asset;
 


public partial class App_Locations_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack || sender==rtsBarcodeEntity)
        { 
            InitializeCulture();
            if (!Page.IsPostBack)
            {
          
                RadTab tab1 = rtsBarcodeEntity.Tabs.FindTabByValue(Request.QueryString["selectedtab"]);
                tab1.Selected = true;
               
            }
            DataSet ds = new DataSet(); 
            try
            {
                FacilityModel obj_mdl = new FacilityModel();
                FacilityClient obj_clnt = new FacilityClient();
                obj_mdl.Facility_id = Guid.Parse(Request.QueryString["FacilityId"]);
                obj_mdl.Entity = rtsBarcodeEntity.SelectedTab.Value;
                ds = obj_clnt.proc_get_facility_config(obj_mdl, SessionController.ConnectionString);
            }
            catch (Exception ex)
            {

            }

        //    if (ds.Tables.Count != 0 && sender == rtsBarcodeEntity)
        //        ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_facilitybarcode('" + rtsBarcodeEntity.SelectedTab.Value + "','" + Request.QueryString["FacilityId"] + "');", true);
        //    else if (ds.Tables.Count != 0)
        //    {
        //        ViewState["CurrentTable"] = ds.Tables["Table1"];
        //        DataRow dr = null;
        //        FillTemplateDropdown();              
        //        rgEntity.DataSource = ds.Tables["Table1"];                  
        //        rgEntity.DataBind();
        //        SetPreviousData();
        //        FillTypeDropdown();
        //        ddlBarcodeType.Items.FindItemByText(ds.Tables["Table"].Rows[0]["barcode_type"].ToString()).Selected=true;
        //        FillSymbolDropdown();
        //        ddlSymbol.Items.FindItemByValue(ds.Tables["Table"].Rows[0]["barcode_symbol"].ToString()).Selected=true;
               
        //        txtRandomizationLength.Text = ds.Tables["Table"].Rows[0]["randomization_length"].ToString();
        //        manageviewstate();
        //    }
        //    else
        //    {
        //        FillTemplateDropdown();
        //        SetInitialRow();                
        //        FillTypeDropdown();
        //        FillSymbolDropdown();
                
        //    }
        //}
            if (ds.Tables.Count != 0 && sender == rtsBarcodeEntity)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_facilitybarcode('" + rtsBarcodeEntity.SelectedTab.Value + "','" + Request.QueryString["FacilityId"] + "');", true);
            else if (ds.Tables.Count != 0) // by pratik
            {
                if (ds.Tables["Table"].Rows.Count != 0)
                {
                    ViewState["CurrentTable"] = ds.Tables["Table1"];
                    DataRow dr = null;
                    FillTemplateDropdown();
                    rgEntity.DataSource = ds.Tables["Table1"];
                    rgEntity.DataBind();
                    setprevioustemplate();
                        SetPreviousData();
                    
                        FillTypeDropdown();

                    ddlBarcodeType.Items.FindItemByText(ds.Tables["Table"].Rows[0]["barcode_type"].ToString()).Selected = true;
                    FillSymbolDropdown();
                    ddlSymbol.Items.FindItemByValue(ds.Tables["Table"].Rows[0]["barcode_symbol"].ToString()).Selected = true;

                    txtRandomizationLength.Text = ds.Tables["Table"].Rows[0]["randomization_length"].ToString();

                    manageviewstate();
                }
            }
            else
            {
                FillTemplateDropdown();
                SetInitialRow();
                FillTypeDropdown();
                FillSymbolDropdown();

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
    
    private void FillSymbolDropdown()
    {
        ddlSymbol.Items.Clear();
        ddlSymbol.Items.Insert(0, new RadComboBoxItem("N/A", ""));
        ddlSymbol.Items.Insert(1, new RadComboBoxItem("-", "-"));
        ddlSymbol.Items.Insert(2, new RadComboBoxItem(":", ":"));
        ddlSymbol.Items.Insert(3, new RadComboBoxItem(".", "."));
    }
  
    private void FillTypeDropdown()
    {
        try
        {

            DataSet ds = new DataSet();
            FacilityModel obj_mdl = new FacilityModel();
            FacilityClient obj_clnt = new FacilityClient();
            ds = obj_clnt.proc_bind_barcode_type(SessionController.ConnectionString);
            ddlBarcodeType.DataTextField = "barcode_type";
            ddlBarcodeType.DataValueField = "pk_barcode_type_id";
            ddlBarcodeType.DataSource = ds;
            ddlBarcodeType.DataBind();
            ddlBarcodeType.Items.FindItemByText("Code128").Selected = true;
        }

        catch (Exception ex)
        {
        }

    }
    private void FillEntityDropdown(RadComboBox ddl)
    {
        try
        {

            DataSet ds = new DataSet();
            FacilityModel obj_mdl = new FacilityModel();
            FacilityClient obj_clnt = new FacilityClient();
            obj_mdl.Entity = rtsBarcodeEntity.SelectedTab.Value;
            ds = obj_clnt.proc_bind_barcode_entity(obj_mdl,SessionController.ConnectionString);
            ddl.DataTextField = "entity_name";
            ddl.DataValueField = "pk_entity_id";
            ddl.DataSource = ds;
            ddl.DataBind();
        }

        catch (Exception ex)
        {
            //ExceptionHandle("BindLanguage :-", ex);
        }

    }
    private void FillEntityFieldDropdown(RadComboBox ddl)
    {
        try
        {

            DataSet ds = new DataSet();
            FacilityModel obj_mdl = new FacilityModel();
            FacilityClient obj_clnt = new FacilityClient();
            GridItem rdrow = (GridItem)ddl.NamingContainer;
            int index = (rdrow.RowIndex / 2) - 1;
            RadComboBox entity = (RadComboBox)rgEntity.Items[index].Cells[1].FindControl("ddlEntity");
            obj_mdl.Entity_id = Guid.Parse(entity.SelectedValue);
            ds = obj_clnt.proc_bind_barcode_entity_field(obj_mdl, SessionController.ConnectionString);
            ddl.DataTextField = "field_name";
            ddl.DataValueField = "pk_barcode_entity_field_type_id";
            ddl.DataSource = ds;
            ddl.DataBind();
        }

        catch (Exception ex)
        {
          
        }

    }

    private void SetInitialRow()
    {

        DataTable dt = new DataTable();
        DataRow dr = null;

        dt.Columns.Add(new DataColumn("entity", typeof(string)));
        dt.Columns.Add(new DataColumn("field", typeof(string)));
        dt.Columns.Add(new DataColumn("template_id", typeof(Guid)));
        dt.Columns.Add(new DataColumn("print_option", typeof(int)));

        dr = dt.NewRow();


        dr["entity"] = "00000000-0000-0000-0000-000000000000";
        dr["field"] = "00000000-0000-0000-0000-000000000000";
        dr["template_ID"] = "00000000-0000-0000-0000-000000000000";
        dr["print_option"] = "0";
        dt.Rows.Add(dr);
      

        ViewState["CurrentTable"] = dt;
        rgEntity.DataSource = dt;
        rgEntity.DataBind();
        RadComboBox ddl1 = (RadComboBox)rgEntity.Items[0].Cells[1].FindControl("ddlEntity");
        RadComboBox ddl2 = (RadComboBox)rgEntity.Items[0].Cells[3].FindControl("ddlField");

        FillEntityDropdown(ddl1);
        FillEntityFieldDropdown(ddl2);
        manageviewstate();
    }
    private void AddNewRowToGrid()
    {


        if (ViewState["CurrentTable"] != null)
        {

            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;

            if (dtCurrentTable.Rows.Count > 0)
            {

                drCurrentRow = dtCurrentTable.NewRow();
                manageviewstate();
                drCurrentRow["entity"] = "00000000-0000-0000-0000-000000000000";
                drCurrentRow["field"] = "00000000-0000-0000-0000-000000000000";
                drCurrentRow["template_ID"] = "00000000-0000-0000-0000-000000000000";
                drCurrentRow["print_option"] = "0";
                    
                dtCurrentTable.Rows.Add(drCurrentRow);
                

                ViewState["CurrentTable"] = dtCurrentTable;

                rgEntity.DataSource = dtCurrentTable;

                rgEntity.DataBind();

            }

        }

        else
        {

            Response.Write("ViewState is null");

        }
        SetPreviousData();

    }
    private void SetPreviousData()
    {
        if (ViewState["CurrentTable"] != null)
        {

            DataTable dt = (DataTable)ViewState["CurrentTable"];

            if (dt.Rows.Count > 0)
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {

                  
                    RadComboBox ddlEntity = (RadComboBox)rgEntity.Items[i].Cells[1].FindControl("ddlEntity");
                    RadComboBox ddlfield = (RadComboBox)rgEntity.Items[i].Cells[3].FindControl("ddlField");
                    FillEntityDropdown(ddlEntity);
                    
                    if (i < dt.Rows.Count)
                    {
                        ddlEntity.ClearSelection();
                    
                        ddlEntity.Items.FindItemByValue(dt.Rows[i]["entity"].ToString()).Selected = true;
           
                        FillEntityFieldDropdown(ddlfield);
                        ddlfield.ClearSelection();
                       ddlfield.Items.FindItemByValue(dt.Rows[i]["field"].ToString()).Selected = true;
                       
                   
                    }
                    else
                        FillEntityFieldDropdown(ddlfield);
                    
                }
                //setprevioustemplate();
                
                
            }

        }

    }
    protected void ButtonAdd_Click(object sender, EventArgs e)
    {

        AddNewRowToGrid();

    }
    private void manageviewstate()
    {
        DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
        bool temp=false;
        bool custom_flag = false;
        if (dtCurrentTable.Rows.Count > 0)
        {

            for (int i = 0; i < dtCurrentTable.Rows.Count; i++)
            {

                RadComboBox ddlEntity = (RadComboBox)rgEntity.Items[i].Cells[1].FindControl("ddlEntity");
                RadComboBox ddlfield = (RadComboBox)rgEntity.Items[i].Cells[3].FindControl("ddlField");

                dtCurrentTable.Rows[i]["entity"] = ddlEntity.SelectedItem.Value;
                dtCurrentTable.Rows[i]["field"] = ddlfield.SelectedItem.Value;
                if (ddDocumentTemplate.SelectedItem.Text.Equals("Select"))
                {
                    dtCurrentTable.Rows[i]["template_ID"] = "00000000-0000-0000-0000-000000000000";
                }
                else
                {

                    dtCurrentTable.Rows[i]["template_ID"] = ddDocumentTemplate.SelectedItem.Value;
                }
                if (ddlEntity.SelectedItem.Text == "Randomize")
                {
                    temp = true;
                }
                if (RadioButtonList1.SelectedValue == "")
                {
                    dtCurrentTable.Rows[i]["print_option"] = 0;
                }
                else
                {
                    dtCurrentTable.Rows[i]["print_option"] = int.Parse(RadioButtonList1.SelectedValue.ToString());
                }

            }
            if (temp)
            {
                txtRandomizationLength.Enabled = true;
                lblRandomizationLength.Attributes.Remove("style");
                upRandomText.Update();
                upRandomLabel.Update();
            }
            else
            {
                txtRandomizationLength.Text = "";
                txtRandomizationLength.Enabled = false;
                lblRandomizationLength.Attributes.Add("style", "color:grey;");
                upRandomText.Update();
                upRandomLabel.Update();

            }




        }
        
         
           
       
        ViewState["CurrentTable"] = dtCurrentTable;

    }
    protected void ddlEntityIndexChange(object sender, EventArgs e)
    {
        RadComboBox ddl = (RadComboBox)sender;
        GridItem rdrow = (GridItem)ddl.NamingContainer;
        int index = (rdrow.RowIndex / 2) - 1;
        FillEntityFieldDropdown((RadComboBox)rgEntity.Items[index].Cells[3].FindControl("ddlField"));
        manageviewstate();
    }
    protected void BtnonDelete_ClicK(object sender, EventArgs e)
    {
        DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
        RadComboBox ddlEntity;
        RadComboBox ddlfield;
        manageviewstate();
        if (dtCurrentTable.Rows.Count > 1)
        {
            ImageButton btn = (ImageButton)sender;
            GridItem rdrow = (GridItem)btn.NamingContainer;
            dtCurrentTable.Rows.RemoveAt((rdrow.RowIndex / 2) - 1);
            rgEntity.DataSource = dtCurrentTable;
            rgEntity.DataBind();
            if (dtCurrentTable.Rows.Count > 0)
            {

                int i;
                for (i = 0; i < dtCurrentTable.Rows.Count; i++)
                {


                    ddlEntity = (RadComboBox)rgEntity.Items[i].Cells[1].FindControl("ddlEntity");
                    ddlfield = (RadComboBox)rgEntity.Items[i].Cells[3].FindControl("ddlField");
                    FillEntityDropdown(ddlEntity);
                    
                    ddlEntity.ClearSelection();
                    ddlEntity.Items.FindItemByValue(dtCurrentTable.Rows[i]["entity"].ToString()).Selected = true;

                    FillEntityFieldDropdown(ddlfield);
                    ddlfield.ClearSelection();
                    ddlfield.Items.FindItemByValue(dtCurrentTable.Rows[i]["field"].ToString()).Selected = true;

                }

            }
            ViewState["CurrentTable"] = dtCurrentTable;
            manageviewstate();
        } 
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        manageviewstate();       
        insertUpdateConfig();
        ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_facilitybarcode('" + rtsBarcodeEntity.SelectedTab.Value + "','" + Request.QueryString["FacilityId"] +"');", true);
    }
    private void insertUpdateConfig()
    {
        try
        {

            FacilityModel obj_mdl = new FacilityModel();
            FacilityClient obj_clnt = new FacilityClient();
            obj_mdl.Facility_id = Guid.Parse(Request.QueryString["FacilityId"]);
            obj_mdl.Entity = rtsBarcodeEntity.SelectedTab.Value;
            obj_mdl.ConfigDetail =(DataTable) ViewState["CurrentTable"];
            obj_mdl.BarcodeType_id = Guid.Parse(ddlBarcodeType.SelectedValue.ToString());
            obj_mdl.pk_Document_Template_Id = Guid.Parse(ddDocumentTemplate.SelectedValue.ToString());
            obj_mdl.Print_option = int.Parse(RadioButtonList1.SelectedValue.ToString());
             
            if(ddDocumentTemplate.SelectedItem.Text.Equals("Custom Template"))
            {
                if (txtBarcodeHeight.Text == "")
                {
                    txtBarcodeHeight.Text = "0.5";
                }
                if (txtBarcodeWidth.Text == "")
                {
                    txtBarcodeWidth.Text = "1.0";
                }
                if (txtBarcodePerPage.Text == "")
                {
                    txtBarcodePerPage.Text = "8";
                }

                double temp_height = double.Parse(txtBarcodeHeight.Text.ToString()) * 150;
                double temp_width = double.Parse(txtBarcodeWidth.Text.ToString()) * 150;
                obj_mdl.Barcode_Height = Convert.ToInt32(temp_height);
                obj_mdl.Barcode_Width = Convert.ToInt32(temp_width);
                obj_mdl.Barcode_per_page = int.Parse(txtBarcodePerPage.Text.ToString());
                obj_clnt.proc_update_custom_template(SessionController.ConnectionString, obj_mdl);
            }
            else
            {
                DataSet ds= obj_clnt.proc_get_barcode_height_width(SessionController.ConnectionString,(ddDocumentTemplate.SelectedValue.ToString()));
                
              
                    obj_mdl.Barcode_Height = int.Parse(ds.Tables[0].Rows[0]["barcode_height"].ToString());
                    if (ddlBarcodeType.SelectedItem.Text.ToString().Equals("QR"))
                    {
                        int width = int.Parse(ds.Tables[0].Rows[0]["barcode_width"].ToString());
                        width = width - 70;
                        obj_mdl.Barcode_Width = width;
                    }
                    else
                    {
                        obj_mdl.Barcode_Width = int.Parse(ds.Tables[0].Rows[0]["barcode_width"].ToString());
                    }
               
            }

            if(ddlSymbol.SelectedIndex!=0)
            obj_mdl.Barcode_symbol = ddlSymbol.SelectedItem.Value;
            if (txtRandomizationLength.Text!="" && int.Parse(txtRandomizationLength.Text) > 0)
                obj_mdl.RazomizeLength = int.Parse(txtRandomizationLength.Text);
            else
                obj_mdl.RazomizeLength = 0;
            

            obj_clnt.proc_insert_Update_facility_config(obj_mdl, SessionController.ConnectionString);

        }

        catch (Exception ex)
        {

        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_facilitybarcode('" + rtsBarcodeEntity.SelectedTab.Value + "','" + Request.QueryString["FacilityId"] + "');", true);
    }
    protected void btnPreview_Click(object sender, EventArgs e)
    {
        manageviewstate();
        BarCodeBuilder builder_bar = new BarCodeBuilder();
        System.IO.MemoryStream ms = new System.IO.MemoryStream();
       
        string barcodestring;
        FacilityModel obj_mdl = new FacilityModel();
        FacilityClient obj_clnt = new FacilityClient();
        obj_mdl.ConfigDetail = (DataTable)ViewState["CurrentTable"];
        obj_mdl.Facility_id = Guid.Parse(Request.QueryString["FacilityId"]);
        obj_mdl.Barcode_symbol = ddlSymbol.SelectedValue;
        if (txtRandomizationLength.Text.Length>0)
        obj_mdl.RazomizeLength = int.Parse(txtRandomizationLength.Text);
        barcodestring=obj_clnt.proc_get_preview(obj_mdl, SessionController.ConnectionString);
        builder_bar.CodeText = barcodestring;

        builder_bar.SymbologyType =(Symbology) Enum.Parse(typeof(Symbology), ddlBarcodeType.SelectedItem.Text);
        builder_bar.BarCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
        byte[] byteImage = ms.ToArray();
        Convert.ToBase64String(byteImage);
        if (!ddlBarcodeType.SelectedItem.Text.ToString().Equals("QR"))
        {
            imgBarcodeSample.Width = 250;
            imgBarcodeSample.Height = 80;
        }
        else
        {
            
            imgBarcodeSample.Height = 90;  
        }
        imgBarcodeSample.ImageUrl = "data:image/bmp;base64," + Convert.ToBase64String(byteImage);

    }


    //By Pratik on 09/30/2013

        private void FillTemplateDropdown()
    {
        try
        {

            DataSet ds = new DataSet();
            FacilityModel obj_mdl = new FacilityModel();
            FacilityClient obj_clnt = new FacilityClient();
            ds = obj_clnt.proc_bind_document_template_type(SessionController.ConnectionString);
            ddDocumentTemplate.DataTextField = "template_type";
            ddDocumentTemplate.DataValueField = "pk_document_template_id";
            
            ddDocumentTemplate.DataSource = ds;
            ddDocumentTemplate.DataBind();

            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow dr = null;
            dtCurrentTable.Columns.Add(new DataColumn("template_id", typeof(Guid)));
            dtCurrentTable.Columns.Add(new DataColumn("Print_option",typeof(int)));
            if (ddDocumentTemplate.SelectedItem.Text.Equals("Select"))
            {
                dtCurrentTable.Rows[0]["template_ID"] = "00000000-0000-0000-0000-000000000000";
            }
            else
            {

                dtCurrentTable.Rows[0]["template_ID"] = ddDocumentTemplate.SelectedItem.Value;
            }
            dtCurrentTable.Rows[0]["print_option"] = 0; //RadioButtonList1.SelectedValue;

            ddDocumentTemplate.SelectedItem.Selected = false;
            RadioButtonList1.ClearSelection();
            ViewState["CurrentTable"] = dtCurrentTable;
            
           
           
            
            
        }

        catch (Exception ex)
        {
        }

    }

        public void setprevioustemplate()
        {
            AssetModel objbarcode_mdl = new AssetModel();
            AssetClient objbarcode_crtl = new AssetClient();

            FacilityModel obj_mdl = new FacilityModel();
            FacilityClient obj_clnt = new FacilityClient();

            obj_mdl.Facility_id = Guid.Parse(Request.QueryString["FacilityId"]);
            DataSet dtCurrentSet = new DataSet();
            DataTable dt = new DataTable();
            DataRow dr = null;
            
           
            dtCurrentSet.Tables.Add(dt);
            dr = dtCurrentSet.Tables[0].NewRow();
            dt.Rows.InsertAt(dr,0);
            dtCurrentSet.Tables[0].Columns.Add(new DataColumn("facility_Id"));
            dtCurrentSet.Tables[0].Rows[0]["facility_Id"] = obj_mdl.Facility_id;
            
            DataSet doc_template = objbarcode_crtl.proc_get_barcode_info(SessionController.ConnectionString, dtCurrentSet);
            if (doc_template.Tables.Count > 0)
            {
                if (doc_template.Tables[0].Rows.Count > 0)
                {
                    ddDocumentTemplate.Items.FindByValue(doc_template.Tables[0].Rows[0]["pk_document_template_id"].ToString()).Selected = true;
                }
                else
                {
                    ddDocumentTemplate.Items.FindByText("Select").Selected = true;
                }
            }
            DataSet print_option = obj_clnt.proc_get_barcode_print_option(SessionController.ConnectionString, dtCurrentSet);
            if (print_option.Tables[0].Rows.Count > 0)
            {
                int barcode_print_option = int.Parse(print_option.Tables[0].Rows[0]["barcode_print_option"].ToString());
                if (barcode_print_option == 1)
                {
                    RadioButtonList1.SelectedIndex = 1;

                }
                else
                {
                    RadioButtonList1.SelectedIndex = 0;
                }
            }

        
        }

    


        //protected void ddDocumentTemplate_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        //{

        //        manageviewstate();
          
        //}

        
}