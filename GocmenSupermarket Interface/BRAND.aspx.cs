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
    public partial class BRAND : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack == false)
            {

                string sqlstr;
                sqlstr = "select * from BRAND";

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
            string sqlstr = "select * from BRAND";

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
            SqlCommand cmd = new SqlCommand("sp_brandPhone", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@brandName", SqlDbType.NVarChar).Value = TextBox1.Text;
            cmd.Parameters.Add("@phoneNumber", SqlDbType.VarChar).Value = TextBox2.Text;



            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_insertBrand", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@brandName", SqlDbType.NVarChar).Value = TextBox1.Text;
            cmd.Parameters.Add("@phoneNumber", SqlDbType.VarChar).Value = TextBox2.Text;
            cmd.Parameters.Add("@emailAddress", SqlDbType.VarChar).Value = TextBox3.Text;
            cmd.Parameters.Add("@city", SqlDbType.NVarChar).Value = TextBox4.Text;
            cmd.Parameters.Add("@state", SqlDbType.NVarChar).Value = TextBox5.Text;
            cmd.Parameters.Add("@zipCode", SqlDbType.Char).Value = TextBox6.Text;
            cmd.Parameters.Add("@dayForSell", SqlDbType.VarChar).Value = TextBox7.Text;



            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();


        }


    }
}