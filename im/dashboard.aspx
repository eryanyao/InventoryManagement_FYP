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
                <div class="w3-left"><i class="fa fa-shopping-basket w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3>
                        <asp:Label Text="10" ID="lblProduct" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Products</h4>
                <a href="/im/products/Default.aspx" class="w3-button w3-white w3-hover-light-grey"
                    style="width: 100%;">More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>
        </div>
        <div class="w3-quarter">
            <div class="w3-container w3-blue w3-padding-16">
                <div class="w3-left"><i class="fa fa-shopping-cart w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3>
                        <asp:Label Text="10" ID="lblOrder" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Paid Orders</h4>
                <a href="/im/order/Default.aspx" class="w3-button w3-white w3-hover-light-grey" style="width: 100%;">
                    More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>

        </div>
        <div class="w3-quarter">
            <div class="w3-container w3-teal w3-padding-16">
                <div class="w3-left"><i class="fa fa-cubes  w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3>
                        <asp:Label Text="10" ID="lblCategory" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Categorys</h4>
                <a href="/im/category/Default.aspx" class="w3-button w3-white w3-hover-light-grey"
                    style="width: 100%;">More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>
        </div>
        <div class="w3-quarter">
            <div class="w3-container w3-orange w3-text-white w3-padding-16">
                <div class="w3-left"><i class="fa fa-tags w3-xxxlarge"></i></div>
                <div class="w3-right">
                    <h3>
                        <asp:Label Text="10" ID="lblBrand" runat="server" /></h3>
                </div>
                <div class="w3-clear"></div>
                <h4>Total Brands</h4>
                <a href="/im/brand/Default.aspx" class="w3-button w3-white w3-hover-light-grey" style="width: 100%;">
                    More Details
                    &nbsp; <i class="fa fa-arrow-right"></i></a>
            </div>
        </div>
    </div>

    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>Sales Analysis</strong></h2>
            <div>
                <table>
                    <tr>
                        <td><strong>Year</strong></td>
                        <td>
                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="w3-input w3-border w3-border-dark-gray"
                                DataSourceID="sqlYear" DataTextField="year" DataValueField="year" Width="150px">
                            </asp:DropDownList>
                        </td>
                        <td>&nbsp;</td>
                        <td><strong>Month</strong></td>
                        <td>
                            <asp:DropDownList ID="ddlMonth" runat="server" CssClass="w3-input w3-border w3-border-dark-gray"
                                DataSourceID="sqlMonth" DataTextField="month" DataValueField="Id" Width="150px">
                            </asp:DropDownList>
                            </td>
                                <td>&nbsp;</td>
                                <td>

                                <asp:Button ID="btnDateSubmit" Text="Submit" CssClass="w3-button w3-border w3-green"
                                    runat="server" OnClick="btnDateSubmit_Click" /></td>
                    </tr>
                </table>




            </div>

            <br />
            <div id="piechart2" class="w3-left w3-margin-bottom" style="width: 49%; height: 500px;">
            </div>

            <div id="piechart" class="w3-right w3-margin-bottom" style="width: 49%; height: 500px;">
            </div>

            <div id="chart_div" class="w3-left w3-margin-bottom w3-margin-top" style="width: 49%;
                height: 500px;">
            </div>
            <div id="" class="w3-right w3-margin-bottom w3-margin-top" style="width: 49%;
                height: 500px;">
                <div class="w3-container w3-white" style="height: 500px;">
                    <h3><strong>Top Performance</strong></h3>
                    <table class="w3-table w3-white w3-bordered w3-hoverable w3-table-all">
                        <tr>
                            <td style="width: 30%"><b>Top Sales Product</b></td>
                            <td>
                                <asp:Label ID="lblTopSales" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><b>Top Brand</b></td>
                            <td>
                                <asp:Label ID="lblTopBrand" runat="server"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><b>Top Category</b></td>
                            <td>
                                <asp:Label ID="lblTopCategory" runat="server"></asp:Label></td>
                        </tr>
                    </table>
                </div>

            </div>
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
                        <th style="width: 150px;">Product ID</th>
                        <th style="width: 400px;">Image</th>
                        <th style="width: 600px;">Product Name</th>
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
                                    <asp:Image ImageUrl='<%# img(Eval("product_img").ToString())%>' Height="100px" runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_quantity")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button Text="Replenishment" CommandArgument='<%# Eval("id")%>' OnCommand="btnReplenish_Command"
                                        CssClass="w3-blue w3-button" runat="server" />
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
                        <th style="width: 150px;">Product ID</th>
                        <th style="width: 400px;">Image</th>
                        <th style="width: 600px;">Product Name</th>
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
                                    <asp:Image ImageUrl='<%# img(Eval("product_img").ToString())%>' Height="100px" runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_name")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("product_quantity")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button Text="Replenishment" ID="btnReplenish" CommandArgument='<%# Eval("id")%>'
                                        OnCommand="btnReplenish_Command" CssClass="w3-blue w3-button" runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <br />
        </div>
    </div>

    <asp:SqlDataSource runat="server" ID="SqlProduct" ConnectionString="<%$ ConnectionStrings:connStr %>"
        SelectCommand="SELECT * FROM product WHERE product_quantity <= 5 AND product_quantity >= 1" />
    <asp:SqlDataSource runat="server" ID="SqlOutOfStock" ConnectionString="<%$ ConnectionStrings:connStr %>"
        SelectCommand="SELECT * FROM product WHERE product_quantity = 0" />
    <asp:SqlDataSource ID="sqlYear" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT YEAR(date_time) as year FROM bill GROUP BY YEAR(date_time) ORDER BY YEAR(date_time) DESC">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMonth" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT * FROM report"></asp:SqlDataSource>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['corechart'] });
        google.charts.setOnLoadCallback(drawVisualization);

        function drawVisualization() {
            // Some raw data (not necessarily accurate)
            var productName = '<%= this.jsSerializer.Serialize(this.productName) %>';
            var productQty = '<%= this.jsSerializer.Serialize(this.productQty) %>';

            var showName = JSON.parse(productName);
            var showQty = JSON.parse(productQty);

            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Product');
            data.addColumn('number', 'Qty');

            for (i = 0; i < showName.length; i++) {
                data.addRow([showName[i], showQty[i]]);
            }

            var options = {
                title: 'Total Sales Analysis',
                hAxis: { format: '0' },
                vAxis: { format: '0' },
                is3D: true,


            };

            var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        }

        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {

            var categoryName = '<%= this.jsSerializer.Serialize(this.categoryName) %>';
            var categoryQty = '<%= this.jsSerializer.Serialize(this.categoryQty) %>';

            var showName = JSON.parse(categoryName);
            var showQty = JSON.parse(categoryQty);


            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Category');
            data.addColumn('number', 'Qty');

            for (i = 0; i < showName.length; i++) {
                data.addRow([showName[i], showQty[i]]);
            }

            var options = {
                title: 'Category Sales Analysis'
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart'));

            chart.draw(data, options);
        }
        google.charts.setOnLoadCallback(drawChart2);
        function drawChart2() {

            var categoryName = '<%= this.jsSerializer.Serialize(this.brandName) %>';
            var categoryQty = '<%= this.jsSerializer.Serialize(this.brandQty) %>';

            var showName = JSON.parse(categoryName);
            var showQty = JSON.parse(categoryQty);


            var data = new google.visualization.DataTable();
            data.addColumn('string', 'Brand');
            data.addColumn('number', 'Qty');

            for (i = 0; i < showName.length; i++) {
                data.addRow([showName[i], showQty[i]]);
            }

            var options = {
                title: 'Phone Brand Sales Analysis'
            };

            var chart = new google.visualization.PieChart(document.getElementById('piechart2'));

            chart.draw(data, options);
        }
    </script>
</asp:Content>

