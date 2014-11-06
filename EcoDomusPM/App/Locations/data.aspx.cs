using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using Facility;
using EcoDomus.Session;

public partial class App_Locations_data : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {




        if (!IsPostBack)
        {
            //BindHierarchyStructure()
            BindHierarchyData();
        }





    }

    protected void BindHierarchyStructure(DataSet ds)
    {

        try
        {

            HtmlGenericControl div1 = new HtmlGenericControl("div");
            div1.ID = "divHierarchy";
            // add whatever attributes you need, eg make it scrollable:
            //  div1.Attributes["style"] = "overflow: auto; width: 400px; height: 150px;";

            // initialize your table
            HtmlTable table1 = new HtmlTable();
            table1.ID = "tblHeirarchy";

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (ds.Tables[0].Rows[i]["custom_flag"].ToString() == "Y")
                {


                    HtmlTableRow tr = new HtmlTableRow();
                    tr.ID = "tr_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();

                    HtmlTableCell tc = new HtmlTableCell();
                    tc.ID = "tc_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();

                    HtmlTableCell tc_ddl = new HtmlTableCell();
                    tc_ddl.ID = "tc_ddl_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();


                    Label lbl = new Label();
                    lbl.ID = "lbl" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();
                    lbl.Text = ds.Tables[0].Rows[i]["custom_hierarchy_data_name"].ToString();


                    DropDownList ddl = new DropDownList();
                    ddl.ID = "ddl_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();

                    tc.Controls.Add(lbl);
                    tc.Controls.Add(ddl);
                    tr.Cells.Add(tc);
                    table1.Rows.Add(tr);
                }
                else
                {
                    

                    HtmlTableRow tr = new HtmlTableRow();
                    tr.ID = "tr_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();

                    HtmlTableCell tc = new HtmlTableCell();
                    tc.ID = "tc_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();

                    HtmlTableCell tc_ddl = new HtmlTableCell();
                    tc_ddl.ID = "tc_ddl_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();


                    Label lbl = new Label();
                    lbl.ID = "lbl" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();
                    lbl.Text = ds.Tables[0].Rows[i]["hierarchy_name"].ToString();


                    DropDownList ddl = new DropDownList();
                    ddl.ID = "ddl_" + ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString() ;

                    tc.Controls.Add(lbl);
                    tc.Controls.Add(ddl);
                    tr.Cells.Add(tc);
                    table1.Rows.Add(tr);

                }
            }





            // add the table to the div:
            div1.Controls.Add(table1);
            panel_data.Controls.Add(div1);


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }


    protected void BindHierarchyData()
    {

        DataSet ds = new DataSet();




        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        // facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
        ds = facObjClientCtrl.Get_Hierarchy_Data(facObjFacilityModel, SessionController.ConnectionString);

        if (ds.Tables[0].Rows.Count > 0)
        {
            BindHierarchyStructure(ds);

        }




    }
}