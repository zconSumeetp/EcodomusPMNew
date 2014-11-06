using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EcoDomus.Session;
using EnergyPlus;
using System.Data;
using Telerik.Web.UI;
using System.Threading;
using System.Globalization;

public partial class App_Settings_ScheduleLimits : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (SessionController.Users_.UserId != null)
            {
                GridSortExpression sortExpr = new GridSortExpression();
                sortExpr.FieldName = "name";
                sortExpr.SortOrder = GridSortOrder.Ascending;
                //Add sort expression, which will sort against first column
                rg_schedule_limit.MasterTableView.SortExpressions.AddSortExpression(sortExpr);
                Bind_Schedule_Limit_Grid();
                Fill_Numeric_Type();

            }
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "script1", "NiceScrollOnload();", true);
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
        try
        {
            Response.Redirect(url, false);
        }
        catch (Exception ex)
        {
            
            throw ex;
        }
        

    }

    private void Fill_Numeric_Type()
    {
        try
        {


        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    private void Bind_Schedule_Limit_Grid()
    {
        try
        {
            DataSet ds = new DataSet();
            EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
            EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
            ds = obj_energy_plus_client.Get_Simulation_Schedule_Limit(obj_energy_plus_model, SessionController.ConnectionString);
            rg_schedule_limit.DataSource = ds;
            rg_schedule_limit.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        try
        {
            if (!hf_pk_simulation_Schedule_limit.Value.ToString().Equals(""))
            {
                Update_Schedule_Limit_Data(hf_pk_simulation_Schedule_limit.Value);
                
            }
            else
            {
                Insert_Schedule_Limit_Data();
                //btnadd.Text = (string)GetGlobalResourceObject("Resource", "Update");
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void Insert_Schedule_Limit_Data()
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Name = txtName.Text;
            obj_energy_plus_model.Description = txtDescription.Text;
            obj_energy_plus_model.Lower_limit = txtLowerLimit.Text;
            obj_energy_plus_model.Upper_limit = txtUpperLimit.Text;
            obj_energy_plus_model.Numeric_type = rcbNumericType.Text;
            obj_energy_plus_model.Unit_type = txtUnitType.Text;
            obj_energy_plus_model.Flag = "N";
            obj_energy_plus_model.Created_by = new Guid(SessionController.Users_.UserId);
            if (chkInterpolate.Checked)
            {
                obj_energy_plus_model.Interpolate = 1;
            }
            else
            {
                obj_energy_plus_model.Interpolate = 0;
            }
            ds=obj_energy_plus_client.Insert_Update_Simulation_Schedule_Limit(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["pk_simulation_schedule_limit_id"].ToString().Equals(Guid.Empty.ToString ()))
                {
                    lblErrorMsg.Text = "Name already exists";
                    lblErrorMsg.Visible = true;
                    hf_flag.Value = "";
                    btnadd.Text = (string)GetGlobalResourceObject("Resource", "Add");
                    hf_pk_simulation_Schedule_limit.Value = "";
                }
                else
                {
                    txtName.Text = "";
                    txtDescription.Text = "";
                    txtUnitType.Text = "";
                    txtLowerLimit.Text = "";
                    txtUpperLimit.Text = "";
                    rcbNumericType.SelectedValue = "0";
                    chkInterpolate.Checked = false;
                    lblErrorMsg.Text = "";
                    hf_pk_simulation_Schedule_limit.Value = "";
                    btnadd.Text = (string)GetGlobalResourceObject("Resource", "Add");
                }
            }
            hf_pk_simulation_Schedule_limit.Value = "";
            Bind_Schedule_Limit_Grid();
        }
        catch (Exception ex)
        {
            
            throw ex;
        }  
    
    }
    protected void Update_Schedule_Limit_Data(string pk_simulation_Schedule_limit)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        DataSet ds = new DataSet();
        try
        {
            obj_energy_plus_model.Pk_simulation_schedule_limit_id = new Guid(pk_simulation_Schedule_limit);
            obj_energy_plus_model.Name = txtName.Text;
            obj_energy_plus_model.Description = txtDescription.Text;
            obj_energy_plus_model.Lower_limit = txtLowerLimit.Text;
            obj_energy_plus_model.Upper_limit = txtUpperLimit.Text;
            obj_energy_plus_model.Numeric_type = rcbNumericType.Text;
            obj_energy_plus_model.Unit_type = txtUnitType.Text;
            obj_energy_plus_model.Created_by = new Guid(SessionController.Users_.UserId);
            obj_energy_plus_model.Flag = hf_flag.Value.ToString();
            if (chkInterpolate.Checked)
            {
                obj_energy_plus_model.Interpolate = 1;
            }
            else
            {
                obj_energy_plus_model.Interpolate = 0;
            }
            ds=obj_energy_plus_client.Insert_Update_Simulation_Schedule_Limit(obj_energy_plus_model, SessionController.ConnectionString);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["pk_simulation_schedule_limit_id"].ToString().Equals(Guid .Empty .ToString ()))
                {
                        lblErrorMsg.Text = "Name already exists";
                        lblErrorMsg.Visible = true;
                        btnadd .Text =(string)GetGlobalResourceObject("Resource", "Update");
                }
                else
                {
                    txtName.Text = "";
                    txtDescription.Text = "";
                    txtUnitType.Text = "";
                    txtLowerLimit.Text = "";
                    txtUpperLimit.Text = "";
                    rcbNumericType.SelectedValue = "0";
                    chkInterpolate.Checked = false;
                    lblErrorMsg.Text = "";
                    btnadd.Text = (string)GetGlobalResourceObject("Resource", "Add");
                }
               
            }
            
            Bind_Schedule_Limit_Grid();

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void rg_schedule_limit_PageIndexChanged(object sender, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            Bind_Schedule_Limit_Grid();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_schedule_limit_PageSizeChanged(object sender, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            Bind_Schedule_Limit_Grid();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_schedule_limit_SortCommand(object sender, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            Bind_Schedule_Limit_Grid();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    protected void rg_schedule_limit_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GridDataItem item = (GridDataItem)rg_schedule_limit.SelectedItems[0];//get selected row
            if (item != null)
            {
                Guid pk_simulation_schedule_limit_id = new Guid(item["pk_simulation_schedule_limit_id"].Text);
                hf_pk_simulation_Schedule_limit.Value = pk_simulation_schedule_limit_id.ToString();
                txtName.Text = item["name"].Text;
                txtLowerLimit.Text = item["lower_limit"].Text;
                txtUpperLimit.Text = item["upper_limit"].Text;
                hf_flag.Value = "";
                //rcbNumericType.SelectedItem.Text = item["numeric_type"].Text;
                if (item["description"].Text.Equals("&nbsp;"))
                {
                    txtDescription.Text = "";
                }
                else
                {
                    txtDescription.Text = item["description"].Text;
                }
                if (item["unit_type"].Text.Equals("&nbsp;"))
                {
                    txtUnitType.Text = "";
                }
                else
                {
                    txtUnitType.Text = item["unit_type"].Text;
                
                }
                
                if (item["interpolate"].Text.Equals("True"))
                {
                    chkInterpolate.Checked = true;
                }
                else
                {
                    chkInterpolate.Checked = false;
                }
                switch (item["numeric_type"].Text)
                {
                    case "CONTINUOUS":
                        rcbNumericType.SelectedValue = "1";
                        break;
                    case "DISCRETE":
                        rcbNumericType.SelectedValue = "2";
                        break;
                    default:
                        rcbNumericType.SelectedValue = "0";
                        break;

                }
                btnadd.Text = (string)GetGlobalResourceObject("Resource", "Update");
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        EnergyPlusClient obj_energy_plus_client = new EnergyPlusClient();
        EnergyPlusModel obj_energy_plus_model = new EnergyPlusModel();
        try
        {
            if (rg_schedule_limit.SelectedItems.Count > 0)
            {
                GridDataItem item = (GridDataItem)rg_schedule_limit.SelectedItems[0];//get selected row
                if (item != null)
                {

                    Guid pk_simulation_schedule_limit_id = new Guid(item["pk_simulation_schedule_limit_id"].Text);
                    obj_energy_plus_model.Pk_simulation_schedule_limit_id = pk_simulation_schedule_limit_id;
                    obj_energy_plus_client.Delete_Simulation_Schedule_Limit(obj_energy_plus_model, SessionController.ConnectionString);
                    txtName.Text = "";
                    txtDescription.Text = "";
                    txtLowerLimit.Text = "";
                    txtUpperLimit.Text = "";
                    rcbNumericType.SelectedValue = "0";
                    txtUnitType.Text = "";
                    chkInterpolate.Checked = false;
                    hf_flag.Value = "";
                    btnadd.Text = (string)GetGlobalResourceObject("Resource", "Add");
                    Bind_Schedule_Limit_Grid();
                }
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    protected void txtName_TextChanged(object sender, EventArgs e)
    {
        try
        {
            hf_flag.Value = "Y";

        }
        catch (Exception ex)
        {
            
            throw ex;
        }
    }
}