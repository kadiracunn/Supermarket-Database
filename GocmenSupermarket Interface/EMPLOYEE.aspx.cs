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
    public partial class EMPLOYEE : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack==false)
            {
                string sqlstr;
                sqlstr = "select * from EMPLOYEE";

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
            string sqlstr = "select * from EMPLOYEE e order by e.SSN";

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
            SqlCommand cmd = new SqlCommand("sp_insertEmployee", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SSN", SqlDbType.VarChar).Value = TextBox1.Text;
            cmd.Parameters.Add("@firstName", SqlDbType.NVarChar).Value = TextBox2.Text;
            cmd.Parameters.Add("@lastName", SqlDbType.NVarChar).Value = TextBox3.Text;
            cmd.Parameters.Add("@birthDate", SqlDbType.Date).Value = TextBox4.Text;
            cmd.Parameters.Add("@age", SqlDbType.SmallInt).Value = TextBox5.Text;
            cmd.Parameters.Add("@phoneNumber", SqlDbType.VarChar).Value = TextBox6.Text;
            cmd.Parameters.Add("@salary", SqlDbType.SmallInt).Value = TextBox7.Text;
            cmd.Parameters.Add("@sectionID", SqlDbType.TinyInt).Value = TextBox8.Text;
            cmd.Parameters.Add("@cStartDate", SqlDbType.Date).Value = TextBox9.Text;
            cmd.Parameters.Add("@cEndDate", SqlDbType.Date).Value = TextBox10.Text;
            cmd.Parameters.Add("@daysOff", SqlDbType.NVarChar).Value = TextBox11.Text;
            cmd.Parameters.Add("@workingDay", SqlDbType.SmallInt).Value = TextBox12.Text;
            

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }



        protected void Button3_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_deleteEmployee", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SSN", SqlDbType.VarChar).Value = TextBox1.Text;

            con.Open();
            cmd.ExecuteNonQuery();

            con.Close();


        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conStr"].ToString();

            SqlConnection con = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand("sp_updateForEmployee", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SSN", SqlDbType.VarChar).Value = TextBox1.Text;
            cmd.Parameters.Add("@cEndDate", SqlDbType.Date).Value = TextBox10.Text;
            cmd.Parameters.Add("@salary", SqlDbType.SmallInt).Value = TextBox7.Text;


            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();


        }
    }
}