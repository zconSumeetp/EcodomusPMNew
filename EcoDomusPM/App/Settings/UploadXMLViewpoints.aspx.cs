using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.IO;
using BIMModel;
using EcoDomus.Session;
using Telerik.Web.UI;
using System.Collections;
using System.Data;
public partial class App_Settings_UploadXMLViewpoints : System.Web.UI.Page
{
    Hashtable HtNode_pks = new Hashtable();
    public static Guid New_pk_default_view_id;
    string filepath = string.Empty;
    public static Guid FileId;
    public static Guid FileIdMain;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (SessionController.Users_.UserId != null)
                {
                    if (Request.QueryString["file_id"] != null && Request.QueryString["file_id"] != "0")
                    {
                        BIMModel.BIMModelClient BIMModelClient = new BIMModel.BIMModelClient();
                        BIMModel.BIMModels mdl = new BIMModel.BIMModels();


                        FileId = new Guid(Request.QueryString["file_id"].ToString());

                    }
                    if (Request.QueryString["File_id_main"] != null)
                    {
                        FileIdMain = new Guid(Request.QueryString["File_id_main"].ToString());
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btn_upload_Click(object sender, EventArgs e)
    {
        try
        {
            string nwdfilepath = System.Configuration.ConfigurationManager.AppSettings["NWDFilesPath"].ToString();
            ///string strfacilityName = SessionController.Users_.facilityID.ToString();
            string strfacilityName = Request.QueryString["facility_id"].ToString();
            string strDirExists5 = string.Empty;

            strDirExists5 = Server.MapPath(nwdfilepath + strfacilityName);

            DirectoryInfo de5 = new DirectoryInfo(strDirExists5);

            if (!de5.Exists)
            {
                de5.Create();
            }
            foreach (UploadedFile f in upload_xml.UploadedFiles)
            {
                string filename = string.Empty;
                filename = f.GetName();
                filename = filename.Replace("&", "_");
                filename = filename.Replace("#", "_");
                filename = filename.Replace("%", "_");
                filename = filename.Replace("*", "_");
                filename = filename.Replace("{", "_");
                filename = filename.Replace("}", "_");
                filename = filename.Replace("\\", "_");
                filename = filename.Replace(":", "_");
                filename = filename.Replace("<", "_");
                filename = filename.Replace(">", "_");
                filename = filename.Replace("?", "_");
                filename = filename.Replace("/", "_");
                // hfifcxmlpath.Value = f.GetName();



                if (filename.Substring(filename.Length - 3, 3).ToString().ToLower() == "xml")
                {
                    string file_path;
                    // file_path =
                    filepath = Path.Combine(Server.MapPath(nwdfilepath + strfacilityName), filename);
                    //MessageBox(filepath);
                    f.SaveAs(filepath, true);
                    InsertXmlData(filepath);

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Script", "LoadViews();", true);
                }
            }
        }

        catch (Exception ex)
        {
            throw ex;

        }
    }


    private void InsertXmlData(string filepath)
    {
        XmlTextReader reader = new XmlTextReader(filepath);
        HtNode_pks.Clear();
        reader.WhitespaceHandling = WhitespaceHandling.None;
        XmlDocument xmlDoc = new XmlDocument();
        //Load the file into the XmlDocument
        xmlDoc.Load(reader);
        //Close off the connection to the file.
        reader.Close();

        //Find the root nede, and add it togather with its childeren
        XmlNode xnod = xmlDoc.DocumentElement;
        AddWithChildren(xnod, 1);
    }

    private void AddWithChildren(XmlNode xnod, Int32 intLevel)
    {

        XmlNode xnodWorking;
        // String strIndent = new string(' ',2 * intLevel);

        //For an element node, retrive the attributes
        if (xnod.NodeType == XmlNodeType.Element)
        {
            XmlNamedNodeMap mapAttributes;

            if (xnod.Name == "View")
            {

                mapAttributes = xnod.Attributes;
                if (mapAttributes.Count > 1)
                {
                    string view_name = mapAttributes.GetNamedItem("label").Value;

                    New_pk_default_view_id = InsertXmlParametersInDatabase(view_name, Guid.Empty, FileId, DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString());
                    HtNode_pks.Add(view_name, New_pk_default_view_id);
                }

            }
           
            if (xnod.Name == "Node")
            {
                Guid parent_pk;
                XmlNode Node = xnod.ParentNode;
                if (xnod.ParentNode.Attributes.Count == 0)
                {
                    mapAttributes = xnod.ParentNode.ParentNode.Attributes;
                }
                else
                {
                    mapAttributes = xnod.Attributes;
                }
                string current_node_name = xnod.Attributes.GetNamedItem("label").Value;
                string parant_node_name = mapAttributes.GetNamedItem("label").Value;
                if (parant_node_name != "" || parant_node_name != null)
                {
                    parent_pk = new Guid(HtNode_pks[parant_node_name].ToString());

                }
                else
                {
                    parent_pk = Guid.Empty;
                }
                New_pk_default_view_id = InsertXmlParametersInDatabase(current_node_name, parent_pk, FileIdMain, DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString(), DBNull.Value.ToString());
                if (HtNode_pks.ContainsKey(current_node_name))
                {
                    HtNode_pks.Remove(current_node_name);
                }
                HtNode_pks.Add(current_node_name, New_pk_default_view_id);

            }
            if (xnod.Name == "ModelViewNode")
            {
                Guid parent_pk;
                if (xnod.ParentNode.Attributes.Count == 0)
                {
                    mapAttributes = xnod.ParentNode.ParentNode.Attributes;
                }
                else
                {
                    mapAttributes = xnod.Attributes;
                }
                string current_node_name = xnod.Attributes.GetNamedItem("label").Value;
                string parant_node_name = mapAttributes.GetNamedItem("label").Value;
                if (parant_node_name != "" || parant_node_name != null)
                {
                    parent_pk = new Guid(HtNode_pks[parant_node_name].ToString());

                }
                else
                {
                    parent_pk = Guid.Empty;
                }
                XmlNodeList list_mscene = xnod.ChildNodes;
                XmlNodeList list_camera = list_mscene[0].ChildNodes;

                string positionx = list_camera[0].Attributes.GetNamedItem("positionX").Value;
                string positiony = list_camera[0].Attributes.GetNamedItem("positionY").Value;
                string positionz = list_camera[0].Attributes.GetNamedItem("positionZ").Value;
                string targetX = list_camera[0].Attributes.GetNamedItem("targetX").Value;
                string targetY = list_camera[0].Attributes.GetNamedItem("targetY").Value;
                string targetZ = list_camera[0].Attributes.GetNamedItem("targetZ").Value;
                string upVectorX = list_camera[0].Attributes.GetNamedItem("upVectorX").Value;
                string upVectorY = list_camera[0].Attributes.GetNamedItem("upVectorY").Value;
                string upVectorZ = list_camera[0].Attributes.GetNamedItem("upVectorZ").Value;

                string fieldWidth = list_camera[0].Attributes.GetNamedItem("fieldWidth").Value;
                string fieldHeight = list_camera[0].Attributes.GetNamedItem("fieldHeight").Value;

                //**************
                Guid New_view_id = InsertXmlParametersInDatabase(current_node_name, parent_pk, FileIdMain, positionx, positiony, positionz, targetX, targetY, targetZ, upVectorX, upVectorY, upVectorZ, fieldWidth, fieldHeight);

            }
            if (xnod.Name == "ModelScene")
            {
            }

            if (xnod.Name == "Camera")
            {
            }

            //If there are any child node, call this procedrue recursively
            if (xnod.HasChildNodes)
            {
                xnodWorking = xnod.FirstChild;
                while (xnodWorking != null)
                {
                    AddWithChildren(xnodWorking, intLevel + 1);
                    xnodWorking = xnodWorking.NextSibling;
                }
            }

        }
    }

    private Guid InsertXmlParametersInDatabase(string view_name, Guid parant_id, Guid file_id, string Positionx, string Positiony, string Positionz, string Targetx, string Targety, string Targetz, string Upx, string Upy, string Upz, string Width, string Height)
    {
        BIMModels mdl = new BIMModels();
        BIMModelClient bmc = new BIMModelClient();
        BIMModels return_mdl = new BIMModels();


        mdl.View_Name = view_name;
        mdl.Parent_id = parant_id;
        mdl.File_id = file_id;
        mdl.Positionx = Positionx;
        mdl.Positiony = Positiony;
        mdl.Positionz = Positionz;
        mdl.Targetx = Targetx;
        mdl.Targety = Targety;
        mdl.Targetz = Targetz;
        mdl.Upx = Upx;
        mdl.Upy = Upy;
        mdl.Upz = Upy;

        mdl.Width = Width;
        mdl.Height = Height;
        return_mdl = bmc.InsertUpdateViewEcoDomusViewer_xml(mdl, SessionController.ConnectionString);
        Guid New_id = new Guid(return_mdl.New_pk_view_id.ToString());
        return New_id;
    }
}