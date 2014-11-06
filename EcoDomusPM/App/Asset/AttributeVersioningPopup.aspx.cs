using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attributes;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Asset_AttributeVersioningPopup : System.Web.UI.Page
{
    private static string attributeID;
    private static string attribute_flag;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null)
        {

            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "value";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                Rghistory.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                string attribute_id = Request.QueryString["attribute_id"];
                attribute_flag = Request.QueryString["attribute_flag"];
                attributeID = attribute_id;
                Bindhistory();
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
 public void    Bindhistory()
    {


        AttributeClient ctrl = new AttributeClient();
        AttributeModel mdl = new AttributeModel();
        DataSet ds;
        Guid AttributeID = new Guid(Convert.ToString (attributeID ));
           mdl.Attribute_id = AttributeID;
           mdl.Attribute_flag = attribute_flag;
           mdl.Txt_search = txtSearch.Text;
        // lblAttribute.Text ="Attribute History";
        ds = ctrl.GetAttributeHistory(mdl, SessionController.ConnectionString.ToString());
        Rghistory.DataSource = ds;       
        Rghistory.DataBind();

    }

 protected void btnClose_Click(object sender, EventArgs e)
 {
    
 }
 protected void Rghistory_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
 {
     
     Bindhistory();
 }

 protected void Rghistory_PageIndexChanged1(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
 {
     Bindhistory();
 }
 protected void Rghistory_PageSizeChanged1(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
 {
     Bindhistory();
 }
 protected void Rghistory_PreRender(object sender, EventArgs e)
 {
 }

 protected void lblAttribute_Load(object sender, EventArgs e)
 {

 }
 protected void btnSearch_Click(object sender, EventArgs e)
 {
     Bindhistory();
 }
}