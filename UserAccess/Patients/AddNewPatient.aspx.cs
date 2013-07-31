﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserAccess_Patients_AddNewPatient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        AddPatientFormView.ChangeMode(FormViewMode.Insert);
    }
    protected void InsertButton_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(1000);

        var patientName = ((TextBox)AddPatientFormView.FindControl("NameTextBox")).Text;
        var patientGender = ((DropDownList)AddPatientFormView.FindControl("GenderDropdownList")).SelectedValue;
        var patientAddress = ((TextBox)AddPatientFormView.FindControl("AddressTextbox")).Text;
        var patientDateOfBirth = ((Calendar)AddPatientFormView.FindControl("DateOfBirthCalendar")).SelectedDate.Ticks;

        System.Collections.Specialized.ListDictionary dic = new System.Collections.Specialized.ListDictionary();
        dic.Add("Name", patientName);
        dic.Add("Gender", patientGender);
        dic.Add("Address", patientAddress);
        dic.Add("DateOfBirth", patientDateOfBirth);


        if (AddPatientDataSource.Insert(dic) == 0)
        {
            //fail
            ResultAlert.SetResultAlert("An error occured!",
                TemplateControls_ResultAlert.AlertTypeError);
        }
        else
        {
            // success
            ResultAlert.SetResultAlert("Patient inserted successfully!",
                TemplateControls_ResultAlert.AlertTypeSuccess);
            ClearForm();
        }
    }

    protected void ClearForm()
    {
        ((TextBox)AddPatientFormView.FindControl("NameTextBox")).Text = "";
        ((DropDownList)AddPatientFormView.FindControl("GenderDropdownList")).SelectedIndex = 0;
        ((TextBox)AddPatientFormView.FindControl("AddressTextbox")).Text = "";
        ((Calendar)AddPatientFormView.FindControl("DateOfBirthCalendar")).SelectedDate = DateTime.Now;
    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        ClearForm();
    }

    protected void AddPatientFormView_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        if (e.Exception == null)
        {
            ResultAlert.SetResultAlert("Patient inserted successfully!",
                TemplateControls_ResultAlert.AlertTypeSuccess);
            ClearForm();
        }
        else
        {
            
        }
    }
}