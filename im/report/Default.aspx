<%@ Page Title="" Language="C#" MasterPageFile="~/im/MasterPage.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="im_report_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <header class="w3-container" style="padding-top: 22px">
        <h3><b><i class="fa fa-book nav-icon"></i>&nbsp;Report</b> <small style="font-size: x-small;">
            Manage</small></h3>
    </header>
    <div class="w3-container">
        <table>
            <tr>
                <td>
                    <h4><strong>Year:</strong> &nbsp;</h4>
                </td>
                <td>
                    <asp:DropDownList ID="ddlYear" runat="server" CssClass="w3-input w3-border w3-border-dark-gray"
                        DataSourceID="sqlYear" DataTextField="year" DataValueField="year" Width="150px">
                    </asp:DropDownList></td>
                <td>
                    <asp:Button Text="Submit" ID="btnSubmit" runat="server" CssClass="w3-button w3-green" Width="100px" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
    </div>

    <br />
    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong><asp:Label ID="lblYear" runat="server" /> Sales Performance</strong></h2>
            <div class="w3-container w3-white">
                <br />
                <div class="w3-white w3-padding" id="columnchart_material" style="height:300px;"></div>
                <br />
            </div>

            <br />
        </div>
    </div>
   
    <div class="w3-row-padding w3-margin-bottom w3-light-grey w3-border" style="margin-left: 20px;
        margin-right: 20px; margin-top: 20px;"
        runat="server">
        <div class="w3-container">
            <h2 class="w3-text-black"><strong>
                
                Total Monthly Sales</strong></h2>
            <table class="w3-table w3-white w3-bordered w3-hoverable w3-table-all">
                <thead>
                    <tr>
                        <th></th>
                        <th>Month</th>
                        <th>Total</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <asp:Repeater ID="rTotal" runat="server" DataSourceID="sqlTotal">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Label Text='<%# Eval("Id")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("month")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("total")%>' runat="server" />
                                </td>
                                <td>
                                    <asp:Button ID="btnView" Text="View" CommandArgument='<%# Eval("id")%>' OnCommand="btnView_Command" CssClass="w3-blue w3-button" runat="server" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
            <br />
        </div>
    </div>

    <asp:SqlDataSource ID="sqlTotal" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT * FROM report"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlYear" runat="server" DataSourceMode="DataReader" ConnectionString="<%$ ConnectionStrings:connStr%>"
        SelectCommand="SELECT YEAR(date_time) as year FROM bill GROUP BY YEAR(date_time) ORDER BY YEAR(date_time) DESC">
    </asp:SqlDataSource>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['bar'] });
        google.charts.setOnLoadCallback(drawChart);
        var total = '<%= this.jsSerializer.Serialize(this.reportTotal) %>';
        var show = JSON.parse(total);
      

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Months', 'Sales'],
              ['January', show[0]],
              ['Febraury', show[1]],
              ['March', show[2]],
              ['April', show[3]],
              ['May', show[4]],
              ['June', show[5]],
              ['July', show[6]],
              ['August', show[7]],
              ['September', show[8]],
              ['October', show[9]],
              ['November', show[10]],
              ['December', show[11]]
            ]);

            var options = {
                chart: {
                  

                }
            };

            var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }
    </script>


</asp:Content>

