using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_dashboard : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            updateCount(lblProduct, "SELECT COUNT(*) as count FROM product");
            updateCount(lblOrder, "SELECT COUNT(*) as count FROM bill");
            updateCount(lblCategory, "SELECT COUNT(*) as count FROM category");
            updateCount(lblBrand, "SELECT COUNT(*) as count FROM brand");
        }

    }

    void updateCount(Label label, string sql)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = sql;
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            SqlDataReader dr = cmd7.ExecuteReader();

            if (dr.Read())
            {
                label.Text = dr["count"].ToString();
            }

            conn.Close();
        }
    }
}