﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="REGULAR_CUSTOMER.aspx.cs" Inherits="GocmenSupermarket.REGULAR_CUSTOMER" MasterPageFile="~/template.Master" %>
<asp:Content ID="Content1" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <p>
        &nbsp;</p>
    <p>
        Customer ID
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    </p>
    <p>
        First Name
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
    </p>
      <p>
        Last Name
        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
    </p>
      <p>
        Phone Number
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
    </p>
      
    
    <p>
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Update Customer's Phone Number" />
    &nbsp;
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Insert New Customer" />

    </p>
    
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

