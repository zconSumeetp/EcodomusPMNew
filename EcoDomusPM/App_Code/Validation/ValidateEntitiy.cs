using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using EcoDomus.Session;
using System.Text;
using System.Data;
using Asset;
//using EcoDomus.AccessRoles;
using System.Threading;
using System.Globalization;
using Login;
using TypeProfile;
using Facility;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for ValidateEntitiy
/// </summary>
public class ValidateEntitiy
{
	public ValidateEntitiy()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public string vaildate_asset_type(string Entity_name, string Entity_type , Guid facility_id)
    {
        string exist_flag;
        TypeProfileClient obj_client = new TypeProfileClient();
        TypeModel obj_model = new TypeModel();
        DataSet ds = new DataSet();
        try
        {
            obj_model.Entity_name = Entity_name;
            obj_model.Entity_type = Entity_type;
            obj_model.Project_id = new Guid(SessionController.Users_.ProjectId);
            obj_model.Facility_Id = facility_id;
            ds = obj_client.validate_asset_type(obj_model, SessionController.ConnectionString);
            exist_flag = ds.Tables[0].Rows[0]["exist_flag"].ToString();

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return exist_flag;
    }


}