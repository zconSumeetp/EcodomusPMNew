using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using TypeProfile;
using Facility;
using System.Collections;
using Asset;

public partial class Select_Entity_PM : System.Web.UI.Page
{
    public List<string> EntityIds
    {
        get
        {
            if (ViewState["EntityIds"] == null)
            {
                ViewState["EntityIds"] = new List<string>();
            }
            return (List<string>)ViewState["EntityIds"];
        }
        set
        {
            ViewState["EntityIds"] = value;
        }
    }

    public List<string> EntityNames
    {
        get
        {
            if (ViewState["EntityNames"] == null)
            {
                ViewState["EntityNames"] = new List<string>();
            }
            return (List<string>)ViewState["EntityNames"];
        }
        set
        {
            ViewState["EntityNames"] = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null && SessionController.Users_.UserId != string.Empty)
            {
                if (!IsPostBack)
                {
                    if (Request.QueryString["row_ids"] != null)
                    {
                        if (!Convert.ToString(Request.QueryString["row_ids"]).Equals(string.Empty))
                        {
                            hf_Entity_ids.Value = Request.QueryString["row_ids"].ToString();
                            hf_row_ids.Value = hf_Entity_ids.Value;
                            EntityIds = new List<string>(hf_Entity_ids.Value.ToUpper().Split(','));
                        }
                    }
                    if (Request.QueryString["row_name"] != null)
                    {
                        if (!Convert.ToString(Request.QueryString["row_name"]).Equals(string.Empty))
                        {
                            hf_Entity_Names.Value = Request.QueryString["row_name"].ToString();
                            EntityNames = new List<string>(hf_Entity_Names.Value.Split(','));

                            for(int i=0; i<EntityNames.Count;++i)
                            {
                                EntityNames[i] = EntityNames[i].Trim();
                            }
                        }
                    }
                    if (Request.QueryString["facilityid"] != null)
                    {
                        if (!Convert.ToString(Request.QueryString["facilityid"]).Equals(string.Empty))
                        {
                            hf_facility_id.Value = Request.QueryString["facilityid"].ToString();
                        }
                    }

                    GridSortExpression sortExpr = new GridSortExpression();
                    sortExpr.FieldName = "asset_name";
                    sortExpr.SortOrder = GridSortOrder.Ascending;
                    //Add sort expression, which will sort against first column
                    rgentity.MasterTableView.SortExpressions.AddSortExpression(sortExpr);

                    if (Request.QueryString["entityname"] == "Type")
                    {
                        //lblType.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>setTitle('" + (string)GetGlobalResourceObject("Resource", "Select") + " " + (string)GetGlobalResourceObject("Resource", "Type") + "');</script>");
                    }
                    if (Request.QueryString["entityname"] == "Component")
                    {
                        rgentity.AllowCustomPaging = true;
                        ViewState["PageSize"] = 10;
                        ViewState["PageIndex"] = 0;
                        ViewState["SortExpression"] = "asset_name";  // This is for assetname
                        //lblComponent.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>setTitle('" + (string)GetGlobalResourceObject("Resource", "Select") + " " + (string)GetGlobalResourceObject("Resource", "Component") + "');</script>");
                    }
                    if (Request.QueryString["entityname"] == "System")
                    {
                        //lblSystem.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>setTitle('" + (string)GetGlobalResourceObject("Resource", "Select") + " " + (string)GetGlobalResourceObject("Resource", "System") + "');</script>");
                    }
                    if (Request.QueryString["entityname"] == "Facility")
                    {
                        //lblFacility.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>setTitle('" + (string)GetGlobalResourceObject("Resource", "Select") + " " + (string)GetGlobalResourceObject("Resource", "Facility") + "');</script>");
                    }
                    if (Request.QueryString["entityname"] == "Floor")
                    {
                        //lblFloor.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>setTitle('" + (string)GetGlobalResourceObject("Resource", "Select") + " " + (string)GetGlobalResourceObject("Resource", "Floor") + "');</script>");
                    }
                    if (Request.QueryString["entityname"] == "Space")
                    {
                        //lblSpace.Visible = true;
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>setTitle('" + (string)GetGlobalResourceObject("Resource", "Select") + " " + (string)GetGlobalResourceObject("Resource", "Space") + "');</script>");
                    }
                    BindGrid();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        GetNewSelectedRows();
        if (Request.QueryString["entityname"] == "Component")
        {
            ViewState["PageIndex"] = 0;
        }
        BindGrid();
    }

    protected void BindGrid()
    {
        try
        {
            DataSet ds_Search_assets = new DataSet();

            if (Request.QueryString["entityname"] == "Component")
            {
                AssetModel objloc_mdl = new AssetModel();
                AssetClient objloc_crtl = new AssetClient();
                DataSet ds_ComponentCount = new DataSet();

                objloc_mdl.CriteriaText = txtcriteria.Text;
                objloc_mdl.FacilityNames = hf_facility_id.Value;
                ds_ComponentCount = objloc_crtl.Get_Component_Count(SessionController.ConnectionString, objloc_mdl);

                rgentity.VirtualItemCount = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());
                ViewState["ComponentCount"] = Int32.Parse(ds_ComponentCount.Tables[0].Rows[0]["Cnt"].ToString());

                objloc_mdl.Pagesize = Int32.Parse(ViewState["PageSize"].ToString());
                objloc_mdl.Pageindex = Int32.Parse(ViewState["PageIndex"].ToString());
                objloc_mdl.Orderby = ViewState["SortExpression"].ToString();
                ds_Search_assets = objloc_crtl.GetComponentsForBulkUpload(SessionController.ConnectionString, objloc_mdl);
                rgentity.DataSource = ds_Search_assets;
                rgentity.DataBind();

            }
            else
            {
                FacilityClient facctrl = new FacilityClient();
                FacilityModel facmdl = new FacilityModel();
                if (hf_facility_id.Value == "")
                {
                    facmdl.Facility_id = Guid.Empty;
                }
                else
                {
                    facmdl.Facility_id = new Guid(hf_facility_id.Value);
                }
                facmdl.Entity_id = new Guid(Request.QueryString["entityflag"].ToString());
                facmdl.Search_text_name = txtcriteria.Text;
                ds_Search_assets = facctrl.BindGridForSelectedEntity(facmdl, SessionController.ConnectionString);
                rgentity.DataSource = ds_Search_assets;
                rgentity.DataBind();

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgentity_OnItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Item)
        {
            GridDataItem item = (GridDataItem)e.Item;
            item.Selected = EntityIds.Contains(item.GetDataKeyValue("id").ToString().ToUpper());
        }
    }

    protected void btnAssign_Click(object sender, EventArgs e)
    {
        try
        {
            GetNewSelectedRows();

            string id = String.Join(",", EntityIds.Select(x => x.ToString()).ToArray());
            string name = String.Join(",", EntityNames.Select(x => x.ToString()).ToArray());
            if (id.StartsWith(","))
            {
                id = id.Remove(0, 1);
            }
            if (name.StartsWith(","))
            {
                name = name.Remove(0, 1);
            }

            name = name.Replace("'", "\\'");

            if (id != string.Empty)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>selectfacilityForType('" + id + "','" + name + "','" + hf_row_ids.Value + "');</script>");
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

    protected void rgentity_OnPageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            GetNewSelectedRows();
            if (Request.QueryString["entityname"] == "Component")
            {
                ViewState["PageIndex"] = e.NewPageIndex;
            }
            BindGrid();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgentity_OnPageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetNewSelectedRows();
            if (Request.QueryString["entityname"] == "Component")
            {
                if (e.NewPageSize != 10 && e.NewPageSize != 20 && e.NewPageSize != 50)
                {
                    ViewState["PageSize"] = 0;
                    ViewState["PageIndex"] = 0;

                }
                else
                {
                    ViewState["PageSize"] = e.NewPageSize;
                    int compo_count = Int32.Parse(ViewState["ComponentCount"].ToString());
                    int page_size = Int32.Parse(ViewState["PageSize"].ToString());
                    int page_index = Int32.Parse(ViewState["PageIndex"].ToString());
                    int maxpg_index = (compo_count / page_size) + 1;
                    if (page_index >= maxpg_index)
                    {
                        ViewState["PageIndex"] = 0;
                    }
                }
            }
            BindGrid();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void rgentity_OnSortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            if (Request.QueryString["entityname"] == "Component")
            {
                ViewState["SortExpression"] = e.SortExpression;
                if (e.NewSortOrder.ToString() == "Descending")
                {
                    ViewState["SortExpression"] = ViewState["SortExpression"].ToString() + " DESC";
                }
            }
            BindGrid();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void GetNewSelectedRows()
    {
        foreach (GridDataItem item in rgentity.Items)
        {
            if (EntityIds.Contains(item.GetDataKeyValue("id").ToString().ToUpper()) && !item.Selected)
            {
                EntityIds.Remove(item.GetDataKeyValue("id").ToString().ToUpper());
                EntityNames.Remove(item.GetDataKeyValue("asset_name").ToString());
            }
            else if (!EntityIds.Contains(item.GetDataKeyValue("id").ToString().ToUpper()) && item.Selected)
            {
                EntityIds.Add(item.GetDataKeyValue("id").ToString().Trim().ToUpper());
                EntityNames.Add(item.GetDataKeyValue("asset_name").ToString().Trim());
            }
        }
    }
}