using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class login : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {   
        conn.Open();

        SqlCommand cmd = new SqlCommand("SELECT * FROM [user] WHERE username=@user AND password=@pass", conn);
        cmd.Parameters.AddWithValue("user", txtUsrname.Text);
        cmd.Parameters.AddWithValue("pass", txtPass.Text);

        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.HasRows)  //determine that has record or not
        {
            while (dr.Read())
            {
                Session["username"] = dr["username"].ToString();
                Session["Id"] = dr["Id"].ToString();
                Response.Redirect("/im/dashboard.aspx");
            }
        }
        else
        {
            Response.Write("<script>alert('EMAIL AND PASSWORD IS NOT FOUND!'); </script>");
        }

        conn.Close();

    }
}