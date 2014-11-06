//extern alias ALT1;
//extern alias ALT2;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using Login;
using EcoDomus.Session;
using User;

public partial class App_Reports_ActivityLogReport : System.Web.UI.Page
{
    private bool isPageSizeChanged = false; 

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;

        radCldStart.SelectedDate = DateTime.Now.Date.AddMonths(-1);
        radCldEnd.SelectedDate = DateTime.Now.Date;
    }

    //Adopting Telerik advanced data binding approach
    protected void radGrdActivityLog_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        //radGrdActivityLog.DataSource = getDefaultActivityLog();
        if (!isPageSizeChanged)
        {
            radGrdActivityLog.PageSize = Int32.Parse(SessionController.Users_.DefaultPageSizeGrids);
        }
        BindLoginActivity(false);
    }

    private void BindLoginActivity(bool export)
    {
        using (var client = new Login.LoginClient())
        {
            DateTime dt_from = new DateTime((radCldStart.SelectedDate ?? DateTime.Now).Date.Ticks, DateTimeKind.Utc);
            DateTime dt_to = new DateTime((radCldEnd.SelectedDate ?? DateTime.Now).Date.Ticks, DateTimeKind.Utc);
            var res = client.GetActivityLog2(dt_from, dt_to, txtNameLastname.Text, cbSortBy.SelectedValue, export ? 1 : radGrdActivityLog.CurrentPageIndex + 1, export ? 0 : radGrdActivityLog.PageSize);
            radGrdActivityLog.VirtualItemCount = res.TotalCount;
            radGrdActivityLog.DataSource = res.Items;            
        }
    }

    //Helper method for showing the default one month records
    private object getDefaultActivityLog()
    {
        DataSet dsOriginal = GetActivityLog();
        DataSet dsDisplay = new DataSet();
        DataTable dtDisplay = new DataTable();

        var end = DateTime.Now.AddDays(1);
        var start = end.AddMonths(-1).AddDays(1);

        dtDisplay = dsOriginal.Tables[0].AsEnumerable()
            .Where(r => r.Field<DateTime?>("session_in_time") >= start &&
                r.Field<DateTime?>("session_in_time") <= end)
                    .CopyToDataTable();

        dsDisplay.Tables.Add(dtDisplay);

        radCldStart.SelectedDate = start;
        radCldEnd.SelectedDate = end;

        return dsDisplay;
    }

    private static bool CheckDbNull(Object obj)
    {
        return obj != DBNull.Value;
    }

    private static DateTimeConvertor _dateTimeConvertor;
    private static object TryConvertToLocalTime(object obj, TimeSpan timeZoneOffset)
    {
        if (_dateTimeConvertor == null)
        {
            _dateTimeConvertor = new DateTimeConvertor();    
        }

        if (!CheckDbNull(obj)) return obj;

        var utcTime = (DateTime) obj;
        var localTime = _dateTimeConvertor.GetLocalDateTime(utcTime, timeZoneOffset);

        return localTime;
    }

    //Helper method for generating RadGrid data
    private static DataSet GetActivityLog()
    {
        var loginModel = 
            new LoginModel
            {
                ClientId = new Guid(SessionController.Users_.ClientID)
            };

        DataSet dataSetActivityLog;

        using (var loginClient = new LoginClient())
        {
            dataSetActivityLog = loginClient.GetActivityLog(loginModel);
        }

        var timeZoneOffset = GetTimeZoneOffset();

        var rows = dataSetActivityLog.Tables[0].Rows;

        const string sessionInTimeColumnName = "session_in_time";
        const string sessionOutTimeColumnName = "session_out_time";

        foreach (DataRow row in rows)
        {
            row[sessionInTimeColumnName] = TryConvertToLocalTime(row[sessionInTimeColumnName], timeZoneOffset);
            row[sessionOutTimeColumnName] = TryConvertToLocalTime(row[sessionOutTimeColumnName], timeZoneOffset);
        }

        return dataSetActivityLog;
    }

    private static TimeSpan GetTimeZoneOffset()
    {
        var userModel = new UserModel
        {
            UserId = new Guid(SessionController.Users_.UserId)    
        };

        var timeZoneOffset = TimeSpan.Zero;

        DataSet dsTimeZoneInfo;
 
        using (var userClient = new UserClient())
        {
            dsTimeZoneInfo = userClient.GetTimeZoneInfo(userModel);
        }

        if (dsTimeZoneInfo.Tables.Count > 0)
        {
            timeZoneOffset = (TimeSpan) dsTimeZoneInfo.Tables[0].Rows[0]["UtcOffset"];
        }
        
        return timeZoneOffset;
    }

    public void radGrdActivityLog_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e) {
        int currentPageSize = radGrdActivityLog.PageSize;
        if (!string.IsNullOrEmpty(hfPageSize.Value) && currentPageSize > int.Parse(hfPageSize.Value)) {
            hfPageSize.Value = currentPageSize.ToString();
        } else {
            hfPageSize.Value = SessionController.Users_.DefaultPageSizeGrids;
        }
        //if (radGrdActivityLog.Items.Count > 10) {
        //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Script", "<script language='javascript'>resize_Nice_Scroll();</script>", false);
        //}
        isPageSizeChanged = true;
    }

    //Helper method for filtering RadGrid data    
    protected void btnGenerate_OnClick(object sender, EventArgs e)
    {
        try
        {
            //applyFilters();
            radGrdActivityLog.Rebind();
        } catch (Exception ex) {
        
        }
    }

    //Helper method is for appling filters to the RadGrid data
    private void applyFilters() {
        DataSet dsOriginal = GetActivityLog();
        DataSet dsDisplay = new DataSet();
        DataTable dtDisplay = new DataTable();
        var name = txtNameLastname.Text;
        var startDate = radCldStart.DbSelectedDate;
        var endDate = radCldEnd.DbSelectedDate;
        dtDisplay = dsOriginal.Tables[0].Copy();
        if (!string.IsNullOrEmpty(name) || startDate != null || endDate != null) {
            if (!string.IsNullOrEmpty(name)) {
                dtDisplay = dtDisplay.AsEnumerable()
                    .Where(r => r.Field<string>("first_last_name")
                        .IndexOf(name, StringComparison.CurrentCultureIgnoreCase) >= 0)
                        .CopyToDataTable();
            }
            if (startDate != null) {
                dtDisplay = dtDisplay.AsEnumerable()
                    .Where(r => r.Field<DateTime?>("session_in_time") >= DateTime.Parse(startDate.ToString()))
                    .CopyToDataTable();
            }
            if (endDate != null) {
                dtDisplay = dtDisplay.AsEnumerable()
                    .Where(r => r.Field<DateTime?>("session_in_time") <= DateTime.Parse(endDate.ToString()))
                    .CopyToDataTable();
            }
        } else {

        }
        dsDisplay.Tables.Add(dtDisplay);
        radGrdActivityLog.DataSource = dsDisplay;
        radGrdActivityLog.Rebind();
    }

    //Helper method for exporting an excel file
    protected void btnExport_OnClick(object sender, EventArgs e)
    {
        /*DataSet dsOriginal = GetActivityLog();
        var name = txtNameLastname.Text;
        var startDate = radCldStart.DbSelectedDate;
        var endDate = radCldEnd.DbSelectedDate;
        if (!string.IsNullOrEmpty(name) && startDate != null && endDate != null)
        {
            var row = dsOriginal.Tables[0].AsEnumerable()
                .Where(r => r.Field<string>("first_last_name")
                    .IndexOf(name, StringComparison.CurrentCultureIgnoreCase) >= 0)
                    .FirstOrDefault();
            var fullName = row["first_last_name"].ToString();
            var start = DateTime.Parse(startDate.ToString());
            var end = DateTime.Parse(endDate.ToString());
            radGrdActivityLog.ExportSettings.FileName = fullName + "_activity_log_from_" +
                start.Date.ToString("yyyy-MM-dd") + "_to_" + end.Date.ToString("yyyy-MM-dd");
            radGrdActivityLog.ExportSettings.ExportOnlyData = true;
            radGrdActivityLog.ExportSettings.IgnorePaging = true;
        }
        else
        {
            radGrdActivityLog.ExportSettings.FileName = "activity_log_generated_on_" +
                DateTime.Now.ToString("yyyy-MM-dd");
            radGrdActivityLog.ExportSettings.ExportOnlyData = true;
            radGrdActivityLog.ExportSettings.IgnorePaging = true;
        }
        applyFilters();
        radGrdActivityLog.MasterTableView.ExportToExcel();*/
        BindLoginActivity(true);
        radGrdActivityLog.ExportSettings.ExportOnlyData = true;
        radGrdActivityLog.ExportSettings.IgnorePaging = true;
        radGrdActivityLog.MasterTableView.ExportToPdf();
    }
}