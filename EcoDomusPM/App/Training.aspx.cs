using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data;
using Login;
public partial class App_Training : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        bindvideos();
        string url = Request.Url.GetLeftPart(UriPartial.Authority) + "/" + "app/Files/Training/BC1_5.mp4";

        Bindvideoobject(url);
    }
     
    private void bindvideos()
    {
        try 
        {
            
            LoginClient loginobj = new LoginClient();

            DataSet ds = new DataSet();
            ds = loginobj.Gettrainingvideo();
            rgvideo.DataSource = ds.Tables[0];
            rgvideo.DataBind();
        }
        catch (Exception ex)
        { }

    }

    //private void bindlist()
    //{
    //    try 
    //    {
    //   LoginClient loginobj=new LoginClient();
    //   LoginModel loginmodel=new LoginModel();
           
    //   // RadListView1.InsertItem(
    //        DataSet ds= new DataSet();
    //        ds= loginobj.Gettrainingvideo();
    //        RadListView1.DataSource = ds.Tables[0];
    //        RadListView1.DataBind();
        
    //    }
    //    catch (Exception ex) { }
    //}
    private void Bindvideoobject(string URL)
    {
        string myObjectTag = "";
        try
        {
            myObjectTag = myObjectTag + "<object classid='CLSID:22D6F312-B0F6-11D0-94AB-0080C74C7E95' id='player' " + "width='640' height='480'" + " standby='Please wait while the object is loaded...'>";
            myObjectTag = myObjectTag + "<param name='url' value='" + URL + "' />";
            myObjectTag = myObjectTag + "<param name='src' value='" + URL + "' />";
            myObjectTag = myObjectTag + "<param name='AutoStart' value='true' />";
            myObjectTag = myObjectTag + "<param name='Balance' value='0' />"; //-100 is fully left, 100 is fully right.
            myObjectTag = myObjectTag + "<param name='CurrentPosition' value='0' />"; //Position in seconds when starting.
            myObjectTag = myObjectTag + "<param name='showcontrols' value='true' />"; //Show play/stop/pause controls.
            myObjectTag = myObjectTag + "<param name='enablecontextmenu' value='true' />"; //Allow right-click.
            myObjectTag = myObjectTag + "<param name='fullscreen' value='" + "false" + "' />"; //Start in full screen or not.
            myObjectTag = myObjectTag + "<param name='mute' value='false' />";
            myObjectTag = myObjectTag + "<param name='PlayCount' value='1' />"; //Number of times the content will play.
            myObjectTag = myObjectTag + "<param name='rate' value='1.0' />"; //0.5=Slow, 1.0=Normal, 2.0=Fast
            myObjectTag = myObjectTag + "<param name='uimode' value='full' />"; // full, mini, custom, none, invisible
            myObjectTag = myObjectTag + "<param name='showdisplay' value='false' />"; //Show or hide the name of the file.
            myObjectTag = myObjectTag + "<param name='volume' value='50' />"; // 0=lowest, 100=highest
            myObjectTag = myObjectTag + "</object>";

            Video.InnerHtml = myObjectTag;
        }

        catch (Exception ex)
        {

        }
    }
    protected void rgvideo_itemcommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
    {
        string url="";
        if (e.CommandName == "Play")
        {
            url = Request.Url.GetLeftPart(UriPartial.Authority) + "/" + ((System.Data.DataRowView)((e.Item).DataItem)).Row.ItemArray[3].ToString();
        }
        else
        {
            try
            {
                if (((System.Data.DataRowView)((e.Item).DataItem)).Row.ItemArray[3].ToString().Contains("avi"))
                {
                    Response.Redirect("~/" + ((System.Data.DataRowView)((e.Item).DataItem)).Row.ItemArray[3].ToString().Replace("avi", "zip"));

                }
                // Response.Redirect(Request.Url.GetLeftPart(UriPartial.Authority) + "/" + ((System.Data.DataRowView)((e.Item).DataItem)).Row.ItemArray[3].ToString());
                Response.Redirect("~/" + ((System.Data.DataRowView)((e.Item).DataItem)).Row.ItemArray[3].ToString().Replace("mp4", "zip"));

            }
            catch (Exception ex)
            {
                throw (ex);
            }//Bindvideoobject(url);
        }


        Bindvideoobject(url);
    }
    protected void rgvideo_SelectedCellChanged(object sender, EventArgs e)
    {
        string url = "";

        Bindvideoobject(url);

    }
}