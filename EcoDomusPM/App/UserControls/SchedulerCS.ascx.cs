using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using System.Globalization;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Data;
using SyncAsset;

public partial class App_UserControls_SchedulerCS : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    protected void OnControlLoad(object sender, EventArgs e)
    {
        try
        {
            RadSchedulerRecurrenceEditor1.StartDate = System.DateTime.Now;

            RadSchedulerRecurrenceEditor1.EndDate = System.DateTime.Parse("12/12/2999");
            //Ashok Jagtap Date 15/6/2012 ("Date parsing problem")
            //RadSchedulerRecurrenceEditor1.EndDate = System.DateTime.Parse("12/31/2999 00:00:00");
            String DBRecurrenceRuleText = GetSchedularDetails();

            if (DBRecurrenceRuleText != null && DBRecurrenceRuleText.Equals("") == false)
            {
                if (DBRecurrenceRuleText.Contains("MINUTES"))
                {
                    insertSchedularDetails_minutes(DBRecurrenceRuleText);
                }
                else
                {
                    if (RadSchedulerRecurrenceEditor1.RecurrenceRuleText == null || (RadSchedulerRecurrenceEditor1.RecurrenceRuleText != null && RadSchedulerRecurrenceEditor1.RecurrenceRuleText.Equals("") == true))
                    {
                        RadSchedulerRecurrenceEditor1.RecurrenceRuleText = DBRecurrenceRuleText;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public void insertSchedularDetails_minutes(string DBRecurrenceRuleText)
    {
        try
        {
            string[] sep = { "INTERVAL=" };
            string[] keys = DBRecurrenceRuleText.Split(sep, StringSplitOptions.None);
            hf_minutes_track.Value = Convert.ToString(keys[1]);

        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected String GetSchedularDetails()
    {
        try
        {
            String PkConfigurationID = SessionController.Users_.Configuration_id;
            if (PkConfigurationID == null)
                return null;

            if (PkConfigurationID.Equals("") == true)
                return null;

            DataSet ds = new DataSet();
            AssetSyncClient obj_AssetSyncClient = new AssetSyncClient();
            AssetSyncModel obj_AssetSynchModel = new AssetSyncModel();
            obj_AssetSynchModel.Pk_configuration_Id = new Guid(PkConfigurationID);
            ds = obj_AssetSyncClient.GetSchedularDetails(obj_AssetSynchModel, SessionController.ConnectionString);
            if (ds != null)
            {
                if (ds.Tables[0].Rows.Count > 0)
                    if (ds.Tables[0].Rows[0][0] != null && ds.Tables[0].Rows[0][0].ToString().Equals("") == false)
                        return ds.Tables[0].Rows[0][0].ToString();
            }
            return null;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnSaveSchedule_Click(object sender, EventArgs e)
    {
        string temp_date = DateTime.Now.ToUniversalTime().ToString("yyyy''MM''dd'T'HH''mm''ss'Z'");

        lbl_test.Text = temp_date;



        try
        {

            string new_str = string.Empty;
            String rruleText = RadSchedulerRecurrenceEditor1.RecurrenceRuleText;
            string interval = String.Format("{0}", Request.Form["txt_minutes"]);

            if (Convert.ToString(hf_minute_flag.Value) == "1")
            {

                if (Convert.ToString(hf_repeat_flag.Value) != "")
                {
                    rruleText = "";
                    rruleText = "DTSTART:";
                    rruleText = rruleText + temp_date + " DTEND:29991212T000000Z RRULE:FREQ=HOURLY;";

                    new_str = rruleText.Substring(0, rruleText.LastIndexOf("HOURLY;"));
                    new_str = new_str + "MINUTES;";
                    if (Convert.ToString(hf_repeat_flag.Value) == "3")
                    {
                        new_str = new_str + "UNTIL=" + Convert.ToString(hf_end_by_date.Value) + ";";
                    }
                    if (Convert.ToString(hf_repeat_flag.Value) == "2")
                    {
                        new_str = new_str + "COUNT=" + Convert.ToString(hf_Occurrences_no.Value) + ";";
                    }
                    new_str = new_str + "INTERVAL=" + interval;
                    rruleText = new_str;
                }
            }


            if (rruleText != null)
            {
                if (rruleText.Equals("") == false)
                {
                    DataSet ds = new DataSet();
                    AssetSyncClient obj_AssetSyncClient = new AssetSyncClient();
                    AssetSyncModel obj_AssetSynchModel = new AssetSyncModel();
                    obj_AssetSynchModel.Pk_configuration_Id = Guid.Parse(SessionController.Users_.Configuration_id);
                    obj_AssetSynchModel.RecurrenceRuleText1 = rruleText;
                    ds = obj_AssetSyncClient.UpdateSchedularDetails(obj_AssetSynchModel, SessionController.ConnectionString);
                }
            }
            Response.Redirect("SetupSyncPage.aspx");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }



}



