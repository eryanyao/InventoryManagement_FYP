<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <div class="w3-container">
            <h2 class="w3-text-black"><strong>Sales Performance</strong></h2>
            <div id="columnchart_material"></div>
            <br />
        </div>
    </div>
        <div>
            <asp:GridView ID="gvTable" AutoGenerateColumns="false" runat="server">
                <Columns>
                <asp:BoundField ItemStyle-width="150px" HeaderText="Months" DataField="mon"/>
                <asp:BoundField ItemStyle-width="150px" HeaderText="Total" DataField="total" />
            </Columns>
            </asp:GridView>
        </div>
        <asp:HiddenField ID="HiddenField1" runat="server" />
    </form>


    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', { 'packages': ['bar'] });
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Months', 'Sales'],
              ['January', 1000],
              ['Febraury', 1170],
              ['March', 660],
              ['April', 1030],
              ['May', 1030],
              ['June', 1030],
              ['July', 1030],
              ['August', 1030],
              ['September', 1030],
              ['October', 1030],
              ['November', 1030],
              ['December', 1030]
            ]);

            var options = {
                chart: {
                    title: 'Sales Performance',
                    subtitle: 'Sales, Expenses, and Profit: 2014-2017',
                }
            };

            var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

            chart.draw(data, google.charts.Bar.convertOptions(options));
        }
    </script>
</body>
</html>
