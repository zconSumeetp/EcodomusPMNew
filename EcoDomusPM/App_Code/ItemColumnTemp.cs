using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Telerik;
using Telerik.Web.UI;
/// <summary>
/// Summary description for ItemColumnTemp
/// </summary>
public class ItemColumnTemp:ITemplate 
{
	public ItemColumnTemp()
	{
		
	}
  public void InstantiateIn(System.Web.UI.Control Container)
    {

        RadComboBox itemComboBox = new RadComboBox();
        itemComboBox.ID = "cmbExternalSystem";
        //itemComboBox.DataBinding += new EventHandler(itemComboBox_DataBinding);

        Container.Controls.Add(itemComboBox);

 

    }

//  void itemComboBox_DataBinding(object sender, EventArgs e)

//    {
//        RadComboBox itemComboBox = (RadComboBox)sender;

//        string item = ((DataRowView)((GridDataItem)(((TableCell)itemLab.Parent).Parent)).DataItem)

 

//["ItemName"].ToString();
//        itemLab.Text = item;
//    }

}