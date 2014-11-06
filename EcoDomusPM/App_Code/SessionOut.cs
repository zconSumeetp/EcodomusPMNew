using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Login;
using EcoDomus.Session;

/// <summary>
/// Summary description for SessionOut
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class SessionOut : System.Web.Services.WebService
{

    public SessionOut () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    //To keep logout time records when a browser is closed: Kongkun  
    [WebMethod(EnableSession = true)]
    public void UpdateSessionOutTime()
    {
        LoginClient loginControl = new LoginClient();
        LoginModel loginModel = new LoginModel();

        loginModel.UserId = new Guid(SessionController.Users_.UserId.ToString());
        loginModel.LoginId = new Guid(SessionController.Users_.UserLoginDetailId.ToString());
        loginModel.SessionOutTime = DateTime.Now.ToUniversalTime();

        int rowUpdated = loginControl.UpdateLoginUsersessionDetail(loginModel);
    }
    
}
