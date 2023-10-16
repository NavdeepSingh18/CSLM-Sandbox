page 50515 "Internal Exam Schedule"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                                         Remarks
    // ---------------------------------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  14-04-19   OnAfterGetRecord()                              Code added for Document Validation.
    // 02.   CSPL-00174  14-04-19   OnNewRecord()                                   Code added for Document Validation
    // 03.   CSPL-00174  14-04-19   OnDeleteRecord()                                Code added for Showing Error.
    // 04.   CSPL-00174  14-04-19   No. - OnAssistEdit()                            Code added for No.Series Generation.
    // 05.   CSPL-00174  14-04-19   Generate Exam Schedule - OnAction()             Code added for Exam Schedule Generation.
    // 06.   CSPL-00174  14-04-19   Calculate Student Attendance - OnAction()       Code added for Calculate Students Attendance.
    // 07.   CSPL-00174  14-04-19   Generate  External Exam Attendance  - OnAction()Code added for Generate Students External Exam Attendance.
    // 08.   CSPL-00174  14-04-19   Generate  External Exam Details - OnAction()    Code added for Generate Students External Exam Details.
    // 09.   CSPL-00174  14-04-19   Export/Import Exam Schedule - OnAction()        Code added for Export/Import Exam Schedule .
    // 10.   CSPL-00174  14-04-19   Hall Allotment - OnAction()                     Code added for Validation with Hall Allotment.
    // 11.   CSPL-00174  14-04-19   Release - OnAction()                            Code added for Modify Record.
    // 12.   CSPL-00174  14-04-19   Reopen - OnAction()                             Code added for Modify Record.

    Caption = 'Schedule Internal Exam';
    DeleteAllowed = false;
    PageType = Document;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Exam Time Table Head-CS";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = NoChangeAllowed;

                    trigger OnAssistEdit()
                    begin
                        //Code added for No.Series Generation::CSPL-00174::140419: Start
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                        //Code added for No.Series Generation::CSPL-00174::140419: End
                    end;
                }
                field("Exam Type"; Rec."Exam Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Exam Code"; Rec."Exam Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Method"; Rec."Exam Method")
                {
                    ApplicationArea = All;
                    Editable = NoChangeAllowed;
                    Visible = false;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                    Editable = NoChangeAllowed;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = all;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = all;
                }
                field("Exam Classification"; Rec."Exam Classification")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    //Editable = NoChangeAllowed; Rec.

                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    //Editable = NoChangeAllowed; Rec.
                    Editable = false;
                }
            }

            part("Internal Exam Schedule Subpage"; "Internal Exam Schedule Subpage")
            {
                Editable = NoChangeAllowed;
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&xam Schedule")
            {
                Caption = 'E&xam Schedule';
                action("&List")
                {
                    Caption = '&List';
                    RunObject = Page 50083;
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;
                }

                action("Export Schedule")
                {
                    Image = Export;
                    Caption = 'Export Schedule';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        ExamSchdLn: Record "Exam Time Table Line-CS";
                        ExtExamSchd: Report ExportSchedule;
                    begin
                        ExamSchdLn.Reset();
                        ExamSchdLn.SetRange("Document No.", Rec."No.");
                        ExtExamSchd.SetTableView(ExamSchdLn);
                        ExtExamSchd.Run();
                    end;
                }
                action("Import Schedule")
                {
                    Image = Import;
                    Caption = 'Import Schedule';
                    Promoted = true;
                    PromotedOnly = true;
                    ApplicationArea = all;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        ExamSchdLn: Record "Exam Time Table Line-CS";
                        ExtExamSchd: XmlPort ExternalSchedLineImport;
                    begin
                        ExamSchdLn.Reset();
                        ExamSchdLn.SetRange("Document No.", Rec."No.");
                        ExtExamSchd.SetTableView(ExamSchdLn);
                        ExtExamSchd.Run();
                    end;
                }
                action("Generate Internal Exam Schedule")
                {
                    Image = CalculateLines;
                    Caption = 'Generate (Internal) Schedule';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    Var
                        ExamScheduleLine: Record "Exam Time Table Line-CS";
                    begin
                        Rec.TestField("Academic Year");
                        Rec.TestField("Global Dimension 1 Code");
                        Rec.TestField("Course Code");
                        Rec.TestField("Semester Code");
                        Rec.TestField("Subject Classification");
                        Rec.TestField("Exam Classification");
                        ExamScheduleLine.Reset();
                        ExamScheduleLine.SetRange("Document No.", Rec."No.");
                        IF NOT ExamScheduleLine.FindFirst() then begin
                            IF UserSetup.GET(UserId()) THEN
                                IF UserSetup."Student Subject Permission" THEN begin
                                    IF CONFIRM(Text_100002Lbl, true, Format(Rec."Exam Type"), Rec."No.") THEN
                                        ExaminationMgmt.GenerateExternalExamSchedule(Rec."No.", 2);

                                end else
                                    Error('You do not have a permission');
                        end Else
                            ERROR('%1 Exam Schedule Already Generated.', Format(REc."Exam Type"));
                    End;
                }


                action("Generate Internal Exam")
                {
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        TotalLinesCreated: Integer;
                    begin
                        IF Rec.Status = Rec.Status::Released THEN begin
                            IF UserSetup.GET(UserId()) THEN
                                IF UserSetup."Student Subject Permission" THEN begin
                                    IF CONFIRM(Text_100001Lbl, true, Rec."No.") THEN begin
                                        TotalLinesCreated := 0;
                                        ExaminationMgmt.CreateInternalExam(Rec."Global Dimension 1 Code", Rec."No.", Rec."Exam Classification", Rec."Exam Type", TotalLinesCreated);
                                        // ExamScheduleMailtoStudent(Rec);//Lucky
                                        if TotalLinesCreated > 0 then
                                            Message('Internal Exam has been Generated.');
                                    end;
                                end else
                                    Error('You do not have a permission');
                        End ELSE
                            ERROR('Exam Schedule Should Be Released!!');
                    End;
                }

            }
            group("F&unction")
            {
                Caption = 'F&unction';
                action("Hall Allotment")
                {
                    Caption = 'Hall Allotment';
                    Promoted = true;
                    PromotedOnly = true;

                    Visible = false;
                    ApplicationArea = All;
                    Image = Allocate;
                    trigger OnAction()
                    var
                        ExamSchedule: Codeunit "Schedule Exam -CS";
                    begin
                        //Code added for Validation with Hall Allotment::CSPL-00174::140419: Start
                        Rec.TESTFIELD("Exam Type");
                        Rec.TESTFIELD("Exam Classification");
                        ExamSchedule.AdmitCrdAllotmentGenration(Rec."No.");
                        //Code added for Validation with Hall Allotment::CSPL-00174::140419: End
                    end;
                }
                action(Release)
                {
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for Modify Record::CSPL-00174::140419: Start
                        Rec.TESTFIELD("No.");
                        Rec.TESTFIELD("Exam Classification");
                        Rec.TESTFIELD("Exam Type");
                        IF Rec.Status = Rec.Status::Released THEN
                            ERROR('Already Released!!');
                        ScheduleExamGenCS.ExamScheduleReleasedCS(Rec."No.");
                        NoChangeAllowed := TRUE;
                        //Code added for Modify Record::CSPL-00174::140419: End
                    end;
                }
                action("Re-Open")
                {
                    Image = ReOpen;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //Code added for Modify Record::CSPL-00174::140419: Start
                        ScheduleExamGenCS.ExamScheduleReopenCS(Rec."No.");
                        //Code added for Modify Record::CSPL-00174::140419: End
                    end;
                }
                // action("Export Schedule SLcM To NBME")
                // {
                //     Image = Allocate;
                //     Promoted = true;
                //     PromotedOnly = true;
                //     PromotedCategory = Process;
                //     ApplicationArea = All;
                //     trigger OnAction()
                //     begin
                //         IF Confirm(Text_10004Lbl, true, "No.") then begin
                //             ExternalExamLine.Reset();
                //             ExternalExamLine.SetRange("Exam Schedule No.", "No.");
                //             If ExternalExamLine.FindFirst() then
                //                 Report.Run(50167, true, true, ExternalExamLine);
                //         end;
                //     end;
                // }
                action("Internal Exam List")
                {
                    Image = CalculateLines;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ExternalExamHeader: Record "Internal Exam Header-CS";
                        ExternalExamList: Page "Internal Student List-CS";
                    begin
                        ExternalExamHeader.Reset();
                        ExternalExamHeader.SetRange("Exam Schedule Code", Rec."No.");
                        IF ExternalExamHeader.FindFirst() then begin
                            ExternalExamList.SetTableView(ExternalExamHeader);
                            ExternalExamList.Run();
                        end;
                    End;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //Code added for Document validation::CSPL-00174::140419: Start
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec.Status, NoChangeAllowed);
        //Code added for Document validation::CSPL-00174::140419: End
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //Code added for Showing Error::CSPL-00174::140419: Start
        IF Rec.Status = Rec.Status::Released THEN
            ERROR('You Can not Delete this schedule');
        //Code added for Showing Error::CSPL-00174::140419: End
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //Code added for Document validation::CSPL-00174::140419: Start
        Rec."Exam Type" := Rec."Exam Type"::Internal;
        // EventsOfExaminationCS.CSRestrictDocumentAfterRelease(Rec.Status, NoChangeAllowed);
        //Code added for Document validation::CSPL-00174::140419: End
    end;

    var
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        UserSetup: Record "User Setup";
        EducationSetupCS: Record "Education Setup-CS";
        ExternalExamLine: Record "External Exam Line-CS";
        ExaminationMgmt: Codeunit "Examination Management";
        StudentSubOldRecCS: Codeunit "Student Sub. Old Rec-CS";
        ScheduleExamGenCS: Codeunit "Schedule Exam Gen-CS";
        // EventsOfExaminationCS: Codeunit "Events Of Examination-CS";
        NoChangeAllowed: Boolean;
        Text0001Lbl: Label 'Do you want generate exam schedule?';


        Text0002Lbl: Label 'Do you want generate the Student External Exam Attendance ?';

        Text_10001Lbl: Label 'Do You Want To Generate External Exam Details ?';
        Text_10003Lbl: Label 'Student External Attendance No Generated. Generate Student External Attendance First !! ';
        Text_10004Lbl: Label 'Do You Want To Calculate Students Attendance ?';
        Text_100001Lbl: Label 'Do You Want To Generate External Exam for Schedule No. %1 ?';
        Text_100002Lbl: Label 'Do You Want To Generate %1 Exam Schedule No. %2 ?';


    [IntegrationEvent(false, false)]
    local procedure CallExternalExaminationEventforStudent(ExternalAttendanceHeaderCS: Record "External Attendance Header-CS")
    begin
    end;

    // Procedure ExamScheduleMailtoStudent(ExamTimeTableHead: Record "Exam Time Table Head-CS");
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     RecStudent: Record "Student Master-CS";
    //     ExamTimeTableLine: Record "Exam Time Table Line-CS";
    //     SMTPMail: codeunit "Email Message";
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipient: Text[250];
    //     Recipients: List of [Text];
    //     BodyText: text;
    // begin
    //     RecStudent.Reset();
    //     RecStudent.SetRange("Academic Year", ExamTimeTableHead."Academic Year");
    //     RecStudent.SetRange(Term, ExamTimeTableHead.Term);
    //     RecStudent.SetRange(Semester, ExamTimeTableHead."Semester Code");
    //     RecStudent.SetRange("Course Code", ExamTimeTableHead."Course Code");
    //     RecStudent.SetRange("Global Dimension 1 Code", ExamTimeTableHead."Global Dimension 1 Code");
    //     RecStudent.SetRange(Status, 'ATT');
    //     if RecStudent.FindSet() then begin
    //         //repeat
    //         SMTPMailSetup.GET;
    //         Subject := 'Exam Schedule Alert';
    //         CLEAR(SMTPMail);
    //         Recipient := 'ajay.khare@corporateserve.com;Lucky.kumar@corporateserve.com';
    //         Recipients := Recipient.Split(';');
    //         SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, Subject, '');
    //         Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //         Smtpmail.AppendtoBody('<br/><br/>');
    //         SMTPMail.AppendtoBody('We are writing to inform you that ' + ExamTimeTableHead."Subject Classification" + ' has been schedule.<br><br>');
    //         SMTPMail.AppendtoBody('Exams will be conducted as follow:<br><br>');
    //         SMTPMail.AppendtoBody('<table border="1" width="100%" align="Center"><tbody><tr><td>Subject  Name</td> <td>Exam Date</td><td>Exam Slot</td></tr>');
    //         ExamTimeTableLine.Reset();
    //         ExamTimeTableLine.SetRange("Document No.", ExamTimeTableHead."No.");
    //         IF ExamTimeTableLine.FindSet() then
    //             repeat
    //                 SMTPMail.AppendtoBody('<tr><td>' + ExamTimeTableLine."Subject Name" + '</td> <td>' + Format(ExamTimeTableLine."Exam Date") + '</td><td>' + ExamTimeTableLine."Exam Slot New" + '</td></tr>');
    //             until ExamTimeTableLine.Next() = 0;
    //         SMTPMail.AppendtoBody('</tbody></table>');
    //         Smtpmail.AppendtoBody('<br><br>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //         Smtpmail.AppendtoBody('<br/><br/>');
    //         Smtpmail.AppendtoBody('Thank you,');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('SLcM System Administrator');
    //         BodyText := SmtpMail.GetBody();
    //         //Mail_lCU.Send();
    //         //MESSAGE('Mail sent');
    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Exam Schedule Alert', 'MEA', SenderAddress, RecStudent."Student Name",
    //         Format(RecStudent."No."), Subject, BodyText, 'Exam Schedule Alert', 'Exam Schedule Alert', Format(ExamTimeTableHead."No."), Format(ExamTimeTableHead.Date, 0, 9),
    //         Recipient, 1, RecStudent."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -
    //         //until RecStudent.Next() = 0;
    //     end;
    // END;

}