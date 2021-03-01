<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true" CodeFile="editProduct.aspx.cs" Inherits="im_products_editProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript" src="../../Scripts/jquery-1.12.4.js"></script>
    <script type="text/javascript">
        function ShowImagePreview(input) {
            if (input.files && input.files[0]) {

                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=ImgPrv.ClientID%>').prop('src', e.target.result)
                        .width(240)
                        .height(150);
                };
                reader.readAsDataURL(input.files[0])
                }
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-shopping-basket"></i>&nbsp;Products</b> <small style="font-size: x-small;">Manage</small></h3>
    </header>

    <div id="divForm" class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px; margin-right: 20px; margin-top: 20px;" runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Edit Product</strong></h2>
            <asp:Label Text="" ID="lblID" runat="server" />
            <p>
                <asp:ValidationSummary CssClass="w3-text-red" runat="server" ValidationGroup="1" HeaderText="Please correct these entries:" />
            </p>
            <p>
                <a class="w3-text-red">*All field are required.</a>
            </p>
            <p>
                <label class="w3-text-black"><b>Image</b></label>
                <fieldset style="width: 290px;" class="w3-padding w3-border-black">
                    <legend class="w3-center w3-large">Image will show before upload</legend>
                    <div style="text-align: center;">

                        <asp:Image ID="ImgPrv" Height="160px" Width="240px" runat="server" CssClass="w3-border w3-image" /><br />
                        <br />
                        <asp:FileUpload ID="flupImage" runat="server" onchange="ShowImagePreview(this);" />                     
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please upload the proper image file type."
                            ForeColor="Red" ControlToValidate="flupImage" Display="Dynamic" ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpg|.JPG|.gif|.GIF|.png|.PNG|.bmp|.BMP)$">
                        </asp:RegularExpressionValidator>
                    </div>
                </fieldset>

            </p>
            <p>
                <label class="w3-text-black"><b>Product Name</b></label>
                <asp:TextBox ID="txtName" CssClass="w3-input w3-border" runat="server" placeholder="Enter product name" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the product name." Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtName" runat="server" ValidationGroup="1" />
            </p>

            <p>
                <label class="w3-text-black"><b>SKU</b></label>
                <asp:TextBox ID="txtSKU" CssClass="w3-input w3-border" runat="server" placeholder="Enter SKU" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the SKU." Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtSKU" runat="server" ValidationGroup="1" />
            </p>
            <p>
                <label class="w3-text-black"><b>Price</b></label>
                <asp:TextBox ID="txtPrice" CssClass="w3-input w3-border" runat="server" placeholder="Enter price" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the price." Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtPrice" runat="server" ValidationGroup="1" />
                <asp:RegularExpressionValidator ID="reprice" ValidationExpression="^\d{0,8}(\.\d{1,2})?$" runat="server" ErrorMessage="Please Enter Your Correct Product Price" ControlToValidate="txtPrice" Display="Dynamic" CssClass="w3-text-red" ValidationGroup="1"  SetFocusOnError="True"></asp:RegularExpressionValidator>
            </p>
            <p>
                <label class="w3-text-black"><b>Quantity</b></label>
                <asp:TextBox ID="txtQuantity" TextMode="Number" CssClass="w3-input w3-border" runat="server" placeholder="Enter quantity" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the quantity." Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtQuantity" runat="server" ValidationGroup="1" />
            </p>
            <p>
                <label class="w3-text-black"><b>Description</b></label>
                <asp:TextBox ID="txtDesc" TextMode="MultiLine" Rows="3" CssClass="w3-input w3-border" runat="server" placeholder="Enter description" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the description." Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtDesc" runat="server" ValidationGroup="1" />
            </p>
            <p>
                <label class="w3-text-black"><b>Brands</b></label>
                <asp:DropDownList ID="ddlBrand" CssClass="w3-input w3-border" runat="server" DataSourceID="sqlBrand" DataTextField="brand_name" DataValueField="brand_name">
                </asp:DropDownList>
            </p>
            <p>
                <label class="w3-text-black"><b>Category</b></label>
                <asp:DropDownList ID="ddlCategory" CssClass="w3-input w3-border" runat="server" DataSourceID="sqlCategory" DataTextField="category_name" DataValueField="category_name">
                    <asp:ListItem></asp:ListItem>
                </asp:DropDownList>
            </p>
            <p>
                <label class="w3-text-black"><b>Status</b></label>
                <asp:DropDownList ID="ddlStatus" CssClass="w3-input w3-border" runat="server">
                    <asp:ListItem Value="1">Active</asp:ListItem>
                    <asp:ListItem Value="0">Inactive</asp:ListItem>
                </asp:DropDownList>
            </p>

            <p>
                <asp:Button Text="Back" runat="server" ID="btnBack" CssClass="w3-button w3-red" Width="25%" OnClick="btnBack_Click"  />
                <asp:Button Text="Save Changes" runat="server" ID="btnSave" CssClass="w3-button w3-green" Width="25%" ValidationGroup="1" OnClick="btnSave_Click" />
                <br />
                <asp:Label ID="lblError" CssClass="w3-red" Text="" runat="server" />
            </p>
        </div>
    </div>

    <asp:SqlDataSource ID="sqlBrand" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>" SelectCommand="SELECT brand_name FROM brand WHERE brand_status=1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlCategory" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>" SelectCommand="SELECT category_name FROM category WHERE category_status=1"></asp:SqlDataSource>
</asp:Content>

