using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace GocmenSupermarket
{
    public partial class SECTION : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                string sqlstr;
                sqlstr = "select * from SECTION";

                DBConnection dbcon = new DBConnection();
                DataSet ds = new DataSet();
                ds = dbcon.getSelect(sqlstr);


            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);

            try
            {
                con.Open();
            }
            catch (Exception)
            {
                con.Close();
                return;
                throw;
            }


            DataSet ds = new DataSet();
            string sqlstr = "select * from SECTION";

            SqlDataAdapter da = new SqlDataAdapter(sqlstr, con);
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

        }

    }
}