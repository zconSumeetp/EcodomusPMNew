using System;
using System.Globalization;
using System.Threading;
using System.Web.Routing;
using System.Web.UI;

public class PageBase : Page
{
    protected override void InitializeCulture()
    {
        try
        {
            var culture = (string) Session["Culture"] ?? "en-US";

            Thread.CurrentThread.CurrentUICulture = new CultureInfo(culture);
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(culture);
        }
        catch (Exception)
        {
            RedirectToPage("~\\app\\LoginPM.aspx?Error=Session");
        }

    }

    public void RedirectToPage(string url)
    {
        Response.Redirect(url, false);
    }

    protected void RedirectToRoute(string routeName, RouteValueDictionary queryStringParameters)
    {
        var virtualPathData = RouteTable.Routes.GetVirtualPath(null, routeName, queryStringParameters);

        var navigateUrl = virtualPathData.VirtualPath;

        Response.Redirect(navigateUrl, false);
    }
}