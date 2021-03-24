<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="addOrder.aspx.cs" Inherits="im_order_addOrder2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../assets/css/popout.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-shopping-cart nav-icon"></i>&nbsp;Order</b> <small style="font-size: x-small;">
            Manage</small></h3>
    </header>

    <div id="divForm" class="w3-row-padding w3-margin-bottom w3-light-grey w3-border"
        style="margin-left: 20px; margin-right: 20px; margin-top: 20px;" runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Add new order</strong></h2>
            <p>
                <table class="w3-right">
                    <tr>
                        <td class="w3-text-black w3-margin-right" style="width: 60px;"><b>Date</b></td>
                        <td>
                            <asp:Label ID="lblDate" Text="" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td class="w3-text-black w3-margin-right"><b>Time</b></td>
                        <td>
                            <asp:Label ID="lblTime" Text="" runat="server" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </p>
            <p>
                <asp:ValidationSummary CssClass="w3-text-red" runat="server" ValidationGroup="1"
                    HeaderText="Please correct these entries:" />
            </p>
            <p>
                <a class="w3-text-red">*All field are required.</a>
            </p>
            <p>
                <asp:Button ID="btnNewCustomer" Text="New Customer" runat="server" CssClass="w3-green w3-button"
                    OnClick="btnNewCustomer_Click" Width="200px" />
                <asp:Button ID="btnCustomer" Text="Existing Customer" runat="server" CssClass="w3-green w3-button"
                    OnClick="btnCustomer_Click" Width="200px" />
            </p>
            <p>
                <label class="w3-text-black"><b>Customer Name</b></label>
                <asp:TextBox ID="txtName" CssClass="w3-input w3-border" Enabled="false" runat="server"
                    placeholder="Enter customer name" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the customer name."
                    Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtName" runat="server"
                    ValidationGroup="1" />
            </p>
            <p>
                <label class="w3-text-black"><b>Customer Phone</b></label>
                <asp:TextBox ID="txtPhone" TextMode="Phone" CssClass="w3-input w3-border" Enabled="false"
                    runat="server" placeholder="Enter customer phone" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the phone number."
                    Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtPhone" runat="server"
                    ValidationGroup="1" />
            </p>
            <p>
                <label class="w3-text-black"><b>Customer Address</b></label>
                <asp:TextBox ID="txtAddress" CssClass="w3-input w3-border" Enabled="false" runat="server"
                    placeholder="Enter customer address" />
                <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the address."
                    Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtAddress" runat="server"
                    ValidationGroup="1" />
            </p>

            <br />

            <div class="w3-white w3-padding">
                <asp:GridView ID="gvProduct" runat="server" ShowHeaderWhenEmpty="True"
                    class="w3-table w3-bordered" AutoGenerateColumns="False"
                    OnRowDeleting="gvProduct_RowDeleting" OnRowUpdating="gvProduct_RowUpdating"
                    OnRowCancelingEdit="gvProduct_RowCancelingEdit" OnRowEditing="gvProduct_RowEditing"
                    CellPadding="4" ForeColor="#333333"
                    GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>Product</HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label Text='<%#Eval("product_name")%>' runat="server" />
                                <asp:Label ID="lblId2" runat="server" Text='<%#Eval("product_id")%>' Visible="false"></asp:Label>
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>Quantity</HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label Text='<%#Eval("product_qty_need")%>' runat="server"></asp:Label>

                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblId" runat="server" Text='<%#Eval("product_id")%>' Visible="false"></asp:Label>
                                <asp:TextBox ID="txtQtyNeed" Width="100px" TextMode="Number" CssClass="w3-input w3-border"
                                    Text='<%#Eval("product_qty_need")%>'
                                    runat="server"
                                    min="1" max='<%#Eval("product_qty_instock")%>' />
                            </EditItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>Rate</HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblRate" Text='<%#Eval("product_price")%>' runat="server" />
                            </ItemTemplate>

                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>Amount</HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label Text='<%#Eval("product_total_price")%>' runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderStyle-Width="300px" ItemStyle-Width="300px">
                            <ItemTemplate>
                                <asp:Button Text="Edit" CssClass="w3-button w3-green" CommandName="Edit" Width="100px"
                                    runat="server" />
                                <asp:Button Text="Delete" CssClass="w3-button w3-red" Width="100px" CommandName="Delete"
                                    runat="server" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button Text="Update" CssClass="w3-button w3-green" Width="100px" CommandName="Update"
                                    runat="server" />
                                <asp:Button Text="Cancel" CssClass="w3-button w3-red" Width="100px" CommandName="Cancel"
                                    runat="server" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EditRowStyle BackColor="#FFFFFF" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#E3EAEB" />
                    <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F8FAFA" />
                    <SortedAscendingHeaderStyle BackColor="#246B61" />
                    <SortedDescendingCellStyle BackColor="#D4DFE1" />
                    <SortedDescendingHeaderStyle BackColor="#15524A" />
                </asp:GridView>

                <br />
                <asp:Button ID="btnAddProduct" CssClass="w3-button w3-green" Text="Add Product" runat="server"
                    OnClick="btnAddProduct_Click" />
            </div>
            <br />

            <div style="width: 100%;" class="w3-container">
                <table style="width: 45%" class="w3-right w3-container">
                    <tr>
                        <td><b>Gross Amount</b></td>
                        <td>
                            <asp:TextBox ID="txtGross" runat="server" CssClass="w3-input w3-border"
                                Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td><b>Services Tax</b></td>
                        <td>
                            <asp:TextBox ID="txtService" runat="server" CssClass="w3-input w3-border" Enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td><b>Discount</b></td>
                        <td>
                            <asp:TextBox ID="txtDiscount" OnTextChanged="txtDiscount_TextChanged" TextMode="Number"
                                AutoPostBack="true" runat="server" CssClass="w3-input w3-border" />
                        </td>
                    </tr>
                    <tr>
                        <td><b>Net Amount</b></td>
                        <td>
                            <asp:TextBox ID="txtNet" runat="server" CssClass="w3-input w3-border" Enabled="false" />
                        </td>
                    </tr>
                </table>
            </div>

            <p>
                <asp:Button Text="Back" runat="server" ID="btnClose" CssClass="w3-button w3-red"
                    Width="25%" OnClick="btnClose_Click" />
                <asp:Button Text="Save Changes" runat="server" ID="btnSave" CssClass="w3-button w3-green"
                    Width="25%" ValidationGroup="1" OnClick="btnSave_Click" />
                <br />
                <asp:Label ID="lblError" CssClass="w3-red" Text="" runat="server" />
            </p>
        </div>
    </div>

   

    <div id="modalProduct" class="modal" runat="server" visible="false">
        <div class="modal-content">
            <asp:Button Text="&times;" OnClick="btnCancel_Click" BorderStyle="None"
                CssClass="close"
                runat="server" />
            <br />
            <h2><b>Select product:</b></h2>
            <hr />
            <table id="example" class="display" style="width: 99%;">

                <thead>
                    <tr>
                        <th style="width: 5%">ID</th>
                        <th style="width: 15%">Image</th>
                        <th style="width: 30%">Product Name</th>
                        <th style="width: 10%">Price</th>
                        <th style="width: 10%">Qty in Stock</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rProduct" runat="server" DataSourceID="productSQL">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label ID="lblProductId" Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Image ImageUrl='<%# img(Eval("product_img").ToString())%>' Height="100px" runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblProductName" Text='<%# Eval("product_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblProductPrice" Text='<%# Eval("product_price")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblProductQuantity" Text='<%# Eval("product_quantity")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox runat="server" min="1" max='<%# Eval("product_quantity")%>' TextMode="Number"
                                        ID="txtQty" CssClass="w3-half w3-input w3-border w3-margin-right" Width="50px" />
                                    <asp:Button ID="btnSelectProduct" CssClass="w3-button w3-green w3-half"
                                        runat="server" Width="100px" Text="Add Product" OnClick="btnSelectProduct_Click" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <br />
            <br />
            <asp:Button runat="server" CssClass="w3-button w3-red w3-padding" OnClick="btnCancel_Click"
                Width="100px" Text="Cancel" />
        </div>
    </div>

    <div id="myModal" class="modal" runat="server" visible="false">
        <!-- Modal content -->
        <div class="modal-content">
            <asp:Button Text="&times;" BorderStyle="None"
                CssClass="close" OnClick="btnCancel_Click"
                runat="server" />
            <br />
            <h2><b>Select existing customer:</b></h2>
            <hr />
            <table id="example2" class="display" style="width: 99%;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Phone</th>
                        <th>Address</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rCustomer" runat="server" DataSourceID="customerSQL">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("customer_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("customer_phone")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("customer_address")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnSelect" CssClass="w3-button w3-green w3-row w3-padding" CommandArgument='<%# Eval("Id")%>'
                                        CommandName="brandId" runat="server" Width="60px" Text="Select" OnCommand="btnSelect_Command" />
                                </td>

                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <br />
            <br />
            <asp:Button ID="btnNo" runat="server" CssClass="w3-button w3-red w3-padding"
                Width="100px" Text="Cancel" />
        </div>
    </div>

    <asp:SqlDataSource ID="productSQL" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT * FROM product WHERE product_status = 1 AND product_quantity !=0">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="customerSQL" runat="server" ConnectionString="<%$ ConnectionStrings:connStr %>"
        SelectCommand="SELECT * FROM customer"></asp:SqlDataSource>
    


    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#example').DataTable();
        });
        $(document).ready(function () {
            $('#example2').DataTable();
        });
    </script>
</asp:Content>

