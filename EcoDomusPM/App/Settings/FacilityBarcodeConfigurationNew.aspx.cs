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
public partial class App_Settings_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack || sender == rtsBarcodeEntity)
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

            if (ds.Tables.Count == 0)
                ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_facilitybarcode('" + rtsBarcodeEntity.SelectedTab.Value + "','" + Request.QueryString["FacilityId"] + "');", true);
             else if (ds.Tables["Table"].Rows.Count != 0)
            {
                //if (ds.Tables["Table"].Rows.Count == 0)
                //{

                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "Configurefacility();", true);

                //}
                //else
                //{
                    rgEntity.DataSource = ds.Tables["Table1"];
                    rgEntity.DataBind();
                    string template = ds.Tables["Table"].Rows[0]["template_type"].ToString();
                    if (template.Equals("Custom Template"))
                    {
                        double height = double.Parse(ds.Tables["Table"].Rows[0]["barcode_height"].ToString());
                        height = height / 150;
                        lblBarcodeHeightValue.Text = Convert.ToString(height) + " Inch";                           // ds.Tables["Table"].Rows[0]["barcode_height"].ToString();
                        double width = double.Parse(ds.Tables["Table"].Rows[0]["barcode_Width"].ToString());

                        width = width / 150;
                        lblBarcodeWidthValue.Text = Convert.ToString(width) + " Inch";
                        lblBarcodePerPageValue.Text = ds.Tables["Table"].Rows[0]["barcode_per_page"].ToString();
                    }
                    int print_option = Convert.ToInt16(ds.Tables["Table"].Rows[0]["barcode_print_option"].ToString());
                    if (print_option == 0)
                    {
                        lblBarcodePrintOptionValue.Text = "Barcode without Data";
                    }
                    else if (print_option == 1)
                    {
                        lblBarcodePrintOptionValue.Text = "Barcode with Data";
                    }
                    lblTemplateValue.Text = template.ToString();
                    lblSymbolValue.Text = ds.Tables["Table"].Rows[0]["barcode_symbol"].ToString();
                    lblBarcodeTypeValue.Text = ds.Tables["Table"].Rows[0]["barcode_type"].ToString();
                    lblRandomizationLengthValue.Text = ds.Tables["Table"].Rows[0]["randomization_length"].ToString();
                    setpreviewimage(ds);

                }
            //}
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
    private void setpreviewimage(DataSet ds)
    {
        BarCodeBuilder builder_bar = new BarCodeBuilder();
        System.IO.MemoryStream ms = new System.IO.MemoryStream();

        string barcodestring;
        FacilityModel obj_mdl = new FacilityModel();
        FacilityClient obj_clnt = new FacilityClient();
        obj_mdl.ConfigDetail = (DataTable)ds.Tables["Table1"];
        obj_mdl.Barcode_symbol = ds.Tables["Table"].Rows[0]["barcode_symbol"].ToString();
        obj_mdl.RazomizeLength = int.Parse(ds.Tables["Table"].Rows[0]["randomization_length"].ToString());
        obj_mdl.Facility_id = Guid.Parse(Request.QueryString["FacilityId"]);
        barcodestring = obj_clnt.proc_get_preview(obj_mdl, SessionController.ConnectionString);

        if (barcodestring == "")
        {
            barcodestring = "demo"; 
        }
        builder_bar.CodeText = barcodestring;

        builder_bar.SymbologyType = (Symbology)Enum.Parse(typeof(Symbology), ds.Tables["Table"].Rows[0]["barcode_type"].ToString());
        builder_bar.BarCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
        byte[] byteImage = ms.ToArray();
        Convert.ToBase64String(byteImage);
        if (!ds.Tables["Table"].Rows[0]["barcode_type"].ToString().Equals("QR"))
        {
            imgBarcodeSample.Width=250 ;
        }
        imgBarcodeSample.ImageUrl = "data:image/bmp;base64," + Convert.ToBase64String(byteImage);
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "FindLocation", "navigate_facilitybarcode('" + rtsBarcodeEntity.SelectedTab.Value + "','" + Request.QueryString["FacilityId"] + "');", true);
    }
}