using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Data;
using Facility;
using Locations;
using AttributeTemplate;
using System.Collections;
using System.Text.RegularExpressions;
using System.Text;

public partial class App_UserControls_UCMapDocuments : System.Web.UI.UserControl
{
    public ArrayList arrayList = new ArrayList();

    private Dictionary<String, String> _mappingStatus = new Dictionary<String, string>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["facilityid"] != null)
        {
            hf_facility_id.Value = Session["facilityid"].ToString();
        }

        if (SessionController.Users_.UserId != null)
        {
            string isPostback = string.Empty;
            if (Page.Request.Params.Get("__EVENTTARGET") != null)
            {
                isPostback = Page.Request.Params.Get("__EVENTTARGET");
            }
            if (isPostback.Equals(string.Empty))
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "document_name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                rgdocument.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                BindCategories();
                BindStages();
                BindApprovalby();
                BindEntity();
                BindGrid();
            }
        }
    }

    protected void BindCategories()
    {
        try
        {
            rcbcategory.DataTextField = "type_name";
            rcbcategory.DataValueField = "doc_type_id";
            rcbcategory.DataSource = GetTypes();
            rcbcategory.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private DataSet GetTypes()
    {
        LocationsClient locObj_crtl = new LocationsClient();
        LocationsModel locObj_mdl = new LocationsModel();

        locObj_mdl.ProjectId = new Guid(SessionController.Users_.ProjectId);
        locObj_mdl.Attribute_template_id = Guid.Empty;

        locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
        return locObj_crtl.Get_All_Document_Types(SessionController.ConnectionString, locObj_mdl);
    }

    private Guid GetTypeId(String name)
    {
        return FindId(GetTypes(), name, "type_name", "doc_type_id", Resources.Resource.Document_type_not_found);
    }

    private Guid FindId(DataSet ds, String name, String nameField, String idField, String exceptionMessage)
    {
        if (ds != null && ds.Tables.Count > 0)
        {
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (ds.Tables[0].Rows[i][nameField].ToString().Equals(name, StringComparison.InvariantCultureIgnoreCase))
                    return new Guid(ds.Tables[0].Rows[i][idField].ToString());
            }
        }

        throw new Exception(exceptionMessage);
    }

    // set default value
    private void SetComboBoxDefaultValue(RadComboBox combo, String text)
    {
        for (int i = 0; i < combo.Items.Count; i++)
        {
            if (text.Equals(combo.Items[i].Text, StringComparison.InvariantCultureIgnoreCase))
            {
                combo.SelectedIndex = i;
                break;
            }
        }
    }

    protected void BindStages()
    {
        try
        {
            rcbstage.DataTextField = "stage_name";
            rcbstage.DataValueField = "id";
            rcbstage.DataSource = GetStages();
            rcbstage.DataBind();
            SetComboBoxDefaultValue(rcbstage, "As Built");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private DataSet GetStages()
    {
        LocationsClient locObj_crtl = new LocationsClient();
        LocationsModel locObj_mdl = new LocationsModel();
        locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
        return locObj_crtl.get_stages(SessionController.ConnectionString);
    }

    private Guid GetStageId(String name)
    {
        return FindId(GetStages(), name, "stage_name", "id", Resources.Resource.Stage_not_found);
    }

    protected void BindApprovalby()
    {
        try
        {
            rcbapproval.DataTextField = "approval_by";
            rcbapproval.DataValueField = "id";
            rcbapproval.DataSource = GetApprovalBy();
            rcbapproval.DataBind();
            SetComboBoxDefaultValue(rcbapproval, "Owner Approval");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private DataSet GetApprovalBy()
    {
        LocationsClient locObj_crtl = new LocationsClient();
        LocationsModel locObj_mdl = new LocationsModel();

        locObj_mdl.OrganizationID = SessionController.Users_.OrganizationID;
        return locObj_crtl.get_approval_by(SessionController.ConnectionString);
    }

    private Guid GetApprovalById(String name)
    {
        return FindId(GetApprovalBy(), name, "approval_by", "id", Resources.Resource.ApprovalBy_not_found);
    }

    protected void BindEntity()
    {
        try
        {
            DataSet ds_entity = new DataSet();
            AttributeTemplateClient attObj_crtl = new AttributeTemplateClient();
            AttributeTemplateModel attObj_mdl = new AttributeTemplateModel();
            attObj_mdl.Flag = "doc";
            ds_entity = attObj_crtl.BindEntity(attObj_mdl, SessionController.ConnectionString);

            rcbentity.DataTextField = "Entity";
            rcbentity.DataValueField = "pk_entity_id";
            rcbentity.DataSource = ds_entity;
            rcbentity.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void GetSelectedRows()
    {
        try
        {
            if (ViewState["SelectedDocuments"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedDocuments"];
            }

            foreach (GridDataItem item in rgdocument.Items)
            {
                string strIndex = rgdocument.MasterTableView.CurrentPageIndex.ToString();
                string CompositeKey = item["document_name"].Text + item["entity_name"].Text.Replace("&nbsp;","");
                if (item.Selected)
                {
                    if (!arrayList.Contains(CompositeKey.ToString()))
                    {
                        arrayList.Add(CompositeKey.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(CompositeKey.ToString()))
                    {
                        arrayList.Remove(CompositeKey.ToString());
                    }
                }
            }

            ViewState["SelectedDocuments"] = arrayList;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected IEnumerable<AutoMapFields> GetSelectedDocs()
    {
        var autoMapFields = new List<AutoMapFields>();

        GetSelectedRows();

        DataSet ds = GetDocuments();

        foreach (DataRow row in ds.Tables[0].Rows)
        {
            string CompositeKey = row["document_name"].ToString() + row["entity_name"].ToString();

            if (arrayList.Contains(CompositeKey))
            {
                autoMapFields.Add(new AutoMapFields() { DocumentIds = row["pk_document_ids"].ToString(), DocumentName = row["document_name"].ToString(), FilePath = row["file_path"].ToString() });
            }
        }

        return autoMapFields;
    }

    protected void btnDone_Click(object sender, EventArgs e)
    {
        Session["facilityid"] = null;
        Response.Redirect("~/App/Asset/Document.aspx", false);
    }

    protected void btnMapDocument_Click(object sender, EventArgs e)
    {
        if (chbAutoMapDocuments.Checked)
        {
            AutoMapDocuments();
        }
        else
        {
            lblentityname.Text = hf_entitynames.Value;

            GetSelectedRows();

            if (arrayList.Count < 1)
            {
                lblMsg.Style["color"] = "red";
                lblMsg.Text = Resources.Resource.Please_select_at_least_one_document;
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Visible = false;

                List<string> UploadedDocumentIds = new List<string>();

                DataSet ds = GetDocuments();

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    string CompositeKey = row["document_name"].ToString() + row["entity_name"].ToString();

                    if (arrayList.Contains(CompositeKey))
                    {
                        MapDocument(
                            row["pk_document_ids"].ToString(),
                            row["document_name"].ToString(),
                            hf_row_ids.Value,
                            new Guid(rcbcategory.SelectedValue),
                            new Guid(rcbstage.SelectedValue),
                            new Guid(rcbapproval.SelectedValue),
                            row["file_path"].ToString());
                    }
                }

                BindGrid();
            }
        }
    }

    private void MapDocument(String oldDocumentIds, String documentName, String rowIds, Guid docTypeId, Guid stageId, Guid approvalById, String filePath)
    {
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();

        facObjFacilityModel.Document_ids = oldDocumentIds;
        facObjFacilityModel.User_Id = new Guid(SessionController.Users_.UserId.ToString());
        facObjFacilityModel.Entity_id = new Guid(rcbentity.SelectedValue); // EntityId, not assetId, typeId, systemId, etc.
        facObjFacilityModel.Document_type_id = docTypeId;
        facObjFacilityModel.Fk_stage_id = stageId;
        facObjFacilityModel.Fk_approval_id = approvalById;
        facObjFacilityModel.Document_Name = documentName;
        facObjFacilityModel.File_path = filePath;
        facObjFacilityModel.Fk_row_ids = rowIds;
        facObjFacilityModel.Facility_id = new Guid(Session["facilityid"].ToString());

        facObjFacilityModel = facObjClientCtrl.InsertUpdate_BulkDocumentPM(facObjFacilityModel, SessionController.ConnectionString);

        SetBulkUploadDocumentIds(oldDocumentIds.ToLower(), facObjFacilityModel.New_Document_ids.ToLower());
    }

    private void AutoMapDocuments()
    {
        try
        {
            lblMsg.Visible = false;
            _mappingStatus.Clear();

            foreach (var fields in GetAutoMapFields())
            {
                if (!fields.IsError)
                    MapDocument(fields.DocumentIds, fields.DocumentName, fields.RowId.ToString(), fields.TypeId, fields.StageId, fields.ApprovalById, fields.FilePath);
                else
                {
                    if (!_mappingStatus.ContainsKey(fields.DocumentIds))
                        _mappingStatus.Add(fields.DocumentIds, fields.Error);
                    else
                        _mappingStatus[fields.DocumentIds] += Environment.NewLine + fields.Error;
                }
            }
        }
        catch (Exception ex)
        {
            lblMsg.Style["color"] = "red";
            lblMsg.Text = ex.Message;
            lblMsg.Visible = true;
        }

        BindGrid();
    }

    private IEnumerable<AutoMapFields> GetAutoMapFields()
    {
        Guid id;

        if (String.IsNullOrWhiteSpace(cbAutoMapFileNameFormat.Text))
            throw new Exception(Resources.Resource.Please_type_a_file_name_pattern);

        String[] patternFields = cbAutoMapFileNameFormat.Text.Split(new char[] { '_' }, StringSplitOptions.RemoveEmptyEntries);
        var pattern = GetPattern(patternFields);

        var autoMapFields = GetSelectedDocs();
        if (autoMapFields.Count() < 1)
            throw new Exception(Resources.Resource.Please_select_at_least_one_document);

        foreach (var fields in autoMapFields)
        {
            FillAutoMapFieldsFromDocName(pattern, patternFields, fields);

            if (!fields.IsError)
            {
                try
                {
                    fields.RowId = GetEntityId(rcbentity.Text, fields.RowName);
                    
                    id = new Guid(rcbcategory.SelectedValue);
                    if (id != Guid.Empty)
                        fields.TypeId = id;
                    else if (!String.IsNullOrWhiteSpace(fields.TypeName))
                        fields.TypeId = GetTypeId(fields.TypeName);
                    else
                        throw new Exception(Resources.Resource.Document_type_not_defined);

                    id = new Guid(rcbstage.SelectedValue);
                    if (id != Guid.Empty)
                        fields.StageId = id;
                    else if (!String.IsNullOrWhiteSpace(fields.StageName))
                        fields.StageId = GetStageId(fields.StageName);
                    else
                        throw new Exception(Resources.Resource.Stage_not_defined);

                    id = new Guid(rcbapproval.SelectedValue);
                    if (id != Guid.Empty)
                        fields.ApprovalById = id;
                    else if (!String.IsNullOrWhiteSpace(fields.ApprovalByName))
                        fields.ApprovalById = GetApprovalById(fields.ApprovalByName);
                    else
                        throw new Exception(Resources.Resource.ApprovalBy_not_defined);
                }
                catch (Exception ex)
                {
                    fields.IsError = true;
                    fields.Error = ex.Message;
                }
            }
        }

        return autoMapFields;
    }

    private Regex GetPattern(String[] patternFields)
    {
        int i;
        StringBuilder regexPattern = new StringBuilder("^");

        for (i = 0; i < patternFields.Length; i++)
        {
            if (i > 0)
                regexPattern.Append("_");

            if (patternFields[i].Length < 3 || patternFields[i][0] != '%' || patternFields[i][patternFields[i].Length - 1] != '%')
                throw new Exception(Resources.Resource.Invalid_pattern);
            
            regexPattern.Append("(.+)");
        }

        regexPattern.Append("$");

        return new Regex(regexPattern.ToString());
    }

    private void FillAutoMapFieldsFromDocName(Regex pattern, String[] patternFields, AutoMapFields fields)
    {
        do
        {
            var match = pattern.Match(fields.DocumentName);
            if (!match.Success)
            {
                fields.IsError = true;
                fields.Error = Resources.Resource.The_document_name_does_not_match_the_pattern;
                break;
            }

            for (int i = 0; i < patternFields.Length; i++)
            {
                switch (patternFields[i].ToUpper())
                {
                    case "%NAME%":
                        fields.RowName = match.Groups[i + 1].Value;
                        break;

                    case "%DOCUMENTTYPE%":
                        fields.TypeName = match.Groups[i + 1].Value;
                        break;

                    case "%STAGE%":
                        fields.StageName = match.Groups[i + 1].Value;
                        break;

                    case "%APPROVALBY%":
                        fields.ApprovalByName = match.Groups[i + 1].Value;
                        break;
                }
            }
        }
        while(false);
    }

    private Guid GetEntityId(String entity, String name)
    {
        Guid facilityId = new Guid(Session["facilityid"].ToString());
        Guid id;

        switch (entity.ToLower())
        {
            case "component":
                using (var client = new Asset.AssetClient())
                {
                    id = client.GetSingleAssetByName(name, facilityId, SessionController.ConnectionString);
                }
                break;
            
            case "facility":
                id = facilityId;
                break;
            
            case "floor":
            case "space":
                using (var client = new Locations.LocationsClient())
                {
                    id = client.GetSingleLocationByName(entity.ToLower().Equals("floor") ? "Floor Type" : "Space", name, facilityId, SessionController.ConnectionString);
                }
                break;            
            
            case "system":
                using (var client = new Systems.SystemsClient())
                {
                    id = client.GetSingleSystemByName(name, facilityId, SessionController.ConnectionString);
                }
                break;
            
            case "type":
                using (var client = new TypeProfile.TypeProfileClient())
                {
                    id = client.GetSingleTypeByName(name, facilityId, SessionController.ConnectionString);
                }
                break;

            default:
                throw new Exception(Resources.Resource.Unknown_entity);
        }

        return id;
    }

    public void SetBulkUploadDocumentIds(string oldDocumentIds, string newDocumentIds)
    {
        List<string> oldDocumentIdsList = oldDocumentIds.Split(',').ToList();
        List<string> SessionDocumentIdsList = SessionController.Users_.BulkUploadDocumentIds.ToLower().Split(',').ToList();
        foreach (string item in oldDocumentIdsList)
        {
            SessionDocumentIdsList.Remove(item);
        }

        List<string> newDocumentIdsList = newDocumentIds.Split(',').ToList();
        foreach (string item in newDocumentIdsList)
        {
            SessionDocumentIdsList.Add(item);
        }

        SessionController.Users_.BulkUploadDocumentIds = String.Join(",", SessionDocumentIdsList.Select(x => x.ToString()).ToArray());
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        rcbentity.SelectedIndex = -1;
        rcbcategory.SelectedIndex = -1;
        rcbstage.SelectedIndex = -1;
        rcbapproval.SelectedIndex = -1;
        lblentityname.Text = string.Empty;
        hf_entityid.Value = string.Empty;
        hf_row_ids.Value = string.Empty;
    }

    public string GetFacilityIdCSV()
    {
        DataSet ds_facility = new DataSet();
        FacilityClient locObj_crtl = new FacilityClient();
        FacilityModel locObj_mdl = new FacilityModel();
        locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
        locObj_mdl.Search_text_name = "";
        locObj_mdl.Doc_flag = "floor";
        ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);
        List<string> FacilityIdList = new List<string>();
        foreach (DataRow row in ds_facility.Tables[0].Rows)
        {
            FacilityIdList.Add(row["pk_facility_id"].ToString());
        }

        return String.Join(",", FacilityIdList.Select(x => x.ToString()).ToArray());
    }

    private DataSet GetDocuments()
    {
        DataSet ds = new DataSet();
        FacilityModel fm = new FacilityModel();
        FacilityClient fc = new FacilityClient();
        try
        {
            fm.Search_text_name = txtSearch.Text;
            fm.Document_ids = SessionController.Users_.BulkUploadDocumentIds;
            fm.Facility_Ids = GetFacilityIdCSV();
            fm.Fk_row_ids = SessionController.Users_.BulkUploadFacilityId;
            ds = fc.GetDocuments_by_DocumentIds_PM(fm, SessionController.ConnectionString);
            return ds;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void BindGrid()
    {
        rgdocument.DataSource = GetDocuments();
        rgdocument.DataBind();
        rgdocument.Visible = true;
    }

    protected void rgdocument_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
                string CompositeKey = item.GetDataKeyValue("document_name").ToString() + item.GetDataKeyValue("entity_name").ToString();
                if (arrayList.Contains(CompositeKey))
                {
                    item.Selected = true;
                }

                Label lblEntityNames = e.Item.FindControl("lblEntityNames") as Label;
                string EntityNames = ((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[4].ToString();
                if (EntityNames.Length > 25)
                {
                    lblEntityNames.Text = EntityNames.Substring(0, 25) + " ...";
                }
                else
                {
                    lblEntityNames.Text = EntityNames;
                }

                Label lblMappingStatus = e.Item.FindControl("lblMappingStatus") as Label;
                if (lblMappingStatus != null)
                {
                    var ids = (String)item.GetDataKeyValue("pk_document_ids");
                    if (_mappingStatus.ContainsKey(ids))
                        lblMappingStatus.Text = _mappingStatus[ids];
                    else
                        lblMappingStatus.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //protected void rcbentity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    try
    //    {
    //        hf_entityid.Value = rcbentity.SelectedValue.ToString();
    //        hf_entityname.Value = rcbentity.Text;
    //        lblentityname.Text = "";
    //        hf_row_ids.Value = "";
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        GetSelectedRows();
        BindGrid();
    }
}

public class AutoMapFields
{
    public bool IsError { get; set; }
    public String Error { get; set; }

    public String DocumentIds { get; set; }
    public String DocumentName { get; set; }
    public String FilePath { get; set; }

    public Guid RowId { get; set; }
    public String RowName { get; set; }

    public String TypeName { get; set; }
    public Guid TypeId { get; set; }

    public String StageName { get; set; }
    public Guid StageId { get; set; }

    public String ApprovalByName { get; set; }
    public Guid ApprovalById { get; set; }
}
