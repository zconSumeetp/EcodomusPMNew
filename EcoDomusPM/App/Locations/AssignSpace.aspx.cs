using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using EcoDomus.Session;
using Locations;
using System.Threading;
using System.Globalization;
using Facility;

public partial class App_Locations_AssignSpace : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (SessionController.Users_.UserId != null)
            {
                if (!IsPostBack)
                {
                    hfzoneid.Value = Request.QueryString["id"].ToString();
                    Bindspaces();
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Bindspaces()
    {
        DataSet ds_zone_spaces = new DataSet();

        Locations.LocationsClient zone_ctrl = new Locations.LocationsClient();
        Locations.LocationsModel zone_mdl = new Locations.LocationsModel();

        if (Convert.ToString(SessionController.Users_.facilityID) == null || Convert.ToString(SessionController.Users_.facilityID) == "")
        {   
            Guid facility_id;
            get_zone_facility(out facility_id);
            zone_mdl.facility_ID = facility_id;
        }
        else
        {
            zone_mdl.facility_ID = new Guid(SessionController.Users_.facilityID.ToString());
        }


        zone_mdl.Location_id = new Guid(hfzoneid.Value.ToString());
        zone_mdl.CriteriaText = txtSearchText.Text;


        ds_zone_spaces = zone_ctrl.get_spaces_for_zone(zone_mdl, SessionController.ConnectionString);

        rgSpaces.DataSource = ds_zone_spaces;
        rgSpaces.DataBind();

    }

    protected void get_zone_facility(out Guid facility_id)
    {
        try
        {
            facility_id = Guid.Empty;
            DataSet ds_facility = new DataSet();
            FacilityModel mdl = new FacilityModel();
            FacilityClient cli = new FacilityClient();

            mdl.Zone_id = new Guid(hfzoneid.Value.ToString());
            ds_facility = cli.GetZoneFacility(mdl, SessionController.ConnectionString);
            facility_id = new Guid(Convert.ToString(ds_facility.Tables[0].Rows[0]["fk_facility_id"]));

        }
        catch (Exception)
        {

            throw;
        }
        finally
        {

        }


    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Bindspaces();
    }

    /// Assign space to zone 
    /// 
    /// </summary>
    protected void btnAssign_Click(object sender, EventArgs e)
    {
        //call the proc 'assign_spaces'
        //close the window
        //redirect to zones page
        //bind zones grid
        try
        {
            string id = "";
            string name = "";

            if (rgSpaces.SelectedItems.Count > 0)  //if at least one space is selected:-
            {
                for (int i = 0; i < rgSpaces.SelectedItems.Count; i++)
                {
                    id = id + rgSpaces.SelectedItems[i].Cells[2].Text + ",";
                    name = name + rgSpaces.SelectedItems[i].Cells[4].Text + ",";

                }
                id = id.Substring(0, id.Length - 1);
                name = name.Substring(0, name.Length - 1);
                name = name.Replace("'", "#");

                string zone_id = hfzoneid.Value;

                if (Request.QueryString["flag"] != "" || Request.QueryString["flag"] != null)
                {
                    if (Request.QueryString["flag"] == "zonepm")
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>Assign_space_for_zone_pm('" + id + "','" + name + "','" + zone_id + "');</script>");
                        return;
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>Assign_space_for_zone('" + id + "','" + name + "');</script>");
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>Assign_space_for_zone('" + id + "','" + name + "');</script>");
                }
            }
            else //if no any space is selected:-
            {
                ClientScript.RegisterStartupScript(this.GetType(), "script", "<script language='javascript'>alertmsg();</script>");
            }
        }
        catch (Exception ex)
        {

            Response.Write("btnSelect_Click:-" + ex.Message);
        }
    }

    protected void rgSpaces_SortCommand(object source, Telerik.Web.UI.GridSortCommandEventArgs e)
    {
        try
        {
            Bindspaces();
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    protected void rgSpaces_PageIndexChanged(object source, Telerik.Web.UI.GridPageChangedEventArgs e)
    {
        try
        {
            Bindspaces();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgSpaces_PageSizeChanged(object source, Telerik.Web.UI.GridPageSizeChangedEventArgs e)
    {
        try
        {
            Bindspaces();
        }
        catch (Exception ex)
        {

            throw ex;
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
}