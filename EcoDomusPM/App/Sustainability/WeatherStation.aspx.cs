using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Data;
using System.Data.SqlClient;
using System.Threading;
using System.Globalization;

public partial class App_Sustainability_WeatherStation : System.Web.UI.Page
{
    public string weatherinsertupdate
    {

        get { return ViewState["weatherinsertupdate"].ToString(); }
        set { ViewState["weatherinsertupdate"] = value; }
    }


    #region Page Events

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {

                if (SessionController.Users_.UserId != null)
                {


                    getweatherstationlist();
                }
            }
        }
        catch (Exception ex)
        {
             
            throw ex;
        }


    }

    #endregion

    #region Private Methods

  

    private void getweatherstationlist()
    {
        try
        {
            Weather.WeatherClient WeatherClient = new Weather.WeatherClient();
            Weather.WeatherModel WeatherModel = new Weather.WeatherModel();

            WeatherModel.Searchtext = txtsearch.Text;
            WeatherModel.Pk_facility_weather_station_id = Guid.Empty;
            DataSet ds = WeatherClient.getWeatherstations(WeatherModel, SessionController.ConnectionString);

            rgweatherstation.DataSource = ds;
            rgweatherstation.DataBind();

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    #endregion

    #region Event Handlers

    protected void btnaddWeatherStation_click(object sender, EventArgs e)
    {
        try
        {

            tblbasserver.Style.Add("display", "inline");
            caption.InnerText = "Add Weather Station";
            btnaddWeatherStation.Visible = false;
            weatherinsertupdate = Guid.Empty.ToString();
            txtdataprovidername.Text = "";
            txturl.Text = "";
            txtstationname.Text = "";
            txtaltitude.Text = "";
            txtlatitude.Text = "";
            txtlongitude.Text = "";
            txtstationid.Text = "";
            chkbasenabled.Checked = false;

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            tblbasserver.Style.Add("display", "none");
            btnaddWeatherStation.Visible = true;


            Weather.WeatherClient WeatherClient = new Weather.WeatherClient();
            Weather.WeatherModel WeatherModel = new Weather.WeatherModel();

            WeatherModel.Pk_facility_weather_station_id = new Guid(weatherinsertupdate);
            WeatherModel.Latitude = txtlatitude.Text;
            WeatherModel.Longitude = txtlongitude.Text;
            WeatherModel.Data_provider_url = txturl.Text;
            WeatherModel.Data_provider_name = txtdataprovidername.Text.ToString();
            WeatherModel.Station_name = txtstationname.Text.ToString();
            WeatherModel.Station_id = txtstationid.Text.ToString();
            WeatherModel.Altitude_msl= txtaltitude.Text;
            WeatherModel.Enabled = chkbasenabled.Checked;
            WeatherClient.InsertUpdateWeatherinformation(WeatherModel, SessionController.ConnectionString);

            getweatherstationlist();


        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void btncancel_Click(object sender, EventArgs e)
    {
        try
        {
            tblbasserver.Style.Add("display", "none");
            btnaddWeatherStation.Visible = true;
        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    protected void rgbasserver_itemcommad(object sender, GridCommandEventArgs e)
    {
        Guid weatherstationid;
        try
        {
            if (e.CommandName == "DeleteWeather")
            {

                weatherstationid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_bas_weather_station_id"].ToString());

                Weather.WeatherClient WeatherClient = new Weather.WeatherClient();
                Weather.WeatherModel WeatherModel = new Weather.WeatherModel();


                WeatherModel.Pk_facility_weather_station_id = weatherstationid;
                WeatherClient.DeleteWeatherstations(WeatherModel, SessionController.ConnectionString);
                getweatherstationlist();

            }

            if (e.CommandName == "navigate")
            {
                tblbasserver.Style.Add("display", "inline");
                caption.InnerText = "Edit Weather Station";


                DataSet ds = new DataSet();
                weatherstationid = new Guid(e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_bas_weather_station_id"].ToString());

                Weather.WeatherClient WeatherClient = new Weather.WeatherClient();
                Weather.WeatherModel WeatherModel = new Weather.WeatherModel();


                WeatherModel.Pk_facility_weather_station_id = weatherstationid;
                WeatherModel.Searchtext = "";
                
                ds = WeatherClient.getWeatherstations(WeatherModel, SessionController.ConnectionString);
                if (ds != null)
                {
                    tblbasserver.Visible = true;
                    btnaddWeatherStation.Visible = false;

                    txtdataprovidername.Text = ds.Tables[0].Rows[0]["data_provider_name"].ToString();
                    txtaltitude.Text = ds.Tables[0].Rows[0]["altitude_msl"].ToString();
                    txtlatitude.Text = ds.Tables[0].Rows[0]["latitude"].ToString();
                    txtlongitude.Text = ds.Tables[0].Rows[0]["longitude"].ToString();
                    txturl.Text = ds.Tables[0].Rows[0]["data_provider_url"].ToString();
                    txtstationname.Text = ds.Tables[0].Rows[0]["station_name"].ToString();
                    txtstationid.Text = ds.Tables[0].Rows[0]["station_id"].ToString();
                    chkbasenabled.Checked = Convert.ToBoolean(ds.Tables[0].Rows[0]["enabled"].ToString());
                    weatherinsertupdate = weatherstationid.ToString();

                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void rgbasserver_sortcommand(object sender, GridSortCommandEventArgs e)
    {
        try
        {
            getweatherstationlist();

        }
        catch (Exception ex)
        {

            throw ex;
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

    protected void radbtnsearch_click(object sender, EventArgs e)
    {

        try
        {

            getweatherstationlist();


        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    #endregion
}