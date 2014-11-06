using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for SessionController
/// </summary>
/// 

namespace EcoDomus.Session
{
    public partial class SessionController
    {

        #region ConnectionString

        public static string ConnectionString
        {
            get { return (string)HttpContext.Current.Session[Dictionary.ConnectionString]; }
            set { HttpContext.Current.Session[Dictionary.ConnectionString] = value; }
        }

        #endregion

       
        #region Users



        public static class Users_
        {
            public static string ProfileName
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.profile_name];}
                set { HttpContext.Current.Session[Dictionary.Users.profile_name] = value; }
            }

            public static bool Password_Change_Flag
            {
                get { return (bool)HttpContext.Current.Session[Dictionary.Users.password_change_flag]; }
                set { HttpContext.Current.Session[Dictionary.Users.password_change_flag] = value; }
            }
            public static bool User_enabled
            {
                get { return (bool)HttpContext.Current.Session[Dictionary.Users.user_enabled]; }
                set { HttpContext.Current.Session[Dictionary.Users.user_enabled] = value; }
            }

            public static string Profileid
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.profileId]; }
                set { HttpContext.Current.Session[Dictionary.Users.profileId] = value; }
            }


            public static string UserId
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.UserId]; }
                set { HttpContext.Current.Session[Dictionary.Users.UserId] = value; }
            }

            public static string UserName
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.UserName]; }
                set { HttpContext.Current.Session[Dictionary.Users.UserName] = value; }
            }
            public static string UserLoginDetailId
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.UserLoginDetailId]; }
                set { HttpContext.Current.Session[Dictionary.Users.UserLoginDetailId] = value; }
            }
            public static string UserSystemRole
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.UserSystemRole]; }
                set { HttpContext.Current.Session[Dictionary.Users.UserSystemRole] = value; }
            }
            public static string UserRoleDescription
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.UserRoleDescription]; }
                set { HttpContext.Current.Session[Dictionary.Users.UserRoleDescription] = value; }
            }
            public static string OrganizationName
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.OrganizationName]; }
                set { HttpContext.Current.Session[Dictionary.Users.OrganizationName] = value; }
            }
            public static string OrganizationID
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.OrganizationID]; }
                set { HttpContext.Current.Session[Dictionary.Users.OrganizationID] = value; }
            }
            public static string facilityID
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.facilityID]; }
                set { HttpContext.Current.Session[Dictionary.Users.facilityID] = value; }
            }
            public static string facilityName
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.facilityName]; }
                set { HttpContext.Current.Session[Dictionary.Users.facilityName] = value; }
            }

            public static string ClientID
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ClientID]; }
                set { HttpContext.Current.Session[Dictionary.Users.ClientID] = value; }
            }

            public static string ClientName
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ClientName]; }
                set { HttpContext.Current.Session[Dictionary.Users.ClientName] = value; }
            }

            public static string IsFacility
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.IsFacility]; }
                set { HttpContext.Current.Session[Dictionary.Users.IsFacility] = value; }
            }
            public static string AssetId
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.AssetId]; }
                set { HttpContext.Current.Session[Dictionary.Users.AssetId] = value; }
            }

            public static string WorkOrderID
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.WorkOrderID]; }
                set { HttpContext.Current.Session[Dictionary.Users.WorkOrderID] = value; }
            }


            public static string SystemRoleAccess
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.SystemRoleAccess]; }
                set { HttpContext.Current.Session[Dictionary.Users.SystemRoleAccess] = value; }
            }


            public static string Spaceflag
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.Spaceflag]; }
                set { HttpContext.Current.Session[Dictionary.Users.Spaceflag] = value; }
            }

            public static string is_PM_FM
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.is_PM_FM]; }
                set { HttpContext.Current.Session[Dictionary.Users.is_PM_FM] = value; }

             }
            public static string ProjectId
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ProjectId]; }
                set { HttpContext.Current.Session[Dictionary.Users.ProjectId] = value; }
            }

            public static string ProjectName
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ProjectName]; }
                set { HttpContext.Current.Session[Dictionary.Users.ProjectName] = value; }
            }


            public static string External_entity_names_setupsync
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.External_entity_names_setupsync]; }
                set { HttpContext.Current.Session[Dictionary.Users.External_entity_names_setupsync] = value; }
            }

            public static string External_entity_id_setupsync
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.External_entity_id_setupsync]; }
                set { HttpContext.Current.Session[Dictionary.Users.External_entity_id_setupsync] = value; }
            }

            public static string Configuration_id
            {
                get 
                {
                    return (string)HttpContext.Current.Session[Dictionary.Users.Configuration_id]; 
                }
                set 
                {
                    HttpContext.Current.Session[Dictionary.Users.Configuration_id] = value; 
                }
            }


            public static string External_system_id
            {
                get
                {
                    return (string)HttpContext.Current.Session[Dictionary.Users.External_system_id];
                }
                set
                {
                    HttpContext.Current.Session[Dictionary.Users.External_system_id] = value;
                }
            }

            public static string FileID
            {
                get {
                    return (string)HttpContext.Current.Session[Dictionary.Users.FileID];
                }
                set
                {
                    HttpContext.Current.Session[Dictionary.Users.FileID] = value;
                }
            }


            public static string MasterFormatId
            {
                get
                {
                    return (string)HttpContext.Current.Session[Dictionary.Users.MasterFormatId];
                }
                set
                {
                    HttpContext.Current.Session[Dictionary.Users.MasterFormatId] = value;
                }

            }
            public static string Action
            {
                get
                {
                    return (string)HttpContext.Current.Session[Dictionary.Users.action];
                }
                set
                {
                    HttpContext.Current.Session[Dictionary.Users.action] = value;
                }

            }

            public static DataSet Permission_ds
            {
                get { return (DataSet)HttpContext.Current.Session[Dictionary.Users.Permission_ds]; }
                
                set { HttpContext.Current.Session[Dictionary.Users.Permission_ds] = value; }
            }

            public static string Em_facility_id
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.Em_facility_id]; }
                set { HttpContext.Current.Session[Dictionary.Users.Em_facility_id] = value; }
            }

            public static string Initial_ConnectionString
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.Initial_ConnectionString]; }
                set { HttpContext.Current.Session[Dictionary.Users.Initial_ConnectionString] = value; }
            }
            public static string Initial_ClientId
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.Initial_ClientId]; }
                set { HttpContext.Current.Session[Dictionary.Users.Initial_ClientId] = value; }
            }
            // For TypePM page:-
            public static string TypeCheckedCheckboxes
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypeCheckedCheckboxes]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypeCheckedCheckboxes] = value; }
            }
            public static string TypePageSize
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypePageSize]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypePageSize] = value; }
            }
            public static string DefaultPageSizeGrids
            {
                get { 
                    // to prevent from negative value
                    uint pageSize = 0;
                    if (uint.TryParse((string)HttpContext.Current.Session[Dictionary.Users.DefaultPageSizeGrids], out pageSize))
                    {
                        if (pageSize == 0)
                            pageSize = 100;
                    }
                    else
                    {
                        pageSize = 100;
                    }
                    return Convert.ToString(pageSize);
                    
                    //return (string)HttpContext.Current.Session[Dictionary.Users.DefaultPageSizeGrids]; 
                }
                set { HttpContext.Current.Session[Dictionary.Users.DefaultPageSizeGrids] = value; }
            }
            public static string TypePageIndex
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypePageIndex]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypePageIndex] = value; }
            }
            public static string TypeSortExpression
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypeSortExpression]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypeSortExpression] = value; }
            }
            public static string TypeSearchText
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypeSearchText]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypeSearchText] = value; }
            }
            public static string TypeCount
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypeCount]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypeCount] = value; }
            }
            // For TypePM page  end-------------------------------------
            // For ComponentPM page:-
            public static string ComponentCheckedCheckboxes
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentCheckedCheckboxes]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentCheckedCheckboxes] = value; }
            }
            public static string ComponentPageSize
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentPageSize]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentPageSize] = value; }
            }
            public static string ComponentPageIndex
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentPageIndex]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentPageIndex] = value; }
            }
            public static string ComponentSortExpression
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentSortExpression]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentSortExpression] = value; }
            }
            public static string ComponentSearchText
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentSearchText]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentSearchText] = value; }
            }
            public static string ComponentCount
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentCount]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentCount] = value; }
            }
            public static string ComponentFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentFacilities] = value; }
            }
            public static string TypeFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypeFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypeFacilities] = value; }
            }
            public static string ComponentSelectedFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ComponentSelectedFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.ComponentSelectedFacilities] = value; }
            }
            public static string TypeSelectedFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.TypeSelectedFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.TypeSelectedFacilities] = value; }
            }
            public static string Em_facility_name
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.Em_facility_name]; }
                set { HttpContext.Current.Session[Dictionary.Users.Em_facility_name] = value; }
            }

            public static string Em_Weather_File_Name
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.Em_Weather_File_Name]; }
                set { HttpContext.Current.Session[Dictionary.Users.Em_Weather_File_Name] = value; }
            }

            // For ComponentPM page  end-------------------------------------

            
            // Added for bulk document upload
            public static string BulkUploadDocumentIds
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.BulkUploadDocumentIds]; }
                set { HttpContext.Current.Session[Dictionary.Users.BulkUploadDocumentIds] = value; }
            }

            public static string BulkUploadFacilityId
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.BulkUploadFacilityId]; }
                set { HttpContext.Current.Session[Dictionary.Users.BulkUploadFacilityId] = value; }
            }
            // End of bulk document upload

            // added for zone facilities
            public static string ZoneFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ZoneFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.ZoneFacilities] = value; }
            }
            public static string ZoneSelectedFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.ZoneSelectedFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.ZoneSelectedFacilities] = value; }
            }
            // end of  zone facilities


            // added for Space facilities
            public static string SpaceFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.SpaceFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.SpaceFacilities] = value; }
            }
            public static string SpaceSelectedFacilities
            {
                get { return (string)HttpContext.Current.Session[Dictionary.Users.SpaceSelectedFacilities]; }
                set { HttpContext.Current.Session[Dictionary.Users.SpaceSelectedFacilities] = value; }
            }
            // end of  Space facilities



          }
        #endregion
    }
}
