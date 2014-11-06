using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public class UserControlBase : System.Web.UI.UserControl
{
    protected void ShowErrorMessage(Exception ex)
    {
        dynamic masterPage = Page.Master;
        if (masterPage != null)
            masterPage.ShowErrorMessage(ex.Message + "<br />" + ex.StackTrace);
    }

    protected bool CheckPreviousPage(string previousPageLocalPath)
    {
        if (!IsPostBack)
        {
            if (Session["LastPageLocalPath"] != null)
            {
                var lastPageLocalPath = (string)Session["LastPageLocalPath"];
                if (lastPageLocalPath == previousPageLocalPath)
                {
                    Session["LastPageLocalPath"] = null;
                }
            }
            else
            {
                return true;
            }
        }
        return false;
    }

    protected enum Command
    {
        AnchorProcessingNeeded,
        GridPageSizeCalculatingNeeded
    };

    protected const string PageIndexKey = "PageIndex";
    protected const string PageSizeKey = "PageSize";
    protected const string SearchTextKey = "SearchText";

    // IsPageSizeCalculated
    private const string IsAfterPageSizeCalculatingKey = "IsPageSizeCalculated";

    protected bool IsPageSizeCalculated
    {
        get
        {
            if (ViewState[IsAfterPageSizeCalculatingKey] != null)
            {
                return (bool)ViewState[IsAfterPageSizeCalculatingKey];
            }
            return false;
        }
        set { ViewState[IsAfterPageSizeCalculatingKey] = value; }
    }

    // SearchText
    protected string SearchText
    {
        get
        {
            return ViewState[SearchTextKey] != null
                ? (string)ViewState[SearchTextKey]
                : string.Empty;
        }
        set { ViewState[SearchTextKey] = value; }
    }

    // SearchControlText
    private const string SearchControlTextKey = "SearchControlText";

    protected string SearchControlText
    {
        get
        {
            return ViewState[SearchControlTextKey] != null
                ? (string)ViewState[SearchControlTextKey]
                : string.Empty;
        }
        set { ViewState[SearchControlTextKey] = value; }
    }

    protected void AddHistoryPoint(string searchText, int pageIndex, int pageSize)
    {
        var scriptManager = ScriptManager.GetCurrent(Page);

        if (scriptManager != null && ((scriptManager.IsInAsyncPostBack) && (!scriptManager.IsNavigating)))
        {
            var state = new NameValueCollection
            {
                {SearchTextKey, searchText},
                {PageIndexKey, pageIndex.ToString(CultureInfo.InvariantCulture)},
                {PageSizeKey, pageSize.ToString(CultureInfo.InvariantCulture)}    
            };

            if (ParentState != null && ParentState.HasKeys())
            {
                state.Add(ParentState);
            }

            //scriptManager.AddHistoryPoint(state, null);
        }
    }

    protected void ExecuteCommand(ref RadGrid radGrid, Command command, string argument)
    {
        switch (command)
        {
            case Command.GridPageSizeCalculatingNeeded:
                {
                    var gridDataDivHeight = int.Parse(argument);
                    CalculateGridPageSize(ref radGrid, gridDataDivHeight);
                    break;
                }
            case Command.AnchorProcessingNeeded:
                {
                    var anchor = argument;
                    ProcessAnchor(ref radGrid, anchor);
                    break;
                }
        }
    }

    private void CalculateGridPageSize(ref RadGrid radGrid, int gridDataDivHeight)
    {
        const int itemHeight = 29; // RadGrid row height
        var pageSize = gridDataDivHeight / itemHeight;
        if (pageSize > 0)
        {
            radGrid.PageSize = pageSize;
        }

        var scriptManager = ScriptManager.GetCurrent(Page);
        if (scriptManager != null && !scriptManager.IsNavigating)
        {
            IsPageSizeCalculated = true;
        }

        radGrid.Rebind();
    }

    private void ProcessAnchor(ref RadGrid radGrid, string anchor)
    {
        var state = HttpUtility.ParseQueryString(anchor);
        RestoreState(ref radGrid, state);
        IsPageSizeCalculated = true;
        radGrid.Rebind();
    }

    protected void RestoreState(ref RadGrid radGrid, NameValueCollection state)
    {
        int pageIndex;
        int.TryParse(state[PageIndexKey], out pageIndex);
        if (pageIndex >= 0)
        {
            radGrid.CurrentPageIndex = pageIndex;
            radGrid.MasterTableView.CurrentPageIndex = pageIndex;
        }

        int pageSize;
        int.TryParse(state[PageSizeKey], out pageSize);
        if (pageSize > 0)
        {
            radGrid.PageSize = pageSize;
            radGrid.MasterTableView.PageSize = pageSize;
        }

        var searchText = state[SearchTextKey];
        SearchText = searchText;
        SearchControlText = searchText;
    }

    protected Command GetCommandFromCommandEventArgs(CommandEventArgs e)
    {
        return (Command)Enum.Parse(typeof(Command), e.CommandName);
    }

    protected string GetCommandArgumentFromCommandEventArgs(CommandEventArgs e)
    {
        return (string)e.CommandArgument;
    }

    protected bool IsNavigating
    {
        get
        {
            var scriptManager = ScriptManager.GetCurrent(Page);

            if (scriptManager != null)
            {
                return scriptManager.IsNavigating;
            }
            return false;
        }
    }

    public bool Displayed { get; set; }

    protected readonly List<char> InvalidCharsList;

    public UserControlBase()
    {
        Displayed = true;

        var invalidCharsList = new List<char>(Path.GetInvalidFileNameChars());
        invalidCharsList.AddRange(new List<char> { '~', '.' });
        InvalidCharsList = invalidCharsList;
    }

    public NameValueCollection ParentState { get; set; }

    protected string GetClientIdWithoutInvalidCharacters()
    {
        return ClientID.Replace(InvalidCharsList, "");
    }

    protected string GetClientIdWithoutInvalidCharacters(string clientId)
    {
        return clientId.Replace(InvalidCharsList, "");
    }
}