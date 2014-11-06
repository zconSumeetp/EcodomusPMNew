using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for Dictionary
/// </summary>
/// 

namespace EcoDomus.Session
{
    public static partial class Dictionary
    {
        
        #region Constants

        public const string ConnectionString = "ConnectionString";

        #endregion
 
       #region Nested Classes

        #region Users

        public static class Users
        {
            public const string profile_name = "Users.ProfileName";
            public const string password_change_flag = "Users.password_change_flag";
            public const string user_enabled = "Users.user_enabled";
            public const string profileId = "Users.ProfileId";
            public const string UserId = "Users.UserId";
            public const string UserName = "Users.UserName";
            public const string UserLoginDetailId = "Users.UserLoginDetailId";
            public const string UserSystemRole = "Users.UserRoleName";
            public const string UserRoleDescription = "Users.UserRoleDescription";
            public const string OrganizationName = "Users.OrganizationName";
            public const string OrganizationID = "Users.OrganizationID";
            public const string facilityID = "Users.FacilityID";
           
            public const string facilityName = "Users.FacilityName";
            public const string ClientID = "Users.cliectID";
            public const string ClientName = "Users.ClientName";
            public const string IsFacility = "Users.IsFacility";
            public const string AssetId = "Users.AssetId";
            public const string WorkOrderID = "Users.WorkOrderID";
            public const string Spaceflag = "Users.Spaceflag";
            public const string ProjectId = "Users.ProjectId";
            public const string ProjectName = "Users.ProjectName";
            public const string Initial_ConnectionString = "Users.Initial_ConnectionString";
            public const string Initial_ClientId = "Users.Initial_ClientId";
            // Added following 5 variables for TypePM page.
            public const string TypeCheckedCheckboxes = "Users.TypeCheckedCheckboxes";
            public const string TypePageSize = "Users.TypePageSize";
            public const string DefaultPageSizeGrids = "Users.DefaultPageSizeGrids";
            public const string TypePageIndex = "Users.TypePageIndex";
            public const string TypeSortExpression = "Users.TypeSortExpression";
            public const string TypeSearchText = "Users.TypeSearchText";
            public const string TypeCount = "Users.TypeCount";
            // Added following 5 variables for ComponentPM page.
            public const string ComponentCheckedCheckboxes = "Users.ComponentCheckedCheckboxes";
            public const string ComponentPageSize = "Users.ComponentPageSize";
            public const string ComponentPageIndex = "Users.ComponentPageIndex";
            public const string ComponentSortExpression = "Users.ComponentSortExpression";
            public const string ComponentSearchText = "Users.ComponentSearchText";
            public const string ComponentCount = "Users.ComponentCount";
            public const string ComponentFacilities = "Users.ComponentFacilities";
            public const string TypeFacilities = "Users.TypeFacilities";
            public const string ComponentSelectedFacilities = "Users.ComponentSelectedFacilities";
            public const string TypeSelectedFacilities = "Users.TypeSelectedFacilities";
            /* Not in Use Plz replace your new session with following as per required*/

            public const string UserFname = "Users.UserFname";
            public const string UserMname = "Users.UserMname";
            public const string UserLname = "Users.UserLname";
            public const string TenantId = "Users.TenantId";
            public const string aspNetUserId = "Users.aspNetUserId";
            public const string UserRoleId = "Users.UserRoleId";
            public const string SystemRoleAccess = "Users.SystemRoleAccess";
            public const string is_PM_FM = "Users.is_PM_FM";
            public const string Configuration_id = "Users.Configuration_id";
            public const string External_entity_id_setupsync = "Users.External_entity_id_setupsync";
            public const string External_entity_names_setupsync = "Users.External_entity_names_setupsync";
            public const string External_system_id = "Users.External_system_id";
            public const string MasterFormatId = "Users.MasterFormatId";
            public const string action = "User.Action";
            public const string Permission_ds = "User.Permission_ds";
            public const string FileID = "User.FileID";
            public const string Em_facility_id = "User.Em_facility_id";
            public const string Em_facility_name = "User.Em_facility_name";
            public const string Em_Weather_File_Name = "User.Em_Weather_File_Name";
            /* Added for Bulk document upload*/
            public const string BulkUploadDocumentIds = "User.BulkUploadDocumentIds";
            public const string BulkUploadFacilityId = "User.BulkUploadFacilityId";
            /* End of Bulk document upload*/           
            /*Added for zone facilities*/
            public const string ZoneFacilities = "Users.ZoneFacilities";
            public const string ZoneSelectedFacilities = "Users.ZoneSelectedFacilities";
            /* End of Zone facilities*/
            /*Added for space facilities*/
            public const string SpaceFacilities = "Users.SpaceFacilities";
            public const string SpaceSelectedFacilities = "Users.SpaceSelectedFacilities";
            /* End of space facilities*/   


        }
        #endregion


#endregion
               

    }
}