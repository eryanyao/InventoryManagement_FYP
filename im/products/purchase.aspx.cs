using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_products_stockIn : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    static string prevPage = String.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            prevPage = Request.UrlReferrer.ToString();

            string id = Request.QueryString["id"];
            if(id != null)
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();

                    string getItem = "SELECT product_name, product_quantity FROM product WHERE Id=@id";
                    SqlCommand cmd7 = new SqlCommand(getItem, conn);
                    cmd7.Parameters.AddWithValue("id", id);
                    SqlDataReader dr = cmd7.ExecuteReader();

                    while (dr.Read())
                    {
                        lblProductId.Text = id.ToString();
                        lblProductName.Text = dr["product_name"].ToString();
                        lblQtyInStock.Text = dr["product_quantity"].ToString();
                    }

                    conn.Close();
                }
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {  
        modalProduct.Visible = false;
        myModal.Visible = false;
        modalHistory.Visible = false;
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



    protected void btnShowBrand_Click(object sender, EventArgs e)
    {
        modalProduct.Visible = true;
    }

    protected void btnSelectProduct_Command(object sender, CommandEventArgs e)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT product_name, product_quantity FROM product WHERE Id=@id";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            cmd7.Parameters.AddWithValue("id", e.CommandArgument);
            SqlDataReader dr = cmd7.ExecuteReader();

            while (dr.Read())
            {
                lblProductId.Text = e.CommandArgument.ToString();
                lblProductName.Text = dr["product_name"].ToString();
                lblQtyInStock.Text = dr["product_quantity"].ToString();
            }

            conn.Close();
        }
        modalProduct.Visible = false;
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        Response.Redirect(prevPage);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if(lblProductId.Text != "")
        {
            myModal.Visible = true;
            lblModalId.Text = lblProductId.Text;
            lblModalName.Text = lblProductName.Text;
            lblModalPrice.Text = txtPrice.Text;
            lblModalQty.Text = txtQuantity.Text;
            lblModalRemark.Text = txtRemark.Text;
        }
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        int qtyleft = Int32.Parse(lblQtyInStock.Text);
        int qtyAdd = Int32.Parse(lblModalQty.Text);
        int total = qtyleft + qtyAdd;
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string insertItem = "INSERT INTO instock (product_id,qty_new,purchase_price,date_time,remark) VALUES (@id,@qty,@price,@date_time,@remark)";
            SqlCommand cmd5 = new SqlCommand(insertItem, conn);
            cmd5.Parameters.AddWithValue("id", lblModalId.Text);
            cmd5.Parameters.AddWithValue("qty", lblModalQty.Text);
            cmd5.Parameters.AddWithValue("price", lblModalPrice.Text);
            cmd5.Parameters.AddWithValue("date_time", DateTime.Now);
            cmd5.Parameters.AddWithValue("remark", lblModalRemark.Text);
            cmd5.ExecuteNonQuery();

            conn.Close();
        }
        updating(total.ToString(), lblModalId.Text);
        Response.Write("<script>alert('Product: " + lblModalId.Text + ". Quantity update Successfully!');location.href='/im/products/Default.aspx';</script>");
    }

    void updating(string left, string id)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            string update = "UPDATE product SET product_quantity = @qty WHERE Id = @id";
            SqlCommand cmd9 = new SqlCommand(update, conn);
            cmd9.Parameters.AddWithValue("qty", left);
            cmd9.Parameters.AddWithValue("id", id);

            cmd9.ExecuteNonQuery();
            conn.Close();
        }
    }

    protected void btnShowHistory_Click(object sender, EventArgs e)
    {
        modalHistory.Visible = true;
    }
}