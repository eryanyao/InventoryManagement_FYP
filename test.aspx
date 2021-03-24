<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

    <div id="chart_div" style="width: 49%; height: 500px;">

        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">

            google.charts.load('current', { 'packages': ['corechart'] });
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
                    title: 'Category Sales Analysis',
                    sliceVisibilityThreshold: .2
                };

                var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
                chart.draw(data, options);
            }
        </script>


        <script type="text/javascript">
            google.charts.load('current', { 'packages': ['corechart'] });
            google.charts.setOnLoadCallback(drawVisualization);


            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {
                var categoryName = '<%= this.jsSerializer.Serialize(this.categoryName) %>';
                var categoryQty = '<%= this.jsSerializer.Serialize(this.categoryQty) %>';

                var showName = JSON.parse(total);
                var showQty = JSON.parse(total);

                var data = new google.visualization.DataTable();
                data.addColumn('string', 'Category');
                data.addColumn('number', 'Qty');

                data.addRows([
                    ['Pepperoni', 33],
                    ['Hawaiian', 26],
                    ['Mushroom', 22],
                    ['Sausage', 10], // Below limit.
                    ['Anchovies', 9] // Below limit.
                ]);

                var options = {
                    title: 'Category'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                chart.draw(data, options);
            }
            google.charts.setOnLoadCallback(drawChart2);
            function drawChart2() {

                var data = google.visualization.arrayToDataTable([
                  ['Task', 'Hours per Day'],
                  ['Work', 11],
                  ['Eat', 2],
                  ['Commute', 2],
                  ['Watch TV', 2],
                  ['Sleep', 7]
                ]);

                var options = {
                    title: 'Category'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart2'));

                chart.draw(data, options);
            }
        </script>
</body>
</html>
