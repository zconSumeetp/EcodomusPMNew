using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Telerik.Web.UI;
using TypeProfile;
using EcoDomus.Session;
using System.Threading;
using System.Globalization;
using System.Collections;
using Facility;

public partial class App_TypePM : System.Web.UI.Page
{
    string Master_flag = "";
    string UniClass_flag = "";
    string UniFormat_flag = "";
    string OmniClass_flag = "";
    public ArrayList arrayList = new ArrayList();
    List<String> ls = new List<string>();
    bool custom_flag = true;
    //string defaultPageSize = SessionController.Users_.TypePageSize;
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


    protected void Page_Load(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserId != null)
        {

            txt_search.Attributes.Add("onKeyPress", "doClick('" + btnSearch.ClientID + "',event)");
            if (!IsPostBack)
            {
                if (SessionController.Users_.ProjectId == null || SessionController.Users_.ProjectId == Guid.Empty.ToString())
                {

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "ProjectValidation();", true);
                }
                else
                {
                    ViewState["SelectedTypeID"] = null;

                    BindFacility();

                    //ViewState["PageSize"] = 10;
                    //ViewState["PageIndex"] = 0;
                    //ViewState["SortExpression"] = "ismajor  desc";
                    //SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "2";
                    if (SessionController.Users_.TypePageSize == null)
                    {
                        // SessionController.Users_.TypePageSize = "10";
                        SessionController.Users_.TypePageSize = SessionController.Users_.DefaultPageSizeGrids;
                    }
                    if (SessionController.Users_.TypePageIndex == null)
                    {
                        SessionController.Users_.TypePageIndex = "0";
                    }
                    if (SessionController.Users_.TypeCheckedCheckboxes == null)
                    {
                        chk_omniclass.Checked = true;
                    }
                    if (SessionController.Users_.TypeSortExpression == null)
                    {
                        //  Add sort expression, which will sort against column ismajor bydefault
                        GridSortExpression sortExpr = new GridSortExpression();
                        sortExpr.FieldName = "ismajor";
                        sortExpr.SortOrder = GridSortOrder.Descending;
                        rgtype.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                        SessionController.Users_.TypeSortExpression = "ismajor desc";
                    }
                    else
                    {
                        string TypeSortExpression = SessionController.Users_.TypeSortExpression;
                        GridSortExpression sortExpr = new GridSortExpression();

                        if (TypeSortExpression.Contains(' '))
                        {
                            int index = TypeSortExpression.IndexOf(' ');
                            sortExpr.FieldName = TypeSortExpression.Substring(0, index);
                            sortExpr.SortOrder = GridSortOrder.Descending;
                        }
                        else
                        {
                            sortExpr.FieldName = TypeSortExpression;
                            sortExpr.SortOrder = GridSortOrder.Ascending;
                        }

                        rgtype.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                    }
                    hfTypePMPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
                    //if(hfcount.Value !="")
                    bindtypes("n");
                }
            }
        }
        else
        {
            Response.Redirect("~/App/LoginPM.aspx?Error=Session", false);
        }

        //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>ShowSearchEntity('');</script>", false);
    }

    /*  protected void bindtypes(string m)
       {
           DataSet ds = new DataSet();
           TypeModel tm = new TypeModel();
           TypeProfileClient tc=new TypeProfileClient();
           try
           {
               if (m == "m")
               {
                   tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                   tm.Flag = "type";
                   tm.Txt_Search = txt_search.Text;
                   ds = tc.bindtypepm(tm, SessionController.ConnectionString);
                   rgtype.DataSource = ds;
                   rgtype.DataBind();
                   rgtype.Columns[4].Visible = true;                
               }
               else if(m=="u")
               {
                   tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                   tm.Flag = "type";
                   tm.Txt_Search = txt_search.Text;
                   ds = tc.bindtypepm(tm, SessionController.ConnectionString);
                   rgtype.DataSource = ds;
                   rgtype.DataBind();
                   rgtype.Columns[5].Visible = true; 
               }
               else if(m=="n")
               {
                   tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                   tm.Flag = "type";
                   tm.Txt_Search = txt_search.Text;
                   ds = tc.bindtypepm(tm, SessionController.ConnectionString);
                   rgtype.DataSource = ds;
                   rgtype.DataBind();
                   rgtype.Columns[4].Visible = false;
                   rgtype.Columns[5].Visible = false;
               }
            }            
           catch(Exception ex)
           {
               throw ex;
           }
       }*/

    protected void Page_Prerender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "CBU")
        {
            btn_update_names.Visible = false;
            btnAssignMajor.Visible = false;

        }
        if (SessionController.Users_.UserSystemRole == "GU")
        {
            btn_update_names.Visible = false;
            btnAssignMajor.Visible = false;
            btndelete.Visible = false;
            bn_add_type.Visible = false;

        }
        // bindtypes("n");
        if (SessionController.Users_.Permission_ds != null)
        {
            if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
            {
                {
                    SetPermissions();
                }
            }
        }
    }

    private void SetPermissions()
    {
        try
        {
            DataSet ds_component = SessionController.Users_.Permission_ds;
            DataRow dr_component = ds_component.Tables[0].Select("name='Type'")[0];

            SetPermissionToControl(dr_component);


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private void SetPermissionToControl(DataRow dr)
    {
        Permissions objPermission = new Permissions();
        string view_permission = dr["view_permission"].ToString();
        string edit_permission = dr["edit_permission"].ToString();
        string delete_permission = dr["delete_permission"].ToString();
        // delete button on component profile
        if (dr["name"].ToString() == "Type")
        {
            objPermission.SetEditable(btndelete, delete_permission);
            objPermission.SetEditable(bn_add_type, edit_permission);
            objPermission.SetEditable(btn_edit_masterformat_uniformat, edit_permission);
            objPermission.SetEditable(btn_designer_contractor, edit_permission);
            objPermission.SetEditable(btn_assign, edit_permission);
            objPermission.SetEditable(btn_update_names, edit_permission);
            objPermission.SetEditable(btnAssignMajor, edit_permission);
        }

        if (edit_permission == "N")
        {
            foreach (GridDataItem item in rgtype.MasterTableView.Items)
            {
                CheckBox check1 = (CheckBox)item.FindControl("chkMajor");
                check1.Enabled = false;
            }
        }
        else
        {
            foreach (GridDataItem item in rgtype.MasterTableView.Items)
            {
                CheckBox check1 = (CheckBox)item.FindControl("chkMajor");
                check1.Enabled = true;
            }
        }

    }

    protected void bindtypes(string m)
    {
        //pagesize
        //pageindex
        //orderby
        //txt_search 
        //checked_checkboxes

        DataSet ds_TypeCount = new DataSet();

        DataSet ds = new DataSet();
        TypeModel tm = new TypeModel();
        TypeProfileClient tc = new TypeProfileClient();

        if ((SessionController.Users_.TypeSearchText == "") || (SessionController.Users_.TypeSearchText == null))
        {
            tm.Txt_Search = txt_search.Text.Trim().Replace("'", "''");
            SessionController.Users_.TypeSearchText = txt_search.Text.Trim().Replace("'", "''");
        }
        else
        {
            tm.Txt_Search = SessionController.Users_.TypeSearchText;
        }



        try
        {
            if (m == "n")
            {
                tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                tm.Flag = "type";
                txt_search.Text = SessionController.Users_.TypeSearchText;

                rgtype.CurrentPageIndex = Int32.Parse(SessionController.Users_.TypePageIndex);

                //GridSortExpression sortExpr = new GridSortExpression();
                //sortExpr.FieldName = SessionController.Users_.TypeSortExpression;
                //rgtype.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                //---------------------------added to bind only 10 types at a time------------------------------------------------------------------

                //SessionController.Users_.TypeSearchText = txt_search.Text.Trim().Replace("'", "''");
                tm.Txt_Search = SessionController.Users_.TypeSearchText;

                /*--get the selected facilities from dropdown => --*/
                System.Text.StringBuilder selectedfacilitynames = new System.Text.StringBuilder();
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                        selectedfacilitynames.Append(rcbItem.Text);
                        selectedfacilitynames.Append(",");

                    }
                }
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                if (selectedfacilitynames.ToString().Length > 0)
                {
                    selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
                }


                if (Convert.ToString(SessionController.Users_.TypeFacilities) != null)
                {
                    tm.Facility_Ids = SessionController.Users_.TypeFacilities;
                }
                else
                {
                    SessionController.Users_.TypeFacilities = facilityvalues.ToString();
                    SessionController.Users_.TypeSelectedFacilities = selectedfacilitynames.ToString();
                    tm.Facility_Ids = facilityvalues.ToString();
                }

                /*--get the selected facilities from dropdown--*/

                ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);
                if (SessionController.Users_.TypePageSize == "All")
                {
                    rgtype.PageSize = Int32.Parse(ds_TypeCount.Tables[0].Rows[0]["Cnt"].ToString());
                }
                else
                {
                    rgtype.PageSize = Int32.Parse(SessionController.Users_.TypePageSize);

                }
                if (ds_TypeCount.Tables != null)
                {
                    if (ds_TypeCount.Tables[1] != null)
                    {
                        if (ds_TypeCount.Tables[1].Rows.Count != null)
                        {
                            if (ds_TypeCount.Tables[1].Rows[0]["uniclass"].ToString() == "1")
                            {
                                chk_uniclass.Visible = true;
                                chk_uniclass_unassign.Visible = true;
                                Session["Show_uniclass"] = "Y";


                            }
                            else
                            {
                                chk_uniclass.Visible = false;
                                chk_uniclass_unassign.Visible = false;
                                Session["Show_uniclass"] = "N";
                            }
                        }
                        else
                        {
                            chk_uniclass.Visible = false;
                            chk_uniclass_unassign.Visible = false;
                            Session["Show_uniclass"] = "N";

                        }
                    }
                    else
                    {
                        chk_uniclass.Visible = false;
                        chk_uniclass_unassign.Visible = false;
                        Session["Show_uniclass"] = "N";
                    }
                    if (ds_TypeCount.Tables[2] != null)
                    {
                        if (ds_TypeCount.Tables[2].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds_TypeCount.Tables[2].Rows.Count; i++)
                            {
                                if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "MasterFormat")
                                {
                                    Master_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                                }
                                else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "OmniClass 2010")
                                {
                                    OmniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                                }
                                else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniFormat")
                                {
                                    UniFormat_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                                }
                                else if (ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString() == "UniClass")
                                {
                                    UniClass_flag = ds_TypeCount.Tables[2].Rows[i]["standard_name"].ToString();
                                }
                            }
                        }
                        if (Master_flag == "")
                        {
                            chk_master.Visible = false;
                            chk_master_unassign.Visible = false;
                        }
                        if (UniClass_flag == "")
                        {
                            chk_uniclass.Visible = false;
                            chk_uniclass_unassign.Visible = false;
                        }
                        else if (UniClass_flag != "")
                        {
                            chk_uniclass.Checked = true;
                            chk_uniclass.Visible = true;
                            chk_uniclass_unassign.Visible = true;
                        }
                        if (UniFormat_flag == "")
                        {
                            chk_uniformat.Visible = false;
                            chk_uniformat_unassign.Visible = false;
                        }
                        if (OmniClass_flag == "")
                        {
                            chk_omniclass.Checked = false;
                            chk_omniclass.Visible = false;
                            chk_omniclass_unassign.Visible = false;
                        }
                        else if (OmniClass_flag != "")
                        {
                            chk_omniclass.Checked = true;
                            chk_omniclass.Visible = true;
                            chk_omniclass_unassign.Visible = true;
                        }
                    }
                }
                rgtype.VirtualItemCount = Int32.Parse(ds_TypeCount.Tables[0].Rows[0]["Cnt"].ToString());
                SessionController.Users_.TypeCount = ds_TypeCount.Tables[0].Rows[0]["Cnt"].ToString();
                if (SessionController.Users_.TypePageSize == "All")
                {
                    tm.Pagesize = 0;
                }
                else
                {
                    tm.Pagesize = Int32.Parse(SessionController.Users_.TypePageSize);
                }

                tm.Pageindex = Int32.Parse(SessionController.Users_.TypePageIndex);
                /*-------for sort by major and Name------*/
                SessionController.Users_.TypeSortExpression = "ismajor desc , name";
                /*-------for sort by major and Name------*/

                tm.Orderby = SessionController.Users_.TypeSortExpression;
                //-------------------------------------------------------------------------------------------------------------------------------------------
                ds = tc.bindtypepm_v1(tm, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    rgtype.DataSource = ds;
                    rgtype.DataBind();
                }
                else
                {
                    rgtype.DataSource = string.Empty;
                    rgtype.DataBind();


                }
                //rgtype.Columns[2].Visible = false;
                // rgtype.Columns[4].Visible = false;
                rgtype.Columns[5].Visible = false;
                rgtype.Columns[6].Visible = false;
                rgtype.Columns[7].Visible = false;
                rgtype.Columns[8].Visible = false;
                if (chk_omniclass.Checked)
                {
                    rgtype.Columns[3].Visible = true;
                }
                else
                {
                    rgtype.Columns[3].Visible = false;
                }
                if (chk_uniclass.Checked)
                {
                    rgtype.Columns[10].Visible = true;
                }
                else
                {
                    rgtype.Columns[10].Visible = false;
                }
                if (SessionController.Users_.TypeCheckedCheckboxes != null)
                {
                    if (SessionController.Users_.TypeCheckedCheckboxes.Contains('0'))
                    {
                        GridColumn col = rgtype.Columns.FindByUniqueName("Master_format");
                        GridBoundColumn colBound = col as GridBoundColumn;
                        colBound.Visible = true;
                        chk_master.Checked = true;
                    }
                    if (SessionController.Users_.TypeCheckedCheckboxes.Contains('1'))
                    {
                        GridColumn col = rgtype.Columns.FindByUniqueName("UniFormat");
                        GridBoundColumn colBound = col as GridBoundColumn;
                        colBound.Visible = true;
                        chk_uniformat.Checked = true;
                    }
                    if (SessionController.Users_.TypeCheckedCheckboxes.Contains('2'))
                    {
                        GridColumn col = rgtype.Columns.FindByUniqueName("OmniClass");
                        GridBoundColumn colBound = col as GridBoundColumn;
                        colBound.Visible = true;
                        chk_omniclass.Checked = true;
                    }
                    if (SessionController.Users_.TypeCheckedCheckboxes.Contains('3'))
                    {
                        GridColumn col = rgtype.Columns.FindByUniqueName("Designer");
                        GridBoundColumn colBound = col as GridBoundColumn;
                        colBound.Visible = true;
                        chk_designer.Checked = true;
                    }
                    if (SessionController.Users_.TypeCheckedCheckboxes.Contains('4'))
                    {
                        GridColumn col = rgtype.Columns.FindByUniqueName("Contractor");
                        GridBoundColumn colBound = col as GridBoundColumn;
                        colBound.Visible = true;
                        chk_contractor.Checked = true;
                    }
                }
            }
            else
            {
                tm.Project_id = new Guid(SessionController.Users_.ProjectId.ToString());
                tm.Flag = "type";
                txt_search.Text = SessionController.Users_.TypeSearchText;
                rgtype.CurrentPageIndex = Int32.Parse(SessionController.Users_.TypePageIndex);

                //GridSortExpression sortExpr = new GridSortExpression();
                //sortExpr.FieldName = SessionController.Users_.TypeSortExpression;
                //rgtype.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                //---------------------------added to bind only 10 types at a time----------------------------------------------------------
                tm.Txt_Search = SessionController.Users_.TypeSearchText;

                /*--get the selected facilities from dropdown => --*/
                System.Text.StringBuilder selectedfacilitynames = new System.Text.StringBuilder();
                System.Text.StringBuilder facilityvalues = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues.Append(rcbItem.Value);
                        facilityvalues.Append(",");
                        selectedfacilitynames.Append(rcbItem.Text);
                        selectedfacilitynames.Append(",");

                    }
                }
                if (facilityvalues.ToString().Length > 0)
                {
                    facilityvalues = facilityvalues.Remove(facilityvalues.ToString().Length - 1, 1);
                }
                if (selectedfacilitynames.ToString().Length > 0)
                {
                    selectedfacilitynames = selectedfacilitynames.Remove(selectedfacilitynames.ToString().Length - 1, 1);
                }
                tm.Facility_Ids = facilityvalues.ToString();

                SessionController.Users_.TypeFacilities= facilityvalues.ToString();

                SessionController.Users_.TypeSelectedFacilities= selectedfacilitynames.ToString();

                /*--get the selected facilities from dropdown--*/


                ds_TypeCount = tc.bindtypepm_count_v1(tm, SessionController.ConnectionString);
                if (SessionController.Users_.TypePageSize == "All")
                {
                    rgtype.PageSize = Int32.Parse(ds_TypeCount.Tables[0].Rows[0]["Cnt"].ToString());
                }
                else
                {
                    rgtype.PageSize = Int32.Parse(SessionController.Users_.TypePageSize);
                }
                rgtype.VirtualItemCount = Int32.Parse(ds_TypeCount.Tables[0].Rows[0]["Cnt"].ToString());
                SessionController.Users_.TypeCount = ds_TypeCount.Tables[0].Rows[0]["Cnt"].ToString();

                if (SessionController.Users_.TypePageSize == "All")
                {
                    tm.Pagesize = 0;
                }
                else
                {
                    tm.Pagesize = Int32.Parse(SessionController.Users_.TypePageSize);
                }

                tm.Pageindex = Int32.Parse(SessionController.Users_.TypePageIndex);

                /*-------for sort by major and Name------*/
                SessionController.Users_.TypeSortExpression = "ismajor desc , name";
                /*-------for sort by major and Name------*/

                tm.Orderby = SessionController.Users_.TypeSortExpression;
                //-----------------------------------------------------------------------------------------------------------------------------------
                ds = tc.bindtypepm_v1(tm, SessionController.ConnectionString);
                if (ds.Tables.Count > 0)
                {
                    rgtype.DataSource = ds;
                    rgtype.DataBind();

                }
                else
                {
                    rgtype.DataSource = string.Empty;
                    rgtype.DataBind();
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    private ArrayList ConvertDataSetToArrayList(DataSet ds)
    {
        try
        {
            //DataSet ds = (DataSet)Session["selectedRows"];
            ArrayList alist = new ArrayList();
            foreach (DataRow dtRow in ds.Tables[0].Rows)
            {
                alist.Add(dtRow["pk_type_id"].ToString());
            }

            return alist;

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void GetSelectedRows()
    {
        try
        {
            SessionToArrayList();

            foreach (GridDataItem item in rgtype.Items)
            {
                string strIndex = rgtype.MasterTableView.CurrentPageIndex.ToString();
                // string comp_id = item.GetDataKeyValue("pk_type_id").ToString();
                string type_id = item["pk_type_id"].Text;

                if (item.Selected)
                {
                    if (!arrayList.Contains(type_id.ToString()))
                    {
                        arrayList.Add(type_id.ToString());
                    }
                }
                else
                {
                    if (arrayList.Contains(type_id.ToString()))
                    {
                        arrayList.Remove(type_id.ToString());
                    }
                }
            }

            ViewState["SelectedTypeID"] = arrayList;
            ArrayList type_list = (ArrayList)ViewState["SelectedTypeID"];
            string id = "";
            if (type_list.Count > 0)
            {
                for (int i = 0; i < type_list.Count; i++)
                {
                    id = id + type_list[i].ToString() + ",";

                }
                id = id.Substring(0, id.Length - 1);
                hf_type_id.Value = id;

            }
        }

        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void ReSelectedRows()
    {
        try
        {
            foreach (GridDataItem item in rgtype.Items)
            {
                string type_id = item.GetDataKeyValue("pk_type_id").ToString();//item["pk_type_id"].Text;

                if (arrayList.Contains(type_id.ToString()))
                {
                    item.Selected = true;

                }
            }


        }





        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void SessionToArrayList()
    {
        try
        {
            if (ViewState["SelectedTypeID"] != null)
            {
                arrayList = (ArrayList)ViewState["SelectedTypeID"];
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    protected void btn_delete_click(object sender, EventArgs e)
    {
        try
        {
            if (rgtype.SelectedItems.Count > 0)
            {
                System.Text.StringBuilder strSystemIds = new System.Text.StringBuilder();
                for (int i = 0; i < rgtype.SelectedItems.Count; i++)
                {
                    strSystemIds.Append(rgtype.SelectedItems[i].Cells[2].Text);
                    strSystemIds.Append(",");
                }

                string fac_ids = strSystemIds.ToString();
                if (fac_ids.Length > 0)
                {
                    fac_ids = fac_ids.Remove(fac_ids.ToString().Length - 1, 1);
                }
                hf_type_id.Value = fac_ids;
                ClientScript.RegisterClientScriptBlock(this.GetType(), "script1", "deletebatchRegister();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script3", "validate();", true);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btn_refresh_Click(object sender, EventArgs e)
    {
        try
        {
            ViewState["SelectedTypeID"] = null;
            rgtype.MasterTableView.CurrentPageIndex = 0;
            bindtypes("");
            hf_type_id.Value = "";
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void chk_designer_click(object sender, EventArgs e)
    {

        //CheckBox chkBox = (sender as CheckBox);
        if (chk_designer.Checked)
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("Designer");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "3";

            //--------------------------
            bindtypes("");
        }
        else
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("Designer");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.TypeCheckedCheckboxes.Contains('3'))
            {
                int pos = SessionController.Users_.TypeCheckedCheckboxes.IndexOf('3');
                SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            bindtypes("");
        }
    }
    protected void chk_contractor_click(object sender, EventArgs e)
    {

        //CheckBox chkBox = (sender as CheckBox);
        if (chk_contractor.Checked)
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("contractor");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "4";

            //--------------------------
            bindtypes("");
        }
        else
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("contractor");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.TypeCheckedCheckboxes.Contains('4'))
            {
                int pos = SessionController.Users_.TypeCheckedCheckboxes.IndexOf('4');
                SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            bindtypes("");
        }
    }
    protected void chk_master_click(object sender, EventArgs e)
    {

        //CheckBox chkBox = (sender as CheckBox);
        if (chk_master.Checked)
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("Master_format");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "0";

            //--------------------------
            bindtypes("");
        }
        else
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("Master_format");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.TypeCheckedCheckboxes.Contains('0'))
            {
                int pos = SessionController.Users_.TypeCheckedCheckboxes.IndexOf('0');
                SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            bindtypes("");
        }
    }
    protected void chk_uniformat_click(object sender, EventArgs e)
    {
        if (chk_uniformat.Checked)
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("uniformat");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "1";

            //--------------------------
            bindtypes("");
        }
        else
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("uniformat");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.TypeCheckedCheckboxes.Contains('1'))
            {
                int pos = SessionController.Users_.TypeCheckedCheckboxes.IndexOf('1');
                SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            //bindtypes("u");            
        }
    }
    protected void chk_omniclass_click(object sender, EventArgs e)
    {
        if (chk_omniclass.Checked)
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
            GridBoundColumn colBound = col as GridBoundColumn;

            colBound.Visible = true;
            //added
            SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "2";

            //--------------------------
            bindtypes("");
        }
        else
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;

            //added
            chk_omniclass.Checked = false;
            if (SessionController.Users_.TypeCheckedCheckboxes != null)
            {
                if (SessionController.Users_.TypeCheckedCheckboxes.Contains('2'))
                {
                    int pos = SessionController.Users_.TypeCheckedCheckboxes.IndexOf('2');
                    SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes.Remove(pos, 1);
                }
            }
            //---------------------
            bindtypes("");
        }

    }
    //protected void chk_master_unassign_click(object sender, EventArgs e)
    //  {
    //      if (chk_master_unassign.Checked)
    //      {
    //          GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //          GridBoundColumn colBound = col as GridBoundColumn;

    //          colBound.Visible = true;
    //          bindtypes("");
    //      }
    //      else
    //      {
    //          GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //          GridBoundColumn colBound = col as GridBoundColumn;
    //          colBound.Visible = false;
    //          bindtypes("");
    //      }     

    //  }
    //protected void chk_uniformat_unassign_click(object sender, EventArgs e)
    //{
    //    if (chk_uniformat_unassign.Checked)
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;

    //        colBound.Visible = true;
    //        bindtypes("");
    //    }
    //    else
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;
    //        colBound.Visible = false;
    //        bindtypes("");
    //    }

    //}
    //protected void chk_omniclass_unassign_click(object sender, EventArgs e)
    //{
    //    if (chk_omniclass_unassign.Checked)
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;

    //        colBound.Visible = true;
    //        bindtypes("");
    //    }
    //    else
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;
    //        colBound.Visible = false;
    //        bindtypes("");
    //    }

    //}
    //protected void chk_designer_unassign_click(object sender, EventArgs e)
    //{
    //    if (chk_designer_unassign.Checked)
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;

    //        colBound.Visible = true;
    //        bindtypes("");
    //    }
    //    else
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;
    //        colBound.Visible = false;
    //        bindtypes("");
    //    }

    //}
    //protected void chk_contractor_unassign_click(object sender, EventArgs e)
    //{
    //    if (chk_contractor_unassign.Checked)
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;

    //        colBound.Visible = true;
    //        bindtypes("");
    //    }
    //    else
    //    {
    //        GridColumn col = rgtype.Columns.FindByUniqueName("omniclass");
    //        GridBoundColumn colBound = col as GridBoundColumn;
    //        colBound.Visible = false;
    //        bindtypes("");
    //    }

    //}
    protected void btn_unassign_click(object sender, EventArgs e)
    {

        try
        {
            string type_ids = "";
            if (rgtype.SelectedItems.Count > 0)  // check weather user check any text box or not 
            {
                for (int i = 0; i < rgtype.SelectedItems.Count; i++)
                {
                    //rgtype.SelectedValues.
                    type_ids = type_ids + rgtype.SelectedItems[i].Cells[2].Text + ",";
                    //name = name + rgtype.SelectedItems[i].Cells[4].Text + ",";
                }
                type_ids = type_ids.Substring(0, type_ids.Length - 1);
                TypeModel tm = new TypeModel();
                TypeProfileClient tc = new TypeProfileClient();
                //type_ids = type_ids.Remove(type_ids.Length - 1, 1);

                if (chk_master_unassign.Checked)
                {
                    tm.Masterformat = "m";
                    // tm.Designer = "d";
                }

                if (chk_contractor_unassign.Checked)
                {
                    tm.Contractor = "c";
                }
                /*----------------------Masterformat uniformat omniclass----------------------------*/
                if (chk_designer_unassign.Checked)
                {
                    tm.Designer = "d";
                }

                if (chk_uniformat_unassign.Checked)
                {
                    tm.Uniformat = "u";
                }

                if (chk_omniclass_unassign.Checked)
                {
                    tm.Omniclass = "o";
                }
                if (chk_omniclass_unassign.Checked)
                {
                    tm.Omniclass = "o";
                }
                if (chk_uniclass.Checked)
                {
                    tm.UniClass = "uc";
                }
                //else
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "script3", "chk_validate();", true);
                //    //ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>chk_validate()</script>");

                //}

                tm.Type_Ids = type_ids;

                tc.Unassign(tm, SessionController.ConnectionString);
                bindtypes("");
                //  ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>refreshParent()</script>");
            }

        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
    }
    protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        if (e.Argument == "Rebind")
        {

            rgtype.MasterTableView.SortExpressions.Clear();
            rgtype.MasterTableView.GroupByExpressions.Clear();
            rgtype.Rebind();
        }
    }
    protected void btnAssignMajor_Click(object sender, EventArgs e)
    {
        foreach (GridDataItem row in rgtype.Items)
        {
            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();

            CheckBox ch = new CheckBox();
            ch = row.FindControl("chkmajor") as CheckBox;
            if (ch.Checked)
            {
                mdl.Type_Id = new Guid(row.GetDataKeyValue("pk_type_id").ToString());
                mdl.IsMajor = "Y";
                TypeClient.InsertUpdateMajorTypes(mdl, SessionController.ConnectionString);

            }
            else
            {
                mdl.Type_Id = new Guid(row.GetDataKeyValue("pk_type_id").ToString());
                mdl.IsMajor = "N";
                TypeClient.InsertUpdateMajorTypes(mdl, SessionController.ConnectionString);
            }
            bindtypes("");
        }
    }
    protected void rgtype_OnPreRender(object sender, EventArgs e)
    {
        if (SessionController.Users_.UserSystemRole == "CBU")
        {
            //foreach (GridDataItem item in rgtype.MasterTableView.Items)
            //{
            //    CheckBox check1 = (CheckBox)item.FindControl("chkMajor");
            //    check1.Enabled = false;
            //}
        }
        if (SessionController.Users_.UserSystemRole == "GU")
        {

            foreach (GridDataItem item in rgtype.MasterTableView.Items)
            {
                CheckBox check1 = (CheckBox)item.FindControl("chkMajor");
                check1.Enabled = false;
            }
        }

    }

    protected void chk_uniclass_CheckedChanged(object sender, EventArgs e)
    {
        if (chk_uniclass.Checked)
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("uniclass");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = true;
            //added
            SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes + "5";

            //--------------------------
            bindtypes("");
        }
        else
        {
            GridColumn col = rgtype.Columns.FindByUniqueName("uniclass");
            GridBoundColumn colBound = col as GridBoundColumn;
            colBound.Visible = false;
            //added
            if (SessionController.Users_.TypeCheckedCheckboxes.Contains('5'))
            {
                int pos = SessionController.Users_.TypeCheckedCheckboxes.IndexOf('5');
                SessionController.Users_.TypeCheckedCheckboxes = SessionController.Users_.TypeCheckedCheckboxes.Remove(pos, 1);
            }
            //---------------------
            bindtypes("");
        }
    }

    #region Grid events

    protected void rgtype_SortCommand(object source, GridSortCommandEventArgs e)
    {
        try
        {
            GetSelectedRows();
            //ViewState["SortExpression"] = e.SortExpression;
            SessionController.Users_.TypeSortExpression = e.SortExpression;
            if (e.NewSortOrder.ToString() == "Descending")
            {
                //ViewState["SortExpression"] = ViewState["SortExpression"].ToString() + " DESC";
                SessionController.Users_.TypeSortExpression = SessionController.Users_.TypeSortExpression + " DESC";
            }
            bindtypes("");
        }
        catch (Exception)
        {

            throw;
        }

    }
    protected void rgtype_PageSizeChanged(object source, GridPageSizeChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            if (e.NewPageSize != 20 && e.NewPageSize != 50 && e.NewPageSize != Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids))
            {
                //ViewState["PageSize"] = 0;
                //ViewState["PageIndex"] = 0;
                SessionController.Users_.TypePageSize = "All";
                SessionController.Users_.TypePageIndex = "0";
                //rgtype.PageSize = e.NewPageSize; 
            }
            else
            {
                //ViewState["PageSize"] = e.NewPageSize;
                SessionController.Users_.TypePageSize = e.NewPageSize.ToString();
                int type_count = Int32.Parse(SessionController.Users_.TypeCount);
                int page_size = Int32.Parse(SessionController.Users_.TypePageSize);
                int page_index = Int32.Parse(SessionController.Users_.TypePageIndex);
                int maxpg_index = (type_count / page_size) + 1;
                if (page_index >= maxpg_index)
                {
                    //ViewState["PageIndex"] = 0;
                    SessionController.Users_.TypePageIndex = "0";
                }
            }
            if (e.Item is GridPagerItem)
            {
                RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                cb.Items.FindItemByValue(rgtype.PageSize.ToString()).Selected = true;

                //xx

            }
            bindtypes("");
            if (rgtype.Items.Count > 10) { }
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rgtype_PageIndexChanged(object source, GridPageChangedEventArgs e)
    {
        try
        {
            GetSelectedRows();
            //ViewState["PageIndex"] = e.NewPageIndex;
            SessionController.Users_.TypePageIndex = e.NewPageIndex.ToString();
            bindtypes("");
            if (rgtype.Items.Count > 10)
                ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    int TotalItemCount;

    protected void rgtype_OnItemEvent(object sender, GridItemEventArgs e)
    {

        if (e.EventInfo is GridInitializePagerItem)
        {

            TotalItemCount = (e.EventInfo as GridInitializePagerItem).PagingManager.DataSourceCount;
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

        }
        hfcount.Value = TotalItemCount.ToString();
        // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);

    }
    protected void rgtype_OnItemCreated(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {

        //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        //Check for GridHeaderItem if you wish tooltips only for the header cells
        if (e.Item is GridHeaderItem)
        {
            GridHeaderItem headerItem = e.Item as GridHeaderItem;

            foreach (GridColumn column in rgtype.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }
                if (column is GridButtonColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }
                if (column is GridTemplateColumn)
                {
                    //if the sorting feature of the grid is enabled
                    if (column.HeaderText != "")
                        (headerItem[column.UniqueName].Controls[0] as LinkButton).ToolTip = column.HeaderText;

                }


            }
        }

        if (e.Item is GridDataItem)
        {
            GridDataItem gridItem = e.Item as GridDataItem;
            foreach (GridColumn column in rgtype.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //this line will show a tooltip based type of Databound for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null)
                    {
                        gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                }
                else if (column is GridButtonColumn)
                {
                    //this line will show a tooltip based type of linkbutton for grid data field
                    if (column.OrderIndex > -1 && e.Item.DataItem != null)
                    {
                        if (column.UniqueName.ToString().Equals("name"))
                            //if(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].GetType() == typeof(string))
                            gridItem[column.UniqueName].ToolTip = Convert.ToString(((System.Data.DataRowView)(e.Item.DataItem)).Row[column.UniqueName].ToString());
                    }
                }
            }
        }
    }
    protected void btn_search_click(object sender, EventArgs e)
    {

        //ViewState["PageIndex"] = 0;
        SessionController.Users_.TypePageIndex = "0";
        //SessionController.Users_.TypePageSize = "10";
        SessionController.Users_.TypePageSize = SessionController.Users_.DefaultPageSizeGrids;
        SessionController.Users_.TypeSearchText = txt_search.Text.Trim().Replace("'", "''");
        bindtypes("");
    }
    protected void btn_add_type_click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/Asset/TypeProfileMenu.aspx?type_id=00000000-0000-0000-0000-000000000000", false);
        // Response.Redirect("~/App/Asset/TypeProfile.aspx?type_id=00000000-0000-0000-0000-000000000000", false);
    }
    protected void rgtype_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            Guid type_id = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_type_id"].ToString());
            hf_type_id.Value = type_id.ToString();
            Response.Redirect("~/App/Asset/TypeProfileMenu.aspx?type_id=" + hf_type_id.Value.ToString(), false);
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        }
    }
    protected void rgtype_OnItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
        try
        {

            if (SessionController.Users_.UserSystemRole == "CBU")
            {
                rgtype.Columns[4].Visible = false;
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
            }
            else
            {
                //if (e.Item.ItemType == GridItemType.AlternatingItem || e.Item.ItemType == GridItemType.Item)
                //{ 
                //}

                if (e.Item is Telerik.Web.UI.GridDataItem)
                {
                    CheckBox chkmajor = e.Item.FindControl("chkMajor") as CheckBox;
                    GridDataItem item = (GridDataItem)e.Item;

                    if (((System.Data.DataRowView)(e.Item.DataItem)).Row.ItemArray[12].ToString() == "Y")
                    {
                        chkmajor.Checked = true;
                    }
                }

                if (e.Item is GridPagerItem)
                {

                    RadComboBox cb = (e.Item as GridPagerItem).FindControl("PageSizeComboBox") as RadComboBox;
                    cb.Items.Clear();

                    RadComboBoxItem item = item = new RadComboBoxItem(SessionController.Users_.DefaultPageSizeGrids, SessionController.Users_.DefaultPageSizeGrids);

                    item.Attributes.Add("ownerTableViewId", rgtype.MasterTableView.ClientID);

                    if (hfcount.Value != "")
                    {
                        if (Convert.ToInt32(hfcount.Value) >= Convert.ToInt32(SessionController.Users_.DefaultPageSizeGrids))
                        {
                            if (cb.Items.FindItemByValue(SessionController.Users_.DefaultPageSizeGrids) == null)
                                cb.Items.Add(item);
                        }
                    }

                    //if (hfcount.Value != "")
                    //{
                    //    if (Convert.ToInt32(hfcount.Value) >= 10)
                    //    {
                    //        if (cb.Items.FindItemByValue("10") == null)
                    //            cb.Items.Add(item);
                    //    }
                    //    // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
                    //}
                    if (hfcount.Value != "")
                    {
                        if (Convert.ToInt32(hfcount.Value) >= 20)
                        {
                            item = new RadComboBoxItem("20", "20");
                            item.Attributes.Add("ownerTableViewId", rgtype.MasterTableView.ClientID);
                            if (cb.Items.FindItemByValue("20") == null)
                                cb.Items.Add(item);
                            // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
                        }
                    }
                    if (hfcount.Value != "")
                    {
                        if (Convert.ToInt32(hfcount.Value) >= 50)
                        {
                            item = new RadComboBoxItem("50", "50");
                            item.Attributes.Add("ownerTableViewId", rgtype.MasterTableView.ClientID);
                            if (cb.Items.FindItemByValue("50") == null)
                                cb.Items.Add(item);
                            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
                        }
                    }
                    /*
                      if (hfcount.Value != "")
                      {
                          if (Convert.ToInt32(hfcount.Value) >= 15)
                          {
                              item = new RadComboBoxItem("15", "15");
                              item.Attributes.Add("ownerTableViewId", rgtype.MasterTableView.ClientID);
                              if (cb.Items.FindItemByValue("15") == null)
                                  cb.Items.Add(item);
                              //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
                          }
                      }
                      */




                    item = new RadComboBoxItem("All", hfcount.Value);
                    item.Attributes.Add("ownerTableViewId", rgtype.MasterTableView.ClientID);
                    if (cb.Items.FindItemByValue("All") == null)
                        cb.Items.Add(item);

                    cb.Items.Sort(new PagerRadComboBoxItemComparer());
                    if (cb.Items.FindItemByValue(rgtype.PageSize.ToString()) != null)
                        cb.Items.FindItemByValue(rgtype.PageSize.ToString()).Selected = true;
                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
                }


                ReSelectedRows();
                /*
                  if (e.Item is GridDataItem)
        {
            GridDataItem gridItem = e.Item as GridDataItem;
            foreach (GridColumn column in rgtype.MasterTableView.RenderColumns)
            {
                if (column is GridBoundColumn)
                {
                    //this line will show a tooltip based on the CustomerID data field
                    gridItem[column.UniqueName].ToolTip = gridItem.OwnerTableView.DataKeyValues[gridItem.ItemIndex]["CustomerID"].ToString();

                    //This is in case you wish to display the column name instead of data field.
                    //gridItem[column.UniqueName].ToolTip = "Tooltip: " + column.UniqueName;
                }
            }
        }
                 */
                //if (e.Item is Telerik.Web.UI.GridDataItem)
                //{
                //    Permissions objPermission = new Permissions();
                //    if (SessionController.Users_.Permission_ds != null)
                //    {
                //        if (SessionController.Users_.Permission_ds.Tables[0].Rows.Count > 0)
                //        {
                //            DataSet ds_component = SessionController.Users_.Permission_ds;
                //            DataRow dr_component = ds_component.Tables[0].Select("name='Type'")[0];


                //            string delete_permission = dr_component["delete_permission"].ToString();
                //            string edit_permission = dr_component["edit_permission"].ToString();
                //            string name = string.Empty;
                //            if (edit_permission == "N")
                //            {
                //                // remove hyperlink for System name 
                //                try
                //                {
                //                    //LinkButton lnk = (LinkButton)e.Item.FindControl("lnkbtnName");
                //                    //name = lnk.Text.ToString();
                //                    //lnk.Enabled = false;
                //                    //lnk.ResolveUrl(name.Replace("&nbsp;", ""));
                //                    //name = e.Item.Cells[4].Text.ToString();
                //                    //e.Item.Cells[4].Text = objPermission.remove_Hyperlink(name.Replace("&nbsp;", ""));


                //                }
                //                catch (Exception)
                //                {

                //                    throw;
                //                }
                //            }
                //        }
                //    }
                //}
            }
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    #endregion

    protected void btnCustomPageSize_Click(object sender, EventArgs e)
    {
        //    SessionController.Users_.TypePageSize = hfcustomPageSize.Value.ToString();
        //    this.bindtypes("");


    }
    //protected void btnclick_Click(object sender, EventArgs e)
    //{
    //    bindtypes("n");
    //}

    #region facility dropdown

    protected void cmbfacility_ItemDataBound(object sender, RadComboBoxItemEventArgs e)
    {
        try
        {

            if (SessionController.Users_.ComponentFacilities == null)
            {
                System.Text.StringBuilder facilityvalues1 = new System.Text.StringBuilder();
                foreach (Telerik.Web.UI.RadComboBoxItem rcbItem in cmbfacility.Items)
                {
                    if (((CheckBox)rcbItem.FindControl("CheckBox1")).Checked)
                    {
                        facilityvalues1.Append(rcbItem.Value);
                        facilityvalues1.Append(",");
                    }
                }
                if (facilityvalues1.ToString().Length > 0)
                {
                    facilityvalues1 = facilityvalues1.Remove(facilityvalues1.ToString().Length - 1, 1);
                }
                SessionController.Users_.ComponentFacilities = facilityvalues1.ToString();

            }

            ((CheckBox)e.Item.FindControl("CheckBox1")).Attributes.Add("onclick", "checkboxClick('" + ((Telerik.Web.UI.RadComboBox)sender).ClientID + "');");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void navigate(object sender, EventArgs e)
    {
        //cmb_floors.Enabled = true;
        bindtypes("");
    }

    /// <summary>
    ///  Bind facilities to facility Dropdown according to project
    /// </summary>
    private void BindFacility()
    {
        try
        {

            DataSet ds_facility = new DataSet();
            FacilityClient locObj_crtl = new FacilityClient();
            FacilityModel locObj_mdl = new FacilityModel();
            locObj_mdl.Project_id = new Guid(SessionController.Users_.ProjectId);
            locObj_mdl.Search_text_name = "";
            locObj_mdl.Doc_flag = "floor";
            ds_facility = locObj_crtl.GetFacilitiesPM(locObj_mdl, SessionController.ConnectionString);
            //ds_facility1 = ds_facility;
            if (ds_facility.Tables[0].Rows.Count > 0)
            {
                cmbfacility.DataTextField = "name";
                cmbfacility.DataValueField = "pk_facility_id";
                cmbfacility.DataSource = ds_facility;
                cmbfacility.DataBind();
                string name = ds_facility.Tables[0].Rows[0]["name"].ToString();
                //cmbfacility.Text = name;

            }

            cmbfacility.Visible = true;
            lblfacility.Visible = true;
            cmbfacility.Enabled = true;
            //-----------------------------------------------------------------------------------------------------------
            if (ds_facility.Tables[0].Rows.Count != 0)
            {
                if (SessionController.Users_.TypeFacilities== null)
                {
                    for (int k = 0; k < cmbfacility.Items.Count; k++)
                    {
                        CheckBox checkbox = (CheckBox)cmbfacility.Items[k].FindControl("CheckBox1");
                        checkbox.Checked = true;
                        //cmbfacility.SelectedValue = SessionController.Users_.ComponentFacilities;
                        cmbfacility.SelectedValue = cmbfacility.SelectedValue + "," + checkbox.Text;
                        //cmbfacility.Text = SessionController.Users_.ComponentFacilities;

                    }
                    cmbfacility.SelectedValue = cmbfacility.SelectedValue.Remove(0, 1);
                    cmbfacility.Text = cmbfacility.SelectedValue;
                }
                else
                {
                    string facilityids = SessionController.Users_.TypeFacilities;
                    if (facilityids.ToString() != "")
                    {
                        //To check the checkboxes of selected facilities-----------------------------------------------------------------------
                        int count = 0;
                        string mySubString = ",";
                        for (var i = 0; i <= facilityids.Length - mySubString.Length; i++)
                        {
                            if (facilityids.ToString().Substring(i, mySubString.Length) == mySubString)
                            {
                                count++;
                            }
                        }
                        string[] facidarray = new string[count + 1];
                        int j = count + 1;
                        int p = 0;
                        System.Text.StringBuilder facilityvalues2 = new System.Text.StringBuilder();
                        for (int k = 0; k < cmbfacility.Items.Count; k++)
                        {
                            Telerik.Web.UI.RadComboBoxItem rcbItem = (Telerik.Web.UI.RadComboBoxItem)cmbfacility.Items[k];
                            if (facilityids.Contains(rcbItem.Value))
                            {
                                facidarray[p] = rcbItem.Value;
                                cmbfacility.SelectedValue = facidarray[p].ToString();
                                CheckBox checkbox = (CheckBox)cmbfacility.Items[k].FindControl("CheckBox1");
                                checkbox.Checked = true;
                            }
                        }
                        //------------------------added on 21-11-12--------------------------------------------------------------------------------------------------------
                        //int f= 0;
                        //string value = "";
                        //for (int q = 0; q < ds_facility.Tables[0].Rows.Count; q++)
                        //{
                        //    int length = SessionController.Users_.ComponentSelectedFacilities.IndexOf(',');
                        //    value = SessionController.Users_.ComponentSelectedFacilities.Substring(0,length);
                        //    if (ds_facility.Tables[0].Rows[q]["name"].ToString().Contains(value))
                        //    {

                        //    }
                        //    else
                        //    {
                        //        f++;
                        //        //SessionController.Users_.ComponentSelectedFacilities = SessionController.Users_.ComponentSelectedFacilities.Replace(value, "");
                        //    }
                        //}
                        //----------------------------------------------------------------------------------------------------------------------------------
                        cmbfacility.SelectedValue = SessionController.Users_.TypeSelectedFacilities;
                        cmbfacility.Text = SessionController.Users_.TypeSelectedFacilities;

                    }
                }
            }
            //--------------------------------------------------------------------------------------------------------------
        }
        catch (Exception ex)
        {
         throw ex;
        }
    }


    #endregion


    protected void btnMerge_Click(object sender, EventArgs e)
    {
        List<Guid> typeIds = new List<Guid>();

        for (int i = 0; i < rgtype.SelectedItems.Count; i++)
        {
            typeIds.Add(new Guid(rgtype.SelectedItems[i].Cells[2].Text));
        }

        using (var client = new TypeProfile.TypeProfileClient())
        {
            client.MergeTypes(typeIds.ToArray(), SessionController.ConnectionString);
        }

        Response.Redirect("TypePM.aspx", false);
    }
}


