using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_order_addOrder2 : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();

                string deleteCart = "DELETE FROM cart";
                SqlCommand cmd6 = new SqlCommand(deleteCart, conn);
                cmd6.ExecuteNonQuery();

                conn.Close();
            }
            var datetime = DateTime.Now;
            lblDate.Text = datetime.ToString("dddd, dd-MM-yyyy");
            lblTime.Text = datetime.ToString("hh:mm:ss tt");
            bindgrid();
        }
    }

    //Start Product Section
    protected void gvProduct_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        conn.Open();
        string qty = (gvProduct.Rows[e.RowIndex].FindControl("txtQtyNeed") as TextBox).Text.Trim();
        string price = (gvProduct.Rows[e.RowIndex].FindControl("lblRate") as Label).Text.Trim();
        string add = "UPDATE cart SET product_qty_need = @qty_need, product_total_price=@price WHERE product_id = @id";
        SqlCommand cmd = new SqlCommand(add, conn);
        Double total = Double.Parse(price) * Double.Parse(qty);
        cmd.Parameters.AddWithValue("qty_need", qty);
        cmd.Parameters.AddWithValue("id", (gvProduct.Rows[e.RowIndex].FindControl("lblId") as Label).Text);
        cmd.Parameters.AddWithValue("price", total);

        cmd.ExecuteNonQuery();

        gvProduct.EditIndex = -1;

        conn.Close();
        bindgrid();

    }
    protected void gvProduct_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                string queryBrand = "DELETE FROM cart WHERE product_id=@id";
                SqlCommand searchCmd = new SqlCommand(queryBrand, conn);
                searchCmd.Parameters.AddWithValue("id", (gvProduct.Rows[e.RowIndex].FindControl("lblId2") as Label).Text);

                searchCmd.ExecuteNonQuery();

                conn.Close();

                bindgrid();
                calcultateSum();

            }
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
        }

    }
    protected void gvProduct_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvProduct.EditIndex = -1;
        bindgrid();

    }
    protected void gvProduct_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvProduct.EditIndex = e.NewEditIndex;
        bindgrid();

    }
    protected void btnAddProduct_Click(object sender, EventArgs e)
    {
        modalProduct.Visible = true;
    }
    protected void btnSelectProduct_Click(object sender, EventArgs e)
    {
        RepeaterItem item = (sender as Button).Parent as RepeaterItem;
        TextBox txtQtyNeed = item.FindControl("txtQty") as TextBox;

        String id = (item.FindControl("lblProductId") as Label).Text;
        String name = (item.FindControl("lblProductName") as Label).Text;
        Double price = Double.Parse((item.FindControl("lblProductPrice") as Label).Text);
        Double qtyInStock = Double.Parse((item.FindControl("lblProductQuantity") as Label).Text);
        Double qtyNeed = Double.Parse(txtQtyNeed.Text);

        Double total = qtyNeed * price;

        try
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                string queryBrand = "SELECT * FROM cart WHERE product_id=@id";
                SqlCommand searchCmd = new SqlCommand(queryBrand, conn);
                searchCmd.Parameters.AddWithValue("id", id);
                searchCmd.ExecuteNonQuery();

                SqlDataReader dr = searchCmd.ExecuteReader();

                bool rf = dr.Read();
                conn.Close();
                if (rf)
                {
                    conn.Open();

                    string add = "UPDATE cart SET product_name = @name, product_qty_instock = @qty_instock, product_qty_need = @qty_need,product_price = @price, product_total_price=@total WHERE product_id = @id";
                    SqlCommand cmd = new SqlCommand(add, conn);

                    cmd.Parameters.AddWithValue("id", id);
                    cmd.Parameters.AddWithValue("name", name);
                    cmd.Parameters.AddWithValue("qty_instock", qtyInStock);
                    cmd.Parameters.AddWithValue("qty_need", qtyNeed);
                    cmd.Parameters.AddWithValue("price", price);
                    cmd.Parameters.AddWithValue("total", total);

                    cmd.ExecuteNonQuery();

                    Response.Write("<script>alert('The product already exists! The system updates existing orders!');</script>");

                    conn.Close();

                    bindgrid();
                }
                else
                {
                    conn.Open();

                    string add = "INSERT INTO cart (product_id,product_name,product_qty_instock,product_qty_need,product_price,product_total_price)values(@id,@name,@qty_instock,@qty_need,@price,@total)";
                    SqlCommand cmd = new SqlCommand(add, conn);

                    cmd.Parameters.AddWithValue("id", id);
                    cmd.Parameters.AddWithValue("name", name);
                    cmd.Parameters.AddWithValue("qty_instock", qtyInStock);
                    cmd.Parameters.AddWithValue("qty_need", qtyNeed);
                    cmd.Parameters.AddWithValue("price", price);
                    cmd.Parameters.AddWithValue("total", total);

                    cmd.ExecuteNonQuery();

                    Response.Write("<script>alert('Product: " + name + " Added Successfully!');</script>");

                    conn.Close();
                    bindgrid();
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "ERROR: " + ex.ToString();
            lblError.ForeColor = System.Drawing.Color.Red;
        }

        modalProduct.Visible = false;
        txtQtyNeed.Text = "";

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        myModal.Visible = false;
        modalProduct.Visible = false;
    }

    //price
    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {
        Double discount = Double.Parse(txtDiscount.Text);
        Double gross = Double.Parse(txtGross.Text);
        Double service = Double.Parse(txtService.Text);

        txtNet.Text = (gross + service - discount).ToString();
    }
    void calcultateSum()
    {
        Double gross;
        Double service;
        Double netTotal;
        Double tax = 0.06;
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            string queryBrand = "SELECT COUNT(*) FROM cart";
            SqlCommand searchCmd = new SqlCommand(queryBrand, conn);

            int result = (int)searchCmd.ExecuteScalar();

            if (result == 0)
            {
                gross = 0.00;
                service = 0.00;
                netTotal = 0.00;

                txtGross.Text = gross.ToString();
                txtService.Text = service.ToString();
                txtNet.Text = netTotal.ToString();
            }
            else
            {
                SqlCommand cmd = new SqlCommand("SELECT SUM(product_total_price) as Total FROM [cart]", conn);
                SqlDataReader dr = cmd.ExecuteReader();
                bool rf = dr.Read();

                if (rf)
                {
                    gross = Double.Parse(dr["Total"].ToString());
                    service = (Double.Parse(dr["Total"].ToString()) * tax);
                    netTotal = Double.Parse(dr["Total"].ToString()) + (Double.Parse(dr["Total"].ToString()) * tax);

                    txtGross.Text = gross.ToString();
                    txtService.Text = service.ToString();
                    txtNet.Text = netTotal.ToString();
                }


            }

            conn.Close();
        }
    }
    void bindgrid()
    {
        DataTable dt = new DataTable();
        
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            SqlDataAdapter sql = new SqlDataAdapter("SELECT * FROM cart", conn);
            sql.Fill(dt);
            conn.Close();
        }
        if (dt.Rows.Count > 0)
        {
            gvProduct.DataSource = dt;
            gvProduct.DataBind();
        }
        else
        {
            gvProduct.DataSource = dt;
            gvProduct.DataBind();
        }
      
        calcultateSum();
    }

    //other
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
    protected void btnClose_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    //customer section
    protected void btnNewCustomer_Click(object sender, EventArgs e)
    {
        txtName.Text = "";
        txtAddress.Text = "";
        txtPhone.Text = "";

        txtName.Enabled = true;
        txtAddress.Enabled = true;
        txtPhone.Enabled = true;

        Response.Cookies["customer"].Value = "0";
    }
    protected void btnCustomer_Click(object sender, EventArgs e)
    {
        myModal.Visible = true;
    }
    protected void btnSelect_Command(object sender, CommandEventArgs e)
    {
        conn.Open();
        SqlCommand cmd = new SqlCommand("SELECT * FROM customer WHERE Id=@Id", conn);
        cmd.Parameters.AddWithValue("Id", e.CommandArgument.ToString());
        SqlDataReader dr = cmd.ExecuteReader();
        bool rf = dr.Read();

        if (rf)
        {
            txtName.Text = dr["customer_name"].ToString();
            txtPhone.Text = dr["customer_phone"].ToString();
            txtAddress.Text = dr["customer_address"].ToString();
            Response.Cookies["customer_id"].Value = dr["Id"].ToString();

            txtName.Enabled = false;
            txtPhone.Enabled = false;
            txtAddress.Enabled = false;

            myModal.Visible = false;
            Response.Cookies["customer"].Value = "1";

        }
        conn.Close();
    }

    //save product section
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int customer_id = 0;
        int order_id = 0;
        List<string> id = new List<string>();
        List<string> left = new List<string>();

        if (txtDiscount.Text == "")
        {
            txtDiscount.Text = "0";
        }

        if (Convert.ToInt32(Request.Cookies["customer"].Value) == 1)
        {
            customer_id = Convert.ToInt32(Request.Cookies["customer_id"].Value);
        }
        else if(Convert.ToInt32(Request.Cookies["customer"].Value) == 0)
        {
            
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();

                string add = "INSERT INTO customer (customer_name,customer_phone,customer_address)values(@name,@phone,@address)";
                SqlCommand cmd = new SqlCommand(add, conn);
                cmd.Parameters.AddWithValue("name", txtName.Text);
                cmd.Parameters.AddWithValue("phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("address", txtAddress.Text);
                cmd.ExecuteNonQuery();

                string query = "SELECT @@Identity as newId FROM customer";
                SqlCommand cmd2 = new SqlCommand(query, conn);
                customer_id = Convert.ToInt32(cmd2.ExecuteScalar());

                conn.Close();

            }
           
        }

       
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string add2 = "INSERT INTO bill (customer_id,date_time,gross_amount,service_amount,net_amount,discount,user_id)values(@id,@date,@gross,@service,@net,@discount,@userId)";
            SqlCommand cmd3 = new SqlCommand(add2, conn);
            cmd3.Parameters.AddWithValue("id", customer_id);
            cmd3.Parameters.AddWithValue("date", DateTime.Now);
            cmd3.Parameters.AddWithValue("gross", txtGross.Text);
            cmd3.Parameters.AddWithValue("service", txtService.Text);
            cmd3.Parameters.AddWithValue("net", txtNet.Text);
            cmd3.Parameters.AddWithValue("discount", txtDiscount.Text);
            cmd3.Parameters.AddWithValue("userId", Session["Id"].ToString());

            cmd3.ExecuteNonQuery();

            string query = "SELECT @@Identity as newId FROM bill";
            SqlCommand cmd4 = new SqlCommand(query, conn);
            order_id = Convert.ToInt32(cmd4.ExecuteScalar());

            conn.Close();
        }

        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string getItem = "SELECT product_id,product_qty_need,product_qty_instock FROM cart";
            SqlCommand cmd7 = new SqlCommand(getItem, conn);
            SqlDataReader dr = cmd7.ExecuteReader();

            while (dr.Read())
            {
                int leftStock = Int32.Parse(dr["product_qty_instock"].ToString()) - Int32.Parse(dr["product_qty_need"].ToString());
                id.Add(dr["product_id"].ToString());
                left.Add(leftStock.ToString());
            }

            conn.Close();
        }

        for (int i = 0; i < id.Count; i++)
        {
            updating(left[i], id[i]);
            Response.Write(id[i] + ":<br>");
            Response.Write(left[i] + ":<br>");
        }

        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string insertItem = "INSERT INTO bill_item (bill_id,product_id,product_price,product_qty_need,product_total) SELECT " + order_id.ToString() + ",product_id,product_price,product_qty_need,product_total_price FROM cart";
            SqlCommand cmd5 = new SqlCommand(insertItem, conn);

            cmd5.ExecuteNonQuery();

            string deleteCart = "DELETE FROM cart";
            SqlCommand cmd6 = new SqlCommand(deleteCart, conn);
            cmd6.ExecuteNonQuery();

            conn.Close();
        }
      
        Response.Write("<script>alert('Order: " + order_id + ". Added Successfully!');location.href='/im/order/invoice.aspx?id="+ order_id +"';</script>");

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
}