// report 50230 "Sales Force Error Re-Processed"
// {
//     Caption = 'SalesForce Error Re-Process';
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem("Salesforce Sync Error Log"; "Salesforce Sync Error Log")
//         {
//             DataItemTableView = where(Retry = Filter(false), Counter = filter(<= 5), URL = Filter(<> ''));
//             trigger OnPreDataItem()
//             begin
//                 EntryFound_gBool := false;
//             end;

//             Trigger OnAfterGetRecord()
//             begin
//                 lSuccessStatusCode := false;
//                 ReasonPhrs := '';
//                 ResData := '';
//                 SLcMSalesForce_gCU.SFInsert("Salesforce Sync Error Log".URL, "Salesforce Sync Error Log".Method, "Salesforce Sync Error Log"."Body 1", lSuccessStatusCode, ReasonPhrs, ResData);
//                 If lSuccessStatusCode then begin
//                     "Salesforce Sync Error Log".Counter := 0;
//                     "Salesforce Sync Error Log".Retry := true;
//                     "Salesforce Sync Error Log".Modify();
//                 end else begin
//                     If "Salesforce Sync Error Log".Counter < 5 then
//                         "Salesforce Sync Error Log".Counter += 1
//                     else
//                         "Salesforce Sync Error Log".Counter := 99;
//                     "Salesforce Sync Error Log".Modify();
//                     EntryFound_gBool := true;
//                 end;
//             end;
//         }
//     }

//     trigger OnPostReport()
//     Begin
//         IF EntryFound_gBool then
//             SendEmail();
//     End;

//     var
//         SLcMSalesForce_gCU: Codeunit SLcMToSalesforce;
//         lSuccessStatusCode: Boolean;
//         ReasonPhrs: Text;
//         ResData: Text[2048];
//         EntryFound_gBool: Boolean;


//     procedure SendEmail()
//     Var
//         SMTPSetup_lRec: Record "Email Account";
//         EducationSetup_lRec: Record "Education Setup-CS";
//         SalesForceLogDetails_lRep: Report "SalesForce Log Details";
//         SMTP_lCU: Codeunit "Email Message";
//         Folder_lTxt: Text;
//         FileName_lTxt: Text;
//         Subject_lTxt: Text;
//         Body_lTxt: Text;
//         EmailId_lTxt: Text;
//         Recipients: List of [Text];
//     begin
//         SMTPSetup_lRec.Reset();

//         Clear(SalesForceLogDetails_lRep);
//         FileName_lTxt := 'SalesForce Log Details';
//         Folder_lTxt := 'C:\' + FileName_lTxt + '.xls';
//         SalesForceLogDetails_lRep.SaveAsExcel(Folder_lTxt);

//         EmailId_lTxt := '';
//         EducationSetup_lRec.Reset();
//         EducationSetup_lRec.SetRange("Global Dimension 1 Code", '9000');
//         If EducationSetup_lRec.FindFirst() then
//             EmailId_lTxt := EducationSetup_lRec."E-mail ID (SalesForce Log)";

//         EducationSetup_lRec.Reset();
//         EducationSetup_lRec.SetRange("Global Dimension 1 Code", '9100');
//         If EducationSetup_lRec.FindFirst() then
//             EmailId_lTxt += ';' + EducationSetup_lRec."E-mail ID (SalesForce Log)";

//         Recipients := EmailId_lTxt.Split(';');
//         SMTPSetup_lRec.Get();
//         Clear(SMTP_lCU);
//         Subject_lTxt := '';
//         Body_lTxt := '';

//         Subject_lTxt := 'SalesForce Error Log Details';

//         SMTP_lCU.Create('MEA', SMTPSetup_lRec."User ID", Recipients, Subject_lTxt, '', true);
//         SMTP_lCU.AppendtoBody('Dear Team');
//         SMTP_lCU.AppendtoBody('<br><br>');
//         SMTP_lCU.AppendtoBody('Please find the attached SalesForce Error Log Details.');
//         SMTP_lCU.AppendtoBody('<br><br>');
//         SMTP_lCU.AppendtoBody('Regards');
//         SMTP_lCU.AppendtoBody('<br><br>');
//         SMTP_lCU.AppendtoBody('MEA Administrator');
//         SMTP_lCU.AppendtoBody('<br><br>');
//         SMTP_lCU.AppendtoBody('This is system generated mail. Please do not reply on this E-mail ID.');
//         SMTP_lCU.AddAttachment(Folder_lTxt, Folder_lTxt);
//         //SMTP_lCU.Send();
//     end;
// }