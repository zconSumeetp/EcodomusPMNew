using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Asset;
using Telerik.Web.UI;
using System.Collections;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;

public partial class App_Asset_AssetsImpact : System.Web.UI.Page
{
    public ArrayList arrayList = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {
            if (!Page.IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column

                bind_AffectsBy_grid();
                ViewState["SelectedFacilityID"] = null;
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void Get_AssetProfile(string AssetId)
    {
        try
        {
            AssetClient obj_assetclient = new AssetClient();
            AssetModel obj_assetmodel = new AssetModel();
            DataSet AssetProfile = new DataSet();
            obj_assetmodel.Asset_id = new Guid(AssetId);
            AssetProfile = obj_assetclient.Get_AssetProfile(obj_assetmodel, SessionController.ConnectionString);
            hffacilityid.Value = AssetProfile.Tables[0].Rows[0]["fk_facility_id"].ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void bind_AffectsBy_grid()
    {
        var objAssetClient = new AssetClient();
        var objAssetModel = new AssetModel();
        var dsImpact = new DataSet();
        objAssetModel.Asset_id = new Guid(Request.QueryString["asset_id"]);
        objAssetModel.EntityName = "";
        objAssetModel.Search_Text = RadTextBoxSearchAffectedBy.Text;
        dsImpact = objAssetClient.get_rows_for_affect(objAssetModel, SessionController.ConnectionString);
        AffectedByGrid.DataSource = dsImpact;
        AffectedByGrid.DataBind();
    }

       
    protected void rgAffectedByPageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        bind_AffectsBy_grid();
    }

    
    protected void rgAffectedByPageSizeChanged(object sender, GridPageSizeChangedEventArgs e) 
    {
        bind_AffectsBy_grid();
    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedFacilityID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedFacilityID"];
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    
    protected void btnSearchAffectedByClick(object sender, EventArgs e)
    {
        bind_AffectsBy_grid();
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

    
    protected void Page_Prerender(object sender, EventArgs e)
    {
       

    }

}