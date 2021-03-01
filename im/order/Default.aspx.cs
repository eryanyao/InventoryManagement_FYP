using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_order_Default : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("addOrder.aspx");
    }

    protected void btnView_Command(object sender, CommandEventArgs e)
    {
        string url = "invoice.aspx?id=" + e.CommandArgument.ToString();
        Response.Redirect(url);
    }

    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {

        myModal.Visible = true;
      
        conn.Open();

        string getItem = "SELECT bill.Id as id,customer.customer_name as name,customer.customer_phone as phone,bill.net_amount as net, bill.gross_amount as gross, bill.service_amount as service, bill.discount as discount, date_time as datetime FROM bill INNER JOIN customer ON bill.customer_id = customer.Id WHERE bill.Id=@Id";
        SqlCommand cmd = new SqlCommand(getItem, conn);
        Response.Cookies["deleteId"].Value = e.CommandArgument.ToString();
        cmd.Parameters.AddWithValue("Id", e.CommandArgument.ToString());
        SqlDataReader dr = cmd.ExecuteReader();
        bool rf = dr.Read();

        if (rf)
        {
            lblBillNo.Text = dr["id"].ToString();
            lblCustomerName.Text = dr["name"].ToString();
            lblCustomerPhone.Text = dr["phone"].ToString();
            lblDateTime.Text = dr["datetime"].ToString();
            lblGross.Text = dr["gross"].ToString();
            lblServices.Text = dr["service"].ToString();
            lblDiscount.Text = dr["discount"].ToString();
            lblTotal.Text = dr["net"].ToString();
        }
        else
        {
            Response.Redirect("Default.aspx");
        }

        conn.Close();
        
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
            string delete = "DELETE FROM [bill] WHERE Id=@id;";
            SqlCommand cmd = new SqlCommand(delete, conn);
            cmd.Parameters.AddWithValue("id", Convert.ToInt32(Request.Cookies["deleteId"].Value));
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("<script>alert('Bill: " + lblBillNo.Text + ". Delete Successfully!');location.href='/im/order/Default.aspx';</script>");

        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        myModal.Visible = false;
    }

    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        string url = "editOrder.aspx?id=" + e.CommandArgument.ToString();
        Response.Redirect(url);
    }
}