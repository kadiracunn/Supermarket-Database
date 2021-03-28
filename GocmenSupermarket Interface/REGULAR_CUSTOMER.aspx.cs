using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace GocmenSupermarket
{
    public partial class REGULAR_CUSTOMER : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {
                string sqlstr;
                sqlstr = "select * from REGULAR_CUSTOMER";

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
            string sqlstr = "select * from REGULAR_CUSTOMER";

            SqlDataAdapter da = new SqlDataAdapter(sqlstr, con);
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_updateTelForCustomer", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@customerID", SqlDbType.SmallInt).Value = TextBox1.Text;
            cmd.Parameters.Add("@phoneNumber", SqlDbType.VarChar).Value = TextBox4.Text;



            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_insertCustomer", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@customerID", SqlDbType.SmallInt).Value = TextBox1.Text;
            cmd.Parameters.Add("@firstName", SqlDbType.NVarChar).Value = TextBox2.Text;
            cmd.Parameters.Add("@lastName", SqlDbType.NVarChar).Value = TextBox3.Text;
            cmd.Parameters.Add("@phoneNumber", SqlDbType.VarChar).Value = TextBox4.Text;




            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();


        }


    }
}