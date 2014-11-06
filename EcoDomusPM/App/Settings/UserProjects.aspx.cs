using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using Login;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Project;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;
using Organization;

public partial class UserProjects : System.Web.UI.Page
{
    DataSet ds_temp3 = new DataSet();
    int blank_master;
    string tempPageSize = "";
    bool flag = false;
    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Request.QueryString["flag"] == "no_master")
        {
            Page.MasterPageFile = "~/App/EcoDomusMasterBlank.master";
            blank_master = 1;
            ViewState["flag_master"] = "no_master";
        }

     
        //if(Request.QueryString["flag1"] == "new" && Request.QueryString["flag"] != "no_master")
        //{
        //    Page.MasterPageFile = "~/App/EcoDomusMaster.master"; 
        //    //blank_master = 0;
        //}
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (SessionController.Users_.UserId != null)
        {
            if (SessionController.Users_.UserSystemRole == "SA")
            {
                //btnAddProject.Visible = false;
            }
            
            if (!IsPostBack)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "project_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;                
                rgProjects.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
                hfDocumentPMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 1);
                tempPageSize = hfDocumentPMPageSize.Value;
                
                GetUserClientDetail_forPM();
            }

            if (Request.QueryString["flag"] == "no_master")
            {
                OrganizationModel om = new OrganizationModel();
                OrganizationClient oc = new OrganizationClient();

                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption('Y');", true);

            }
            else
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCaption", "SetCaption('N');", true);
        }
        else
        {
           // Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }
    }


    public void GetUserClientDetail_forPM()
    {
        try
        {
            DataSet ds = new DataSet();
            DataSet ds_facility = new DataSet();
            LoginClient login_ctrl = new LoginClient();
            LoginModel login_mdl = new LoginModel();
            CryptoHelper crypt = new CryptoHelper();
            login_mdl.UserId = new Guid(SessionController.Users_.UserId);

            if (Request.QueryString["UserId"] != null && Request.QueryString["UserId"]!="")
                  login_mdl.UserId = new Guid(Request.QueryString["UserId"]);

            Project.ProjectClient ctrl = new Project.ProjectClient();
            Project.ProjectModel mdl = new Project.ProjectModel();

            ////When SA logs in as OA using proxy login ********************************************
            //if ((SessionController.Users_.UserRoleDescription == "System Admin")&&(SessionController.Users_.UserSystemRole == "OA"))
            //{
            //    mdl.Search_text_name = txtSearch.Text;
            //    mdl.User_id = new Guid(SessionController.Users_.UserId);
            //    mdl.Client_id = new Guid(SessionController.Users_.ClientID);
            //    mdl.Conn_string = SessionController.ConnectionString;
            //    ds = ctrl.GetUserProjects(mdl, SessionController.ConnectionString);
            //    rgProjects.DataSource = ds;
            //    rgProjects.DataBind();
              
            //}
            //// When SA logs in and viewing projects of particular user.(Without doing proxy login.)
            //else if ((SessionController.Users_.UserRoleDescription == "System Admin")&&(SessionController.Users_.UserSystemRole == "SA"))
            //{
            //    ds = login_ctrl.GetUserClientDetail_new(login_mdl);
            //}
            //else // when OA logs in and viewing projects of particular user
            //{
    //****************************************************************************************
                ds = login_ctrl.GetUserClientDetail_new(login_mdl);
                rgProjects.AllowCustomPaging = true;
            if (tempPageSize != "")
               rgProjects.MasterTableView.PageSize = Convert.ToInt32(tempPageSize);
            rgProjects.VirtualItemCount = Int32.Parse((ds.Tables[0].Rows.Count.ToString()));

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataSet ds_temp2 = new DataSet();
                    DataSet ds_temp1 = new DataSet();
                    foreach (DataRow myRow in ds.Tables[0].Rows)
                    {
                        //   DataSet ds_temp1 = new DataSet(); earlier
                        //mdl.User_id = new Guid(SessionController.Users_.UserId);  //previously
                        mdl.User_id = new Guid(Request.QueryString["UserId"]);

                        mdl.Search_text_name = txtSearch.Text;

                        mdl.Client_id = new Guid(myRow["client_id"].ToString());
                        mdl.Conn_string = crypt.Encrypt(myRow["ConnectionString"].ToString());

                        // mdl.Role = myRow["role"].ToString();



                        ds_temp1 = ctrl.GetUserProjects(mdl, crypt.Encrypt(myRow["ConnectionString"].ToString()));

                        //if (ds_temp1.Tables[0].Rows.Count > 0)
                        //{
                        //    if (ds_temp1.Tables[0].Rows[0]["user_role"].ToString() == "OA")
                        //    {
                        //        btnAddProject.Visible = false;
                        //    }
                        //}
                        
                        ds_temp2.Merge(ds_temp1);
                    }
                    if (ds_temp2.Tables[0].Rows.Count > 0)
                    {
                        rgProjects.DataSource = ds_temp2;
                        rgProjects.DataBind();
                    }
                    else
                    {
                        rgProjects.DataSource = ds_temp1;
                        rgProjects.DataBind();
                    }
                    ds_temp3 = ds_temp2;
                }
                else
                {
                    rgProjects.DataSource = ds;
                    rgProjects.DataBind();
                }
                
            //}
        
        }
        catch (Exception ex)
        {
            throw ex;
        }
        
    }

    protected void rgProjects_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Edit")
            {
                CryptoHelper crypto_obj = new CryptoHelper();
                SessionController.ConnectionString = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["cons_string"].ToString(); //earlier
                
                string pk_project_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_project_id"].ToString();
                string project_name = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["project_name"].ToString();

                SessionController.Users_.ClientID = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_client_id"].ToString();




                hfprojectid.Value = pk_project_id;
                SessionController.Users_.ProjectId = pk_project_id;
                SessionController.Users_.ProjectName = project_name;
                try
                {
                   // GetUserClientDetail_forPM();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "navigate", "NavigateToProjectProfile();", true); 
                }
                catch (Exception ex)
                {

                    throw ex;
                }              
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void btnAddProject_Click(object sender, EventArgs e)
    //{
    //    LoginModel lm = new LoginModel();
    //    LoginClient lc = new LoginClient();
    //    DataSet ds = new DataSet();
    //    CryptoHelper crypt = new CryptoHelper();
    //    lm.UserId = new Guid(SessionController.Users_.UserId);
    //    ds = lc.GetConnectionStringUser(lm);
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        if (ds.Tables[0].Rows[0]["is_primary_flag"].ToString() == "")
    //        {
    //            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
    //        }
    //        else
    //        {
    //            //added on 29-06-12------------
    //            if (SessionController.Users_.UserRoleDescription != "System Admin")
    //            {
    //                SessionController.ConnectionString = crypt.Encrypt(ds.Tables[0].Rows[0]["connection_string"].ToString());
    //                SessionController.Users_.OrganizationID = ds.Tables[0].Rows[0]["pk_organization_id"].ToString();
    //                SessionController.Users_.OrganizationName = ds.Tables[0].Rows[0]["name"].ToString();
    //            }
    //            else
    //            { 
                    
    //            }
    //            //----------------------------
    //            //SessionController.Users_.OrganizationID = ds.Tables[0].Rows[0]["pk_organization_id"].ToString();
    //            //SessionController.Users_.OrganizationName = ds.Tables[0].Rows[0]["name"].ToString();
                

    //            //if (ViewState["flag_master"] == "no_master")
    //                //Response.Redirect("~\\App\\Settings\\ProjectMenu.aspx?flag=no_master&pagevalue=ProjectProfile&ProjectId=" + Guid.Empty);
    //            //else
    //               // SessionController.Users_.ProjectId = Guid.Empty.ToString();
    //            Response.Redirect("~\\App\\Settings\\ProjectMenu.aspx?pagevalue=ProjectProfile&ProjectId=" + Guid.Empty + "&ispage=");
    //        }
    //    }
    //    else
    //    {
    //        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "validate();", true);
    //    }
    //}

    protected void btnSearch_Click(object sender,EventArgs e)
    {
        GetUserClientDetail_forPM();
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

           // redirect_page("~\\app\\LoginPM.aspx?Error=Session");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {
        Response.Redirect(url, false);
    }

    protected void rgProjects_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            GetUserClientDetail_forPM();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgProjects_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetUserClientDetail_forPM();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgProjects_SortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            GetUserClientDetail_forPM();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void rgProjects_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridHeaderItem)
            {
                GridHeaderItem headerItem = e.Item as GridHeaderItem;

                foreach (GridColumn column in rgProjects.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }
                    else if (column is GridButtonColumn)
                    {
                        //if the sorting feature of the grid is enabled
                        if (column.HeaderText != "" && column.HeaderText != "Delete")
                            (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                    }

                }
            }

            if (e.Item is GridPagerItem && flag)
            {

                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.Sort(new PagerRadComboBoxItemComparer());
                if (tempPageSize != "")
                {
                    cb.Items.FindItemByValue(tempPageSize).Selected = true;
                }
            }

            //if (e.Item is GridPagerItem)
            //{
            //    GridPagerItem pagerItem = e.Item as GridPagerItem;
            //    RadComboBox combo = pagerItem.FindControl("PageSizeComboBox") as RadComboBox;
            //    combo.EnableScreenBoundaryDetection = false;
            //    combo.ExpandDirection = RadComboBoxExpandDirection.Up;
            //}
            if (e.Item is GridDataItem)
            {
                GridDataItem gridItem = e.Item as GridDataItem;
                foreach (GridColumn column in rgProjects.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn)
                    {
                        //this line will show a tooltip based type of Databound for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "OrganizationName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[2].ToString());
                        }
                        else if (column.UniqueName == "client_name" || column.UniqueName == "enabled")
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[3].ToString());
                        else
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                    else if (column is GridButtonColumn)
                    {
                        //this line will show a tooltip based type of linkbutton for grid data field
                        if (column.OrderIndex > -1 && e.Item.DataItem != null)
                        {
                            if (column.UniqueName.ToString().Equals("Name"))
                                //if(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].GetType() == typeof(string))
                                gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                        }
                    }
                    else if (column is GridTemplateColumn)
                    {
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "unitName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[8].ToString());
                        }
                        if (column.OrderIndex > -1 && e.Item.DataItem != null && column.UniqueName == "StageName")
                        {
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString());
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
}