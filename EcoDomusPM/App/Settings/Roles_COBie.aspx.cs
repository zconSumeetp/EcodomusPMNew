using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using Aspose.Words.Lists;
using Newtonsoft.Json;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using System.Text;
using Roles;

public partial class App_Settings_Roles_COBie : System.Web.UI.Page
{
    string tempPageSize = "";
    int expanded_parent_index=0;
    bool flag = true;
   
     
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {


            ScriptManager.RegisterStartupScript(this, this.GetType(), "OnLoad", "getRole_Id();", true);
            string str = hf_roleId_cobie.Value;
            tempPageSize = SessionController.Users_.DefaultPageSizeGrids;
            hfAttributePMPageSize.Value = Convert.ToString(Convert.ToInt32(tempPageSize) - 1);
            tempPageSize = hfAttributePMPageSize.Value;
            DataTable dt_permission = new DataTable();
            dt_permission.Columns.Add("PageControlId");
            dt_permission.Columns.Add("AccessView");
            dt_permission.Columns.Add("Edit_permission");
            dt_permission.Columns.Add("Delete_permission");
            dt_permission.Columns.Add("Add_permission");
            dt_permission.Columns.Add("Name");
            ViewState["expanded_index"] = 0;
            ViewState["dt_permission"] = dt_permission;
            ViewState["flag"] = true;
            flag = true;           
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void Bind_COBie_pages()
    {
        try
        {          
            var rolesClient = new RolesClient();

            var rolesModel = new RolesModel
            {
                PageName = "COBie",
                Project_RoleId = new Guid(hf_roleId_cobie.Value),
                System_role = SessionController.Users_.UserSystemRole
            };

            var dataSetPermissionState = rolesClient.Get_COBie_pages(rolesModel, SessionController.ConnectionString);
            ViewState["permission_state"] = dataSetPermissionState.Tables[0];

            RadGridPermissions.DataSource = dataSetPermissionState;
            RadGridPermissions.DataBind();

            ViewState["is_child"] = "N";
        }
        catch(Exception ex)
        {
        }
    }

    protected void RadGridPermissions_OnDetailTableDataBind(object source, GridDetailTableDataBindEventArgs e)
    {
        try
        {
            var gridDataItem = e.DetailTableView.ParentItem;
            
            if (e.DetailTableView.Name.Equals("ChildGrid"))
            {
                var rolesClient = new RolesClient();

                var rolesModel = new RolesModel
                {
                    Project_role_controls_id = new Guid(gridDataItem.GetDataKeyValue("pk_project_role_controls").ToString()),
                    Project_RoleId = new Guid(hf_roleId_cobie.Value),
                    System_role = SessionController.Users_.UserSystemRole
                };

                var dataSetPagesFieldsOnCobieForRoles = rolesClient.get_pages_fields_on_cobie_for_roles(rolesModel, SessionController.ConnectionString);
                ViewState["permission_state"] = dataSetPagesFieldsOnCobieForRoles.Tables[0];
                ViewState["is_child"] = "Y";

                e.DetailTableView.DataSource = dataSetPagesFieldsOnCobieForRoles;
            }
            if (e.DetailTableView.Name.Equals("field_grid"))
            {
                var rolesClient = new RolesClient();

                var rolesModel = new RolesModel
                {
                    Project_role_controls_id = new Guid(gridDataItem.GetDataKeyValue("pk_project_role_controls").ToString()),
                    Project_RoleId = new Guid(hf_roleId_cobie.Value)
                };

                var dataSetPagesFieldsOnCobieForRoles = rolesClient.get_pages_fields_on_cobie_for_roles(rolesModel, SessionController.ConnectionString);
                e.DetailTableView.DataSource = dataSetPagesFieldsOnCobieForRoles; 
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "script1", "resize_frame_page();", true);
        }
        catch(Exception ex)
        {
            Response.Write("rg_document_checklist_OnDetailTableDataBind :- " + ex.Message);
        }
    }

    public class PermissionItem
    {
        public Guid PageControlId { get; set; }
        public string PageTitle { get; set; }
        public bool AddPermission { get; set; }
        public bool EditPermission { get; set; }
        public bool DeletePermission { get; set; }
        public bool ViewPermission { get; set; }
    }

    private string SerializePermissionsToXml(IEnumerable<PermissionItem> permissionsList)
    {
        var stringWriter = new StringWriter();
        var xmlWriterSettings = new XmlWriterSettings
        {
            OmitXmlDeclaration = true,
            Indent = false
        };
        var xmlWriter = XmlWriter.Create(stringWriter, xmlWriterSettings);
        xmlWriter.WriteStartElement("root");

        foreach (var permissionItem in permissionsList)
        {
            xmlWriter.WriteStartElement("folder");
            xmlWriter.WriteAttributeString("PageTitle", permissionItem.PageTitle);
            xmlWriter.WriteAttributeString("PageControlId", permissionItem.PageControlId.ToString());
            xmlWriter.WriteAttributeString("AccessView", GetLiteral(permissionItem.ViewPermission));
            xmlWriter.WriteAttributeString("Add_permission", GetLiteral(permissionItem.AddPermission));
            xmlWriter.WriteAttributeString("Edit_permission", GetLiteral(permissionItem.EditPermission));
            xmlWriter.WriteAttributeString("Delete_permission", GetLiteral(permissionItem.DeletePermission));
            xmlWriter.WriteFullEndElement();
        }

        xmlWriter.WriteEndElement();
        xmlWriter.Close();
        return stringWriter.ToString();
    }

    private static string GetLiteral(bool value)
    {
        return value ? "Y" : "N";
    } 

    protected void btnSave_Click(object sender, EventArgs e)
    {
       
        try
        {
            var hiddenFieldPermissionsChangesValue = HiddenFieldPermissionsChanges.Value;

            if (!String.IsNullOrEmpty(hiddenFieldPermissionsChangesValue))
            {
                var permissionsList = JsonConvert.DeserializeObject<List<PermissionItem>>(hiddenFieldPermissionsChangesValue);

                if (permissionsList.Count > 0)
                {
                    var serializedPermissions = SerializePermissionsToXml(permissionsList);

                    using (var rolesClient = new RolesClient())
                    {
                        var rolesModel = new RolesModel
                        {
                            Permissions = serializedPermissions,
                            Project_RoleId = new Guid(hf_roleId_cobie.Value)
                        };
                        rolesClient.Insert_update_project_roles_permissions(rolesModel, SessionController.ConnectionString);
                    }

                    HiddenFieldPermissionsChanges.Value = String.Empty;
                    Bind_COBie_pages();
                }    
            }

            btnSave.Enabled = false;
        }

        catch (Exception ex)
        {
            throw ex;
        }

    }

    protected void hdnbtn_Click(object sender, EventArgs e)
    {
        Bind_COBie_pages();
    }

    private const string CheckBoxAddPermissionId = "CheckBoxAddPermission";
    private const string CheckBoxEditPermissionId = "CheckBoxEditPermission";
    private const string CheckBoxDeletePermissionId = "CheckBoxDeletePermission";
    private const string CheckBoxViewPermissionId = "CheckBoxViewPermission";

    private const string AddPermissionColumnName = "add_permission";
    private const string EditPermissionColumnName = "edit_permission";
    private const string DeletePermissionColumnName = "delete_permission";
    private const string ViewPermissionColumnName = "view_permission";
    
    protected void RadGridPermissions_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        var gridDataItem = e.Item as GridDataItem;

        if (gridDataItem == null) return;

        var checkBoxAddPermission = FindCheckBox(gridDataItem, CheckBoxAddPermissionId);
        var checkBoxEditPermission = FindCheckBox(gridDataItem, CheckBoxEditPermissionId);
        var checkBoxDeletePermission = FindCheckBox(gridDataItem, CheckBoxDeletePermissionId);
        var checkBoxViewPermission = FindCheckBox(gridDataItem, CheckBoxViewPermissionId);

        var pageTitle = (string)gridDataItem.GetDataKeyValue("name");
        var pageControlId = (Guid)gridDataItem.GetDataKeyValue("pk_project_role_controls");

        var checkBoxAddPermissionClientId = checkBoxAddPermission.ClientID;
        var checkBoxEditPermissionClientId = checkBoxEditPermission.ClientID;
        var checkBoxDeletePermissionClientId = checkBoxDeletePermission.ClientID;
        var checkBoxViewPermissionClientId = checkBoxViewPermission.ClientID;

        var checkBoxParameters = new CheckBoxParameters
        {
            PageTitle = pageTitle,
            PageControlId = pageControlId,
            CheckBoxAddPermissionClientId = checkBoxAddPermissionClientId,
            CheckBoxEditPermissionClientId = checkBoxEditPermissionClientId,
            CheckBoxDeletePermissionClientId = checkBoxDeletePermissionClientId,
            CheckBoxViewPermissionClientId = checkBoxViewPermissionClientId
        };

        var serializedCheckBoxParameters = JsonConvert.SerializeObject(checkBoxParameters);

        AddParametersToCheckBox(checkBoxAddPermission, serializedCheckBoxParameters);
        AddParametersToCheckBox(checkBoxEditPermission, serializedCheckBoxParameters);
        AddParametersToCheckBox(checkBoxDeletePermission, serializedCheckBoxParameters);
        AddParametersToCheckBox(checkBoxViewPermission, serializedCheckBoxParameters);
        
        checkBoxAddPermission.Checked = GetCheckBoxCheckedState(gridDataItem, AddPermissionColumnName);
        checkBoxEditPermission.Checked = GetCheckBoxCheckedState(gridDataItem, EditPermissionColumnName);
        checkBoxDeletePermission.Checked = GetCheckBoxCheckedState(gridDataItem, DeletePermissionColumnName);
        checkBoxViewPermission.Checked = GetCheckBoxCheckedState(gridDataItem, ViewPermissionColumnName);

        if (!checkBoxViewPermission.Checked)
        {
            checkBoxEditPermission.Checked = false;
            checkBoxDeletePermission.Checked = false;
        }

        var ownerTableView = gridDataItem.OwnerTableView;

        if (ownerTableView.Name == "ChildGrid")
        {
            var parentItem = ownerTableView.ParentItem;

            AddCheckBoxIdToRelatedCheckBoxesClientIdsList(parentItem, CheckBoxAddPermissionId, checkBoxAddPermissionClientId);
            AddCheckBoxIdToRelatedCheckBoxesClientIdsList(parentItem, CheckBoxEditPermissionId, checkBoxEditPermissionClientId);
            AddCheckBoxIdToRelatedCheckBoxesClientIdsList(parentItem, CheckBoxDeletePermissionId, checkBoxDeletePermissionClientId);
            AddCheckBoxIdToRelatedCheckBoxesClientIdsList(parentItem, CheckBoxViewPermissionId, checkBoxViewPermissionClientId);
        }
    }

