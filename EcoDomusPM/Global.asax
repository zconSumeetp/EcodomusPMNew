<%@ Application Language="C#" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="System.Web.Routing" %>


<script runat="server">


void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
        PropertyInfo p = typeof(System.Web.HttpRuntime).GetProperty("FileChangesMonitor", BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Static);
        object o = p.GetValue(null, null);
        FieldInfo f = o.GetType().GetField("_dirMonSubdirs", BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.IgnoreCase);
        object monitor = f.GetValue(o);
        MethodInfo m = monitor.GetType().GetMethod("StopMonitoring", BindingFlags.Instance | BindingFlags.NonPublic);
        m.Invoke(monitor, new object[] { });

        RegisterRoutes(RouteTable.Routes);
    }

    private static void RegisterRoutes(RouteCollection routes)
    {
        // ProjectMenu
        routes.MapPageRoute("ProjectMenu",
            "App/Settings/ProjectMenu.aspx",
            "~/App/Settings/ProjectMenu.aspx");

        // FacilityMenu
        routes.MapPageRoute("FacilityMenu",
            "App/Locations/FacilityMenu.aspx",
            "~/App/Locations/FacilityMenu.aspx");
        
        // ModelViewer
        routes.MapPageRoute("ModelViewer",
            "App/Settings/ModelViewer.aspx",
            "~/App/Settings/ModelViewer.aspx");

        // EcodomusModelViewer
        routes.MapPageRoute("EcodomusModelViewer",
            "App/Settings/EcodomusModelViewer.aspx",
            "~/App/Settings/EcodomusModelViewer.aspx");
    }

    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }

    protected void Application_Error(object sender, EventArgs e)
    {
        if (Server.GetLastError() != null)
        {
            Exception ex = Server.GetLastError().GetBaseException();

            Server.ClearError();

            if (!IsSpam(ex))
            {
                Context.Items["Exception"] = ex;
                Context.Items["ErrorMessage"] = ex.Message;
                Server.Transfer("~/App/Error.aspx");
            }
        }
    }

    protected bool IsSpam(Exception ex)
    {

        bool blockIp = false;

        if (ex is HttpRequestValidationException || ex is ViewStateException)
        {
            blockIp = true;
        }
        return blockIp;
    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
