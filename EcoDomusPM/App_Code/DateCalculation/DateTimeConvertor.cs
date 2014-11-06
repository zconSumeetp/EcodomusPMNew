using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Login;
using User;
using EcoDomus.Session;
using System.Data;

/// <summary>
/// Helper class for calculating time
/// </summary>
public class DateTimeConvertor
{
    public DateTimeConvertor()
	{

	}

    /// <summary>
    /// Convert UTC time to user's local time
    /// </summary>
    /// <param name="aUtcTime">UTC time</param>
    /// <returns>Local time if user's time zone information is available; UTC time if otherwise.</returns>
    public DateTime GetLocalDateTime(DateTime aUtcTime)
    {
        UserClient userClient = new UserClient();
        UserModel userModel = new UserModel();
        DateTime utcTime = aUtcTime;
        DateTime localTime = new DateTime(); ;
        DataSet dsTimeZoneInfo = new DataSet();
        TimeSpan timeZoneOffset = new TimeSpan();
        DateTimeOffset utcOffset;

        try
        {
            utcOffset = new System.DateTimeOffset(utcTime, TimeSpan.Zero);
            userModel.UserId = new Guid(SessionController.Users_.UserId);
            dsTimeZoneInfo = userClient.GetTimeZoneInfo(userModel);
            if (dsTimeZoneInfo.Tables.Count > 0)
            {
                timeZoneOffset = (TimeSpan)dsTimeZoneInfo.Tables[0].Rows[0]["UtcOffset"];
                localTime = utcOffset.ToOffset(timeZoneOffset).DateTime;
            }
            else
            {
                localTime = utcTime;
            }
        }
        catch (Exception ex)
        {
        }

        return localTime;
    }

    public DateTime GetLocalDateTime(DateTime utcTime, TimeSpan timeZoneOffset)
    {
        var utcOffset = new DateTimeOffset(utcTime, TimeSpan.Zero);
        return utcOffset.ToOffset(timeZoneOffset).DateTime;
    }
}