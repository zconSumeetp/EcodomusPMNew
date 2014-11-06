using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using User;
using Telerik.Web.UI;
using EcoDomus.Session;

public partial class App_Settings_fileHistoryPopup : System.Web.UI.Page
{
    Guid FileId;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
                if (!IsPostBack)
                {
                    bindgrid();
                }
           
        }
        catch (Exception ex)
        {
 
        }

    }
   
    
    protected void bindgrid()
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();
            string p = SessionController.Users_.ProjectId.ToString();
            string fileid = Request.QueryString["fileid"].ToString();
            string facilityid = Request.QueryString["facilityid"].ToString();
            mdl.File_id = new Guid(fileid.ToString());
            mdl.Fk_facility_id = new Guid(facilityid.ToString());
            ds = BIMModelClient.GetHistoryUploadedFilesModelServerPM(mdl, SessionController.ConnectionString);
            rghistory.DataSource = ds;
            rghistory.DataBind();

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected void rghistory_pagesizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        //GetUploadedFilesPM();
        bindgrid();
    }
    protected void btn_download_Click()
    {
        try
        {
            DataSet ds = new DataSet();
            BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
            BIMModel.BIMModels mdl = new BIMModel.BIMModels();

             mdl.File_id = FileId;//new Guid(hfselected_fileid.Value);
                    ds = BIMModelClient.proc_get_file_path_by_id_for_history(mdl, SessionController.ConnectionString);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        Response.Redirect(ds.Tables[0].Rows[0]["file_path"].ToString());
                        // Server.Transfer("testfm.ecodomus.com+ds.Tables[0].Rows[0]["file_path"].ToString()));

                    }
         
          

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rghistory_OnItemCommand(object sender, GridCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Download")
            {
                FileId = new Guid((e.Item as GridDataItem).GetDataKeyValue("pk_uploaded_file_id_history").ToString());
                btn_download_Click();
            }

        }
        catch (Exception ex)
        {
 
        }
    }

    protected void rghistory_ItemDataBound(object sender, GridItemEventArgs e)
    {
        try
        {

            //GridDataItem item = ((GridNestedViewItem)e.Item).ParentItem as GridDataItem;
            //string ID = item.GetDataKeyValue("pk_facility_id").ToString();

            if (e.Item is Telerik.Web.UI.GridDataItem)
            {

                ImageButton btn_bim = e.Item.FindControl("btn_bim") as ImageButton;
                //Button btn_bim = e.Item.FindControl("btn_bim") as Button;


                //prevoious  //btn_bim.Attributes.Add("onclick", "javascript:return jump_model('" + e.Item.Cells[3].Text + "','"+e.Item.Cells[4].Text+"')");
                // btn_bim.Attributes.Add("onclick", "javascript:return jump_model('" + e.Item.Cells[3].Text + "','" + e.Item.Cells[4].Text + "','" + e.Item.Cells[8].Text + "','"+e.Item.Cells[9].Text+"')");
                btn_bim.Attributes.Add("onclick", "javascript:return jump_model('" + e.Item.Cells[2].Text + "','" + e.Item.Cells[5].Text + "','" + e.Item.Cells[6].Text + "','" + e.Item.Cells[4].Text + "')");
                //if (e.Item.Cells[11].Text == "N")
                //{

                btn_bim.Visible = true;
                //}
                //else
                //{
                //    btn_bim.Visible = false;

                //}
            }
            //if (e.Item is Telerik.Web.UI.ExpandDirection)
            //{
            //    GridDataItem item1 = ((GridNestedViewItem)e.Item).ParentItem as GridDataItem;
            //    string ID1 = item1.GetDataKeyValue("pk_facility_id").ToString();
            //}
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

}