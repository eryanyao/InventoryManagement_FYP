using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Threading;

public partial class im_category_Default : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        divOn();
        lblHeader.Text = "Add new category";
        Response.Cookies["OperationId"].Value = "0";
        txtCategory.Text = "";
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        divOff();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if(Convert.ToInt32(Request.Cookies["OperationId"].Value) == 0)
        {
            conn.Open();
            string queryBrand = "SELECT * FROM brand WHERE brand_name=@name";
            SqlCommand searchCmd = new SqlCommand(queryBrand, conn);
            searchCmd.Parameters.AddWithValue("name", ToTitleCase(txtCategory.Text.Trim()));
            searchCmd.ExecuteNonQuery();

            SqlDataReader dr = searchCmd.ExecuteReader();

            bool rf = dr.Read();
            conn.Close();
            if (rf)
            {
                lblCheck.Visible = true;
            }
            else
            {
                lblCheck.Visible = false;
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();

                    string add = "INSERT INTO category (category_name,category_status)values(@name,@status)";
                    SqlCommand cmd = new SqlCommand(add, conn);

                    cmd.Parameters.AddWithValue("name", ToTitleCase(txtCategory.Text.Trim()));
                    cmd.Parameters.AddWithValue("status", ddlStatus.SelectedValue);

                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('New Category: " + ToTitleCase(txtCategory.Text.Trim()) + ". Added Successfully!');location.href='/im/category/Default.aspx';</script>");
                }
            }
        }
        else if (Convert.ToInt32(Request.Cookies["OperationId"].Value) == 1)
        {
            try
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();

                    string edit = "UPDATE [category] SET category_name=@name, category_status=@status WHERE Id=@Id";

                    SqlCommand cmd = new SqlCommand(edit, conn);

                    cmd.Parameters.AddWithValue("Id", Convert.ToInt32(Request.Cookies["brandId"].Value));
                    cmd.Parameters.AddWithValue("name", ToTitleCase(txtCategory.Text.Trim()));
                    cmd.Parameters.AddWithValue("status", ddlStatus.SelectedValue);

                    cmd.ExecuteNonQuery();

                    conn.Close();

                    Response.Write("<script>alert('Category: " + ToTitleCase(txtCategory.Text.Trim()) + ". Update Successfully!');location.href='/im/category/Default.aspx';</script>");
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "ERROR: " + ex.ToString();
                lblError.ForeColor = System.Drawing.Color.Red;
            }
        }

    }

    public String show(string msg)
    {
        if (msg.Equals("1"))
        {
            return "Available";
    
        }
        else
        {
            return "Unavailable";
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

    private void divOn()
    {
        divForm.Visible = true;
        divTable.Visible = false;
        btnAdd.Visible = false;
    }
    private void divOff()
    {
        divForm.Visible = false;
        divTable.Visible = true;
        btnAdd.Visible = true;

    }
    
    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        divOn();
        lblHeader.Text = "Edit Category";
        Response.Cookies["OperationId"].Value = "1";

        conn.Open();

        SqlCommand cmd = new SqlCommand("SELECT * FROM [category] WHERE Id=@Id", conn);
        Response.Cookies["brandId"].Value = e.CommandArgument.ToString();
        cmd.Parameters.AddWithValue("Id", e.CommandArgument.ToString());
        SqlDataReader dr = cmd.ExecuteReader();
        bool rf = dr.Read();

        if (rf)
        {
            txtCategory.Text = dr["category_name"].ToString();
            ddlStatus.SelectedValue = dr["category_status"].ToString();
        }
        else
        {
            Response.Redirect("Default.aspx");
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

        SqlCommand cmd = new SqlCommand("SELECT * FROM [category] WHERE Id=@Id", conn);
        Response.Cookies["deleteId"].Value = e.CommandArgument.ToString();
        cmd.Parameters.AddWithValue("Id", e.CommandArgument.ToString());
        SqlDataReader dr = cmd.ExecuteReader();
        bool rf = dr.Read();

        if (rf)
        {
            lblId.Text = dr["Id"].ToString();
            lblName.Text = dr["category_name"].ToString();
        }
        else
        {
            Response.Redirect("Default.aspx");
        }

    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            conn.Open();
            string delete = "DELETE FROM [category] WHERE Id=@id;";
            SqlCommand cmd = new SqlCommand(delete, conn);
            cmd.Parameters.AddWithValue("id", Convert.ToInt32(Request.Cookies["deleteId"].Value));
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("<script>alert('Category: " + lblName.Text + ". Delete Successfully!');location.href='/im/category/Default.aspx';</script>");
        }
        catch (Exception ex)
        {
            lblError.Text = ex.ToString();
        }
    }

    public static string ToTitleCase(string str)
    {
        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(str.ToLower());
    }
}