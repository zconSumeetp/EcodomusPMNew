using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Login;
using EcoDomus.EncrptDecrypt.CryptoHelperCs;
using Facility;

public partial class App_Locations_Facility : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {

                if (!IsPostBack)
                {
                    GetUserClientDetail();
                }
            }
            else
            {
                Response.Redirect("~\\app\\LoginPM.aspx?Error=Session");
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected void GetUserClientDetail()
    {
        try
        {
            DataSet ds = new DataSet();
            DataSet ds_facility = new DataSet();
            LoginClient login_ctrl = new LoginClient();
            LoginModel login_mdl = new LoginModel();
            CryptoHelper crypt = new CryptoHelper();
            login_mdl.UserId = new Guid(SessionController.Users_.UserId);
            ds = login_ctrl.GetUserClientDetail(login_mdl);
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow myRow in ds.Tables[0].Rows)
                {
                    DataSet ds_temp = new DataSet();
                    ds_temp = GetFacilities(crypt.Encrypt(myRow["ConnectionString"].ToString()), new Guid(myRow["pk_user_id"].ToString()), new Guid(myRow["client_id"].ToString()), myRow["ClientName"].ToString(), myRow["role"].ToString());
                    ds_facility.Merge(ds_temp);
                }
                rgFacility.Visible = true;
                ViewState["TempDataset"] = ds_facility;
                rgFacility.DataSource = ds_facility;
                rgFacility.DataBind();
            }
            else
            {
                rgFacility.Visible = false;
                lbl_msg.Text = "No facility is assigned, Contact your Organization Admin";
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetUserClientDetail :- " + ex.Message.ToString();

        }
    }

    protected DataSet GetFacilities(string con_string, Guid pk_UserID, Guid client_id, string Client_name, string role)
    {
        FacilityClient facility_crtl = new FacilityClient();
        FacilityModel facility_mdl = new FacilityModel();
        DataSet ds = new DataSet();
        try
        {
            DataColumn column;
            facility_mdl.User_Id = pk_UserID;
            facility_mdl.Client_id = client_id;
            facility_mdl.Search_text_name = srch_txt_box.Text;
            facility_mdl.Role = role;
            ds = facility_crtl.GetUserFacility(facility_mdl, con_string);
            column = new DataColumn();
            column.DataType = System.Type.GetType("System.String");
            column.ColumnName = "Client_Name";
            ds.Tables[0].Columns.Add(column);
            foreach (DataRow myRow in ds.Tables[0].Rows)
            {
                myRow["Client_Name"] = Client_name;
            }
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "GetFacilities :- " + ex.Message.ToString();
        }
        return ds;
    }
}