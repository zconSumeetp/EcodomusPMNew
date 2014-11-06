using System;
using EcoDomus.Session;

public class SelectProjectPage : PageBase
{
    protected void SwitchContextToProject(Guid projectId, string projectName, Guid clientId, string connectionString)
    {
        SessionController.Users_.ProjectId = projectId.ToString();
        SessionController.Users_.ProjectName = projectName;
        SessionController.Users_.ClientID = clientId.ToString();
        SessionController.ConnectionString = connectionString;

        //added to kill all sessionvalues of type page
        SessionController.Users_.TypePageSize = null;
        SessionController.Users_.TypePageIndex = null;
        SessionController.Users_.TypeCount = null;
        SessionController.Users_.TypeCheckedCheckboxes = null;
        SessionController.Users_.TypeSearchText = null;
        SessionController.Users_.TypeSortExpression = null;
        SessionController.Users_.TypeFacilities = null;
        SessionController.Users_.TypeSelectedFacilities = null;
        //added to kill all sessionvalues of component page
        SessionController.Users_.ComponentPageSize = null;
        SessionController.Users_.ComponentPageIndex = null;
        SessionController.Users_.ComponentCount = null;
        SessionController.Users_.ComponentCheckedCheckboxes = null;
        SessionController.Users_.ComponentSearchText = null;
        SessionController.Users_.ComponentSortExpression = null;
        SessionController.Users_.ComponentFacilities = null;
        SessionController.Users_.ComponentSelectedFacilities = null;
        //added to kill session value of space 
        SessionController.Users_.SpaceFacilities = null;
    }
}