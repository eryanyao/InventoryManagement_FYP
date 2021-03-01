using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_products_editProduct : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    private string directoryInfo;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            conn.Open();

            SqlCommand cmd = new SqlCommand("SELECT * FROM [Product] WHERE Id=@Id", conn);
            cmd.Parameters.AddWithValue("Id", Convert.ToInt32(Request.Cookies["ProductId"].Value));
            SqlDataReader dr = cmd.ExecuteReader();
            bool rf = dr.Read();

            if (rf)
            {
                ImgPrv.ImageUrl = dr["product_img"].ToString();
                txtName.Text = dr["product_name"].ToString();
                txtSKU.Text = dr["product_sku"].ToString();
                txtPrice.Text = dr["product_price"].ToString();
                txtQuantity.Text = dr["product_quantity"].ToString();
                txtDesc.Text = dr["product_desc"].ToString();
                ddlBrand.SelectedValue = dr["product_brand"].ToString();
                ddlCategory.SelectedValue = dr["product_category"].ToString();
                ddlStatus.SelectedValue = dr["product_status"].ToString();

            }
            else
            {
                Response.Write("<script>alert('Error Occured. Please try again.');location.href='Default.aspx';</script>");
            }
        }


        conn.Close();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();
                var Id = Convert.ToInt32(Request.Cookies["ProductId"].Value);
                var directoryInfo = new DirectoryInfo("C:\\Users\\yanyao\\Desktop\\InventoryManagement\\assets\\image\\product\\");
                if (directoryInfo.Exists)
                {
                    directoryInfo.CreateSubdirectory(Id.ToString());
                }
               

                string edit = "UPDATE [product] SET product_name=@name, product_sku=@sku, product_price=@price, product_quantity=@quantity, product_desc=@desc, product_brand=@brand, product_category=@category, product_img=@img, product_status=@status WHERE Id=@Id";
                   
                SqlCommand cmd = new SqlCommand(edit, conn);

                cmd.Parameters.AddWithValue("Id", Convert.ToInt32(Request.Cookies["ProductId"].Value));
                cmd.Parameters.AddWithValue("name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("sku", txtSKU.Text);
                cmd.Parameters.AddWithValue("price", txtPrice.Text);
                cmd.Parameters.AddWithValue("quantity", txtQuantity.Text);
                cmd.Parameters.AddWithValue("desc", txtDesc.Text);
                cmd.Parameters.AddWithValue("brand", ddlBrand.SelectedValue);
                cmd.Parameters.AddWithValue("category", ddlCategory.SelectedValue);

                if(flupImage.HasFile == true)
                {
                    flupImage.SaveAs(directoryInfo + Id.ToString() + "\\" + flupImage.FileName);
                    cmd.Parameters.AddWithValue("img", "\\assets\\image\\product\\" + Convert.ToInt32(Request.Cookies["ProductId"].Value) + "\\" + flupImage.FileName);
                }
                else
                {
                    cmd.Parameters.AddWithValue("img", "");
                }
               

                cmd.Parameters.AddWithValue("status", ddlStatus.SelectedValue);

                cmd.ExecuteNonQuery();

                conn.Close();

                Response.Write("<script>alert('Product: " + txtName.Text + ". Update Successfully!');location.href='/im/products/Default.aspx';</script>");
            }
        }
        catch(Exception ex)
        {
            lblError.Text = "ERROR: " + ex.ToString();
            lblError.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");

    }
}
