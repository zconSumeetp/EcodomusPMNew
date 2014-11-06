<%@ WebHandler Language="C#" Class="GetPdf" %>

using System;
using System.Web;

public class GetPdf : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "Application/pdf";
       // context.Response.AddHeader("content-disposition", "inline; filename=ECODOMUSENDUSERLICENSEAGREEMENT.pdf");
      context.Response.WriteFile("EULADocument/ECODOMUSENDUSERLICENSEAGREEMENT.pdf");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}