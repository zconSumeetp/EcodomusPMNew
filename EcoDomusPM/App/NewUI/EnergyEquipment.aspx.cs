using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Locations;
using EcoDomus.Session;
using System.Data;
using System.Threading;
using System.Globalization;
using Facility;

public partial class App_Asset_EnergyEquipment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindZones();
        }

    }

    protected void RadGrid1_ColumnCreated(object sender, GridColumnCreatedEventArgs e)
    {
        if (e.Column is GridGroupSplitterColumn)
        {
            e.Column.Display = false;
        }
    }

    protected void BindZones()
    {
        FacilityClient lc = new FacilityClient();
        FacilityModel lm = new FacilityModel();
        DataSet ds = new DataSet();
        try
        {
            lm.Facility_Ids = "15d87cef-5157-4359-b7a3-763e0a539246,9639c208-d53b-4ee1-b7ca-b9a562934eb3,c0ee7374-2536-410e-b145-b0e7df8ca56e,9f81e273-e214-4307-9783-8d92e1360b17,845d7ecf-e48c-4573-a315-adb0d42d449f,7272d8c3-c714-4e42-89ba-2eff1452c6f4,7cdab02b-3c4d-41d0-9c61-7c0241b1d926,725e1d9f-f030-4ecf-823f-8ac1b1c84879,173119bf-c690-4ffe-b791-494e5df53023,9ecccc15-7fc4-4677-a277-fecf3c8bcfe4,178e9212-4222-42ec-b4d6-b6bfd7ef6030";
            lm.Search_text_name = "";
            ds = lc.Get_Zones_For_Facility(lm, SessionController.ConnectionString);
            rgorders.DataSource = ds;
            rgorders.DataBind();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void RadGrid1_PreRender1(object sender, EventArgs e)
    {
        foreach (GridNestedViewItem item in rgorders.MasterTableView.GetItems(GridItemType.NestedView)) // loop through the nested items of a NestedView Template
        {
            GridDataItem parentitem = (GridDataItem)item.ParentItem;
            TableCell cell = parentitem["ExpandColumn"];
            cell.Controls.Clear();
         
        }

    }


  

}