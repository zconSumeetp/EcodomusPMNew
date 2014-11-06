using System;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web.UI;
using System.Web.UI.WebControls;
using Asset;
using EcoDomus.Session;
using Telerik.Web.UI;
using Systems;

namespace App.Asset
{
    public partial class AssetSystems : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (SessionController.Users_.UserId != null)
                {
                    if (!IsPostBack)
                    {
                        BindSystems();
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "script1", "LogoutNavigation();", true);
                }

            }
            catch (Exception ex)
            {
                Response.Write("Page_Load:- " + ex.Message);
            }
        }

        public void BindSystems()
        {
            var assetId = GetAssetId();
            var searchText = txtcriteria.Text;
        
            var connectionString = GetConnectionString();

            using (var assetClient = new AssetClient())
            {
                var systemsSearchResult = assetClient.GetAssetSystems(assetId, searchText, null, connectionString);
                RadGridSystems.DataSource = systemsSearchResult.Items.OrderBy(s => s.Name);
            }
        
            RadGridSystems.DataBind();
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            BindSystems();
        }

        protected override void InitializeCulture()
        {
            try
            {
                var culture = (string) Session["Culture"] ?? "en-US";
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "script1", "LogoutNavigation();", true);
            }

        }

        public void redirect_page(string url)
        {

            Response.Redirect(url, false);

        }

        protected void btnsearch_Click(object sender, EventArgs e)
        {
            BindSystems();
        }

        protected void RadButtonUnassignAsset_Click(object sender, EventArgs e)
        {
            var selectedSystemsCommaSeparatedList = GetSelectedSystemsCommaSeparatedList();
            var assetId = GetAssetId();
            var connectionString = GetConnectionString();

            var assetModel = new AssetModel {Asset_id = assetId, System_id = selectedSystemsCommaSeparatedList};
            using (var assetClient = new AssetClient())
            {
                assetClient.UnAssign_system_for_asset(assetModel, connectionString);
            }

            BindSystems();
        }

        private string GetSelectedSystemsCommaSeparatedList()
        {
            var selectedItems = RadGridSystems.SelectedItems;

            var systemIdsList = 
            (
                from GridItem selectedItem
                in selectedItems
                select (Guid)selectedItem.OwnerTableView.DataKeyValues[selectedItem.ItemIndex]["Id"]
            ).ToList();

            return String.Join(",", systemIdsList);
        }

        protected void RadGridSystems_OnSortCommand(object source, GridSortCommandEventArgs e)
        {
            BindSystems();
        }

        protected void RadGridSystems_OnPageIndexChanged(object sender, GridPageChangedEventArgs e)
        {
            BindSystems();
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }

        protected void RadGridSystems_OnPageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
        {
            BindSystems();
            ScriptManager.RegisterClientScriptBlock(Page, GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        protected void RadGridSystems_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName != "deleteSystem") return;
            var strSystemId = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_system_id"].ToString();

            var systemsModel = new SystemsModel();
            var systemsClient = new SystemsClient();
            systemsModel.SystemIds = strSystemId;
            systemsClient.DeleteSystems(systemsModel, SessionController.ConnectionString);
            BindSystems();
        }

        protected void Page_Prerender(object sender, EventArgs e)
        {
            if (SessionController.Users_.UserSystemRole == "GU")
            {
                btnassignSystem.Visible = false;
                RadButtonUnassignAsset.Visible = false;
            }

            if (SessionController.Users_.Permission_ds == null ||
                SessionController.Users_.Permission_ds.Tables[0].Rows.Count <= 0) return;
            SetPermissions();
        }

        private void SetPermissions()
        {
            var dsComponent = SessionController.Users_.Permission_ds;
            var drComponent = dsComponent.Tables[0].Select("name='Component'")[0];
            var drSubmenuComponent = dsComponent.Tables[0].Select("fk_parent_control_id='" + drComponent["pk_project_role_controls"] + "'");
            foreach (var drProfile in drSubmenuComponent.Where(drProfile => drProfile["name"].ToString() == "Component Profile"))
            {
                SetPermissionToControl(drProfile);
            }
        }

        private void SetPermissionToControl(DataRow dr)
        {
            var editPermission = dr["edit_permission"].ToString();
            var deletePermission = dr["delete_permission"].ToString();
            
            btnassignSystem.Enabled = editPermission != "N";
            RadButtonUnassignAsset.Enabled = deletePermission != "N";
        }

        protected void RadGridSystems_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            const string systemNameUniqueColumnName = "Name";
            const string radButtonSystemLinkId = "RadButtonSystemLink";
            const string systemMenuQueryString = "SystemMenu.aspx?system_id=";
            const string isMainUniqueColumnName = "IsMain";
            const string radButtonSetAsMainId = "RadButtonSetAsMain";
            
            var gridDataItem = e.Item as GridDataItem;
            if (gridDataItem == null) return;

            var system = (SystemViewModel)gridDataItem.DataItem;

            var systemId = system.Id.ToString();
            var linkButtonSystemName = (RadButton)gridDataItem[systemNameUniqueColumnName].FindControl(radButtonSystemLinkId);
            linkButtonSystemName.NavigateUrl = systemMenuQueryString + systemId;

            var radButtonSetAsMain = (RadButton)gridDataItem[isMainUniqueColumnName].FindControl(radButtonSetAsMainId);
            radButtonSetAsMain.Value = system.Id.ToString();

            if (!system.IsMain) return;

            linkButtonSystemName.Font.Bold = true;
            radButtonSetAsMain.Visible = false;
        }

        protected void RadButtonSetAsMain_OnClick(object sender, EventArgs e)
        {
            var radButtonSetAsMain = (RadButton) sender;
            var systemId = new Guid(radButtonSetAsMain.Value);
            var assetId = GetAssetId();
            var connectionString = GetConnectionString();

            using (var assetClient = new AssetClient())
            {
                assetClient.SetAssetMainSystem(assetId, systemId, connectionString);
            }

            BindSystems();
        }

        private static Guid GetAssetId()
        {
            return new Guid(SessionController.Users_.AssetId);
        }

        private static string GetConnectionString()
        {
            return SessionController.ConnectionString;
        }
    }
}