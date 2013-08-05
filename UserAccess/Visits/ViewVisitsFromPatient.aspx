﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewVisitsFromPatient.aspx.cs" Inherits="UserAccess_Visits_ViewVisitsFromPatient" %>

<%@ Register Src="~/TemplateControls/UpdateProgressBar.ascx" TagPrefix="utmpl" TagName="UpdateProgressBar" %>
<%@ Register Src="~/TemplateControls/ResultAlert.ascx" TagPrefix="utmpl" TagName="ResultAlert" %>



<asp:Content ID="Content1" ContentPlaceHolderID="Title" runat="Server">
    Patient's Visits
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" runat="Server">
    Visits History
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>



                <asp:GridView ID="VisitsFromPatientGridView" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="ID" DataSourceID="VisitsFromPatientDataSource"
                    CssClass="gridview table table-bordered table-striped table-hover" AllowPaging="True">
                    <Columns>
                        <asp:TemplateField HeaderText="Patient">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server"
                                    Text='<%# ((Patient)Eval("Patient")).Name %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Visit Date" SortExpression="Date">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server"
                                    Text='<%# DateTime.FromBinary(long.Parse(Eval("Date").ToString())).ToShortDateString() %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Diagnosis" SortExpression="ICDID">
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server"
                                    Text='<%# ((ICD)Eval("ICD")).Name %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Outcome" SortExpression="Outcome">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Outcome") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:HyperLinkField Text="Details"
                            DataNavigateUrlFormatString="ViewVisitDetails.aspx?ID={0}"
                            DataNavigateUrlFields="ID">
                            <ControlStyle CssClass="btn btn-primary" />
                        </asp:HyperLinkField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="DeleteButton" runat="server" Text="Delete"
                                    CssClass="btn btn-danger" CommandName="Delete"
                                    OnClientClick="return confirm('Are you sure you want to delete this Visit?\n\nAll Prescriptions, Prescription Details as well as Lab Orders, Lab Order Details belong to this visit will be deleted, too!')" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:LinqDataSource ID="VisitsFromPatientDataSource" runat="server" ContextTypeName="DataClassesDataContext" EntityTypeName="" TableName="Visits" Where="PatientID == @PatientID" OrderBy="Date">
                    <WhereParameters>
                        <asp:QueryStringParameter Name="PatientID" QueryStringField="PatientID" Type="Int64" />
                    </WhereParameters>
                </asp:LinqDataSource>

                <utmpl:ResultAlert runat="server" ID="ResultAlert" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <utmpl:UpdateProgressBar runat="server" ID="UpdateProgressBar" />
    </form>
</asp:Content>

