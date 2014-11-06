using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data .SqlClient ;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Telerik.Web.UI;
using System.Collections.Generic;
using Locations;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;


public partial class App_omniclasslinkup : System.Web.UI.Page
{
    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString.Count > 0)
            {
                if (SessionController.Users_.UserId != null)
                {
                
                    if (!IsPostBack)
                    {
                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "SystemName";
                        sortExpr.SortOrder = GridSortOrder.Ascending;
                        //Add sort expression, which will sort against first column
                        rgSubSystems.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        if (SessionController.Users_.is_PM_FM == "FM")
                        {
                            BindSubSystem();
                        }
                        if (SessionController.Users_.is_PM_FM == "PM")
                        {
                            BindSubSystem_PM();
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
       
    }

    #endregion

    #region Event Handlers

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        try
        {
            BindSubSystem();
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        
    }

    protected void btnAssignSubsystems_click(Object sender, EventArgs e)
    {
        string strSubsystemids = "", strSubsystemNames = "";
        try
        {
            if (rgSubSystems.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rgSubSystems.SelectedItems.Count; i++)
                {
                    strSubsystemids = strSubsystemids + rgSubSystems.SelectedItems[i].Cells[2].Text + ",";
                    strSubsystemNames = strSubsystemNames + rgSubSystems.SelectedItems[i].Cells[4].Text + ",";
                }
                strSubsystemids = strSubsystemids.Substring(0, strSubsystemids.Length - 1);
                strSubsystemNames = strSubsystemNames.Substring(0, strSubsystemNames.Length - 1);

                Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
                Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                if (Request.QueryString["system_id"] != null)
                {
                    if (Request.QueryString["system_id"].ToString() != "")
                    {
                        if (Request.QueryString["system_id"].ToString() == Guid.Empty.ToString())
                        {
                            objSystemsModel.SystemId = Guid.Empty;
                        }
                        else
                        {
                            objSystemsModel.SystemId = new Guid(Request.QueryString["system_id"].ToString());
                        }
                    }
                }

                objSystemsModel.SubSystemIds = strSubsystemids;
                objSystemsClient.AssignSubSystems(objSystemsModel, SessionController.ConnectionString);

                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>RefreshSubsystem('" + strSubsystemids + "','" + strSubsystemNames + "')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>assignSubsystem();</script>", false);
            }
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Private Methods

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

    public void BindSubSystem()
        {
            try
            {
                Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
                Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
                DataSet ds = new DataSet();
                if (Request.QueryString["system_id"] != null)
                {
                    if (Request.QueryString["system_id"] == "" || Request.QueryString["system_id"] == Guid.Empty.ToString())
                    {
                        objSystemsModel.SystemId = Guid.Empty;
                    }
                    else
                    {
                        objSystemsModel.SystemId = new Guid(Request.QueryString["system_id"].ToString());
                    }

                }
            
                objSystemsModel.SearchText = txtSearch.Text.ToString();
                ds = objSystemsClient.GetSubSystemsToAssign(objSystemsModel, SessionController.ConnectionString);
                rgSubSystems.DataSource = ds;
                rgSubSystems.DataBind();
        
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    public void BindSubSystem_PM()
    {
        try
        {
            Systems.SystemsModel objSystemsModel = new Systems.SystemsModel();
            Systems.SystemsClient objSystemsClient = new Systems.SystemsClient();
            DataSet ds = new DataSet();
            if (Request.QueryString["system_id"] != null)
            {
                if (Request.QueryString["system_id"] == "" || Request.QueryString["system_id"] == Guid.Empty.ToString())
                {
                    objSystemsModel.SystemId = Guid.Empty;
                }
                else
                {
                    objSystemsModel.SystemId = new Guid(Request.QueryString["system_id"].ToString());
                }

            }

            objSystemsModel.Project_id = new Guid(SessionController.Users_.ProjectId);
            objSystemsModel.SearchText = txtSearch.Text.ToString();
            ds = objSystemsClient.GetSubSystemsToAssign_underproject(objSystemsModel, SessionController.ConnectionString);
            rgSubSystems.DataSource = ds;
            rgSubSystems.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion
}

