﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewAllICD.aspx.cs" Inherits="UserAccess_ICDs_ViewAllICD" %>

<%@ Register Src="~/TemplateControls/ResultAlert.ascx" TagPrefix="utmpl" TagName="ResultAlert" %>
<%@ Register Src="~/TemplateControls/UpdateProgressBar.ascx" TagPrefix="utmpl" TagName="UpdateProgressBar" %>



<asp:Content ID="Content1" ContentPlaceHolderID="Title" Runat="Server">
    ICD List
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">
    ICD List
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
    <form runat="server" class="form-horizontal">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="control-group">
                    <strong><asp:Label CssClass="label_filter" ID="Label3" runat="server" Text="Filter"></asp:Label></strong>&nbsp;
                    <asp:TextBox placeholder="ICD Code" ID="FindICDCodeTextBox" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="AutoCompleteExtender1" TargetControlID="FindICDCodeTextBox"
                        runat="server" UseContextKey="True" ServiceMethod="GetICDCodeCompletionList">
                    </asp:AutoCompleteExtender>
                    <asp:TextBox placeholder="ICD Name" ID="FindICDNameTextBox" runat="server"></asp:TextBox>
                    <asp:AutoCompleteExtender ID="AutoCompleteExtender2" TargetControlID="FindICDNameTextBox"
                        runat="server" UseContextKey="True" ServiceMethod="GetICDNameCompletionList">
                    </asp:AutoCompleteExtender>
                    
                    <asp:Button ID="FindICDButton" CssClass="btn btn-primary" runat="server" Text="Search" OnClick="FindICDButton_Click"/>
                    <asp:Button ID="CancelFindButton" runat="server" CssClass="btn btn-primary" Text="Cancel" OnClick="CancelFindButton_Click" />
                </div>

                <asp:GridView ID="AllICDGridView" runat="server" AllowPaging="True"
                    AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="AllICDDataSource"
                    CssClass="gridview table table-bordered table-striped table-hover" OnRowDeleted="AllICDGridView_RowDeleted" OnRowDeleting="AllICDGridView_RowDeleting">
                    <EmptyDataTemplate>
                        <strong>There are no ICDs that match your criteria</strong>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField HeaderText="Code" SortExpression="Code">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Code") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name" SortExpression="Name">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server"
                                    Text='<%# (new DataClassesDataContext()).ICDChapters.Where(c => c.ID == long.Parse(Eval("ICDChapterID").ToString())).Select(c => c.Name).First().ToString() %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField DataNavigateUrlFields="ID"
                            DataNavigateUrlFormatString="ViewICDDetails.aspx?ID={0}"
                            Text="Details">
                            <ControlStyle CssClass="btn btn-primary btn-small" />
                        </asp:HyperLinkField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="DeleteButton" runat="server" Text="Delete"
                                    CommandName="Delete" CssClass="btn btn-danger btn-small"
                                    OnClientClick="return confirm('Are you sure to you want to delete this ICD?\n\nAll Visits associated with this ICD will be deleted, too!')" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <pagertemplate>
                        <ul class="pager">
                            <li>
                                <asp:LinkButton CommandName="Page" CommandArgument="First" ID="HyperLink2" runat="server">
                                    First
                                </asp:LinkButton>
                                <asp:LinkButton CommandName="Page" CommandArgument="Prev" ID="LinkButton1" runat="server">
                                    Previous
                                </asp:LinkButton>
                                <asp:Label ID="Label4" runat="server" Text="Label">
                                    Page <%= AllICDGridView.PageIndex + 1 %> of <%= AllICDGridView.PageCount %>
                                </asp:Label>
                                <asp:LinkButton CommandName="Page" CommandArgument="Next" ID="LinkButton2" runat="server">
                                    Next
                                </asp:LinkButton>
                                <asp:LinkButton CommandName="Page" CommandArgument="Last" ID="LinkButton3" runat="server">
                                    Last
                                </asp:LinkButton>
                            </li>
                        </ul>
                    </pagertemplate>
                </asp:GridView>

                <asp:LinqDataSource ID="AllICDDataSource" runat="server" ContextTypeName="DataClassesDataContext"
                    EnableDelete="True" EntityTypeName="" TableName="ICDs"
                    Where="Code.Contains(@CodePart) && Name.Contains(@NamePart)">
                    <WhereParameters>
                        <asp:ControlParameter ControlID="FindICDCodeTextBox" ConvertEmptyStringToNull="False" Name="CodePart" PropertyName="Text" />
                        <asp:ControlParameter ControlID="FindICDNameTextBox" ConvertEmptyStringToNull="False" Name="NamePart" PropertyName="Text" />
                    </WhereParameters>
                </asp:LinqDataSource>

                <p></p>
                <utmpl:ResultAlert runat="server" ID="ResultAlert" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <utmpl:UpdateProgressBar runat="server" ID="UpdateProgressBar" />
    </form>
</asp:Content>

