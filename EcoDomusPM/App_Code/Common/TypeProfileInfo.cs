using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using EcoDomus.Session;

/// <summary>
/// Summary description for TypeProfileInfo
/// </summary>

namespace EcoDomus.Common
{
    public class TypeProfileInfo
    {
        public TypeProfileInfo()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        /// <summary>
        /// method for finding Warrenty Duration Parts from Type profile ID
        /// </summary>
        /// <param name="typeID"></param>
        /// <returns></returns>
        public int GetDurationParts(string typeID)
        {

            TypeProfile.TypeProfileClient TypeClient = new TypeProfile.TypeProfileClient();
            TypeProfile.TypeModel mdl = new TypeProfile.TypeModel();
            DataSet ds_systemprofile = new DataSet();
            int durationParts = 0;
            try
            {
                mdl.Type_Id = new Guid(typeID);
                DataSet ds1 = new DataSet();
                ds1 = TypeClient.GetTypeProfileInformation(mdl, SessionController.ConnectionString);
                if (ds1.Tables[0].Rows[0]["Warranty_duration_parts"].ToString() != "")
                    durationParts = Convert.ToInt16(ds1.Tables[0].Rows[0]["Warranty_duration_parts"].ToString());
                
            }
            catch (Exception exc)
            {
                throw exc;

            }
            return durationParts;


        }


    }

}