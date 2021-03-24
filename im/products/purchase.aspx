<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="purchase.aspx.cs" Inherits="im_products_stockIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../assets/css/popout.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-shopping-basket"></i>&nbsp;Products</b> <small style="font-size: x-small;">
            Manage</small></h3>
    </header>

    <div id="divForm" class="w3-row-padding w3-margin-bottom w3-light-grey w3-border"
        style="margin-left: 20px; margin-right: 20px; margin-top: 20px;" runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Replenishment</strong></h2>
            <p>
                <asp:Button Text="Select Product" runat="server" ID="btnShowBrand" CssClass="w3-button w3-border w3-green"
                    OnClick="btnShowBrand_Click"
                    Width="200px" />
                <asp:Button Text="History" runat="server" ID="btnShowHistory" CssClass="w3-button w3-border w3-green"
                   OnClick="btnShowHistory_Click"
                    Width="200px" />
            </p>
            <div id="divShow" runat="server">
                <p>
                    <asp:ValidationSummary CssClass="w3-text-red" runat="server" ValidationGroup="1"
                        HeaderText="Please correct these entries:" />
                </p>
                <p>
                    <a class="w3-text-red">*All field are required.</a>
                </p>
                
                <table>
                    <tr>
                        <td style="width:200px;">
                             <label class="w3-text-black"><b>Product ID</b></label>
                        </td>
                        <td>
                             <asp:Label ID="lblProductId" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <label class="w3-text-black"><b>Product Name</b></label>
                        </td>
                        <td>
                             <asp:Label ID="lblProductName" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="w3-text-black"><b>Qty Available</b></label>
                        </td>
                        <td>
                             <asp:Label ID="lblQtyInStock" runat="server" />
                        </td>
                    </tr>
                </table>
               
                <p>
                    <label class="w3-text-black"><b>Purchase Quantity</b></label>
                    <asp:TextBox ID="txtQuantity" TextMode="Number" CssClass="w3-input w3-border" runat="server"
                        placeholder="Enter quantity" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the quantity."
                        Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtQuantity" runat="server"
                        ValidationGroup="1" />
                </p>
                <p>
                    <label class="w3-text-black"><b>Total Price</b></label>
                    <asp:TextBox ID="txtPrice" CssClass="w3-input w3-border" runat="server" placeholder="Enter price" />
                    <asp:RequiredFieldValidator ErrorMessage="Field Required! Please enter the price."
                        Display="Dynamic" CssClass="w3-text-red" ControlToValidate="txtPrice" runat="server"
                        ValidationGroup="1" />
                    <asp:RegularExpressionValidator ID="reprice" ValidationExpression="^\d{0,8}(\.\d{1,2})?$"
                        runat="server" ErrorMessage="Please Enter Your Correct Product Price" ControlToValidate="txtPrice"
                        Display="Dynamic" CssClass="w3-text-red" ValidationGroup="1" SetFocusOnError="True"></asp:RegularExpressionValidator>
                </p>
                 <p>
                    <label class="w3-text-black"><b>Remarks</b></label>
                    <asp:TextBox ID="txtRemark" CssClass="w3-input w3-border" runat="server"
                        placeholder="Enter remarks" />    
                </p>
                <p>
                <asp:Button Text="Back" runat="server" ID="btnClose" CssClass="w3-button w3-red" Width="25%" OnClick="btnClose_Click"  />
                <asp:Button Text="Save Changes" runat="server" ID="btnSave" CssClass="w3-button w3-green" Width="25%" ValidationGroup="1" OnClick="btnSave_Click"  />
                <br />
                <asp:Label ID="lblError" CssClass="w3-red" Text="" runat="server" />
            </p>
            </div>

        </div>
    </div>

     <div id="modalHistory" class="modal" runat="server" visible="false">
        <div class="modal-content">
            <asp:Button Text="&times;" OnClick="btnCancel_Click" BorderStyle="None"
                CssClass="close"
                runat="server" />
            <br />
            <h2><b>Purchases History:</b></h2>
            <hr />
             <button class="w3-button w3-border w3-green" id="print" style="width:100px;" onclick="printContent('example2');">
            Print</button><br /><br />
          
            <table id="example2" class="display" style="width: 99%;">

                <thead>
                    <tr>
                        <th style="width: 10%">Product ID</th>
                        <th>Date time</th>
                        <th >Product Name</th>
                        <th style="width: 10%">Purchase Qty</th>
                        <th style="width: 10%">Price</th>
                        <th >Remark</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="Repeater1" runat="server" DataSourceID="historySQL">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("datetime")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("qty")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("price")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("remark")%>' runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
                
            </div>
            <br />
            <br />
            <asp:Button runat="server" CssClass="w3-button w3-red w3-padding" OnClick="btnCancel_Click"
                Width="100px" Text="Cancel" />
  
    </div>

    <div id="myModal" class="modal" runat="server" visible="false">
        <!-- Modal content -->
        <div class="modal-content">
            <asp:Button Text="&times;" ID="btnCancel" OnClick="btnCancel_Click" BorderStyle="None" CssClass="close"
                runat="server" /><br />
            <p class="w3-large">Purchase Confirmation</p>
            <table class="w3-padding w3-table w3-bordered">
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Product ID</b></td>
                    <td>
                        <asp:Label ID="lblModalId" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Product Name</b></td>
                    <td>
                        <asp:Label ID="lblModalName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Purchase Quantity</b></td>
                    <td>
                        <asp:Label ID="lblModalQty" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Total Price</b></td>
                    <td>
                        <asp:Label ID="lblModalPrice"  runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Remarks</b></td>
                    <td>
                        <asp:Label ID="lblModalRemark" runat="server"></asp:Label></td>
                </tr>
            </table>
            <br />
            <br />
            <asp:Button ID="btnConfirm" CssClass="w3-button w3-green w3-row w3-padding"
                runat="server" Width="100px" Text="Confirm" OnClick="btnConfirm_Click" />
            <asp:Button ID="btnNo" runat="server" CssClass="w3-button w3-red w3-padding" OnClick="btnCancel_Click"
                Width="100px" Text="Cancel" />
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
                        <th>Category</th>
                        <th>Brand</th>
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
                                    <asp:Image ImageUrl='<%# img(Eval("product_img").ToString())%>' Height="50px" runat="server" />
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
                                    <asp:Label ID="lblProductCategory" Text='<%# Eval("product_category")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label ID="lblProductBrand" Text='<%# Eval("product_brand")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnSelectProduct" CssClass="w3-button w3-green w3-half"
                                        runat="server" Text="Select" CommandArgument='<%# Eval("Id")%>' CommandName="productId" OnCommand="btnSelectProduct_Command" />
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
    <asp:HiddenField ID="searchCmd" runat="server" />

    <asp:SqlDataSource ID="productSQL" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT * FROM product"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBrand" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT brand_name FROM brand WHERE brand_status=1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlCategory" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT category_name FROM category WHERE category_status=1"></asp:SqlDataSource>
     <asp:SqlDataSource ID="historySQL" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT instock.product_id as id,instock.date_time as datetime, product.product_name as name, instock.qty_new as qty, instock.purchase_price as price, instock.remark as remark FROM product INNER JOIN instock ON instock.product_id = product.Id ORDER BY instock.date_time DESC">
    </asp:SqlDataSource>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#example').DataTable();
        });
        $(document).ready(function () {
            $('#example2').DataTable({ 
            });
        });
    </script>

 
 
    <script>
        function printContent(el) {
            var restorepage = $('body').html();
            var printcontent = $('#' + el).clone();
            $('body').empty().html(printcontent);
            window.print();
            $('body').html(restorepage);
        }
    </script>
</asp:Content>

