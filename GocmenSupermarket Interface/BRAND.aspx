<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BRAND.aspx.cs" Inherits="GocmenSupermarket.BRAND" MasterPageFile="~/template.Master" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <p>
        &nbsp;</p>
    <p>
        Brand Name
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </p>
    <p>
        Phone Number
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </p>
      <p>
        E-mail Address
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    </p>
      <p>
        City
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    </p>
      <p>
        State
        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
    </p>
     <p>
        zipCode
        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
    </p>
     <p>
        Day For Sell
        <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
    </p>

    <p>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Update Brand's Phone Number" />
    &nbsp;
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Insert New Brand" />

    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Fill gridview" />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
            <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
            <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
            <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F7F7F7" />
            <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
            <SortedDescendingCellStyle BackColor="#E5E5E5" />
            <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

