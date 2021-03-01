using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_products_Default : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Response.Redirect("addProduct.aspx");
    }

    public String show(string msg)
    {
        if (msg.Equals("1"))
        {
            return "Active";
        }
        else
        {
            return "Inactive";
        }
    }

    public String img(string msg)
    {
        if(msg.Equals(""))
        {
            return "~/assets/image/product/empty.jpg";
        }
        else
        {
            return msg;
        }
    }

    public String color(string msg)
    {
        if (msg.Equals("1"))
        {
            return "w3-tag w3-green";
        }
        else
        {
            return "w3-tag w3-red";
        }
    }

    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        if(e.CommandName == "ProductId")
        {
            Response.Cookies["ProductId"].Value = e.CommandArgument.ToString(); 
            Response.Redirect("editProduct.aspx");
        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        myModal.Visible = false;
    }

    protected void btnDelete_Command(object sender, CommandEventArgs e)
    {
        myModal.Visible = true;
        conn.Open();

        SqlCommand cmd = new SqlCommand("SELECT * FROM [product] WHERE Id=@Id", conn);
        Response.Cookies["deleteId"].Value = e.CommandArgument.ToString();
        cmd.Parameters.AddWithValue("Id", e.CommandArgument.ToString());
        SqlDataReader dr = cmd.ExecuteReader();
        bool rf = dr.Read();

        if (rf)
        {
            lblId.Text = dr["Id"].ToString();     
            lblName.Text = dr["product_name"].ToString();
            ImgPrv.ImageUrl = img(dr["product_img"].ToString());
        }
        else
        {
            Response.Redirect("Default.aspx");
        }

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
       
        conn.Open();
        string delete = "DELETE FROM [product] WHERE Id=@id;";
        SqlCommand cmd = new SqlCommand(delete, conn);
        cmd.Parameters.AddWithValue("id", Convert.ToInt32(Request.Cookies["deleteId"].Value));
        cmd.ExecuteNonQuery();
        conn.Close();

        Response.Write("<script>alert('Product: " + lblName.Text + ". Delete Successfully!');location.href='/im/product/Default.aspx';</script>");
     
    }
}