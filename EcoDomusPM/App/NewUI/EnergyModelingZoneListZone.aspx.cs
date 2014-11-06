using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EnergyPlus;
using EcoDomus.Session;
using System.Data;
using Telerik.Web.UI;
using System.Collections;

public partial class App_NewUI_EnergyModelingZoneListZone : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            lbl_header_name.Text = Request.QueryString["name"].ToString();
            string s = Request.QueryString["id"].ToString();
            getids();
            bindzonesforzonelist();
        }
    }

    public List<string> EntityIds
    {
        get
        {
            if (ViewState["EntityIds"] == null)
            {
                ViewState["EntityIds"] = new List<string>();
            }
            return (List<string>)ViewState["EntityIds"];
        }
        set
        {
            ViewState["EntityIds"] = value;
        }
    }




    protected void bindzonesforzonelist()
    {
        EnergyPlusModel em = new EnergyPlusModel();
        EnergyPlusClient ec = new EnergyPlusClient();
        DataSet ds = new DataSet();
        try
        {
            em.pk_energymodel_zonelist_id = Request.QueryString["id"].ToString();

            em.Fk_em_facility_id =new Guid(SessionController.Users_.Em_facility_id.ToString());
            em.Search_text_name = txt_search.Text;
            ds = ec.Get_energy_modeling_Zones_zonelist(em, SessionController.ConnectionString);
            rg_zones_zonelist.DataSource = ds.Tables[0];
            rg_zones_zonelist.DataBind();                       
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }


    protected void rg_zones_zonelist_PageIndexChanged(object sender, GridPageChangedEventArgs e)
    {
        GetNewSelectedRows();
        bindzonesforzonelist();
    }


    protected void rg_zones_zonelist_PageSizeChanged(object sender, GridPageSizeChangedEventArgs e)
    {
        GetNewSelectedRows();
        bindzonesforzonelist();
    }


    protected void rg_zones_zonelist_SortCommand(object sender, GridSortCommandEventArgs e)
    {
        GetNewSelectedRows();
        bindzonesforzonelist();
    }


    protected void rg_zones_zonelist_item_databound(object sender, GridItemEventArgs e)
    {
        EnergyPlusModel em = new EnergyPlusModel();
        EnergyPlusClient ec = new EnergyPlusClient();
        DataSet ds = new DataSet();
        em.pk_energymodel_zonelist_id = Request.QueryString["id"].ToString();
        em.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id.ToString());
        em.Search_text_name = txt_search.Text;
        ds = ec.Get_energy_modeling_Zones_zonelist(em, SessionController.ConnectionString);
        if(e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item; 
            string pk_location_id = e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["pk_location_id"].ToString().ToUpper();
            //foreach (DataRow dr in ds.Tables[1].Rows)
            //{
            //    if (pk_location_id == new Guid(dr["fk_energymodel_zone_id"].ToString()))
               if (EntityIds.Contains(pk_location_id))                                        
                {
                    item.Selected = true;                  
                }
            //}
        }        
    }


    protected void ibtn_close_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "close", "CloseWindow();", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void RadPanelBar1_ItemClick(object sender, Telerik.Web.UI.RadPanelBarEventArgs e)
    {

    }


    protected void btn_search_click(object sender, EventArgs e)
    {
        //GetNewSelectedRows();
        bindzonesforzonelist();
    }

    protected void GetNewSelectedRows()
    {
        foreach (GridDataItem item in rg_zones_zonelist.Items)
        {
            if (EntityIds.Contains(item.GetDataKeyValue("pk_location_id").ToString().ToUpper()) && !item.Selected)
            {
                EntityIds.Remove(item.GetDataKeyValue("pk_location_id").ToString().ToUpper());

               

            }
            else if (!EntityIds.Contains(item.GetDataKeyValue("pk_location_id").ToString().ToUpper()) && item.Selected)
            {
                EntityIds.Add(item.GetDataKeyValue("pk_location_id").ToString().ToUpper());
               
            }
        }        
    }

   
    protected void btn_apply_Click1(object sender, EventArgs e)
    {
        EnergyPlusModel em = new EnergyPlusModel();
        EnergyPlusClient ec = new EnergyPlusClient();
        GetNewSelectedRows();
        string id = String.Join(",", EntityIds.Select(x => x.ToString()).ToArray());
        if (id.StartsWith(","))
        {
            id = id.Remove(0, 1);
        }
        try
        {
            em.zoneids = id;
            em.pk_energymodel_zonelist_id = Request.QueryString["id"].ToString();
            ec.Insert_Zones_for_Zonelist(em, SessionController.ConnectionString);
            Page.ClientScript.RegisterStartupScript(GetType(), "hwa", "CloseWindow();", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        
    }

    protected void getids()
    {
        EnergyPlusModel em = new EnergyPlusModel();
        EnergyPlusClient ec = new EnergyPlusClient();
        DataSet ds = new DataSet();
        em.pk_energymodel_zonelist_id = Request.QueryString["id"].ToString();
        em.Fk_em_facility_id = new Guid(SessionController.Users_.Em_facility_id.ToString());
        em.Search_text_name = txt_search.Text;
        ds = ec.Get_energy_modeling_Zones_zonelist(em, SessionController.ConnectionString);        
        for (int i = 0; i < ds.Tables[1].Rows.Count;i++ )
        {
            EntityIds.Add(ds.Tables[1].Rows[i]["fk_energymodel_zone_id"].ToString().ToUpper());            
        }
    }
}