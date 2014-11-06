using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using Telerik.Web.UI;
using TypeProfile;
using EcoDomus.Session;

public partial class App_Asset_Unassign : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            load_data();

        }
    }
    protected void load_data()
    {
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();

        DataColumn column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Unassign_Items";
        dt.Columns.Add(column);
        dt.Rows.Add("Designer");
        dt.Rows.Add("Contractor");
        dt.Rows.Add("MasterFormat");
        dt.Rows.Add("UniFormat");
        dt.Rows.Add("OmniClass");
        ds.Tables.Add(dt);
        rg_unassign.DataSource = ds;
        rg_unassign.DataBind();
    }

    protected void system_grid_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
    {

    }

    protected void btn_unassign_Click(object sender, EventArgs e)
    {
        try
        {
            TypeModel tm = new TypeModel();
            TypeProfileClient tc = new TypeProfileClient();                   

            string type_ids = Request.QueryString["type_id"].ToString();
            type_ids = type_ids.Remove(type_ids.Length - 1, 1);


            for (int i = 0; i < rg_unassign.SelectedItems.Count; i++)
            {
                if (rg_unassign.SelectedItems[i].Cells[3].Text == "Designer")
                {
                    tm.Designer = "d";
                }

                if (rg_unassign.SelectedItems[i].Cells[3].Text == "Contractor")
                {
                    tm.Contractor = "c";
                }
                /*----------------------Masterformat uniformat omniclass----------------------------*/
                if (rg_unassign.SelectedItems[i].Cells[3].Text == "MasterFormat")
                {
                    tm.Masterformat = "m";
                }

                if (rg_unassign.SelectedItems[i].Cells[3].Text == "UniFormat")
                {
                    tm.Uniformat = "u";
                }

                if (rg_unassign.SelectedItems[i].Cells[3].Text == "OmniClass")
                {
                    tm.Omniclass = "o";
                }
            }
            tm.Type_Ids = type_ids;

            tc.Unassign(tm, SessionController.ConnectionString);           

            ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>refreshParent()</script>");
           


        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }

    }


    protected void rg_unassign_OnSortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            load_data();
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
    }
}