<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="im_order_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../assets/css/popout.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-shopping-cart nav-icon"></i>&nbsp;Order</b> <small style="font-size: x-small;">
            Manage</small></h3>
    </header>

    <div class="w3-container">
        <asp:Button Text="Add Order" runat="server" ID="btnAdd" CssClass="w3-button w3-border w3-green"
            OnClick="btnAdd_Click" />
    </div>

    <div id="divTable" class="w3-row-padding w3-margin-bottom w3-light-grey w3-border"
        style="margin-left: 20px; margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Order</strong></h2>

            <table id="example" class="display" style="width: 99%;">
                <thead>
                    <tr>
                        <th>Bill No</th>
                        <th>Customer Name</th>
                        <th>Customer Phone</th>
                        <th>Date Time</th>
                        <th>Total Amount</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rBrand" runat="server" DataSourceID="brandSQL">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label Text='<%# Eval("id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("phone").ToString()%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("datetime").ToString()%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("net").ToString()%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnView" CssClass="w3-button w3-blue w3-row w3-padding" CommandArgument='<%# Eval("id")%>'
                                        CommandName="brandId" OnCommand="btnView_Command"
                                        runat="server" Width="60px" Text="View" />
                                    <asp:Button ID="btnEdit" CssClass="w3-button w3-green w3-row w3-padding" CommandArgument='<%# Eval("id")%>'
                                        CommandName="brandId" OnCommand="btnEdit_Command"
                                        runat="server" Width="60px" Text="Edit" />
                                    <asp:Button ID="btnDelete" runat="server" CssClass="w3-button w3-red w3-padding"
                                        CommandArgument='<%# Eval("id")%>' OnCommand="btnDelete_Command"  CommandName="billId" 
                                        Width="60px" Text="Delete" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>
    </div>

    <div id="myModal" class="modal" runat="server" visible="false">
        <!-- Modal content -->
        <div class="modal-content">
            <asp:Button Text="&times;" ID="btnCancel" OnClick="btnCancel_Click" BorderStyle="None" CssClass="close"
                runat="server" /><br />
            <p class="w3-large">Are you sure you want to delete this item?</p>
            <table class="w3-padding w3-table w3-bordered">
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Bill No</b></td>
                    <td>
                        <asp:Label ID="lblBillNo" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Customer Name</b></td>
                    <td>
                        <asp:Label ID="lblCustomerName" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Customer Phone</b></td>
                    <td>
                        <asp:Label ID="lblCustomerPhone" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Date Time</b></td>
                    <td>
                        <asp:Label ID="lblDateTime"  runat="server"></asp:Label></td>
                </tr>
                 <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Gross Amount</b></td>
                    <td>
                        <asp:Label ID="lblGross" runat="server"></asp:Label></td>
                </tr> 
                 <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Services Tax</b></td>
                    <td>
                        <asp:Label ID="lblServices" runat="server"></asp:Label></td>
                </tr> 
                 <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Discount</b></td>
                    <td>
                        <asp:Label ID="lblDiscount" runat="server"></asp:Label></td>
                </tr> 
                <tr>
                    <td class="w3-text-black w3-margin-right" style="width: 200px;"><b>Total Amount</b></td>
                    <td>
                        <asp:Label ID="lblTotal" runat="server"></asp:Label></td>
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


     <asp:SqlDataSource ID="brandSQL" runat="server" ConnectionString="<%$ ConnectionStrings:connStr %>"
        SelectCommand="SELECT bill.Id as id,customer.customer_name as name,customer.customer_phone as phone,bill.net_amount as net,date_time as datetime FROM bill INNER JOIN customer ON bill.customer_id = customer.Id">     
    </asp:SqlDataSource>

    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.23/js/jquery.dataTables.min.js"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/jquery.dataTables.min.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#example').DataTable();
        });
    </script>
</asp:Content>

