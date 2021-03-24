using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_order_invoice : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["connStr"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            string id = Request.QueryString["id"];

           if(id != null)
            {
                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();
                    string queryBrand = "SELECT bill.gross_amount as gross,bill.service_amount as service,bill.net_amount as net,bill.discount as discount,bill.date_time as datetime, bill.user_id as usr, customer.customer_name as name, customer.customer_phone as phone,customer.customer_address as address FROM bill INNER JOIN customer ON bill.customer_id = customer.Id WHERE bill.id = @id";
                    SqlCommand searchCmd = new SqlCommand(queryBrand, conn);
                    searchCmd.Parameters.AddWithValue("id", id);
                    searchCmd.ExecuteNonQuery();

                    SqlDataReader dr = searchCmd.ExecuteReader();

                    bool rf = dr.Read();

                    if (rf)
                    {
                        lblId.Text = id;
                        lbldate.Text = dr["datetime"].ToString();
                        lblName.Text = dr["name"].ToString();
                        lblAddress.Text = dr["address"].ToString();
                        lblPhone.Text = dr["phone"].ToString();
                        lblDiscount.Text = dr["discount"].ToString();
                        lblGross.Text = dr["gross"].ToString();
                        lblService.Text = dr["service"].ToString();
                        lblTotal.Text = dr["net"].ToString();
                        lblUser.Text = dr["usr"].ToString();
                    }

                    conn.Close();
                }

                if (conn.State == ConnectionState.Closed)
                {
                    conn.Open();

                    string getItem = "SELECT * FROM company";
                    SqlCommand cmd7 = new SqlCommand(getItem, conn);
                    SqlDataReader dr = cmd7.ExecuteReader();


                    if (dr.Read())
                    {
                        lblCompany.Text = dr["company_name"].ToString();
                        lblCompanyEmail.Text = dr["company_email"].ToString();
                        lblCompanyPhone.Text = dr["company_phone"].ToString();
                        lblAddress1.Text = dr["company_address1"].ToString();
                        lblAddress2.Text = dr["company_address2"].ToString();
                        lblAddress3.Text = dr["company_address3"].ToString();
                        //txtServices.Text = dr["services_tax"].ToString();
                        lblManager.Text = dr["manager_name"].ToString();
                    }


                    conn.Close();
                }
            }
           else
            {
                Response.Redirect("Default.aspx");
            }
               
            
        }
        
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }
}