using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dashboard;
using EcoDomus.Session;
using Telerik.Web.UI;
using User;

namespace App.Reports
{
    public partial class DashboardPM : SelectProjectPage
    {
        protected const string ShowProfile = "ShowProfile";

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                CheckProjectSelection();
                
                if (IsPostBack) return;

                BindRecentEntities();
            }
            catch (Exception ex)
            {
                Response.Write("Dashboard-Page_Load :-" + ex.Message);
            }
        }

        private void CheckProjectSelection()
        {
            if (SessionController.Users_.ProjectName == null)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "script1", "project_validate();", true);
            }
        }

        private void BindRecentEntities()
        {
            var userClient = new UserClient();
            var userId = GetUserId();
            var recentData = userClient.GetRecentData(userId);

            var recentProjects = recentData.RecentProjects;
            BindRecentProjects(recentProjects);

            var recentFacilities = recentData.RecentFacilies;
            BindRecentFacilities(recentFacilities);
        }

        private static Guid GetUserId()
        {
            return new Guid(SessionController.Users_.UserId);
        }

        private void BindRecentProjects(IEnumerable<RecentProject> recentProjects)
        {
            RadGridRecentProjects.DataSource = recentProjects;
            RadGridRecentProjects.DataBind();

            LabelProjectCount.Text = @"0";
            if (recentProjects != null)
            {
                var count = recentProjects.Count();
                LabelProjectCount.Text = count.ToString(CultureInfo.InvariantCulture);
            }  
        }
        
        private void BindRecentFacilities(IEnumerable<RecentFacility> recentFacilities)
        {
            RadGridRecentFacilities.DataSource = recentFacilities;
            RadGridRecentFacilities.DataBind();

            LabelFacilityCount.Text = @"0";
            if (recentFacilities != null)
            {
                var count = recentFacilities.Count();
                LabelFacilityCount.Text = count.ToString(CultureInfo.InvariantCulture);
            }        
        }

        protected void RadGridRecentProjects_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            var commandName = e.CommandName;
            var dataItem = (GridDataItem) e.Item;

            switch (commandName)
            {
                case "ShowProfile":
                    var projectId = (Guid) dataItem.GetDataKeyValue("Id");
                    var projectName = (string) dataItem.GetDataKeyValue("Name");
                    var clientId = (Guid)dataItem.GetDataKeyValue("RecentEntityProperties.ClientId");
                    var connectionString = (string)dataItem.GetDataKeyValue("RecentEntityProperties.ConnectionString");
                    SwitchContextToProject(projectId, projectName, clientId, connectionString);

                    var queryStringParameters =
                        new RouteValueDictionary  
                        { 
                            { "pagevalue", "ProjectProfile" }, 
                            { "pk_project_id", projectId }  
                        };

                    RedirectToRoute("ProjectMenu", queryStringParameters);
                    
                    break;
            }
        }
        
        protected struct RadGridRecentFacilitiesKeyNames
        {
            public const string FacilityId = "Id";
            public const string FacilityName = "Name";
            public const string ProjectId = "Project.Id";
            public const string ProjectName = "Project.Name";
            public const string ClientId = "RecentEntityProperties.ClientId";
            public const string ConnectionString = "RecentEntityProperties.ConnectionString";
        }

        protected void RadGridRecentFacilities_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            var commandName = e.CommandName;
            var dataItem = (GridDataItem)e.Item;

            switch (commandName)
            {
                case "ShowProfile":
                {
                    var facilityId = (Guid)dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.FacilityId);
                    var facilityName = (string) dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.FacilityName);
                    var projectId = (Guid) dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ProjectId);
                    var projectName = (string) dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ProjectName);
                    var clientId = (Guid) dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ClientId);
                    var connectionString = (string) dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ConnectionString);

                    SwitchContextToProject(projectId, projectName, clientId, connectionString);
                    SessionController.Users_.facilityID = facilityId.ToString();

                    var queryStringParameters =
                        new RouteValueDictionary
                        {
                            { "FacilityId", facilityId },
                            { "FacilityName", facilityName },
                            { "profileflag", "new" }
                        };

                    RedirectToRoute("FacilityMenu", queryStringParameters);
                    break;
                }

                case "ViewInBIM":
                {
                    var facilityId = (Guid)dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.FacilityId);
                    var projectId = (Guid)dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ProjectId);
                    var projectName = (string)dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ProjectName);
                    var clientId = (Guid)dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ClientId);
                    var connectionString = (string)dataItem.GetDataKeyValue(RadGridRecentFacilitiesKeyNames.ConnectionString);

                    SwitchContextToProject(projectId, projectName, clientId, connectionString);
                    SessionController.Users_.facilityID = facilityId.ToString();

                    var dashboardClient = new DashboardClient();
                    var dashboardModel = new DashboardModel { FacilityId = facilityId };
                    var ds = dashboardClient.GetUploadedFileID(dashboardModel, SessionController.ConnectionString);
                    var rows = ds.Tables[0].Rows;

                    if (rows.Count > 0)
                    {
                        var fileName = (string)rows[0]["file_name"];
                        var uploadedFileId = (Guid)rows[0]["uploaded_file_id"];

                        var queryStringParameters =
                            new RouteValueDictionary
                            {
                                { "FileId", uploadedFileId },
                                { "view_pt", "none" },
                                { "facility_id", facilityId }
                            };

                        var extension = Path.GetExtension(fileName);
                        var routeName = (extension == ".nwd") ? "ModelViewer" : "EcodomusModelViewer";

                        RedirectToRoute(routeName, queryStringParameters);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "script1", "Validate();", true);
                    }
                    break;
                }
            }    
        }

        protected void RadGridRecentProjects_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridHeaderItem)
            {
                var gridHeaderItem = e.Item as GridHeaderItem;

                foreach (var column in RadGridRecentProjects.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn || column is GridButtonColumn)
                    {
                        gridHeaderItem[column.UniqueName].ToolTip = column.HeaderText;
                    }
                }
            }

            if (e.Item is GridDataItem)
            {
                var gridDataItem = e.Item as GridDataItem;
                foreach (GridColumn column in RadGridRecentProjects.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn || column is GridButtonColumn)
                    {
                        var recentProject = (RecentProject)gridDataItem.DataItem;
                        string toolTip = null;

                        switch (column.UniqueName)
                        {
                            case "Name":
                                toolTip = recentProject.Name;
                                break;

                            case "OwnerOrganizationName":
                                toolTip = recentProject.OwnerOrganizationName;
                                break;

                            case "LeadOrganizationName":
                                toolTip = recentProject.LeadOrganizationName;
                                break;

                            case "CityState":
                                toolTip = recentProject.CityState;
                                break;
                        }

                        gridDataItem[column.UniqueName].ToolTip = toolTip;
                    }
                }
            }
        }

        protected void RadGridRecentFacilities_OnItemDataBound(object source, GridItemEventArgs e)
        {
            if (e.Item is GridHeaderItem)
            {
                var gridHeaderItem = e.Item as GridHeaderItem;

                foreach (var column in RadGridRecentFacilities.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn || column is GridButtonColumn || column is GridTemplateColumn)
                    {
                        gridHeaderItem[column.UniqueName].ToolTip = column.HeaderText;
                    }
                }
            }

            if (e.Item is GridDataItem)
            {
                var gridDataItem = e.Item as GridDataItem;
                foreach (GridColumn column in RadGridRecentFacilities.MasterTableView.RenderColumns)
                {
                    if (column is GridBoundColumn || column is GridButtonColumn)
                    {
                        var recentFacility = (RecentFacility)gridDataItem.DataItem;
                        string toolTip = null;

                        if (recentFacility != null)
                        {
                            switch (column.UniqueName)
                            {
                                case "Name":
                                    toolTip = recentFacility.Name;
                                    break;

                                case "CityState":
                                    toolTip = recentFacility.CityState;
                                    break;

                                case "ProjectName":
                                    if (recentFacility.Project != null)
                                        toolTip = recentFacility.Project.Name;
                                    else
                                        toolTip = "";
                                    break;
                            }
                        }

                        gridDataItem[column.UniqueName].ToolTip = toolTip;
                    }

                    if (column is GridTemplateColumn)
                    {
                        var imageButtonViewInBIM = (ImageButton) gridDataItem[column.UniqueName].FindControl("ImageButtonViewInBIM");
                        imageButtonViewInBIM.ToolTip = @"Connect to BIMServer";
                    }
                }
            }
        }
        
        protected void RadGridRecentFacilities_OnPreRender(object sender, EventArgs e)
        {
            if (SessionController.Users_.UserSystemRole != "CBU") return;

            foreach (GridItem item in RadGridRecentFacilities.MasterTableView.Items)
            {
                var btn = item.FindControl("btnBIM") as ImageButton;
                if (btn != null) btn.Visible = false;
            }
        }
    }
}