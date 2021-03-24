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

public partial class test : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);

    public List<string> categoryName = new List<string>();
    public List<int> categoryQty = new List<int>();

     public List<categoryData> category = new List<categoryData>();
    public JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
    protected void Page_Load(object sender, EventArgs e)
    {
        getCategory();
    }

    void getCategory()
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT product.product_category as name, COUNT(bill_item.bill_id) as numberOfCategory FROM bill_item LEFT JOIN product ON bill_item.product_id = product.Id GROUP BY product_category";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            SqlDataReader dr = cmd7.ExecuteReader();

            while (dr.Read())
            {
                categoryName.Add(dr["name"].ToString());
                categoryQty.Add(Int16.Parse(dr["numberOfCategory"].ToString()));
            }

            conn.Close();
        }
    }

    public class categoryData{
       public string name { get; set; }
        public int qty { get; set; }
    }


}