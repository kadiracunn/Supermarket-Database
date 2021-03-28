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
    public partial class Views : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            string sqlstr = "Select  p.productID, p.productIDForInfo, p_i.brandName, p_i.productName, p.expirationDate From PRODUCT p inner join PRODUCT_INFO p_i on p.productIDForInfo = p_i.productIDForInfo Where p.expirationDate < GETDATE() and p.sellDate is NULL";

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
            string sqlstr = "Select p.productIDForInfo, p_i.brandName, p_i.productName, Count(*) stockState From PRODUCT p inner join PRODUCT_INFO p_i on p.productIDForInfo = p_i.productIDForInfo Where p.sellDate is NULL Group By p.productIDForInfo , p_i.brandName, p_i.productName";

            SqlDataAdapter da = new SqlDataAdapter(sqlstr, con);
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

        }
        protected void Button3_Click(object sender, EventArgs e)
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
            string sqlstr = "Select p.customerID, Sum(p.amount) totalAmount, p.paymentDescription From PAYMENT p inner join REGULAR_CUSTOMER rc on p.customerID = rc.customerID Group By p.customerID, p.paymentDescription";

            SqlDataAdapter da = new SqlDataAdapter(sqlstr, con);
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

        }
        protected void Button4_Click(object sender, EventArgs e)
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
            string sqlstr = "Select pi.productIDForInfo, pi.productName , Count(*) saleAmount From Payment p inner join Product pro on p.productID = pro.productID inner join PRODUCT_INFO pi on pi.productIDForInfo = pro.productIDForInfo Group by pi.productIDForInfo, pi.productName";

            SqlDataAdapter da = new SqlDataAdapter(sqlstr, con);
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

        }
        protected void Button5_Click(object sender, EventArgs e)
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
            string sqlstr = "Select prom.promotionID, prom.brandName, prom.startDate, prom.endDate , (Sum(pi.price) - Sum(pay.amount)) paymentDifferences From Payment pay inner join PROMOTION prom on pay.promotionID = prom.promotionID inner join PRODUCT pro on pro.productID = pay.productID inner join PRODUCT_INFO pi on pro.productIDForInfo = pi.productIDForInfo Group By prom.promotionID, prom.brandName, prom.startDate, prom.endDate ";

            SqlDataAdapter da = new SqlDataAdapter(sqlstr, con);
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

        }
    }
}