    protected const string AttributeName = "CheckBoxParameters";
    private void AddParametersToCheckBox(CheckBox checkBox, string parameters)
    {
        checkBox.InputAttributes.Add(AttributeName, parameters);    
    }

    private static void AddCheckBoxIdToRelatedCheckBoxesClientIdsList(GridDataItem parentItem, string parentCheckBoxId, string childCheckBoxClientId)
    {
        var parentItemCheckBoxPermission = FindCheckBox(parentItem, parentCheckBoxId);
        var serializedCheckBoxParameters = parentItemCheckBoxPermission.InputAttributes[AttributeName];
        var checkBoxParameters = JsonConvert.DeserializeObject<CheckBoxParameters>(serializedCheckBoxParameters);
        checkBoxParameters.RelatedCheckBoxesClientIds.Add(childCheckBoxClientId);
        serializedCheckBoxParameters = JsonConvert.SerializeObject(checkBoxParameters);
        parentItemCheckBoxPermission.InputAttributes[AttributeName] = serializedCheckBoxParameters;
    }

    public class CheckBoxParameters
    {
        public CheckBoxParameters()
        {
            RelatedCheckBoxesClientIds = new List<string>();
        }

        public string PageTitle { get; set; }
        public Guid PageControlId { get; set; }
        public string CheckBoxAddPermissionClientId { get; set; }
        public string CheckBoxEditPermissionClientId { get; set; }
        public string CheckBoxDeletePermissionClientId { get; set; }
        public string CheckBoxViewPermissionClientId { get; set; }
        public List<string> RelatedCheckBoxesClientIds { get; set; }
    }
    
