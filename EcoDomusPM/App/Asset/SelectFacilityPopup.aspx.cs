using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using TypeProfile;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;


public partial class App_Asset_SelectFacilityPopup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (SessionController.Users_.UserId != null)
        {

            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "Name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
               // RgFacility.Attributes.Remove("AllowMultiRowSelection");
                RgFacility.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                BindFacilityGrid();

            }

        }
    }

    private void BindFacilityGrid()
    {
        DataSet ds = new DataSet();
        TypeProfile.TypeProfileClient obj_type = new TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeModel();
        mdl.Organization_Id = new Guid(SessionController.Users_.OrganizationID.ToString());
        mdl.ClientId = new Guid(SessionController.Users_.ClientID.ToString());
        mdl.User_id = new Guid(SessionController.Users_.UserId.ToString());
        mdl.System_Role = SessionController.Users_.UserSystemRole.ToString();      
        mdl.Txt_Search = txtSearch.Text;

        ds = obj_type.GetFacilityList(mdl,SessionController.ConnectionString);
        RgFacility.DataSource = ds;
        RgFacility.DataBind();
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

    protected void btnAssign_Click(object sender, EventArgs e)
    {
        try
        {
            string id = "";
            string name = "";

            if (RgFacility.SelectedItems.Count > 0)
            {
                for (int i = 0; i < RgFacility.SelectedItems.Count; i++)
                {
                    id = id + RgFacility.SelectedItems[i].Cells[2].Text + ",";
                    name = name + RgFacility.SelectedItems[i].Cells[4].Text + ",";
                    
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);
                name = name.Replace("'", "#");
                
                
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>selectfacilityForType('" + id + "','" + name + "');</script>");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>assignfacility();</script>");
            }
        }
        catch (Exception ex)
        {

            Response.Write("btnSelect_Click:-" + ex.Message);
        }

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindFacilityGrid();
    }
    protected void RgFacility_sortcommand(object source, GridSortCommandEventArgs e)
    {
        BindFacilityGrid();
    }
    protected void RgFacility_pageindexchanged(object sender, GridPageChangedEventArgs e)
    {

        try
        {
            BindFacilityGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void RgFacility_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        try
        {
            BindFacilityGrid();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    
}