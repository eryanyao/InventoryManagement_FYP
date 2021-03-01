<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="im_company_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <link href="../../assets/css/popout.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-book nav-icon"></i>&nbsp;Company</b> <small style="font-size: x-small;">
            Manage</small></h3>
    </header>

    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Manage Company Information</strong></h2>
            <div>
                <p>
                    <label class="w3-text-black"><b>Company Name</b></label>
                    <asp:TextBox ID="txtCompanyName" CssClass="w3-input w3-border" runat="server" placeholder="Enter company name" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required!" Display="Dynamic" CssClass="w3-text-red"
                        ControlToValidate="txtCompanyName" runat="server" ValidationGroup="1" />
                    <asp:Label ID="lblCheck" runat="server" CssClass="w3-text-red" Visible="false" Text="Brand name already exists."></asp:Label>
                </p>
                <p>
                    <label class="w3-text-black"><b>Company Email</b></label>
                    <asp:TextBox ID="txtEmail" CssClass="w3-input w3-border" runat="server" placeholder="Enter company email" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required!" Display="Dynamic" CssClass="w3-text-red"
                        ControlToValidate="txtEmail" runat="server" ValidationGroup="1" />
                    <asp:Label ID="Label2" runat="server" CssClass="w3-text-red" Visible="false" Text="Brand name already exists."></asp:Label>
                </p>
                <p>
                    <label class="w3-text-black"><b>Company Phone</b></label>
                    <asp:TextBox ID="txtPhone" CssClass="w3-input w3-border" runat="server" placeholder="Enter company phone" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required!" Display="Dynamic" CssClass="w3-text-red"
                        ControlToValidate="txtPhone" runat="server" ValidationGroup="1" />
                    <asp:Label ID="Label4" runat="server" CssClass="w3-text-red" Visible="false" Text="Brand name already exists."></asp:Label>
                </p>
                <p>
                    <label class="w3-text-black"><b>Company Address</b></label>
                    <asp:TextBox ID="txtAddress1" CssClass="w3-input w3-border"  runat="server" placeholder="Enter address line 1" />
                    <asp:TextBox ID="txtAddress2" CssClass="w3-input w3-border" runat="server" placeholder="Enter address line 2" />
                    <asp:TextBox ID="txtAddress3" CssClass="w3-input w3-border" runat="server" placeholder="Enter address line 3" />
                   
                    <asp:Label ID="Label3" runat="server" CssClass="w3-text-red" Visible="false" Text="Brand name already exists."></asp:Label>
                </p>
                 <p>
                    <label class="w3-text-black"><b>Manager Name</b></label>
                    <asp:TextBox ID="txtManagerName" CssClass="w3-input w3-border" runat="server" placeholder="Enter manager name" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required!" Display="Dynamic" CssClass="w3-text-red"
                        ControlToValidate="txtManagerName" runat="server" ValidationGroup="1" />
                    <asp:Label ID="Label1" runat="server" CssClass="w3-text-red" Visible="false" Text="Brand name already exists."></asp:Label>
                </p>
                 <p>
                    <label class="w3-text-black"><b>Services Tax (%)</b></label>
                    <asp:TextBox ID="txtServices" CssClass="w3-input w3-border" runat="server" TextMode="Number" placeholder="Enter services tax" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required!" Display="Dynamic" CssClass="w3-text-red"
                        ControlToValidate="txtServices" runat="server" ValidationGroup="1" />
                    <asp:Label ID="Label5" runat="server" CssClass="w3-text-red" Visible="false" Text="Brand name already exists."></asp:Label>
                </p>

                <p>
                    <asp:Button Text="Save Changes" runat="server" ID="btnSave" CssClass="w3-button w3-green"
                        Width="25%" ValidationGroup="1" OnClick="btnSave_Click" />
                    <br />
                    <asp:Label ID="lblError" CssClass="w3-red" Text="" runat="server" />
                </p>
            </div>
            <br />
        </div>
    </div>

    <div id="myModal" class="modal" runat="server" visible="false">
        <!-- Modal content -->
        <div class="modal-content">
            <asp:Button Text="&times;" ID="btnCancel" OnClick="btnCancel_Click" BorderStyle="None" CssClass="close"
                runat="server" /><br />
            <p class="w3-large">Information Confirmation</p>
            <table class="w3-padding w3-table w3-bordered">
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Company Name</b></td>
                    <td>
                        <asp:Label ID="lblName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Company Email</b></td>
                    <td>
                        <asp:Label ID="lblEmail" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Company Phone</b></td>
                    <td>
                        <asp:Label ID="lblPhone" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Company Address</b></td>
                    <td>
                        <asp:Label ID="lblAddress"  runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Manager Name</b></td>
                    <td>
                        <asp:Label ID="lblManagerName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Services Tax (%)</b></td>
                    <td>
                        <asp:Label ID="lblTax" runat="server"></asp:Label></td>
                </tr>
            </table>
            <br />
            <br />
            <asp:Button ID="btnConfirm" CssClass="w3-button w3-green w3-row w3-padding"
                runat="server" Width="100px" Text="OK" OnClick="btnConfirm_Click" />
            <asp:Button ID="btnNo" runat="server" CssClass="w3-button w3-red w3-padding" OnClick="btnCancel_Click"
                Width="100px" Text="Cancel" />
        </div>
    </div>

</asp:Content>