    private bool GetCheckBoxCheckedState(GridDataItem gridDataItem, string columnName)
    {
        return gridDataItem[columnName].Text == @"Y";    
    }

    private static CheckBox FindCheckBox(GridDataItem gridDataItem, string checkBoxId)
    {
        return (CheckBox)gridDataItem.FindControl(checkBoxId);
    }

    public void GetPermissionsForProjectRole()
    {
        try
        {
            Roles.RolesClient obj_roleClient = new Roles.RolesClient();
            Roles.RolesModel obj_roleModel = new Roles.RolesModel();
            DataSet ds = new DataSet();
            obj_roleModel.Fk_project_id = new Guid(SessionController.Users_.ProjectId);
            obj_roleModel.User_Id = new Guid(SessionController.Users_.UserId);
            ds = obj_roleClient.GetPermissionsForProjectRole(obj_roleModel, SessionController.ConnectionString);
            SessionController.Users_.Permission_ds = ds;
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }
    public void viewCheckClicked(object sender, EventArgs e)
    {
        int index=0;
        int temp_index = 0;
       
        DataTable dt_temp =(DataTable) ViewState["dt_permission"];
        DataTable dt_temp_permission = (DataTable)ViewState["permission_state"];

        CheckBox chk = (CheckBox)sender;
        GridDataItem item = (GridDataItem)chk.NamingContainer;
        int crrntindex = item.ItemIndex;
        if (item.HasChildItems == true)
        {

                foreach (GridDataItem row4 in RadGridPermissions.MasterTableView.Items)
                {
                    
                    CheckBox chk1 = (CheckBox)row4.FindControl("CheckBoxEditPermission");
                    CheckBox chk2 = (CheckBox)row4.FindControl("CheckBoxDeletePermission");
                    Guid controlid =(Guid)row4.GetDataKeyValue("pk_project_role_controls");
                    string name = (string)row4.GetDataKeyValue("name");

                    int index1 = row4.ItemIndex;
                    if (crrntindex == index1)
                    {
                        bool exists1 = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == controlid.ToString());
                        if (exists1)
                        {
                            for (int i = 0; i < dt_temp.Rows.Count; i++)
                            {
                                if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                                    index = i;
                                break;
                            }
                            if (chk.Checked)
                            {

                                dt_temp.Rows[index]["Accessview"] = "Y";

                            }
                            else
                            {
                                dt_temp.Rows[index]["Accessview"] = "N";
                                dt_temp.Rows[index]["edit_permission"] = "N";
                                dt_temp.Rows[index]["delete_permission"] = "N";

                            }
                            
                        }
                        else
                       {

                            DataRow dr = dt_temp.NewRow();
                            dr["PageControlId"] = controlid;
                            dr["Name"] = name;
                            if (chk.Checked)
                            {
                                dr["AccessView"] = "Y";
                                if (chk1.Checked)

                                    dr["edit_permission"] = "Y";
                                else
                                    dr["edit_permission"] = "N";
                                if (chk2.Checked)
                                    dr["delete_permission"] = "Y";
                                else
                                    dr["delete_permission"] = "N";
                                dr["Add_permission"] = "Y";

                                dt_temp.Rows.Add(dr);

                                break;

                            }
                            else
                            {
                                dr["AccessView"] = "N";
                                dr["edit_permission"] = "N";
                                dr["delete_permission"] = "N";
                                dr["Add_permission"] = "N";
                                dt_temp.Rows.Add(dr);

                                chk1.Checked = false;
                                chk2.Checked = false;
                                break;
                            }
                        }
                            
                        }
                    }
               
               
             int testindex = (int)ViewState["expanded_index"];
            GridTableView nestedTableView = (RadGridPermissions.MasterTableView.Items[testindex] as GridDataItem).ChildItem.NestedTableViews[0];
                     foreach (GridDataItem row2 in nestedTableView.Items)
                {

                    CheckBox chk2 = (CheckBox)row2.FindControl("CheckBoxViewPermission");
                    CheckBox chk3 = (CheckBox)row2.FindControl("CheckBoxEditPermission");
                    CheckBox chk4 = (CheckBox)row2.FindControl("CheckBoxDeletePermission");
                    Guid controlid = (Guid)row2.GetDataKeyValue("pk_project_role_controls");
                    string name = (string)row2.GetDataKeyValue("name");
                    bool exists_temp = dt_temp.Select().ToList().Exists(row => row2["pk_project_role_controls"].ToString() == controlid.ToString());
                    if (exists_temp)
                    {
                          for (int i = 0; i < dt_temp.Rows.Count; i++)
                         {
                             if (dt_temp.Rows[i][0].Equals(controlid.ToString()))
                                 temp_index = i;
                                break;
                         }
                          if (chk.Checked)
                          {
                              dt_temp.Rows[temp_index]["Accessview"] = "Y";
                              chk2.Checked = true;
                          }
                          else
                          {
                              dt_temp.Rows[temp_index]["Accessview"] = "N";
                              chk2.Checked = false;
                              chk3.Checked = false;
                              chk4.Checked = false;
                          }
 

                    }
                    else
                    {
                        DataRow dr = dt_temp.NewRow();
                        dr["PageControlId"] = controlid.ToString();
                        dr["Name"] = name.ToString();
                        if (chk.Checked)
                        {
                            dr["Accessview"] = "Y";
                            chk2.Checked = true;
                            
                        }
                        else
                        {
                            dr["Accessview"] = "N";
                            chk2.Checked = false;
                            chk3.Checked = false;
                            chk4.Checked = false;
                        }
                        dt_temp.Rows.Add(dr);
 
                    }
                    
                }
                ViewState["dt_permisson"] = dt_temp;
        }
        else
        {
            int testindex = (int)ViewState["expanded_index"];
            GridTableView nestedTableView = (RadGridPermissions.MasterTableView.Items[testindex] as GridDataItem).ChildItem.NestedTableViews[0];

            foreach (GridDataItem row in nestedTableView.Items)
            {
                CheckBox chk1 = (CheckBox)row.FindControl("CheckBoxEditPermission");
                CheckBox chk2 = (CheckBox)row.FindControl("CheckBoxDeletePermission");
                int index1 = row.ItemIndex;
                if (crrntindex == index1)
                {
                    if (!chk.Checked)
                    {
                        chk1.Checked = false;
                        chk2.Checked = false;
                        break;
                    }
                   
                   
                }


            }

            bool exists = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == hfCheckviewValues.Value);
            if (exists)
            {
                int index_temp = 0;
                for (int i = 0; i < dt_temp.Rows.Count; i++)
                {
                    if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                    {
                        index_temp = i;
                        break;
                    }
                }

                if (chk.Checked)
                {

                    dt_temp.Rows[index_temp]["Accessview"] = "Y";
                    

                }
                else
                {
                    dt_temp.Rows[index_temp]["Accessview"] = "N";
                    dt_temp.Rows[index_temp]["edit_permission"] = "N";
                    dt_temp.Rows[index_temp]["delete_permission"] = "N";

                }
            }

            else
            {
                DataRow dr = dt_temp.NewRow();
                dr["PageControlId"] = hfCheckviewValues.Value;
                dr["Name"] = hfname.Value;
                if (chk.Checked)
                {
                    dr["AccessView"] = "Y";
                }
                else
                {
                    dr["AccessView"] = "N";
                    dr["Edit_permission"] = "N";
                    dr["delete_permission"] = "N";

                }
                dt_temp.Rows.Add(dr);
            }
            ViewState["dt_permisson"] = dt_temp;
        }
    }

    public void editCheckClicked(object sender, EventArgs e)
    {
        int index=0;
        int temp_index=0;
        DataTable dt_temp = (DataTable)ViewState["dt_permission"];

        CheckBox chk = (CheckBox)sender;
        GridDataItem item = (GridDataItem)chk.NamingContainer;
         int crrntindex = item.ItemIndex;
         if (item.HasChildItems == true)
         {
             foreach (GridDataItem row4 in RadGridPermissions.MasterTableView.Items)
             {

                 CheckBox chk1 = (CheckBox)row4.FindControl("CheckBoxEditPermission");
                 CheckBox chk2 = (CheckBox)row4.FindControl("CheckBoxDeletePermission");
                 Guid controlid = (Guid)row4.GetDataKeyValue("pk_project_role_controls");
                 string name = (string)row4.GetDataKeyValue("name");

                 int index1 = row4.ItemIndex;
                 if (crrntindex == index1)
                 {

                     bool exists1 = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == controlid.ToString());
                     if (exists1)
                     {
                         for (int i = 0; i < dt_temp.Rows.Count; i++)
                         {
                             if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                             {
                                 index = i;
                                 break;
                             }
                         }
                         if (chk.Checked)
                         {

                             dt_temp.Rows[index]["edit_permission"] = "Y";
                             chk1.Checked = true;

                         }
                         else
                         {
                             dt_temp.Rows[index]["edit_permission"] = "N";
                             dt_temp.Rows[index]["delete_permission"] = "N";
                             chk1.Checked = false;
                             chk2.Checked = false;

                         }

                     }
                     else
                     {

                         DataRow dr = dt_temp.NewRow();
                         dr["PageControlId"] = controlid;
                         dr["Name"] = name;
                         if (chk.Checked)
                         {

                             dr["edit_permission"] = "Y";
                             chk1.Checked = true;
                         }
                         else
                         {
                             dr["edit_permission"] = "N";
                             dr["delete_permission"] = "N";
                             chk1.Checked = false;
                             chk2.Checked = false;
                         }


                         dt_temp.Rows.Add(dr);

                         break;
                     }
                 }
                            
               }
             int testindex = (int)ViewState["expanded_index"];
             GridTableView nestedTableView = (RadGridPermissions.MasterTableView.Items[testindex] as GridDataItem).ChildItem.NestedTableViews[0];
             foreach (GridDataItem row2 in nestedTableView.Items)
             {
                 CheckBox chk2 = (CheckBox)row2.FindControl("CheckBoxDeletePermission");
                 CheckBox chk1 = (CheckBox)row2.FindControl("CheckBoxEditPermission");
                 Guid controlid = (Guid)row2.GetDataKeyValue("pk_project_role_controls");
                 string name = (string)row2.GetDataKeyValue("name");
                 bool exists_temp = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == controlid.ToString());
                 if (exists_temp)
                 {
                     for (int i = 0; i < dt_temp.Rows.Count; i++)
                     {
                         if (dt_temp.Rows[i][0].Equals(controlid.ToString()))
                         {
                             temp_index = i;
                             break;
                         }
                     }
                     if (chk.Checked)
                     {
                         dt_temp.Rows[temp_index]["Edit_permission"] = "Y";
                         chk1.Checked = true;
                     }
                     else
                     {
                         dt_temp.Rows[temp_index]["Edit_permission"] = "N";
                         dt_temp.Rows[temp_index]["delete_permission"] = "N";
                         chk1.Checked = false;
                         chk2.Checked = false;
                     }


                 }
                 else
                 {
                     DataRow dr = dt_temp.NewRow();
                     dr["PageControlId"] = controlid.ToString();
                     dr["Name"] = name.ToString();
                     if (chk.Checked)
                     {
                         dr["Edit_permission"] = "Y";
                         chk2.Checked = true;

                     }
                     else
                     {
                         dr["Edit_permission"] = "N";
                         dr["delete_permission"] = "N";
                         chk2.Checked = false;
                         chk1.Checked = false;
                     }
                     dt_temp.Rows.Add(dr);

                 }

             }
             ViewState["dt_permisson"] = dt_temp;
         }
         else
         {
             int testindex = (int)ViewState["expanded_index"];
             GridTableView nestedTableView = (RadGridPermissions.MasterTableView.Items[testindex] as GridDataItem).ChildItem.NestedTableViews[0];

             foreach (GridDataItem row in nestedTableView.Items)
             {
                 CheckBox chk1 = (CheckBox)row.FindControl("CheckBoxEditPermission");
                 CheckBox chk2 = (CheckBox)row.FindControl("CheckBoxDeletePermission");
                 int index1 = row.ItemIndex;
                 if (crrntindex == index1)
                 {
                     if (!chk.Checked)
                     {
                         chk1.Checked = false;
                         chk2.Checked = false;
                         break;
                     }


                 }


             }

             bool exists = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == hfCheckviewValues.Value);
             if (exists)
             {
                 int index_temp = 0;
                 for (int i = 0; i < dt_temp.Rows.Count; i++)
                 {
                     if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                     {
                         index_temp = i;
                         break;
                     }
                 }

                 if (chk.Checked)
                 {

                     dt_temp.Rows[index_temp]["edit_permission"] = "Y";


                 }
                 else
                 {
                    
                     dt_temp.Rows[index_temp]["edit_permission"] = "N";
                     dt_temp.Rows[index_temp]["delete_permission"] = "N";

                 }
             }

             else
             {
                 DataRow dr = dt_temp.NewRow();
                 dr["PageControlId"] = hfCheckviewValues.Value;
                 dr["Name"] = hfname.Value;
                 if (chk.Checked)
                 {
                     dr["edit_permission"] = "Y";
                 }
                 else
                 {
                   
                     dr["Edit_permission"] = "N";
                     dr["delete_permission"] = "N";

                 }
                 dt_temp.Rows.Add(dr);
             }
             ViewState["dt_permisson"] = dt_temp;
         }

    }

    public void deleteCheckClicked(object sender, EventArgs e)
    {
        int index = 0;
        int temp_index = 0;
        DataTable dt_temp = (DataTable)ViewState["dt_permission"];

        CheckBox chk = (CheckBox)sender;
        GridDataItem item = (GridDataItem)chk.NamingContainer;
        int crrntindex = item.ItemIndex;
        if (item.HasChildItems == true)
        {
            foreach (GridDataItem row4 in RadGridPermissions.MasterTableView.Items)
            {

            
                CheckBox chk2 = (CheckBox)row4.FindControl("CheckBoxDeletePermission");
                Guid controlid = (Guid)row4.GetDataKeyValue("pk_project_role_controls");
                string name = (string)row4.GetDataKeyValue("name");

                int index1 = row4.ItemIndex;
                if (crrntindex == index1)
                {

                    bool exists1 = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == controlid.ToString());
                    if (exists1)
                    {
                        for (int i = 0; i < dt_temp.Rows.Count; i++)
                        {
                            if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                            {
                                index = i;
                                break;
                            }
                        }
                        if (chk.Checked)
                        {

                            dt_temp.Rows[index]["delete_permission"] = "Y";
                            chk2.Checked = true;

                        }
                        else
                        {
                          
                            dt_temp.Rows[index]["delete_permission"] = "N";
                          
                            chk2.Checked = false;

                        }

                    }
                    else
                    {

                        DataRow dr = dt_temp.NewRow();
                        dr["PageControlId"] = controlid;
                        dr["Name"] = name;
                        if (chk.Checked)
                        {

                            dr["delete_permission"] = "Y";
                            chk2.Checked = true;
                        }
                        else
                        {
                           
                            dr["delete_permission"] = "N";
                          
                            chk2.Checked = false;
                        }


                        dt_temp.Rows.Add(dr);

                        //chk1.Checked = true;
                        //chk2.Checked = true;
                        break;
                    }
                }

            }
            int testindex = (int)ViewState["expanded_index"];
            GridTableView nestedTableView = (RadGridPermissions.MasterTableView.Items[testindex] as GridDataItem).ChildItem.NestedTableViews[0];
            foreach (GridDataItem row2 in nestedTableView.Items)
            {
                CheckBox chk2 = (CheckBox)row2.FindControl("CheckBoxDeletePermission");
              
                Guid controlid = (Guid)row2.GetDataKeyValue("pk_project_role_controls");
                string name = (string)row2.GetDataKeyValue("name");
                bool exists_temp = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == controlid.ToString());
                if (exists_temp)
                {
                    for (int i = 0; i < dt_temp.Rows.Count; i++)
                    {
                        if (dt_temp.Rows[i][0].Equals(controlid.ToString()))
                        {
                            temp_index = i;
                            break;
                        }
                    }
                    if (chk.Checked)
                    {
                        dt_temp.Rows[temp_index]["delete_permission"] = "Y";
                        chk2.Checked = true;
                    }
                    else
                    {
                       
                        dt_temp.Rows[temp_index]["delete_permission"] = "N";
                     
                        chk2.Checked = false;
                    }


                }
                else
                {
                    DataRow dr = dt_temp.NewRow();
                    dr["PageControlId"] = controlid.ToString();
                    dr["Name"] = name.ToString();
                    if (chk.Checked)
                    {
                        dr["delete_permission"] = "Y";
                        chk2.Checked = true;

                    }
                    else
                    {
                      
                        dr["delete_permission"] = "N";
                        chk2.Checked = false;
                      
                    }
                    dt_temp.Rows.Add(dr);

                }

            }
            ViewState["dt_permisson"] = dt_temp;
        }
        else
        {
            int testindex = (int)ViewState["expanded_index"];
            GridTableView nestedTableView = (RadGridPermissions.MasterTableView.Items[testindex] as GridDataItem).ChildItem.NestedTableViews[0];

            foreach (GridDataItem row in nestedTableView.Items)
            {
               
                CheckBox chk2 = (CheckBox)row.FindControl("CheckBoxDeletePermission");
                int index1 = row.ItemIndex;
                if (crrntindex == index1)
                {
                    if (!chk.Checked)
                    {
                        
                        chk2.Checked = false;
                        break;
                    }


                }


            }

            bool exists = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == hfCheckviewValues.Value);
            if (exists)
            {
                int index_temp = 0;
                for (int i = 0; i < dt_temp.Rows.Count; i++)
                {
                    if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                    {
                        index_temp = i;
                        break;
                    }
                }

                if (chk.Checked)
                {

                    dt_temp.Rows[index_temp]["delete_permission"] = "Y";


                }
                else
                {

                   
                    dt_temp.Rows[index_temp]["delete_permission"] = "N";

                }
            }

            else
            {
                DataRow dr = dt_temp.NewRow();
                dr["PageControlId"] = hfCheckviewValues.Value;
                dr["Name"] = hfname.Value;
                if (chk.Checked)
                {
                    dr["delete_permission"] = "Y";
                }
                else
                {

                   
                    dr["delete_permission"] = "N";

                }
                dt_temp.Rows.Add(dr);
            }
            ViewState["dt_permisson"] = dt_temp;
        }
    }
    
    public void addCheckClicked(object sender, EventArgs e)
    {
        int index = 0;

        DataTable dt_temp = (DataTable)ViewState["dt_permission"];


        CheckBox chk = (CheckBox)sender;
        GridDataItem item = (GridDataItem)chk.NamingContainer;

        bool exists = dt_temp.Select().ToList().Exists(row => row["PageControlId"].ToString() == hfCheckviewValues.Value);


        if (exists)
        {
            for (int i = 0; i < dt_temp.Rows.Count; i++)
            {
                if (dt_temp.Rows[i][0].Equals(hfCheckviewValues.Value.ToString()))
                    index = i;
            }
            if (chk.Checked)
            {

                dt_temp.Rows[index]["Add_permission"] = "Y";
            }
            else
            {
                dt_temp.Rows[index]["Add_permission"] = "N";
            }
        }

        else
        {
            DataRow dr = dt_temp.NewRow();
            dr["PageControlId"] = hfCheckviewValues.Value;
            dr["Name"] = hfname.Value;
            if (chk.Checked)
            {
                dr["Add_permission"] = "Y";
            }
            else
            {
                dr["Add_permission"] = "N";
            }
            dt_temp.Rows.Add(dr);

        }
        ViewState["dt_permisson"] = dt_temp;

    }
    protected void RadGridPermissions_OnPreRender(object sender, EventArgs e)
    {
       
        if ((bool)ViewState["flag"]== false)
        {
            
                expanded_parent_index = (int)ViewState["expanded_index"];
              
                if (RadGridPermissions.MasterTableView.Items[expanded_parent_index].Expanded !=false)
                RadGridPermissions.MasterTableView.Items[expanded_parent_index].Expanded = true;
                else
                    RadGridPermissions.MasterTableView.Items[expanded_parent_index].Expanded = false;
            
           
          
        }
      
    }
    protected void RadGridPermissions_OnItemcommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if(e.CommandName.Equals("ExpandCollapse"))
        {
            ViewState["flag"] = false;
            expanded_parent_index = e.Item.ItemIndex;
            if (RadGridPermissions.MasterTableView.Items[expanded_parent_index].Expanded == false)
            {
                ViewState["expanded_index"] = expanded_parent_index;
            }
           
        }

    }
}