﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewAllUsers.aspx.cs" Inherits="AdminAccess_ViewAllUsers" %>

<%@ Register Src="~/TemplateControls/UpdateProgressBar.ascx" TagPrefix="utmpl" TagName="UpdateProgressBar" %>


<asp:Content ID="Title" ContentPlaceHolderID="Title" runat="Server">
    Users
</asp:Content>

<asp:Content ID="Header" ContentPlaceHolderID="Header" runat="Server">
    Users List
</asp:Content>

<asp:Content ID="Content" ContentPlaceHolderID="Content" runat="Server">

    <form id="form1" runat="server">
        <asp:ScriptManager ID="UsersScriptManager" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UsersUpdatePanel" runat="server">
            <ContentTemplate>
                <asp:GridView ID="AllUsersGridView" runat="server" CssClass="table table-bordered table-striped table-hover"
                    AutoGenerateColumns="false"
                    AutoGenerateDeleteButton="false" AutoGenerateEditButton="false"
                    OnRowCancelingEdit="AllUsersGridViewRowCancelingEdit"
                    OnRowDeleting="AllUsersGridViewRowDeleting" OnRowEditing="AllUsersGridViewRowEditing"
                    OnRowUpdating="AllUsersGridViewRowUpdating">

                    <Columns>
                        <asp:BoundField DataField="UserName" HeaderText="UserName" ReadOnly="true" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="LastActivityDate" HeaderText="Last Activity" ReadOnly="true" />

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" CommandName="Edit" Text="Edit" />
                                <asp:Button ID="Button2" runat="server" CssClass="btn btn-primary" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this user?')" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Button ID="Button3" runat="server" CssClass="btn btn-primary" CommandName="Update" Text="Update" />
                                <asp:Button ID="Button4" runat="server" CssClass="btn btn-primary" CommandName="Cancel" Text="Cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <div runat="server" id="ResultDiv">
                    <asp:Label ID="ResultLabel" runat="server" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <utmpl:UpdateProgressBar runat="server" ID="UpdateProgressBar" />
    </form>
    <asp:HyperLink CssClass="btn btn-large btn-primary glyphicon glyphicon-plus-sign"
            ID="HyperLink1" runat="server" NavigateUrl="/AdminAccess/AddNewUser.aspx">
            Add New User</asp:HyperLink>
</asp:Content>
