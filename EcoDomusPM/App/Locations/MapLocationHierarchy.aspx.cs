using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using Telerik.Web.UI;
using Facility;
using System.Data;
using System.Threading;
using System.Globalization;

public partial class App_Locations_MapLocationHierarchy : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString.Count > 0)
        {
            if (SessionController.Users_.UserId != null)
            {
                

                    if (!IsPostBack)
                    {
                        BindLocationHierarchy();
                    }
                
            }
        }



    }


    //protected void IndexChange(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    //{
    //    string rcb_combo_id = ((Telerik.Web.UI.RadComboBox)(o)).SelectedItem.Owner.SelectedItem.Owner.UniqueID.ToString();
    //    string rcb_lvl = rcb_combo_id.Substring(3);
    //    string rcb_lvlno = rcb_combo_id.Substring(8);
    //    string level_no = rcb_lvl + " " + rcb_lvlno;


    //    DataSet ds;
    //    int lvl_count = 0;
    //    FacilityClient facObjClientCtrl = new FacilityClient();
    //    FacilityModel facObjFacilityModel = new FacilityModel();
    //    facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
    //    ds = facObjClientCtrl.Get_heirarchy_structure_for_facility(facObjFacilityModel, SessionController.ConnectionString);
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        lvl_count = ds.Tables[0].Rows.Count;
    //    }


    //    for (int i = 0; i < lvl_count; i++)
    //    {

    //        if (i == Convert.ToInt32(rcb_lvlno))
    //        {

    //            string hierarchy_name = ds.Tables[0].Rows[i]["hierarchy_name"].ToString();

    //        }
    //    }
 
 //  }



    protected void BindLocationHierarchy()
    {

        try
        {

            DataSet ds;
            int lvl_count = 0;
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            ds = facObjClientCtrl.Get_heirarchy_structure_for_facility(facObjFacilityModel, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lvl_count = ds.Tables[0].Rows.Count;
            }


            for (int i = 0; i < lvl_count; i++)
            {
                TableRow tr = new TableRow();
                tr = (TableRow)aspTblHierarchy.FindControl("level" + i);
                tr.Visible = true;


                TableCell tc = new TableCell();
                tc = (TableCell)aspTblHierarchy.FindControl("tc_level" + i + "_hierarchy_name");
                tc.Text = ds.Tables[0].Rows[i]["hierarchy_name"].ToString();

                DataSet ds_ddl_data = new DataSet();

                #region for_selected_index_change

                //if(i==0)
                //{
                //    if (ds.Tables[0].Rows[i]["custom_flag"].ToString() == "N")
                //    {

                      
                        
                //            FacilityClient facClient = new FacilityClient();
                //            FacilityModel facModel = new FacilityModel();
                //            facModel.TableName = ds.Tables[0].Rows[i]["db_table_name"].ToString();
                //            facModel.ConditionValue = "N";
                //            facModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                //            facModel.Pk_Hierarchy_Table_Id = new Guid(ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString());
                //            ds_ddl_data = facClient.Get_Hierarchy_Dropdown_Data(facModel, SessionController.ConnectionString);
                     



                //    }
                //    else
                //    {
                //        FacilityClient facClient = new FacilityClient();
                //        FacilityModel facModel = new FacilityModel();
                //        facModel.TableName = ds.Tables[0].Rows[i]["db_table_name"].ToString();
                //        facModel.ConditionValue = "Y";
                //        facModel.Pk_Hierarchy_Table_Id = new Guid(ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString());
                //        facModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                //        facModel.Facility_id = new Guid(SessionController.Users_.facilityID);



                //        ds_ddl_data = facClient.Get_Hierarchy_Dropdown_Data(facModel, SessionController.ConnectionString);


                //    }


                //    RadComboBox ddl = new RadComboBox();
                //    ddl = (RadComboBox)aspTblHierarchy.FindControl("rcblevel" + i);
                //    ddl.Width = 185;
                //    ddl.Height = 100;
                //    //ddl.Filter = Contains; 
                //    ddl.AutoPostBack = true;
                //    ddl.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(this.IndexChange);
   
                //    ddl.DataSource = ds_ddl_data;
                //    ddl.DataTextField = ds.Tables[0].Rows[i]["db_col_name"].ToString();
                //    ddl.DataValueField = ds.Tables[0].Rows[i]["db_col_id"].ToString();
                //    ddl.DataBind();



                //}

                //else
                //{

                //    DataTable table = new DataTable();
                //    table.Columns.Add("db_col_name", typeof(string));
                //    table.Columns.Add("db_col_id", typeof(string));


                //    table.Rows.Add("--Select--", "00000000-0000-0000-0000-000000000000");

                //    ds_ddl_data.Tables.Add(table);

                //    RadComboBox ddl = new RadComboBox();
                //    ddl = (RadComboBox)aspTblHierarchy.FindControl("rcblevel" + i);
                //    ddl.AutoPostBack = true;
                //    ddl.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(this.IndexChange);
                //    ddl.Width = 185;
                //    ddl.Height = 100;
                //    //ddl.Filter = Contains; 
                //    ddl.DataSource = ds_ddl_data;
                //    ddl.DataTextField = "db_col_name"; //ds.Tables[0].Rows[i]["db_col_name"].ToString();
                //    ddl.DataValueField = "db_col_id";//ds.Tables[0].Rows[i]["db_col_id"].ToString();
                //    ddl.DataBind();

                //}




                #endregion




                #region bind_data_on_load
                if (ds.Tables[0].Rows[i]["custom_flag"].ToString() == "N")
                {

                    //if (ds.Tables[0].Rows[i]["db_table_name"].ToString() == "vw_get_city")
                    //{

                    //}
                    //else
                    {
                        FacilityClient facClient = new FacilityClient();
                        FacilityModel facModel = new FacilityModel();
                        facModel.TableName = ds.Tables[0].Rows[i]["db_table_name"].ToString();
                        facModel.ConditionValue = "N";
                        facModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                        facModel.Pk_Hierarchy_Table_Id = new Guid(ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString());
                        ds_ddl_data = facClient.Get_Hierarchy_Dropdown_Data(facModel, SessionController.ConnectionString);
                    }



                }
                else
                {
                    FacilityClient facClient = new FacilityClient();
                    FacilityModel facModel = new FacilityModel();
                    facModel.TableName = ds.Tables[0].Rows[i]["db_table_name"].ToString();
                    facModel.ConditionValue = "Y";
                    facModel.Pk_Hierarchy_Table_Id = new Guid(ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString());
                    facModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                    facModel.Facility_id = new Guid(SessionController.Users_.facilityID);



                    ds_ddl_data = facClient.Get_Hierarchy_Dropdown_Data(facModel, SessionController.ConnectionString);


                }



                RadComboBox ddl = new RadComboBox();
                ddl = (RadComboBox)aspTblHierarchy.FindControl("rcblevel" + i);
                ddl.Width = 185;
                ddl.Height = 100;
                //ddl.Filter = Contains; 
              //  ddl.AutoPostBack = true;
               // ddl.SelectedIndexChanged += new RadComboBoxSelectedIndexChangedEventHandler(this.IndexChange);
                
                 //   ddl.EnableAutomaticLoadOnDemand=true;
              //  ddl.ItemsPerRequest=10;

                ddl.DataSource = ds_ddl_data;
                ddl.DataTextField = ds.Tables[0].Rows[i]["db_col_name"].ToString();
                ddl.DataValueField = ds.Tables[0].Rows[i]["db_col_id"].ToString();
                ddl.DataBind();






                #endregion

            


               









            }

     




        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message.ToString();

        }


    }


    protected void btn_Click_Click(object sender, EventArgs e)
    {
        DataSet ds;
        int lvl_count = 0;
        FacilityClient facObjClientCtrl = new FacilityClient();
        FacilityModel facObjFacilityModel = new FacilityModel();
        facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
        ds = facObjClientCtrl.Get_heirarchy_structure_for_facility(facObjFacilityModel, SessionController.ConnectionString);
        if (ds.Tables[0].Rows.Count > 0)
        {
            lvl_count = ds.Tables[0].Rows.Count;
        }
        //Insert_Update_Custom_Hierarchy_Relation

        string fk_parent_hierarchy_table_id="";
        string fk_parent_hierarchy_table_data_id="";
        string fk_child_hierarchy_table_id="";
        string fk_child_hierarchy_table_data_id = "";




        for (int i = 0; i < lvl_count; i++)
        {
            RadComboBox rcb = new RadComboBox();
            rcb = (RadComboBox)aspTblHierarchy.FindControl("rcblevel" + i);

           // fk_parent_hierarchy_table_id= ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();
            fk_child_hierarchy_table_id = ds.Tables[0].Rows[i]["pk_hierarchy_table_id"].ToString();
            //fk_parent_hierarchy_table_data_id=rcb.SelectedItem.Value;
            fk_child_hierarchy_table_data_id=rcb.SelectedItem.Value;

            if (i == 0)
            {
                facObjFacilityModel.Fk_parent_hierarchy_table_id = Guid.Empty;
                facObjFacilityModel.Fk_parent_hierarchy_table_data_id = Guid.Empty;
                facObjFacilityModel.Fk_child_hierarchy_table_id = new Guid(fk_child_hierarchy_table_id);
                facObjFacilityModel.Fk_child_hierarchy_table_data_id = new Guid(fk_child_hierarchy_table_data_id);
                fk_parent_hierarchy_table_id = fk_child_hierarchy_table_id;
                fk_parent_hierarchy_table_data_id = fk_child_hierarchy_table_data_id;

               
            }
            else
            {
                facObjFacilityModel.Fk_parent_hierarchy_table_id = new Guid(fk_parent_hierarchy_table_id);
                facObjFacilityModel.Fk_parent_hierarchy_table_data_id = new Guid(fk_parent_hierarchy_table_data_id);
                facObjFacilityModel.Fk_child_hierarchy_table_id = new Guid(fk_parent_hierarchy_table_id);
                facObjFacilityModel.Fk_child_hierarchy_table_data_id = new Guid(fk_parent_hierarchy_table_data_id);
               fk_parent_hierarchy_table_id= fk_parent_hierarchy_table_id;
               fk_parent_hierarchy_table_data_id = fk_parent_hierarchy_table_data_id;
            }
            facObjClientCtrl.Insert_Update_Custom_Hierarchy_Relation(facObjFacilityModel, SessionController.ConnectionString);

         }


        facObjClientCtrl.Insert_Update_Facility_Profile(facObjFacilityModel, SessionController.ConnectionString);

        string nw = "<script language='javascript'>RefreshHierarchy();</script>";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "scriptOrgId", nw);




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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }

    protected void btn_save_hierarchy_Click(object sender, EventArgs e)
    {


        
            DataSet ds;
            int lvl_count = 0;
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            ds = facObjClientCtrl.Get_heirarchy_structure_for_facility(facObjFacilityModel, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lvl_count = ds.Tables[0].Rows.Count;
            }


            for (int i = 0; i < lvl_count; i++)
            {


                RadComboBox rcb = new RadComboBox();
                rcb = (RadComboBox)aspTblHierarchy.FindControl("rcblevel" + i);

                string rcb_Text=rcb.SelectedItem.Text;
                string rcb_value = rcb.SelectedItem.Value;

              string datatext=  ds.Tables[0].Rows[i]["db_col_name"].ToString();
              string datavalue = ds.Tables[0].Rows[i]["db_col_id"].ToString();


            }
    }
}