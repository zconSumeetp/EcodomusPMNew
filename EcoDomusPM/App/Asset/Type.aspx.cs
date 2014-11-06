using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using System.Data;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Asset_Type : System.Web.UI.Page
{
    Guid type_id;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                //Telerik.Web.UI.RadComboBox cmbFacility = (Telerik.Web.UI.RadComboBox)UCComboFacility1.FindControl("cmbFacility");
                //if (cmbFacility.Items.Count == 0)
                //{
                //    cmbFacility.Items.Add(new Telerik.Web.UI.RadComboBoxItem());
                //}
                //if (!Page.IsPostBack)
                //{
                //    //App_UserControls_UserControlComboFacility uld = new App_UserControls_UserControlComboFacility();
                //    //uld.Load ld += new EventHandler(Page_Load);
                //    //uld.Load  ld = new EventHandler(Page_Load);

                //    //ld();
                //    //UCComboFacility1
                //    BindTypes();
                //}
            }
            else
            {
                Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
            }
        }
        catch (Exception ex)
        {
           
            lblMsg.Text = "Page_Load:" + ex.ToString();
        }
    }

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

    protected void Page_Prerender(object sender, EventArgs e)
    {
        //RadComboBox objComboBox = (RadComboBox)UCComboFacility1.FindControl("cmbFacility");
        //if (SessionController.Users_.IsFacility == "yes")
        //{

        //    objComboBox.SelectedValue = SessionController.Users_.facilityID;
        //    objComboBox.Enabled = false;
        //}
        //else
        //{

        //    objComboBox.Enabled = true;
        //}
       if (!Page.IsPostBack)
       {
            GridSortExpression sortExpr = new GridSortExpression();
            sortExpr.FieldName = "name";
            sortExpr.SortOrder = GridSortOrder.Ascending;
            //Add sort expression, which will sort against first column
            RgTypes.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
            BindTypes();
       }
       else if (Request.Params.Get("__EVENTTARGET") == "ctl00$chkfacility")
       {
           BindTypes();

       }
       
    }
    private void BindTypes()
    {
        DataSet ds = new DataSet();
        TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
        TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();

        if (cmbcriteria.SelectedItem.Text == "Name")
        {
            mdl.Txt_criteria = "N";
        }
        else
        {
            mdl.Txt_criteria = "D";
        }
        //mdl.Txt_criteria=cmbcriteria.SelectedItem.Text;
        mdl.Txt_Search=txtsearch.Text;

        Telerik.Web.UI.RadComboBox objCmbFacility = (Telerik.Web.UI.RadComboBox)UCComboFacility1.FindControl("cmbFacility");
        string fac_ids="";
        System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
        foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in objCmbFacility.Items)
        {
            Telerik.Web.UI.RadTreeView objRadTreeView = (Telerik.Web.UI.RadTreeView)rcbItem.FindControl("rtvFacilities");
            
            foreach (Telerik.Web.UI.RadTreeNode CheckedNode in objRadTreeView.CheckedNodes)
            {

                fac_ids = fac_ids + CheckedNode.Value + ","; 
               
            }
            if (fac_ids.Length > 0)
            {
                fac_ids = fac_ids.Substring(0, fac_ids.Length - 1);
            }
            
        }
        
        mdl.Facility_Ids = fac_ids.ToString();
        mdl.User_id = new Guid(SessionController.Users_.UserId);
        mdl.System_Role = SessionController.Users_.UserSystemRole;
        mdl.ClientId = new Guid(SessionController.Users_.ClientID);
        mdl.Organization_Id = new Guid(SessionController.Users_.OrganizationID);
        ds = TypeClient.GetTypeList(mdl, SessionController.ConnectionString);
        RgTypes.DataSource = ds;
        RgTypes.DataBind();
        //if(ds.Tables[0].Rows[0]["ismajor"].Equals('Y'))
        //{
            
            
        //}
    }


    protected void navigate(object sender, EventArgs e)
    {
        SessionController.Users_.facilityID = hf_facility_id.Value.ToString();
        Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId=" + SessionController.Users_.facilityID, false);
    }
    protected void OnItemCommand_RgTypes(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        if (e.CommandName == "EditType")
        {

            string type_id;
            type_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["type_id"].ToString();
            Response.Redirect("~/App/Asset/TypeProfileMenu.aspx?type_id=" + type_id.ToString(), false);
            //Response.Redirect("OrganizationProfile.aspx");
        }
        if (e.CommandName == "RemoveType")
        {
            
            string type_id;
            type_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["type_id"].ToString();
            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            mdl.Type_Id = new Guid(type_id);
            TypeClient.DeleteType(mdl, SessionController.ConnectionString);
            BindTypes();
            
        }
        if (e.CommandName == "EditFacility")
        {
            string facility_id;
            facility_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["facility_id"].ToString();
            Response.Redirect("~/App/Locations/FacilityMenu.aspx?FacilityId==" + facility_id.ToString(), false);
          
        }
        
    }
    protected void btnAddType_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/Asset/TypeProfileMenu.aspx?type_id=00000000-0000-0000-0000-000000000000",false);
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        BindTypes();
    }
    protected void RgTypes_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        BindTypes();
    }
    protected void RgTypes_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        BindTypes();
    }
    protected void RgTypes_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        BindTypes();
    }
    protected void RgTypes_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
       

        if (e.Item is Telerik.Web.UI.GridDataItem)
        {

            CheckBox chkmajor = e.Item.FindControl("chkMajor") as CheckBox;
            GridDataItem item = (GridDataItem)e.Item;

            //if (((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[6].ToString() == "Y")
            //{
            //    chkmajor.Checked = true;
            //}
            if (((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[5].ToString() == "Y")
            {
                chkmajor.Checked = true;
            }

        }
    }
    protected void cmbcriteria_SelectedIndexChanged(object o, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        BindTypes();

    }
    protected void btnAssignMajor_Click(object sender, EventArgs e)
    {

        foreach (GridDataItem row in RgTypes.Items)
        {
            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();

            CheckBox ch = new CheckBox();
            ch = row.FindControl("chkmajor") as CheckBox;
            if (ch.Checked)
            {
                mdl.Type_Id=new Guid( row.GetDataKeyValue("type_id").ToString());
                mdl.IsMajor = "Y";
                TypeClient.InsertUpdateMajorTypes(mdl, SessionController.ConnectionString);
              
            }
            else
            {
                mdl.Type_Id = new Guid(row.GetDataKeyValue("type_id").ToString());
                mdl.IsMajor = "N";
                TypeClient.InsertUpdateMajorTypes(mdl, SessionController.ConnectionString);
            }

        }
    }
    protected void btnAssignOmni_Click(object sender, EventArgs e)
    {
        
        try
        {
            if (hftype_id.Value != "")
            {

                DataSet ds = new DataSet();
                TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
                TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
                mdl.Type_Ids = hftype_id.Value.Substring(0, hftype_id.Value.Length - 1);
                mdl.Fk_Omniclass_Id = new Guid(hf_lblOmniClassid.Value);
                TypeClient.AssignOmniclassToType(mdl, SessionController.ConnectionString);
                hftype_id.Value = "";
                hf_lblOmniClassid.Value = "";  
                BindTypes();
               
           }

            else
            {
                string value = "<script language='javascript'>assignomniclass()</script>";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "script1", value);

            }

        }

        catch (Exception ex)
        {
            throw ex;
        }
    }
    
}