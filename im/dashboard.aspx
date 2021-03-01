<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="dashboard.aspx.cs" Inherits="im_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Dashboard</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-dashboard"></i>&nbsp;Dashboard</b> <small style="font-size: x-small;">
            Control panel</small></h3>
    </header>

    <div class="w3-row-padding w3-margin-bottom">
        <div class="w3-quarter">
            <div class="w3-container w3-red w3-padding-16">
                <div class="w3-left"><i class="fa fa-comment w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3>
                        <asp:Label Text="10" ID="lblProduct" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Products</h4>
                <a href="/im/products/Default.aspx" class="w3-button w3-white w3-hover-light-grey" style="width: 100%;">More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>
        </div>
        <div class="w3-quarter">
            <div class="w3-container w3-blue w3-padding-16">
                <div class="w3-left"><i class="fa fa-eye w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3><asp:Label Text="10" ID="lblOrder" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Paid Orders</h4>
                <a href="/im/order/Default.aspx" class="w3-button w3-white w3-hover-light-grey" style="width: 100%;">More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>

        </div>
        <div class="w3-quarter">
            <div class="w3-container w3-teal w3-padding-16">
                <div class="w3-left"><i class="fa fa-share-alt w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3><asp:Label Text="10" ID="lblCategory" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Categorys</h4>
                <a href="/im/category/Default.aspx" class="w3-button w3-white w3-hover-light-grey" style="width: 100%;">More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>
        </div>
        <div class="w3-quarter">
            <div class="w3-container w3-orange w3-text-white w3-padding-16">
                <div class="w3-left"><i class="fa fa-users w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3><asp:Label Text="10" ID="lblBrand" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Brands</h4>
                <a href="/im/brand/Default.aspx" class="w3-button w3-white w3-hover-light-grey" style="width: 100%;">More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>
        </div>
    </div>

    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Analysis</strong></h2>

            <div id="chart_div" class="w3-left" style="width: 50%; height: 500px;"></div>
           
            <div id="piechart"  class="w3-right w3-margin-bottom" style="width: 48%; height: 500px;"></div>
            <br />
            <br />

        </div>
    </div>

     <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Out of Stocks</strong></h2>
            <table class="w3-table w3-white w3-bordered w3-hoverable w3-table-all">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <asp:Repeater runat="server" DataSourceID="SqlOutOfStock">
                        <ItemTemplate>
                            <tr>
                                <td>
                                     <asp:Label Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_quantity")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button Text="View" CssClass="w3-blue w3-button" runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <br />
        </div>
    </div>

    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Low-level Stocks</strong></h2>
            <table class="w3-table w3-white w3-bordered w3-hoverable w3-table-all">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Quantity</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <asp:Repeater runat="server" DataSourceID="SqlProduct">
                        <ItemTemplate>
                            <tr>
                                <td>
                                     <asp:Label Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_quantity")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button Text="View" CssClass="w3-blue w3-button" runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <br />
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="SqlProduct" ConnectionString="<%$ ConnectionStrings:connStr %>" SelectCommand="SELECT * FROM product WHERE product_quantity <= 5 AND product_quantity >= 1" />
     <asp:SqlDataSource runat="server" ID="SqlOutOfStock" ConnectionString="<%$ ConnectionStrings:connStr %>" SelectCommand="SELECT * FROM product WHERE product_quantity = 0" />
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawVisualization);

        function drawVisualization() {
            // Some raw data (not necessarily accurate)
            var data = google.visualization.arrayToDataTable([
              ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
              ['2004/05', 165, 938, 522, 998, 450, 614.6],
              ['2005/06', 135, 1120, 599, 1268, 288, 682],
              ['2006/07', 157, 1167, 587, 807, 397, 623],
              ['2007/08', 139, 1110, 615, 968, 215, 609.4],
              ['2008/09', 136, 691, 629, 1026, 366, 569.6]
            ]);

            var options = {
                title: 'Total Sales Analysis',
                vAxis: { title: 'Cups' },
                hAxis: { title: 'Month' },
                seriesType: 'bars',
                series: { 5: { type: 'line' } }
            };

            var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        }

        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var data = google.visualization.arrayToDataTable([
              ['Task', 'Hours per Day'],
              ['Work', 11],
              ['Eat', 2],
              ['Commute', 2],
              ['Watch TV', 2],
              ['Sleep', 7]
            ]);

            var options = {
                title: 'My Daily Activities'
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
    </script>
</asp:Content>

