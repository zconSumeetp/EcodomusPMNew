using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using TypeProfile;
using EcoDomus.Session;
using Telerik.Web.UI;

public partial class App_Asset_ResourePopup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                this.Header.DataBind();
                if (!(IsPostBack))
                {
                    if (hf_is_loaded.Value.Equals("No"))
                    {
                        hftype_id.Value = Convert.ToString((Convert.ToString(Request.QueryString["pk_type_id"])));
                        hf_resource_ids.Value = Convert.ToString((Convert.ToString(Request.QueryString["hf_resource_ids"])));
                        if (Request.QueryString["edit"] == "edit")
                        {
                            hf_jobedit.Value = "edit";
                        }
                        else
                        {
                            hf_resource_ids.Value = "";
                        }
                        BindResources(new Guid(hftype_id.Value));
                        // Page.ClientScript.RegisterStartupScript(GetType(), "manage_height", "adjust_height();", true);
                        hf_is_loaded.Value = "Yes";
                    }
                }
               // ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_frame_height();", true);
              
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>LogoutNavigation();</script>", false);

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    private void BindResources(Guid type_id)
    {
        DataSet ds = new DataSet();
        TypeModel mdl = new TypeModel();
        TypeProfileClient ctl = new TypeProfileClient();
        mdl.Type_Id = type_id;
        mdl.Txt_Search = txtSearch.Text;
        mdl.Type_Id = type_id;
        ds = ctl.proc_get_types_resources(mdl, SessionController.ConnectionString);
        rg_Resources.DataSource = ds;
        rg_Resources.DataBind();
     
    }
    protected void btnAssign_Click(object sender, EventArgs e)
    {

        System.Text.StringBuilder strResourceIds = new System.Text.StringBuilder();
        System.Text.StringBuilder strResourceNames = new System.Text.StringBuilder();
        for (int i = 0; i < rg_Resources.SelectedItems.Count; i++)
        {
            strResourceIds.Append(rg_Resources.SelectedItems[i].Cells[6].Text);
            strResourceIds.Append(",");
            strResourceNames.Append(rg_Resources.SelectedItems[i].Cells[3].Text);
            strResourceNames.Append(",");
        }

        if (strResourceIds.Length > 0)
        {
            strResourceIds = strResourceIds.Remove(strResourceIds.ToString().Length - 1, 1);
        }
        if (strResourceNames.Length > 0)
        {
            strResourceNames = strResourceNames.Remove(strResourceNames.ToString().Length - 1, 1);
        }

        string all_resourceIds = strResourceIds.ToString();
        string all_resourceNames = strResourceNames.ToString();
       // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Resource('" + all_resourceIds + "','" + all_resourceNames + "')</script>", false); 

    }
    protected void rg_Resources_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindResources(new Guid(hftype_id.Value));

    }
    protected void rg_Resources_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindResources(new Guid(hftype_id.Value));
    }
    protected void rg_Resources_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindResources(new Guid(hftype_id.Value));
    }
    protected void rg_Resources_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
            {
                GridDataItem item = (GridDataItem)e.Item;
              //  hf_resource_ids.Value = hf_resource_ids.Value + item["pk_resource_id"].Text;
                if (hf_resource_ids.Value.Contains(item["pk_resource_id"].Text.ToUpper()))
           {

               e.Item.Selected = true;
              

           }
            }
    }
    protected void btn_searchimg_Click(object sender, ImageClickEventArgs e)
    {

        BindResources(new Guid(hftype_id.Value));
    }
}