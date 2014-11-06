using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Organization;
using System.Threading;
using System.Globalization;

public partial class App_Settings_AddNewState : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)   
    {
        if (!Page.IsPostBack)
        {
           
            if (!string.IsNullOrEmpty(Convert.ToString(Request.QueryString["flag"])))
            {
                if (Request.QueryString["flag"].ToString() == "country")
                {
                   // fieldname.InnerText = "Add new Country";
                    //lblAddCountry.Visible = true;
                    //lblAddCity.Visible = false;
                    //lblAddState.Visible = false;
                    lbl_name.Visible = false;
                    lbl_City.Visible = false;
                    lbl_Country.Visible = true;
                    hfFlag.Value = "country";
                    lbl_abbrivation.Visible = false;
                    txtAbbrivation.Visible = false;
                    BindCountry();
                }
                if (Request.QueryString["flag"].ToString() == "state")
                {
                    lbl_abbrivation.Text = lbl_abbrivation.Text + ":";
                    //fieldname.InnerText = "Add new State";
                    lblAddCountry.Visible = false;
                    lblAddCity.Visible = false;
                    lblAddState.Visible = true;
                    //lbl_name.Text = "State";
                    lbl_name.Visible = true;
                    lbl_City.Visible = false;
                    lbl_Country.Visible = false;
                    hfFlag.Value = "state";
                    BindState();

                }
                if (Request.QueryString["flag"].ToString() == "city")
                {
                   // fieldname.InnerText = "Add new City";
                    lblAddCountry.Visible = false;
                    lblAddCity.Visible = true;
                    lblAddState.Visible = false;
                    //lbl_name.Text = "City";
                    lbl_name.Visible = false;
                    lbl_City.Visible = true;
                    lbl_Country.Visible = false;
                    lbl_abbrivation.Visible = false;
                    txtAbbrivation.Visible = false;
                    BindCity();
                }

            }
        }
    }

    //To Bind City names according to selected state from previous page
    private void BindCity()
    {
        try
        {

            DataSet ds = new DataSet();
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            mdl.StateId = new Guid(Request.QueryString["Id"].ToString());
            ds = obj_ctrl.GetCity(mdl);
            lst_states.DataTextField = "Name";
            lst_states.DataValueField = "Id";
            lst_states.DataSource = ds;
            lst_states.DataBind();
           

        }
        catch (Exception ex)
        {
            lblMessage.Text = "BindCity" + ex.Message.ToString();
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

            redirect_page("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void redirect_page(string url)
    {

        Response.Redirect(url, false);

    }


    //To bind all countries
    protected void BindCountry()
    {
        DataSet ds = new DataSet();
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        ds = obj_ctrl.getCountry();
        lst_states.DataTextField = "Name";
        lst_states.DataValueField = "Id";
        lst_states.DataSource = ds;
        lst_states.DataBind();
    }

    //To Bind State names according to selected country from previous page
    protected void BindState()
    {
        try
        {
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            DataSet ds = new DataSet();
            mdl.Country_Id = new Guid(Request.QueryString["Id"].ToString());
            ds = obj_ctrl.getState(mdl);
            lst_states.DataTextField = "name";
            lst_states.DataValueField = "state_id";
            lst_states.DataSource = ds;
            lst_states.DataBind();
            txtAbbrivation.Text = "";
            
        }
        catch (Exception ex)
        {
            Response.Write("BindState" + ex.Message.ToString());
        }
    }

    //To add new city,state or country according to flag and its parent_id coming from previous page
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
        Organization.OrganizationModel mdl = new Organization.OrganizationModel();
        DataSet ds = new DataSet();
        
        lblMessage.Visible = false;
        if (txtName.Text == "")
        {
            lblMessage.Visible = true;
            lblMessage.Text = "Please insert proper value";
        }
        else
        {

        if (Request.QueryString["Id"].ToString() != "00000000-0000-0000-0000-000000000000")
        {
            mdl.Parent_id = new Guid(Request.QueryString["Id"].ToString());
        }
        else
        {
            mdl.Parent_id = Guid.Empty;
        }
        mdl.Flag = Request.QueryString["flag"];
        mdl.Name = txtName.Text;
        mdl.Abbreviation = txtAbbrivation.Text;
        ds =  obj_ctrl.InsertUpdateCityStateCountry(mdl);
        if (ds.Tables[0].Rows != null)
        {
            if (ds.Tables[0].Rows[0]["flag"].ToString() == "Abbrivation")
                lblAbbrivationError.Text = "Abbrivation aready exist, please try another";
            else if (ds.Tables[0].Rows[0]["flag"].ToString() == "State")
                lblAbbrivationError.Text = "State aready exist, please try another";
            else if (ds.Tables[0].Rows[0]["flag"].ToString() == "Empty")
                lblAbbrivationError.Text = "Please Enter Abbriviation ";
            else
                lblAbbrivationError.Text = "";
        }
         
        lblMessage.Visible = false;
        if (Request.QueryString["flag"] == "country")
        {
            BindCountry();

        }
        if (Request.QueryString["flag"] == "state")
        {
            BindState();
        }
        if (Request.QueryString["flag"] == "city")
        {
            BindCity();
        }
        
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ClearFields", "ClearFields();", true);
        }
    }

    //To Remove city,state or country according to flag parent_id coming from previous page
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        if (lst_states.SelectedValue == "" || lst_states.SelectedItem.Text == " --Select--")
        {
            lblMessage.Visible = true;
            lblMessage.Text = "Please select value from list then remove";
        }
        else
        {
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();

            mdl.Flag = Request.QueryString["flag"];
            mdl.Entity_id = new Guid(lst_states.SelectedValue);
            obj_ctrl.DeleteCityStateCountry(mdl);
            txtName.Text = "";
            txtAbbrivation.Text = "";
            if (Request.QueryString["flag"] == "country")
            {
                BindCountry();

            }
            if (Request.QueryString["flag"] == "state")
            {
                BindState();
            }
            if (Request.QueryString["flag"] == "city")
            {
                BindCity();
            }
        }
    }

    protected void lst_states_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtName.Text = lst_states.SelectedItem.ToString();
        
    }

    //To Rename city,state or country according to flag parent_id coming from previous page
    protected void btnRename_Click(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
        if (lst_states.SelectedValue == "" || lst_states.SelectedItem.Text ==" --Select--" )
        {                                                                    
            lblMessage.Visible = true;
            lblMessage.Text = "Please select Proper value from list then Rename";
        }
        else
        {
            Organization.OrganizationClient obj_ctrl = new Organization.OrganizationClient();
            Organization.OrganizationModel mdl = new Organization.OrganizationModel();
            if (Request.QueryString["Id"].ToString() != "00000000-0000-0000-0000-000000000000")
            {
                mdl.Parent_id = new Guid(Request.QueryString["Id"].ToString());
            }
            else
            {
                mdl.Parent_id = Guid.Empty;
            }
            mdl.Flag = Request.QueryString["flag"];
            mdl.Name = txtName.Text;
            mdl.Entity_id = new Guid(lst_states.SelectedValue);
            obj_ctrl.UpdateCityStateCountry(mdl);
            if (Request.QueryString["flag"] == "country")
            {
                BindCountry();

            }
            if (Request.QueryString["flag"] == "state")
            {
                BindState();
            }
            if (Request.QueryString["flag"] == "city")
            {
                BindCity();
            }
        }
    }
}