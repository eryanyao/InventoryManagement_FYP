using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_company_Default : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.Open();

                string getItem = "SELECT * FROM company";
                SqlCommand cmd7 = new SqlCommand(getItem, conn);
                SqlDataReader dr = cmd7.ExecuteReader();


                if (dr.Read())
                {
                    txtCompanyName.Text = dr["company_name"].ToString();
                    txtEmail.Text = dr["company_email"].ToString();
                    txtPhone.Text = dr["company_phone"].ToString();
                    txtAddress1.Text = dr["company_address1"].ToString();
                    txtAddress2.Text = dr["company_address2"].ToString();
                    txtAddress3.Text = dr["company_address3"].ToString();
                    txtServices.Text = dr["services_tax"].ToString();
                    txtManagerName.Text = dr["manager_name"].ToString();
                }


                conn.Close();
            }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblName.Text = txtCompanyName.Text;
        lblEmail.Text = txtEmail.Text;
        lblPhone.Text = txtPhone.Text;
        lblAddress.Text = txtAddress1.Text + "<br/>" + txtAddress2.Text + "<br/>" + txtAddress3.Text;
        lblManagerName.Text = txtManagerName.Text;
        lblTax.Text = txtServices.Text;
        myModal.Visible = true;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        myModal.Visible = false;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();

            string edit = "UPDATE [company] SET company_name=@name, company_email=@email, company_phone=@phone, company_address1=@address1,company_address2=@address2,company_address3=@address3,services_tax=@tax,manager_name=@manager";

            SqlCommand cmd = new SqlCommand(edit, conn);

            cmd.Parameters.AddWithValue("name", lblName.Text);
            cmd.Parameters.AddWithValue("email", lblEmail.Text);
            cmd.Parameters.AddWithValue("phone", lblPhone.Text);
            cmd.Parameters.AddWithValue("address1", txtAddress1.Text);
            cmd.Parameters.AddWithValue("address2", txtAddress2.Text);
            cmd.Parameters.AddWithValue("address3", txtAddress3.Text);
            cmd.Parameters.AddWithValue("tax", lblTax.Text);
            cmd.Parameters.AddWithValue("manager", lblManagerName.Text);
            cmd.ExecuteNonQuery();

            conn.Close();

            Response.Write("<script>alert('Company details update successfully!');location.href='/im/company/Default.aspx';</script>");
        }
    }
}