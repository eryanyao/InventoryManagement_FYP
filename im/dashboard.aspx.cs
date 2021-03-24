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

public partial class im_dashboard : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    public JavaScriptSerializer jsSerializer = new JavaScriptSerializer();

    public List<int> productQty = new List<int>();
    public List<string> productName = new List<string>();

    public List<int> categoryQty = new List<int>();
    public List<string> categoryName = new List<string>();

    public List<int> brandQty = new List<int>();
    public List<string> brandName = new List<string>();
    public string category;
    public string brand;
    public string product;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            updateCount(lblProduct, "SELECT COUNT(*) as count FROM product");
            updateCount(lblOrder, "SELECT COUNT(*) as count FROM bill");
            updateCount(lblCategory, "SELECT COUNT(*) as count FROM category");
            updateCount(lblBrand, "SELECT COUNT(*) as count FROM brand");

            string yearQuery = Request.QueryString["y"];
            string monthQuery = Request.QueryString["m"];

            String year;
            String month;

            if (yearQuery != null)
            {
                year = yearQuery;
                month = monthQuery;
            }
            else
            {
                year = DateTime.Now.ToString("yyyy");
                month = DateTime.Now.Month.ToString();
            }
           
            ddlYear.SelectedValue = year;
            ddlMonth.SelectedValue = month;
            
            getCategory(year, month);
            getBrand(year, month);
            getProduct(year,month);

            lblTopCategory.Text = category;
            lblTopBrand.Text = brand;
            lblTopSales.Text = product;
        }

    }
    public String img(string msg)
    {
        if (msg.Equals(""))
        {
            return "~/assets/image/product/empty.jpg";
        }
        else
        {
            return msg;
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
    void getProduct(String year,String month)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT product.product_name as name, COUNT(bill_item.bill_id) as numberOfCategory FROM ((bill_item LEFT JOIN product ON bill_item.product_id = product.Id) INNER JOIN bill ON bill_item.bill_id = bill.id) WHERE YEAR(bill.date_time)=@year AND MONTH(bill.date_time)=@month GROUP BY product_name ORDER BY numberOfCategory";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            cmd7.Parameters.AddWithValue("year", year);
            cmd7.Parameters.AddWithValue("month", month);
            SqlDataReader dr = cmd7.ExecuteReader();

            while (dr.Read())
            {
                productName.Add(dr["name"].ToString());
                productQty.Add(Int16.Parse(dr["numberOfCategory"].ToString()));
                product += " - " + dr["name"].ToString() + "<br>";
            }

            conn.Close();
        }
    }

    void getCategory(String year, String month)
    {
        
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT product.product_category as name, COUNT(bill_item.bill_id) as numberOfCategory FROM ((bill_item LEFT JOIN product ON bill_item.product_id = product.Id) INNER JOIN bill ON bill_item.bill_id = bill.id)  WHERE YEAR(bill.date_time)=@year AND MONTH(bill.date_time)=@month GROUP BY product_category";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            cmd7.Parameters.AddWithValue("year", year);
            cmd7.Parameters.AddWithValue("month", month);
            SqlDataReader dr = cmd7.ExecuteReader();

            while (dr.Read())
            {
                categoryName.Add(dr["name"].ToString());
                categoryQty.Add(Int16.Parse(dr["numberOfCategory"].ToString()));
                category += " - " + dr["name"].ToString() + "<br>";
            }

            conn.Close();
        }
    }

    void getBrand(String year, String month)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT product.product_brand as name, COUNT(bill_item.bill_id) as numberOfBrand FROM ((bill_item LEFT JOIN product ON bill_item.product_id = product.Id) INNER JOIN bill ON bill_item.bill_id = bill.id)   WHERE YEAR(bill.date_time)=@year AND MONTH(bill.date_time)=@month AND product.product_category='SMARTPHONE' GROUP BY product_brand ";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            cmd7.Parameters.AddWithValue("year", year);
            cmd7.Parameters.AddWithValue("month", month);
            SqlDataReader dr = cmd7.ExecuteReader();

            while (dr.Read())
            {
                brandName.Add(dr["name"].ToString());
                brandQty.Add(int.Parse(dr["numberOfBrand"].ToString()));
                brand += " - " + dr["name"].ToString() + "<br>";
            }

            conn.Close();
        }
    }

    protected void btnDateSubmit_Click(object sender, EventArgs e)
    {
        string url = "dashboard.aspx?y=" + ddlYear.SelectedValue + "&m=" + ddlMonth.SelectedValue;
        Response.Redirect(url);
    }

    protected void btnReplenish_Command(object sender, CommandEventArgs e)
    {
        string url = "products/purchase.aspx?id=" + e.CommandArgument.ToString();
        Response.Redirect(url);
    }
}