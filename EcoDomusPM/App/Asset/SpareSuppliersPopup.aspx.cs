using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using TypeProfile;
using Telerik.Web.UI;

public partial class App_Asset_SpareSuppliersPopup : System.Web.UI.Page
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
                        BindSupplier();
                    
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "adjust_frame_height();", true);

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
   
    public void BindSupplier()
    {
        try
        {
            DataSet ds = new DataSet();
            TypeModel mdl = new TypeModel();
            TypeProfileClient ctrl = new TypeProfileClient();
            mdl.Organization_Id = Guid.Empty;
            mdl.Txt_Search = txtSearch.Text;
            ds = ctrl.Get_suppliers(mdl, SessionController.ConnectionString);
            rg_suppliers.DataSource = ds;
            rg_suppliers.DataBind();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btn_searchimg_Click(object sender, ImageClickEventArgs e)
    {

        BindSupplier();
    }
    protected void btnAssign_Click(object sender, EventArgs e)
    {

        System.Text.StringBuilder strResourceIds = new System.Text.StringBuilder();
        System.Text.StringBuilder strResourceNames = new System.Text.StringBuilder();
        for (int i = 0; i < rg_suppliers.SelectedItems.Count; i++)
        {
            strResourceIds.Append(rg_suppliers.SelectedItems[i].Cells[4].Text);
            strResourceIds.Append(",");
            strResourceNames.Append(rg_suppliers.SelectedItems[i].Cells[3].Text);
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
        //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>select_Resource('" + all_resourceIds + "','" + all_resourceNames + "')</script>", false);

    }
    protected void rg_Resources_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindSupplier();

    }
    protected void rg_Resources_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindSupplier();
    }
    protected void rg_Resources_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindSupplier();
    }
    protected void rg_Resources_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            //  hf_resource_ids.Value = hf_resource_ids.Value + item["pk_resource_id"].Text;
            //if (hf_resource_ids.Value.Contains(item["pk_resource_id"].Text.ToUpper()))
            //{

            //    e.Item.Selected = true;


            //}
        }
    }
}