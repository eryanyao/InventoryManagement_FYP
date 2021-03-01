using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_report_Default : System.Web.UI.Page
{
    DataTable yearTable = new DataTable();
    List<string> id = new List<string>();
    List<string> total = new List<string>();
    public List<double> reportTotal = new List<double>();
    public JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    public string thisYear = (DateTime.Now.Year).ToString();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string year = Request.QueryString["year"];
            if(year != null)
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();

                    string deleteCart = "UPDATE report SET total=0.00";
                    SqlCommand cmd6 = new SqlCommand(deleteCart, conn);
                    cmd6.ExecuteNonQuery();

                    conn.Close();
                }

                updateReport(year);
                ddlYear.SelectedValue = year;
            }
            else
            {
                Response.Redirect("Default.aspx?year=" + thisYear );
            }
           
        }
            

            
        

    }
    public class report
    {
        public int Id { get; set; }
        public double total { get; set; }
    }
    void updating(string total, string id)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            string insertItem = "UPDATE report SET total = @total WHERE Id=@id";
            SqlCommand cmd5 = new SqlCommand(insertItem, conn);
            cmd5.Parameters.AddWithValue("total",total);
            cmd5.Parameters.AddWithValue("id",id);
            cmd5.ExecuteNonQuery();
            conn.Close();
        }
    }

    void updateReport(string year)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            string getItem = "SELECT SUM(net_amount) AS total,MONTH(date_time) as mon,YEAR(date_time) as year FROM bill WHERE YEAR(date_time)=@year GROUP BY MONTH(date_time), YEAR(date_time) ;";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            cmd7.Parameters.AddWithValue("year", year);
            lblYear.Text = year;
            SqlDataReader dr = cmd7.ExecuteReader();
            while (dr.Read())
            {
                id.Add(dr["mon"].ToString());
                total.Add(dr["total"].ToString());
            }

            conn.Close();
        }

        for (int i = 0; i < id.Count; i++)
        {
            updating(total[i], id[i]);
        }

        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            string getItem = "SELECT month,total FROM report ;";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            SqlDataReader dr = cmd7.ExecuteReader();
            while (dr.Read())
            {
                reportTotal.Add(Double.Parse(dr["total"].ToString()));
            }

            conn.Close();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx?year=" + ddlYear.SelectedValue);
    }

    protected void btnView_Command(object sender, CommandEventArgs e)
    {
        string url = "doc.aspx?y=" + lblYear.Text + "&m=" + e.CommandArgument.ToString();
        Response.Redirect(url);
    }
}