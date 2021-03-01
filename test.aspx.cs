using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test : System.Web.UI.Page
{
    DataTable dataTable = new DataTable();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        List<double> total = new List<double>();
        List<string> mon = new List<string>();
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT SUM(net_amount) AS total,MONTH(date_time) as mon FROM bill GROUP BY MONTH(date_time), YEAR(date_time) ORDER BY MONTH(date_time), YEAR(date_time);";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            SqlDataAdapter a = new SqlDataAdapter(cmd7);
            a.Fill(dataTable);
            gvTable.DataSource = dataTable;
            gvTable.DataBind();

            SqlDataReader dr = cmd7.ExecuteReader();
            while (dr.Read())
            {
                total.Add(Double.Parse(dr["total"].ToString()));
                mon.Add(dr["mon"].ToString());

            }

           

            conn.Close();

          
        }
     
        


    }

}