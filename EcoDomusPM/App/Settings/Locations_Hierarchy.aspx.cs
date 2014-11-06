using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Globalization;
//using System.Windows.Forms;

public partial class App_Settings_Locations_Hierarchy : System.Web.UI.Page
{

    protected override void InitializeCulture()
    {
        string culture = Session["Culture"].ToString();
        if (culture == null)
        {
            culture = "en-US";
        }
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
    }

    //private int numOfRows = 1;
    //LocationHierarchy.ConnectionModel conObj_mdl = new LocationHierarchy.ConnectionModel();
    //DataSet ds = new DataSet();
   
  /*  protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null)
            {
                CreateClientDBConnectionObject();
                if (!IsPostBack)
                {
                    GenerateTable(numOfRows);
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }

  
    public void CreateClientDBConnectionObject()
    {
        try
        {
            conObj_mdl.ClientID = Session["Pk_clientID"].ToString();
            conObj_mdl.ServerInstance = Session["ServerInstance"].ToString();
            conObj_mdl.InitialCatalog = Session["InitialCatalog"].ToString();
            conObj_mdl.SqlUserID = Session["SqlUserID"].ToString();
            conObj_mdl.SqlPassword = Session["SqlPassword"].ToString();
            conObj_mdl.PersistSecurityInfo = Session["PersistSecurityInfo"].ToString();
            conObj_mdl.ConnectTimeout = Session["ConnectTimeout"].ToString();

        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }
    }*/

  /*  protected void Button1_Click(object sender, EventArgs e)
    {
        if (ViewState["RowsCount"] != null)
        {
            numOfRows = Convert.ToInt32(ViewState["RowsCount"].ToString());
        }
        GenerateTable(numOfRows);
    }
 
   /* private void SetPreviousData(int rowsCount, int colsCount)
    {
        Table table = (Table)Page.FindControl("Table1");
        if (table != null)
        {
            for (int i =0 ; i < rowsCount; i++)
            {
                for (int j =0 ; j < colsCount; j++)
                {
                    //Extracting the Dynamic Controls from the Table
                    //TextBox tb = (TextBox)table.Rows[i].Cells[j].FindControl("TextBoxRow_" + i + "Col_" + j);
                    
                    Label lb = (Label)table.Rows[i].Cells[j].FindControl("Level" + i);
                    DropDownList dd = (DropDownList)table.Rows[i].Cells[j].FindControl("DropDown"+i);

                    //Use Request objects for getting the previous data of the dynamic textbox
                    lb.Text = "Level" + ++i;
                }
            }
        }
    }*/


   /* private void GenerateTable(int rowsCount)
    {

        LocationHierarchyClient lc = new LocationHierarchyClient();
        ds = lc.GetHierarchyData(conObj_mdl);
        Table table = new Table();
        table.ID = "Table1";
        td1.Controls.Add(table);

        //The number of Columns to be generated
        const int colsCount = 1;//You can changed the value of 3 based on you requirements

        // Now iterate through the table and add your controls
        for (int i = 1; i <= rowsCount; i++)
        {
            TableRow row = new TableRow();
            for (int j = 1; j <= colsCount; j++)
            {

                TableCell cell = new TableCell();
                System.Web.UI.WebControls.Label lb = new System.Web.UI.WebControls.Label();
                DropDownList dd = new DropDownList();
                dd.Width = 180;
                lb.Text = "Level " + i + "\t";
                dd.DataSource = ds.Tables[0];
                dd.DataTextField = "name";
                dd.DataBind();
                dd.AutoPostBack = true;

                // Add the control to the TableCell
                cell.Controls.Add(lb);
                cell.Controls.Add(dd);

                // Add the TableCell to the TableRow
                row.Cells.Add(cell);
                dd.ID = "ddl_" + rowsCount;
                //dd.SelectedIndexChanged += new  EventHandler(my_fun());
                dd.SelectedIndexChanged += new EventHandler(my_fun);
            }
            // And finally, add the TableRow to the Table
            table.Rows.Add(row);
        }
        //Sore the current Rows Count in ViewState
        rowsCount++;
        ViewState["RowsCount"] = rowsCount;
    }

    private void my_fun(object sender, EventArgs e)
    {
        DropDownList ComboBox = (DropDownList)sender;
        /* DropDownList dd = (DropDownList)sender;
         if(dd.SelectedItem.Text=="Custom")
         {
             string Updatedvalue = "<script language='javascript'> window.location='../Settings/Add_Custom_Hierarchy_data.aspx';</script>";
             Page.ClientScript.RegisterStartupScript(this.GetType(), "script", Updatedvalue);
         }
        global::System.Windows.Forms.MessageBox.Show("Test");
    }*/
    
} 
