using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TypeProfile;
using EcoDomus.Session;
using System.Data;
using System.Net.Mail;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using EcoDomus.Mail;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;

public partial class App_Settings_AssignManufacturerModelViewer : System.Web.UI.Page
{
    CryptoHelper crypto = new CryptoHelper();
    string encry_value = "";
    string encry_client_id = "";
    Guid client_id;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.ClientID != null)
        {

            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;

                rg_manufacturer.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                BindAssignedManufacturer();
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

            throw ex;
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }
    private void BindAssignedManufacturer()
    {
        DataSet ds = new DataSet();
        TypeProfile.TypeProfileClient obj_type = new TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeModel();        
        mdl.Txt_Search = txtsearch.Text;
        mdl.ClientId =new Guid(SessionController.Users_.ClientID);
        ds = obj_type.GetClientAssignedManufacturer(mdl, SessionController.ConnectionString);
        rg_manufacturer.DataSource = ds;
        rg_manufacturer.DataBind();
    }

    protected void btnAssign_Click(object sender, EventArgs e)
    {
        string id = "";
        try
        {
            if (rg_manufacturer.SelectedItems.Count > 0)
            {
                id = Convert.ToString(rg_manufacturer.SelectedValue);
                DataSet ds = new DataSet();
                TypeProfile.TypeProfileClient obj_type = new TypeProfileClient();
                TypeProfile.TypeModel mdl = new TypeModel();
                mdl.Type_Id = new Guid(Request.QueryString["typeid"].ToString());
                mdl.Fk_Manufacturer_Id = new Guid(id);
                obj_type.AssignManufacturerModelViewer(mdl, SessionController.ConnectionString);
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closeWindow()</script>");

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindAssignedManufacturer();
    }

    protected void rg_manufacturer_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindAssignedManufacturer();
    }
    protected void rg_manufacturer_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindAssignedManufacturer();
    }
    protected void rg_manufacturer_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindAssignedManufacturer();
    }

}