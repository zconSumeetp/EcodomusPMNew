using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using Telerik.Web.UI.Grid;


/// <summary>
/// Summary description for Permissions
/// </summary>
public class Permissions
{
	public Permissions()
	{
		//
		// TODO: Add constructor logic here
		//

     
	}

    public void SetVisibility(TextBox txtControl, string Permission)
    {
        if (Permission == "Y")
        {
            txtControl.Visible = true;
        }
        else
        {
            txtControl.Visible = false;
        }
    }
    public void SetEditable(TextBox txtControl, string Permission)
    { 
        if (Permission == "Y")
        {
            txtControl.Enabled  = true;
        }
        else
        {
            txtControl.Enabled = false;
        }
    }

    public void SetVisibility(Label lblControl, string Permission)
    {
        if (Permission == "Y")
        {
            lblControl.Visible = true;
        }
        else
        {
            lblControl.Visible = false;
        }
    }
    public void SetEditable(Label lblControl, string Permission)
    { 
        if (Permission == "Y")
        {
            lblControl.Enabled = true;
        }
        else
        {
            lblControl.Enabled = false;
        }
    }




    public void SetEditable(RadButton btnControl, string Permission)
    {
        if (Permission == "Y")
        {
            btnControl.Enabled = true;
           
        }
        else
        {
            btnControl.Enabled = false;
          
        }
    }

    public void SetEditable(Button btnControl, string Permission)
    {
        if (Permission == "Y")
        {
            btnControl.Enabled = true;
           
        }
        else
        {
            btnControl.Enabled = false;
          
        }
    }

   

    public void SetEditable(DropDownList ddlControl, string Permission)
    {
        if (Permission == "Y")
        {
            ddlControl.Enabled = true;
        }
        else
        {
            ddlControl.Enabled = false;
        }
    }

    public void SetEditable(RadComboBox rcbControl, string Permission)
    {
        if (Permission == "Y")
        {
            rcbControl.Enabled = true;
        }
        else
        {
            rcbControl.Enabled = false;
        }
    }

    public void SetEditable(RadDatePicker rdpControl, string Permission)
    {
        if (Permission == "Y")
        {
            rdpControl.Enabled = true;
        }
        else
        {
            rdpControl.Enabled = false;
        }
    }


    public void SetEditable(ImageButton imgBtn, string Permission)
    {
        if (Permission == "Y")
        {
            imgBtn.Enabled = true;
        }
        else
        {
            imgBtn.Enabled = false;
        }
    }

      public string remove_Hyperlink(string txt)
    {
        string return_str = string.Empty;
        int start_index;
        int last_index;
        int total_length;
        int sub_legth;
        try
        {
            if (txt.Replace("&nbsp;", "") != "" && txt.ToString().Length>0)
            {

                total_length = txt.ToString().Length;
                start_index = txt.IndexOf(">") + 1;
                last_index = txt.LastIndexOf("<");
                sub_legth = last_index - start_index;
                return_str = txt.Substring(start_index, sub_legth);
            }
                return return_str;
            
        }
        catch (Exception)
        {

            throw;
        }
    }

    public string remove_Hyperlink_CSV(string txt)
    {
        string return_str = string.Empty;
        int start_index;
        int last_index;
        int total_length;
        int sub_legth;
        try
        {

            string[] space_array = txt.Split(',');
            if (space_array.Length > 0 && space_array[0].Replace("&nbsp;", "") != "")
            {
                foreach (string space in space_array)
                {
                    total_length = space.ToString().Length;
                    start_index = space.IndexOf(">") + 1;
                    last_index = space.LastIndexOf("<");
                    sub_legth = last_index - start_index;

                    return_str = return_str + space.Substring(start_index, sub_legth) + ",";
                }

            }

            return_str=return_str.TrimStart(',');
            return_str = return_str.TrimEnd(',');
            return_str=(return_str.Trim().Replace(",,", ","));
            
            return return_str;

        }
        catch (Exception)
        {

            throw;
        }
    }
    
}
    
