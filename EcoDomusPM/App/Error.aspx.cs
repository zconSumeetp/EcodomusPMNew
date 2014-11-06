using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

public partial class Error : System.Web.UI.Page
{

    static Guid guid = Guid.NewGuid();
    static string errorMessage;
    //protected string ErrorId
    //{
    //    get
    //    {
    //        object obj = ViewState["ErrorId"];

    //        if (obj == null)
    //        {
    //            return "";
    //        }
    //        else
    //        {
    //            return obj.ToString();
    //        }
    //    }
    //    set
    //    {
    //        ViewState["ErrorId"] = value;
    //    }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            errorMessage = Context.Items["ErrorMessage"].ToString();

            Exception ex = Context.Items["Exception"] as Exception;

            if (ex == null)
            {
                ex = new Exception(errorMessage);
            }

            var context = HttpContext.Current;

            // ErrorId = Elmah.ErrorLog.GetDefault(context).Log(new Elmah.Error(ex, context));
            string Erromessage=errorMessage + Environment.NewLine + "ID=" + guid.ToString();
            lblerrormessage.Text = Erromessage;

        }
    }

    protected void btnLogError_OnClick(object sender, EventArgs e)
    {
        string subject = null;
        Session.RemoveAll();
        Session.Abandon();

        WriteLog(txtuserdesc.Text.ToString());
      

       
    }

    protected void btnredirect_click(object sender, EventArgs e)
    {
        Response.Redirect("~/App/LoginPM.aspx");
    
    }

    public void WriteLog(string strUserDesc)
    {
        try
        {
            StreamWriter SW;
            string Logfilepath = Server.MapPath(System.Configuration.ConfigurationManager.AppSettings["LogFilePath"]);
           

            if (!File.Exists(Logfilepath))
            {
                File.Create(Logfilepath);
                SW = File.AppendText(Logfilepath);

                SW.WriteLine(DateTime.Now.ToString() + " : " + guid.ToString() + " User Message= " + strUserDesc+", "  + "Error= " + errorMessage);
                SW.Close();
             //   SW.Flush();

            }
            else
            {
                SW = File.AppendText(Logfilepath);
                SW.WriteLine(DateTime.Now.ToString() + " : " + guid.ToString() + " User Message= " + strUserDesc+", "  + "Error= " + errorMessage);
                SW.Close();
               // SW.Flush();
            }

            ScriptManager.RegisterStartupScript(this, this.GetType(), "CheckUrl", "CheckUrl();", true);


        }
        catch (Exception ex)
        {
           
        }
    }
}