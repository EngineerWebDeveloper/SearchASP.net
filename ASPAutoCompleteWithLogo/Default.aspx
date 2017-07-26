<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ASPAutoCompleteWithLogo._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h4>Autocomplete Textbox With Image</h4>
        <table class="table table-responsive">
            <tr>
                <td style="width:120px"><label>Select Country :</label></td>
                <td>
                    <div class="ui-widget" style="text-align:left">
                        <asp:TextBox ID="txtCountryName" runat="server" CssClass="textboxAuto form-control" Font-Size="12px" />
                    </div>
                </td>
            </tr>
        </table>
    <style>
        .ui-autocomplete  
            {
                text-align:left;
            }
    </style>
    
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>   
    <script language="javascript" type="text/javascript">
        $(function () {
            $('#<%=txtCountryName.ClientID%>').autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "/Default.aspx/GetCompanyName",
                        data: "{'pre' :'" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {

                                return {
                                    CountryName: item.CountryName,
                                    Logo: item.Logo,
                                    json: item
                                }
                            }))
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                focus: function (event, ui) {
                    // this is for when focus of autocomplete item 
                    $('#<%=txtCountryName.ClientID%>').val(ui.item.CountryName);
                    return false;
                },
                select: function (event, ui) {
                    // this is for when select autocomplete item
                    $('#<%=txtCountryName.ClientID%>').val(ui.item.CountryName);
                    return false;
                }
            }).data("ui-autocomplete")._renderItem = function (ul, item) {
                // here return item for autocomplete text box, Here is the place 
                // where we can modify data as we want to show as autocomplete item
                return $("<li>")
                .append("<a style='padding-left:40px; background-image:url(/CountryLogo/" + item.Logo + ");" +
                "background-repeat:no-repeat;background-position:left center;' >" + item.CountryName + "</a>").appendTo(ul);
            };
        });
    </script>
</asp:Content>
 
