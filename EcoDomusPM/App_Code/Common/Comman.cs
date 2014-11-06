using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Comman
/// </summary>
public class Comman
{
	public Comman()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public static void DisablePageCaching()
    {
        HttpContext.Current.Response.Cache.SetNoServerCaching();
        HttpContext.Current.Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
        HttpContext.Current.Response.Cache.SetNoStore();
    } 
}