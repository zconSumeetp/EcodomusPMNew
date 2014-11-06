using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Facility;
using LocationHierarchy;
using System.Data;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Globalization;
using System.Threading;



public partial class App_Locations_SetLocationHierarchy : System.Web.UI.Page
{

    private const int ItemsPerRequest = 10;
    protected void Page_Load(object sender, EventArgs e)    {
        
            BindLocationHierarchy();
       
    }

   protected void BindLocationHierarchy()
    {
        DataSet ds;
        int lvl_count = 0;
        int i, j;
        try
        {
            FacilityClient facObjClientCtrl = new FacilityClient();
            FacilityModel facObjFacilityModel = new FacilityModel();
            facObjFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
            ds = facObjClientCtrl.Get_hierarchy_for_facility_profile(facObjFacilityModel, SessionController.ConnectionString);
            ViewState["hierarchy_level_cnt"] = ds.Tables[0].Rows.Count;


            if (ds.Tables[0].Rows.Count > 0)
            {
                lvl_count = ds.Tables[0].Rows.Count;
            }

            for (i = 0; i < lvl_count; i++)
            {
                TableRow tr = new TableRow();
                for (j = 1; j <= 2; j++)
                {
                    TableCell td = new TableCell();
                    switch (j)
                    {
                        case 1:
                            td.Text = ds.Tables[0].Rows[i]["hierarchy_name"].ToString() + ":";
                            td.Style.Add("font-weight", "bold");
                            td.CssClass = "Label";
                            break;
                        case 2:
                            RadComboBox rcb = new RadComboBox();
                            rcb.ValidationGroup = ds.Tables[0].Rows[i]["hierarchy_id"].ToString();
                            if (ds.Tables[0].Rows[i]["hierarchy_data_name"].ToString()!=string.Empty)
                            {
                                  rcb.Items.Add(new RadComboBoxItem(ds.Tables[0].Rows[i]["hierarchy_data_Name"].ToString(), ds.Tables[0].Rows[i]["hierarchy_data_id"].ToString()));
                                  rcb.SelectedIndex = 0;
                                
                            }
                            
                            rcb.ID = "rcb_" + i.ToString();
                            SetComboBoxSetting(rcb, ds.Tables[0].Rows[i]["hierarchy_name"].ToString());
                            td.Controls.Add(rcb);
                            break;
                        default:
                            break;
                    }
                    tr.Controls.Add(td);
                }
                tblHierarchy.Controls.Add(tr);
            }

         
        }
        catch (Exception)
        {


        }
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

           //redirect_page("~\\app\\LoginPM.aspx?Error=Session");
           ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "LogoutNavigation();", true);
       }

   }

   protected void bindComboBox(RadComboBox rcb, string pk_hierarchy_table_id)   {
       
       LocationsHierarchyClient objLocationsHierarchyClient = new LocationsHierarchyClient();
       LocationHierrachyModel objLocationHierrachyModel = new LocationHierrachyModel();
       DataSet ds = new DataSet();
       try
       {
           objLocationHierrachyModel.pk_hierarchy_table_id = pk_hierarchy_table_id;

           ds = objLocationsHierarchyClient.proc_get_hierarchy_level_data(objLocationHierrachyModel, SessionController.ConnectionString);
           rcb.DataSource = ds;
           rcb.DataTextField = "hierarchy_data_Name";
           rcb.DataValueField = "hierarchy_data_id";
           rcb.DataBind();
       }
       catch (Exception)
       {
           
           throw;
       }
   }

   protected void SetComboBoxSetting(RadComboBox rcb, string DefaultVal)
   {
       try
       {
           rcb.ItemsRequested += new RadComboBoxItemsRequestedEventHandler(rcb_ItemsRequested);
           rcb.Width = 250;
           rcb.Height = 150;
           rcb.EnableLoadOnDemand = true;
           //rcb.AutoPostBack = true;
           rcb.MarkFirstMatch = true;
           //rcb.ItemsPerRequest = 10;
           rcb.ShowMoreResultsBox = true;
           rcb.EnableVirtualScrolling = true;
           rcb.EmptyMessage = "Select a " + DefaultVal;

       }
       catch (Exception)
       {
           
           throw;
       }
   }


   protected void rcb_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
   {
       try 
	    {	        
		
           DataSet data = new DataSet();
           LocationsHierarchyClient objLocationsHierarchyClient = new LocationsHierarchyClient();
           LocationHierrachyModel objLocationHierrachyModel = new LocationHierrachyModel();
          
           RadComboBox rcb = (RadComboBox)sender;
           objLocationHierrachyModel.pk_hierarchy_table_id = rcb.ValidationGroup.ToString();
           objLocationHierrachyModel.hierarchy_data_text = e.Text;
           data = objLocationsHierarchyClient.proc_get_hierarchy_level_data(objLocationHierrachyModel, SessionController.ConnectionString);



            int itemOffset = e.NumberOfItems;
           int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Tables[0].Rows.Count);

           e.EndOfItems = endOffset == data.Tables[0].Rows.Count;

           for (int i = itemOffset; i < endOffset; i++)
           {
               RadComboBoxItem item = new RadComboBoxItem(data.Tables[0].Rows[i]["hierarchy_data_Name"].ToString(), data.Tables[0].Rows[i]["hierarchy_data_id"].ToString());
               if (item.Value !=rcb.SelectedValue)
               {
                   rcb.Items.Add(item);
               }
           }

           e.Message = GetStatusMessage(endOffset, data.Tables[0].Rows.Count);
       }
	    catch (Exception)
	    {
		
		    throw;
	    }
   }

   private static string GetStatusMessage(int offset, int total)
   {
       if (total <= 0)
           return "No matches";

       return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
   }
   protected void btn_save_hierarchy_Click(object sender, EventArgs e)
   {
       int hierarchy_level;
       int hierarchy_level_cnt = Convert.ToInt32(ViewState["hierarchy_level_cnt"]);
       Table tbl = (Table)this.FindControl("tblHierarchy");
       FacilityClient objFacilityClient = new FacilityClient();
       FacilityModel objFacilityModel = new FacilityModel();
       try
       {
           for (int i=0;i<hierarchy_level_cnt;i++)
           {
               RadComboBox rcb = new RadComboBox();
                hierarchy_level = (i + 1);
               rcb = (RadComboBox)tbl.Rows[i].FindControl("rcb_" + i.ToString());
               if (rcb.SelectedValue != string.Empty)
               {
                   objFacilityModel.hierarchy_level = hierarchy_level;
                   objFacilityModel.Facility_id = new Guid(SessionController.Users_.facilityID);
                   objFacilityModel.Fk_child_hierarchy_table_id = new Guid(rcb.SelectedValue);
                   objFacilityClient.Insert_Update_Hierarchy_Facility(objFacilityModel, SessionController.ConnectionString);
                   ScriptManager.RegisterStartupScript(this, this.GetType(), "key", "javascript:closeWindow_assign();", true);
               }
              
           }
       }
       catch (Exception)
       {
           
           
       }
   }
}