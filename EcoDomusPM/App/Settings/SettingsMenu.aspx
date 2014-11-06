<%@ Page Title="" Language="C#"  MasterPageFile="~/App/EcoDomus_PM_New.master"  AutoEventWireup="true"
    CodeFile="SettingsMenu.aspx.cs" Inherits="App_Settings_SettingsMenu" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link rel="stylesheet" type="text/css" href="../../App_Themes/EcoDomus/style_new_1.css" />
    <script type="text/javascript" language="javascript">


        function sitemap() {


            var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
    
            if (IsFromClient == "N") {
    
                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Library</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='Organizations.aspx'>Organizations</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Organization Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }
            else {
                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span><span><a>Project Setup</a></span>" + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='ClientOrganizations.aspx'>Organizations</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Organization Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
    }


        }

        function sitemapProductProfile() {

            var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
            var parentNode;
            var organization_prof_url;

            if (IsFromClient == "Y") {

                parentNode = "<span><a>Project Setup</a></span>";
                organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
            }
            else {
                parentNode = "<span><a>Library</a></span>";
                organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
            }

            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" +parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='SettingsMenu.aspx?organizationid=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + document.getElementById("ContentPlaceHolder1_HiddenField1").value + "'>Products</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Product Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";
        }

        function sitemapProduct() {

            var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
            var parentNode;
            var organization_prof_url;
            if (IsFromClient == "Y") {

                parentNode = "<span><a>Project Setup</a></span>";
                organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                
            }
            else {

                parentNode = "<span><a>Library</a></span>";
                organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
            }

            document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Product</span><a id='SiteMapPath1_SkipLink'></a></span>";

        }


        function pageload(flag) {
          
            if (flag == 'Organization Profile') {
                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var parentNode;
                var organization_prof_url;
                if (IsFromClient == "Y") {
                    parentNode = "<span><a>Project Setup</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    parentNode = "<span><a>Library</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                pageToLoad = "OrganizationProfile.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Organization Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";

            }
            if (flag == 'Classification') {
                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var parentNode;
                var organization_prof_url;
                if (IsFromClient == "Y") {
                    
                    parentNode = "<span><a>Project Setup</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Classification.aspx'>Organization</a></span>" + "&nbsp;";
                }
                else {
                   
                    parentNode = "<span><a>Library</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Classification.aspx'>Organization</a></span>" + "&nbsp;";
                }
                pageToLoad = "Classification.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Classification</span><a id='SiteMapPath1_SkipLink'></a></span>";


            }
            else if (flag == 'Contacts') {

                var Organization_name = document.getElementById("ContentPlaceHolder1_hforganization_name").value;

                if (Organization_name == "") {
                    Organization_name = QuseryStringValue('Organization_name');
                }

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var parentNode;
                var organization_prof_url;
                if (IsFromClient == "Y") {

                    parentNode = "<span><a>Project Setup</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    parentNode = "<span><a>Library</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }

                pageToLoad = "User.aspx?flag=no_master&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&Organization_name=" + Organization_name;

                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Contacts</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }

            else if (flag == 'Projects') {

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var IsFromProduct = document.getElementById("ContentPlaceHolder1_hfIsFromProduct").value;
                var organization_prof_url;
                var parentNode;
                if (IsFromClient == "Y") {

                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                    parentNode = "<span><a>Project Setup</a></span>";


                }
                else {

                    parentNode = "<span><a>Library</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";


                }
                if (IsFromProduct == "Y") {


                    pageToLoad = "OrganizationProject.aspx?flag=no_master&UserId=" + document.getElementById('ContentPlaceHolder1_hfOrgPrimaryContact').value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&user_role=" + document.getElementById("ContentPlaceHolder1_hfOrgPrimaryContactRole").value;
                    document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='SettingsMenu.aspx?organizationid=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + document.getElementById("ContentPlaceHolder1_HiddenField1").value + "'>Products</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Projects</span><a id='SiteMapPath1_SkipLink'></a></span>";
            
                }
                else {

                    pageToLoad = "OrganizationProject.aspx?flag=no_master&UserId=" + document.getElementById('ContentPlaceHolder1_hfOrgPrimaryContact').value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&user_role=" + document.getElementById("ContentPlaceHolder1_hfOrgPrimaryContactRole").value;

                    document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Projects</span><a id='SiteMapPath1_SkipLink'></a></span>";
                }
            }

            else if (flag == 'Links') {

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var organization_prof_url;
                if (IsFromClient == "Y") {
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                pageToLoad = "AttributeLinks.aspx?UserId=" + document.getElementById('ContentPlaceHolder1_hfOrgPrimaryContact').value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&user_role=" + document.getElementById("ContentPlaceHolder1_hfOrgPrimaryContactRole").value;
               
                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Links</span><a id='SiteMapPath1_SkipLink'></a></span>";
            }

            else if (flag == 'Products') {

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var IsFromProduct = document.getElementById("ContentPlaceHolder1_hfIsFromProduct").value;

                var organization_prof_url;
                var parentNode;

                if (IsFromClient == "Y") {
                    parentNode = "<span><a>Project Setup</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    parentNode = "<span><a>Library</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";


                }
                if (IsFromProduct == "Y") {

                    pageToLoad = "Product.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                    document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Products</span><a id='SiteMapPath1_SkipLink'></a></span>";

                }
                else {

                    pageToLoad = "Product.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                    document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Products</span><a id='SiteMapPath1_SkipLink'></a></span>";

                }

            }

            else if (flag == 'Product Profile') {
                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var organization_prof_url;
                var parentNode;

                if (IsFromClient == "Y") {

                    parentNode = "<span><a>Project Setup</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {

                    parentNode = "<span><a>Library</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }

                pageToLoad = "ProductProfile.aspx?ProductId=" + document.getElementById("ContentPlaceHolder1_hdfProductId").value + "&organization_id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='SettingsMenu.aspx?organizationid=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + document.getElementById("ContentPlaceHolder1_HiddenField1").value + "'>Products</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Product Profile</span><a id='SiteMapPath1_SkipLink'></a></span>";

            }

            else if (flag == 'Product Attributes') {

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var organization_prof_url;
                var parentNode;
                if (IsFromClient == "Y") {

                    parentNode = "<span><a>Project Setup</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    parentNode = "<span><a>Library</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                pageToLoad = "ProductAttribute.aspx?ProductId=" + document.getElementById("ContentPlaceHolder1_hdfProductId").value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='SettingsMenu.aspx?organizationid=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + document.getElementById("ContentPlaceHolder1_HiddenField1").value + "'>Products</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Product Attributes</span><a id='SiteMapPath1_SkipLink'></a></span>";

            }

            else if (flag == 'Product Documents') {
                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var organization_prof_url;
                var parentNode;
                if (IsFromClient == "Y") {
                    parentNode = "<span><a>Project Setup</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    parentNode = "<span><a>Library</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }

                pageToLoad = "ProductDocument.aspx?ProductId=" + document.getElementById("ContentPlaceHolder1_hdfProductId").value + "&Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value;

                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span><font color='red'><a style='width: 15px; height: 15px; border:0px 0px 0px 0px;' href='SettingsMenu.aspx?organizationid=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&IsfromClient=" + document.getElementById("ContentPlaceHolder1_HiddenField1").value + "'>Products</a></span></font>" + "&nbsp;" +
                                             "<span> <img id='ctl00_ctl00_SiteMapPath1_ctl05_imgSmallLogo' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                             "</span><span>Product Documents</span><a id='SiteMapPath1_SkipLink'></a></span>";


            }

            else if (flag == 'Phase') {

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var organization_prof_url;
                var parentNode;
                if (IsFromClient == "Y") {
                    parentNode = "<span><a>Project Setup</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {
                    parentNode = "<span><a>Library</a></span>"
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }

                pageToLoad = "Phases.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&Organization_name=" + document.getElementById("ContentPlaceHolder1_hforganization_name").value;


                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span><a style='text-decoration:none' href='Phases.aspx'>Phases</a></span>";

            }

            else if (flag == 'Document Type') {

                var IsFromClient = document.getElementById("ContentPlaceHolder1_HiddenField1").value;
                var organization_prof_url;
                var parentNode;

                if (IsFromClient == "Y") {

                    parentNode = "<span><a>Project Setup</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='ClientOrganizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }
                else {

                    parentNode = "<span><a>Library</a></span>";
                    organization_prof_url = "</span><span><a style='text-decoration:none' href='Organizations.aspx'>Organizations</a></span>" + "&nbsp;";
                }

                pageToLoad = "DocumentType.aspx?Organization_Id=" + document.getElementById("ContentPlaceHolder1_hfOrgid").value + "&Organization_name=" + document.getElementById("ContentPlaceHolder1_hforganization_name").value;
                document.getElementById("SiteMapPath1").innerHTML = "<span><img id='SiteMapPath1_imgBrdcrmsLogo_1' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                              "</span>" + parentNode + "&nbsp;" +

                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                               organization_prof_url +
                                             "<span><img id='SiteMapPath1_imgBrdcrmsLogo_2' src='../Images/Icons/asset_carrot_right.png' style='width: 15px; height: 15px; border:0px 0px 0px 0px;' />" + "&nbsp;" +
                                            "</span><span>Document Type</span>";

            }


           else
            { }

            loadintoIframe('frameSettingsMenu', pageToLoad);
            return false;
        }

        function QuseryStringValue(QID) {
            // Fetch the query string.
            var QStringOriginal = window.location.search.substring(1);

            // Change the case as querystring id values normally case insensitive.
            QString = QStringOriginal.toLowerCase();
            var qsValue = '';

            // QueryString ID.
            QID = QID.toLowerCase();
            // Start & end point of the QueryString Value.
            var qsStartPoint = QString.indexOf(QID);
            if (qsStartPoint != -1) {
                qsValue = QStringOriginal.substring(qsStartPoint + QID.length + 1);
                // Search for '&' in the query string;
                var qsEndPoint = qsValue.indexOf('&');
                if (qsEndPoint != -1) {
                    // retrive the QueryString value & Return it.
                    qsValue = qsValue.substring(0, qsEndPoint);
                }
                else if (qsValue.indexOf('#') != -1) {
                    // Search for '#' in the query string;
                    qsEndPoint = qsValue.indexOf('&');
                    // retrive the QueryString value & Return it.
                    qsValue = qsValue.substring(0, qsEndPoint);
                }
                else {
                    qsValue = qsValue.substring(0);
                }
            }
            return qsValue;
        }

        function loadintoIframe(iframeid, url) {
            //alert("in loading to iframe");        
            document.getElementById(iframeid).src = url;
        }


        function CallClickEvent(url) {

            window.location = url;

        }

        //To get Updated Task Id
        function UpdateTaskId(newtaskid) {

            document.getElementById("ctl00_ContentPlaceHolder1_hfOrgid").value = newtaskid;
        }



        //  On menu item onClicking event.
        function onClicking(sender, eventArgs) {

            var item = eventArgs.get_item();


            pageload(item.get_value());
            eventArgs.set_cancel(true);

        }

        function CallClickEvent(url) {

            window.location = url;
        }

        function onClientTabSelected(sender, args) {

            var newTabValue = args.get_tab().get_value();
            var tabStrip = $find("<%= rtsSettingMenu.ClientID %>");

            pageload(newTabValue);

            args.set_cancel(false);

        }



        function resize_iframe(obj) {


            try {

                document.getElementById("frameSettingsMenu").hideFocus = true;
                var oBody = frameSettingsMenu.document.body;
                var oFrame = document.all("frameSettingsMenu");
                var string = document.getElementById("frameSettingsMenu").src.toString();


                if (obj != null) {
                    docHeight = frameSettingsMenu.document.body.scrollHeight;
                    if (docHeight <= 400) {
                        document.getElementById("frameSettingsMenu").height = 600;
                    }
                    else {
                        document.getElementById("frameSettingsMenu").height = docHeight;
                    }
                }
            }

            catch (e) {
                window.status = 'Error: ' + e.number + '; ' + e.description;
            }
        }
        window.onresize = resize_iframe;
        window.onload = body_load;
        function body_load() {
            var screenhtg = set_NiceScrollToPanel();
        }
    </script>
    <table id="tblleftmenu" border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse;
        margin-top:0%; vertical-align: top;" runat="server" width="100%">
        
        <tr>
             <th>
                <asp:Label ID="lblProfileName" Visible="false" runat="server" CssClass="profileName" Text="Project Name:"></asp:Label>
            </th>
        </tr> 

        <tr>
            <td style="vertical-align: top;text-align: left;" class="centerAlign">
                <telerik:RadTabStrip ID="rtsSettingMenu" runat="server" Skin="Default" MultiPageID="RadMultiPage1"
                    OnClientTabSelecting="onClientTabSelected"  SelectedIndex="0" 
                    ontabclick="rtsSettingMenu_TabClick" AutoPostBack="true">
                </telerik:RadTabStrip>
                <div style="text-align: left;">
                    <iframe id="frameSettingsMenu" name="frameSettingsMenu" frameborder="0" marginwidth="100%"
                        onload="resize_iframe(this)" width="100%" scrolling="no" height="900"></iframe>
                </div>
                
                <div style="display: none;">
                    <asp:Button runat="server" ID="btnclick" Text="" BackColor="Transparent" OnClick="btnclick_Click" />
                    <asp:HiddenField ID="hfOrgid" runat="server" Value="0" />
                    <asp:HiddenField ID="hdfProductId" runat="server" Value="0" />
                     <asp:HiddenField ID="HiddenField1" runat="server" />
                         <asp:HiddenField ID="hfOrgPrimaryContact" runat="server" />
                <asp:HiddenField ID="hfOrgPrimaryContactRole" runat="server" />
                <asp:HiddenField ID="hforganization_name" runat="server" />
                <asp:HiddenField ID="hfSelectedIndex" runat="server" Value="0" />
                <asp:HiddenField ID="hfIsFromProduct" runat="server" />
                    </div>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadAjaxManagerProxy ID="ramAsset" runat="server">
                    <AjaxSettings>
                        <telerik:AjaxSetting AjaxControlID="btnclick">
                            <UpdatedControls>
                                <telerik:AjaxUpdatedControl ControlID="rtsSettingMenu" />
                            </UpdatedControls>
                        </telerik:AjaxSetting>
                          <telerik:AjaxSetting AjaxControlID="rtsSettingMenu">
                            <UpdatedControls>
                                <telerik:AjaxUpdatedControl ControlID="Content1" />
                            </UpdatedControls>
                        </telerik:AjaxSetting>
                    </AjaxSettings>
                </telerik:RadAjaxManagerProxy>
                <telerik:RadAjaxLoadingPanel Skin="Forest" ID="RadAjaxLoadingPanel1" runat="server"
                    Height="75px" Width="75px">
                </telerik:RadAjaxLoadingPanel>
            </td>
        </tr>
    </table>
</asp:Content>
