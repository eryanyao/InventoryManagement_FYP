using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class im_MasterPage : System.Web.UI.MasterPage
{
    public string thisYear = (DateTime.Now.Year).ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            reportUrl.HRef = "/im/report/Default.aspx?year=" + thisYear;
        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("/login.aspx");
    }
}
