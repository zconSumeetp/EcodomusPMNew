using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using User;
using Telerik.Web.UI;

public partial class App_Settings_SelectOrganizationPopup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against above specified column
            rgOrganization.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            bindOrganization();
        }
        
    }

    protected void bindOrganization()
    {
            UserClient ctrl = new UserClient();
            UserModel mdl = new UserModel();
            DataSet ds = new DataSet();
            try
            {
                mdl.SearchTextOrganization = txtSearch.Text.ToString();
                ds = ctrl.bindOrganization(mdl);
                if (ds.Tables.Count > 0)
                {
                    rgOrganization.DataSource = ds;
                    rgOrganization.DataBind();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
    }


    protected void rgOrganization_SortCommand(object source, GridSortCommandEventArgs e)
    {
        bindOrganization();
    }
    
    protected void rgOrganization_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        bindOrganization();
    }

    protected void rgOrganization_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        bindOrganization();
    }

    protected void rgOrganization_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    { 

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindOrganization();
    }

    protected void btnSelectOrganization_Click(object sender, EventArgs e)
    {
        string id = "", name = "";
        try
        {
            if (rgOrganization.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rgOrganization.SelectedItems.Count; i++)
                {
                    id = id + rgOrganization.SelectedItems[i].Cells[2].Text + ",";
                    name = name + rgOrganization.SelectedItems[i].Cells[4].Text + ",";
                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);

                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>Update_UserProfile('" + id + "','" + name + "')</script>", false);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>closewindow();</script>", false);
            }
        }
        catch(Exception ex)
        {
            throw ex;
        }
    }

}