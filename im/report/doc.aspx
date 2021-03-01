<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="doc.aspx.cs" Inherits="im_order_invoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../assets/css/invoice.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-shopping-cart nav-icon"></i>&nbsp;Report</b> <small style="font-size: x-small;">
            Manage</small></h3>
    </header>

    <div class="w3-container">
        <asp:Button Text="Back" runat="server" ID="btnBack" CssClass="w3-button w3-border w3-green"
            OnClick="btnBack_Click" />
        <button class="w3-button w3-border w3-green" id="print" onclick="printContent('invoice-box');">
            Print</button>
    </div>

    <div class="invoice-box" id="invoice-box">

        <table cellpadding="0" cellspacing="0">
            <tr class="top">
                <td colspan="4">
                    <table>
                        <tr>
                            <td class="title">
                                <h1><strong>Total Monthly Sales</strong> </h1>
                                <h2><asp:Label ID="lblDate" runat="server" /></h2>                              
                            </td>
                        </tr>  
                    </table>
                </td>
            </tr>

            <tr class="information">
                <td colspan="6">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblAddress1" runat="server" /><br />
                                <asp:Label ID="lblAddress2" runat="server" /><br />
                                <asp:Label ID="lblAddress3" runat="server" />
                            </td>

                            <td>
                                <asp:Label ID="lblCompany" runat="server" /><br />
                                <asp:Label ID="lblManager" runat="server" /><br />
                                <asp:Label ID="lblCompanyPhone" runat="server" /><br />
                                <asp:Label ID="lblCompanyEmail" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>


            <tr class="heading">
                <td>Date Time</td>
                <td>Bill Id</td>
                <td>Item</td>
                <td>Unit Price</td>
                <td>Qty.</td>
                <td>Total Amount</td>
            </tr>

            <asp:Repeater runat="server" ID="rItem" DataSourceID="sqlProductItem">
                <ItemTemplate>
                    <tr class="item">
                        <td>
                            <asp:Label Text='<%# Eval("date_time")%>' runat="server" /></td>

                        <td>
                            <asp:Label Text='<%# Eval("bill_id")%>' runat="server" /></td>

                        <td>
                            <asp:Label Text='<%# Eval("name")%>' runat="server" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("unit")%>' runat="server" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("qty")%>' runat="server" /></td>
                        <td>RM
                            <asp:Label Text='<%# Eval("total")%>' runat="server" CssClass="w3-right" /></td>
                    </tr>

                </ItemTemplate>
            </asp:Repeater>
            <tr>
                <td>
                    <br />
                </td>
            </tr>
            <tr class="total">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td style="font-weight: bold;" class="w3-right">Gross Amount:&nbsp;&nbsp;</td>
                <td style="font-weight: bold; width: 15%;">RM
                    <asp:Label ID="lblGross" runat="server" CssClass="w3-right" />
                </td>
            </tr>
            <tr class="total">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td style="font-weight: bold;" class="w3-right">Services Tax:&nbsp;&nbsp;</td>
                <td style="font-weight: bold;">RM
                    <asp:Label ID="lblService" runat="server" CssClass="w3-right" />
                </td>
            </tr>
            <tr class="total">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td style="font-weight: bold;" class="w3-right">Discount:&nbsp;&nbsp;</td>
                <td style="font-weight: bold;">RM
                    <asp:Label ID="lblDiscount" runat="server" CssClass="w3-right" />
                </td>
            </tr>
            <tr class="total">
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td style="font-weight: bold;" class="w3-right">Total Amount:&nbsp;&nbsp;</td>
                <td style="font-weight: bold;">RM
                    <asp:Label ID="lblTotal" runat="server" CssClass="w3-right" />
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="sqlProductItem" runat="server" DataSourceMode="DataReader"
        ConnectionString="<%$ ConnectionStrings:connStr%>" SelectCommand="SELECT bill.date_time as date_time, bill.Id as bill_id, bill_item.product_price as unit,bill_item.product_qty_need as qty,bill_item.product_total as total,product.product_name as name FROM ((bill_item INNER JOIN product ON bill_item.product_id = product.Id) INNER JOIN bill ON bill_item.bill_id = bill.id) WHERE YEAR(bill.date_time)=@y AND MONTH(bill.date_time)=@m ORDER BY bill.date_time ">
        <SelectParameters>
            <asp:QueryStringParameter Name="y" QueryStringField="y" />
        </SelectParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="m" QueryStringField="m" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlBill" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT bill_item.product_id,bill.date_time,bill_item.product_price,bill_item.product_qty_need,bill_item.product_total FROM bill_item INNER JOIN bill ON bill_item.bill_id = bill.Id WHERE bill.date_time">
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="../../assets/js/jQuery.print.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
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

