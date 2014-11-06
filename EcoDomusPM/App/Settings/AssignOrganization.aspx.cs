using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI;
using Project;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;

public partial class App_Settings_AssignOrganization : System.Web.UI.Page
{
    CryptoHelper crypt = new CryptoHelper();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            rgOrganizations.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            DataTable tbl = new DataTable();
            rgOrganizations.DataSource = tbl;
            rgOrganizations.DataBind();            
        }
    }

    protected void BindOrganizations(string search_string)
    {
        DataSet ds = new DataSet();    
        ProjectModel pm=new ProjectModel();
        ProjectClient pc = new ProjectClient();
        try
        {          
            pm.Organization_id =new Guid(SessionController.Users_.OrganizationID);
            pm.Organization_Name = search_string;
            ds = pc.GetOrganizationsForProjects(pm, SessionController.ConnectionString);
            rgOrganizations.DataSource = ds;
            rgOrganizations.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write("BindOrganizations :- " + ex.Message.ToString());
        }
    }


    protected void btnSearch_Click1(object sender, EventArgs e)
    {
        try
        {
            BindOrganizations("%" + txtSearchOrganization.Text.Trim() + "%");
            ViewState["str"] = "%" + txtSearchOrganization.Text.Trim() + "%";
        }
        catch (Exception ex)
        {
            Response.Write("btnSearch_Click :- " + ex.Message.ToString());
        }
    }


    public void rgOrganizations_ItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {
            if (e.Item is GridCommandItem)
            {

                GridCommandItem commandItem = (e.Item as GridCommandItem);
                PlaceHolder container = (PlaceHolder)commandItem.FindControl("PlaceHolder1");

                for (int i = 65; i <= 65 + 25; i++)
                {
                    LinkButton linkButton1 = new LinkButton();
                    LiteralControl lc = new LiteralControl("&nbsp;&nbsp;");

                    linkButton1.Text = "" + (char)i;

                    linkButton1.CommandName = "alpha";
                    linkButton1.CommandArgument = "" + (char)i;

                    container.Controls.Add(linkButton1);
                    container.Controls.Add(lc);
                }

                LiteralControl lcLast = new LiteralControl("&nbsp;");
                container.Controls.Add(lcLast);

                LinkButton linkButtonAll = new LinkButton();
                linkButtonAll.Text = "All";
                linkButtonAll.CommandName = "NoFilter";
                container.Controls.Add(linkButtonAll);
            }

        }
        catch (Exception ex)
        {
            Response.Write("Settings_AssignOrganization:rgOrganizations_ItemCreated :_" + ex.Message.ToString());
        }
    }

    public void rgOrganizations_ItemCommand(object source, Telerik.Web.UI.GridCommandEventArgs e)
    {
        try
        {

            string value = null;
            switch (e.CommandName)
            {
                case ("alpha"):
                    {
                        value = string.Format("{0}%", e.CommandArgument);
                        break;
                    }
                case ("NoFilter"):
                    {
                        value = "%";
                        break;
                    }
            }
            if (value == null)
            {
                value = (string)ViewState["str"];
            }
            else
                ViewState["str"] = value.ToString();
            BindOrganizations(value);
        }
        catch (Exception ex)
        {
            Response.Redirect("Settings_AssignOrganization : rgOrganizations_ItemCommand " + ex.Message.ToString());
        }      
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        string value = "";
        try
        {
            if (rgOrganizations.SelectedValue != null)
            {
                string id = rgOrganizations.SelectedValue.ToString();
                string name = rgOrganizations.Items[rgOrganizations.SelectedIndexes[0]].Cells[4].Text;
               
                if (Request.QueryString["type"] == "L")
                {
                    value = "L";
                    ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>selectedPP('" + id + "','" + name + "','" + value + "');</script>");
                }
                else
                {
                    value = "O";
                    ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>selectedPP('" + id + "','" + name + "','" + value + "');</script>");
                }
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>closewindow();</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("btnClose_Click :-" + ex.Message.ToString());
        }
    }
}

