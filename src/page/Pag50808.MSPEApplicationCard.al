page 50808 "MSPE Application Card"
{
    PageType = Card;
    Caption = 'MSPE Application Card';
    SourceTable = "MSPE";
    UsageCategory = None;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = False;
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }

                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }

                field(Status; Rec."Processing Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Status';
                }
            }
            group("Student Information")
            {
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Previous First Name"; Rec."Previous First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Previous Last Name"; Rec."Previous Last Name")
                {
                    ApplicationArea = All;
                }
                field("Estimated Graduation Date"; Rec."Estimated Graduation Date")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }

                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }

                field("Phone Numbers"; Rec."Phone Numbers")
                {
                    ApplicationArea = All;
                }

                field(Mobile_Cell; Rec.Mobile_Cell)
                {
                    ApplicationArea = All;
                }
                field("AUA Email Address"; Rec."AUA Email Address")
                {
                    ApplicationArea = All;
                }
                // Field("Phone Number - Home";Rec."Phone Number - Home")
                // {
                //     ApplicationArea = All;
                // }
                // Field(Cell;Rec.Cell)
                // {
                //     ApplicationArea = All;
                // }
                // field(Apt;Rec.Apt)
                // {
                //     ApplicationArea = All;
                // }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Zip; Rec.Zip)
                {
                    ApplicationArea = All;
                }

            }
            Group("Other Details")
            {
                field("Step 1 Agree"; Rec."Step 1 Agree")
                {
                    ApplicationArea = All;
                }
                field(ERAS; Rec.ERAS)
                {
                    ApplicationArea = All;
                }
                field(CaRMS; Rec.CaRMS)
                {
                    ApplicationArea = All;
                }
                field("Other Specialty"; Rec."Other Specialty")
                {
                    ApplicationArea = All;
                }
                field("Other Specialty Description"; Rec."Other Specialty Description")
                {
                    ApplicationArea = All;
                }
                field("Do Not Update MPSE"; Rec."Do Not Update MPSE")
                {
                    ApplicationArea = All;
                    Caption = 'Do Not Update MSPE';
                }
            }
            Group("Noteworthy Characteristics")
            {
                Visible = ShowNewPageGroup;
                group("a) Type of Experience")
                {
                    field("1st Noteworthy Char. Exp."; Rec."1st Noteworthy Char. Exp.")
                    {
                        ApplicationArea = All;
                        MultiLine = True;
                        Caption = 'Experience';
                    }
                    field("1st Noteworthy Char. Dates"; Rec."1st Noteworthy Char. Dates")
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field("1st Noteworthy Char. End Date"; Rec."1st Noteworthy Char. End Date")
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }

                    field("1st Noteworthy Char. Location"; Rec."1st Noteworthy Char. Location")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Location';
                    }
                }
                Group("b) Type of Experience")
                {
                    field("2nd Noteworthy Char. Exp."; Rec."2nd Noteworthy Char. Exp.")
                    {
                        ApplicationArea = All;
                        MultiLine = True;
                        Caption = 'Experience';
                    }
                    field("2nd Noteworthy Char Dates"; Rec."2nd Noteworthy Char Dates")
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field("2nd Noteworthy Char. End Date"; Rec."2nd Noteworthy Char. End Date")
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field("2nd Noteworthy Char Location"; Rec."2nd Noteworthy Char Location")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Location';
                    }
                }
                group("c) Type of Experience")
                {
                    field("3rd Noteworthy Char. Exp."; Rec."3rd Noteworthy Char. Exp.")
                    {
                        ApplicationArea = All;
                        MultiLine = True;
                        Caption = 'Experience';
                    }
                    field("3rd Noteworthy Char Dates"; Rec."3rd Noteworthy Char Dates")
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field("3rd Noteworthy Char. End Date"; Rec."3rd Noteworthy Char. End Date")
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field("3rd Noteworthy Char Location"; Rec."3rd Noteworthy Char Location")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Location';
                    }
                }
                group("d) Type of Experience")
                {
                    field("4th Noteworthy Char Exp."; Rec."4th Noteworthy Char Exp.")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Experience';
                    }
                    field("4th Noteworthy Char Dates"; Rec."4th Noteworthy Char Dates")
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field("4th Noteworthy Char. End Date"; Rec."4th Noteworthy Char. End Date")
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field("4th Noteworthy Char Location"; Rec."4th Noteworthy Char Location")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Location';
                    }
                }
                group("e) Type of Experience")
                {
                    field("5th Noteworthy Char Exp."; Rec."5th Noteworthy Char Exp.")
                    {
                        ApplicationArea = All;
                        multiline = true;
                        Caption = 'Experience';
                    }
                    field("5th Noteworthy Char Dates"; Rec."5th Noteworthy Char Dates")
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field("5th Noteworthy Char. End Date"; Rec."5th Noteworthy Char. End Date")
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                    field("5th Noteworthy Char Location"; Rec."5th Noteworthy Char Location")
                    {
                        ApplicationArea = All;
                        MultiLine = true;
                        Caption = 'Location';
                    }
                }
            }
            Group("Under Graduate")
            {
                Visible = ShowNewPageGroup;
                field("Under Graduate School Name"; Rec."Under Graduate School Name")
                {
                    ApplicationArea = All;
                    Caption = 'School Name';
                    MultiLine = true;
                }
                field("Under Graduate Location"; Rec."Under Graduate Location")
                {
                    ApplicationArea = All;
                    Caption = 'Location (City/State)';
                    Multiline = True;
                }
                field("Under Graduate Month Year"; Rec."Under Graduate Month Year")
                {
                    ApplicationArea = All;
                    Caption = 'Month and Year of Graduation';
                }
                field("Under Graduate Degree"; Rec."Under Graduate Degree")
                {
                    ApplicationArea = All;
                    Caption = 'Degree Bachelor';
                }
                field("Under Graduate Degree Major"; Rec."Under Graduate Degree Major")
                {
                    ApplicationArea = All;
                    Caption = 'Degree Major';
                }
            }
            group("Current or Post-Graduate Status")
            {
                Visible = ShowRepeatPageGroup;
                field("Post Graduate_Curr Pos_Dep"; Rec."Post Graduate_Curr Pos_Dep")
                {
                    ApplicationArea = All;
                    Caption = 'Position and Department';
                    MultiLine = True;
                }
                field("Post Graduate_Curr Hosp_Inst"; Rec."Post Graduate_Curr Hosp_Inst")
                {
                    ApplicationArea = All;
                    Caption = 'Hospital/Institution';
                    Multiline = True;
                }
                field("Post Graduate_Curr City_State"; Rec."Post Graduate_Curr City_State")
                {
                    ApplicationArea = All;
                    Caption = 'City/State';
                    MultiLine = True;
                }
                field("Post Graduate_Current From"; Rec."Post Graduate_Current From")
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';

                }
                field("Post Graduate_Current To"; Rec."Post Graduate_Current To")
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
            }
            Group("Other Information")
            {
                Visible = ShowNewPageGroup;
                field("Field of Study"; Rec."Field of Study")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(GAPS; Rec.GAPS)
                {
                    ToolTip = 'Specifies the value of the GAPS field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(ClinicalClerkshipRemediation; Rec.ClinicalClerkshipRemediation)
                {
                    ToolTip = 'Specifies the value of the Clinical Clerkship Remediation field.';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
        }
        area(FactBoxes)
        {
            Part("MSPE Status FactBox"; "MSPE FactBox")
            {
                ApplicationArea = All;
                Caption = 'MSPE Status FactBox';
                SubPageLink = "Application No" = Field("Application No"), "Application Type" = Field("Application Type"), "Student No" = Field("Student No");
            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Send For Review")
            {
                ApplicationArea = All;
                Caption = 'Send For Review';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                //Visible = SendforReviewBoolean;
                Enabled = False;
                //Visible = False;
                trigger OnAction()
                Var
                    StudentMaster_lRec: Record "Student Master-CS";
                begin
                    If Confirm('Do you want to send the application for Review?', True) then begin
                        Rec."Processing Status" := Rec."Processing Status"::"In-Review";
                        Rec.Modify();
                        CurrPage.Update();
                        CU50034.MSPE_Change_Status(Rec);
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("No.", Rec."Student No");
                        If StudentMaster_lRec.FindFirst() then
                            // SendEmail(StudentMaster_lRec, Rec);//GMCSCOM

                            CU50034.MSPEFunction(Rec, '', 0, 'OnAfterModifyEvent');
                        Currpage.Close();

                    end Else
                        exit;
                end;
            }
            action("Review Completed")
            {
                ApplicationArea = All;
                Caption = 'Review Completed';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                Visible = SendforReviewBoolean1;
                trigger OnAction()
                Var
                    StudentMaster_lRec: Record "Student Master-CS";
                begin
                    If Confirm('Do you want to send the application to Completed Status?', True) then begin
                        Rec."Processing Status" := Rec."Processing Status"::Completed;
                        Rec.Modify();
                        CurrPage.Update();
                        CU50034.MSPEFunction(Rec, '', 0, 'OnAfterModifyEvent');
                        CU50034.MSPE_Change_Status(Rec);
                        // StudentMaster_lRec.Reset();
                        // StudentMaster_lRec.SetRange("No.", Rec."Student No");
                        // If StudentMaster_lRec.FindFirst() then
                        //     SendEmail(StudentMaster_lRec, Rec)

                        // SendEmailReviewCompleted("Student No");//GMCSCOM
                        Currpage.Close();

                    end Else
                        exit;
                end;
            }

            action("Send for Completion")
            {
                ApplicationArea = All;
                Caption = 'Send for Completion';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                Visible = ShowRepeatButton;
                trigger OnAction()
                Var
                    StudentMaster_lRec: Record "Student Master-CS";
                begin
                    If Confirm('Do you want to send the application to Completed Status?', True) then begin
                        Rec."Processing Status" := Rec."Processing Status"::Completed;
                        Rec.Modify();
                        CurrPage.Update();
                        CU50034.MSPEFunction(Rec, '', 0, 'OnAfterModifyEvent');
                        CU50034.MSPE_Change_Status(Rec);
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("No.", Rec."Student No");
                        If StudentMaster_lRec.FindFirst() then
                            //MSPERepeatApplicationMail(StudentMaster_lRec, Rec);//GMCSCOM

                            //SendEmailReviewCompleted("Student No");
                            Currpage.Close();

                    end Else
                        exit;
                end;
            }
            action("Student Card")
            {
                Caption = 'Student Card';
                Image = Document;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    StudentMaster_lRec: Record "Student Master-CS";
                    StudentCard_lPag: Page "Student Detail Card-CS";
                begin
                    Clear(StudentCard_lPag);
                    StudentMaster_lRec.Reset();
                    StudentMaster_lRec.SetRange("No.", Rec."Student No");
                    StudentCard_lPag.SetTableView(StudentMaster_lRec);
                    StudentCard_lPag.Editable := False;
                    StudentCard_lPag.RunModal();
                end;
            }
            action("MSPE Application View")
            {
                Caption = 'MSPE Application View';
                Image = Report;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    completedmspeapp: Record MSPE;
                begin
                    completedmspeapp.reset();
                    completedmspeapp.SetRange("Application No", Rec."Application No");
                    if completedmspeapp.FindFirst() then
                        Report.Run(50207, true, false, completedmspeapp);
                end;
            }

            action("Student Document Attachment")
            {
                Caption = 'Student Document Attachment';
                Image = List;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                Visible = ShowDocAtt;
                trigger OnAction()
                var
                    StudentDocAtt: Record "Student Document Attachment";
                begin
                    StudentDocAtt.Reset();
                    StudentDocAtt.FilterGroup(2);
                    StudentDocAtt.SetRange("Student No.", Rec."Student No");
                    // StudentDocAtt.SetRange("Document Category", 'GRADUATE AFFAIRS');
                    StudentDocAtt.FilterGroup(0);
                    Page.RunModal(Page::"Student Document Attachment", StudentDocAtt);
                end;
            }



            action("Send E-Mail")
            {
                Caption = 'Send E-Mail';
                Image = Email;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                var

                begin
                    // SendEmailcomplete;
                end;
            }

            Action("Student Rotation Audit")
            {
                Caption = 'Student Rotation Audit';
                Image = PostApplication;
                ApplicationArea = All;
                RunObject = page "Students Rotation Audit";
                RunPageLink = "Original Student No." = Field("Student No");
            }

            Action("Student Subject Exam")
            {
                Caption = 'Student Subject Exam';
                Image = PostApplication;
                ApplicationArea = All;
                RunObject = page "Student Subject Exam List";
                RunPageLink = "Original Student No." = Field("Student No");
            }

            Action("USMLE Scores")
            {
                Caption = 'USMLE Scores';
                Image = PostApplication;
                ApplicationArea = All;
                RunObject = page "Student Subject Exam List";
                RunPageLink = "Original Student No." = Field("Student No"), "Subject Code" = filter('KAPLAN1' | 'STEPI1' | 'CK1' | 'CK2' | 'CS1' | 'CS2' | 'CS3' | 'KAPLAN2');
            }
        }
    }
    trigger OnOpenPage()
    begin
        StudentMaster.Reset();
        StudentMaster.SetRange("No.", Rec."Student No");
        if StudentMaster.FindFirst() then begin
            Rec."Estimated Graduation Date" := StudentMaster."Estimated Graduation Date";
            Rec.Modify();
        end;

        if Rec."Processing Status" = Rec."Processing Status"::Pending then begin
            Rec."Processing Status" := Rec."Processing Status"::"In-Progress";
            CurrPage.Update();
            CU50034.MSPE_Change_Status(Rec);
            CU50034.MSPEFunction(Rec, '', 0, 'OnAfterModifyEvent');
        end;

        SendforReviewBoolean := false;
        IF Rec."Application Type" = Rec."Application Type"::New then
            If Rec."Processing Status" IN [Rec."Processing Status"::Pending, Rec."Processing Status"::"In-Progress", Rec."Processing Status"::"Review Required"] then
                SendforReviewBoolean := true;


        If Rec."Processing Status" In [Rec."Processing Status"::Completed, Rec."Processing Status"::"In-Review"] then
            CurrPage.Editable := False
        Else
            CurrPage.Editable := True;

        SendforReviewBoolean1 := false;
        IF Rec."Application Type" = Rec."Application Type"::New then
            IF Rec."Processing Status" = Rec."Processing Status"::"Review Required" then
                SendforReviewBoolean1 := true;

        RepeatApplicationShow := False;
        IF Rec."Application Type" = Rec."Application Type"::Repeated then
            RepeatApplicationShow := true;

        ShowNewPageGroup := false;
        ShowRepeatPageGroup := false;

        If Rec."Application Type" = Rec."Application Type"::New then
            ShowNewPageGroup := true;

        If Rec."Application Type" = Rec."Application Type"::Repeated then
            ShowRepeatPageGroup := true;

        ShowDocAtt := false;
        If Rec."Processing Status" In [Rec."Processing Status"::" ", Rec."Processing Status"::Pending, Rec."Processing Status"::"In-Progress", Rec."Processing Status"::Completed] then
            ShowDocAtt := true;

        ShowRepeatButton := false;
        If (Rec."Processing Status" <> Rec."Processing Status"::Completed) then
            ShowRepeatButton := true;
    end;

    trigger OnAfterGetRecord()
    Begin

        SendforReviewBoolean := false;
        IF Rec."Application Type" = Rec."Application Type"::New then
            If Rec."Processing Status" IN [Rec."Processing Status"::Pending, Rec."Processing Status"::"In-Progress"] then
                SendforReviewBoolean := true;

        If Rec."Processing Status" In [Rec."Processing Status"::Completed, Rec."Processing Status"::"In-Review"] then
            CurrPage.Editable := False
        Else
            CurrPage.Editable := True;

        SendforReviewBoolean1 := false;
        IF Rec."Application Type" = Rec."Application Type"::New then
            IF Rec."Processing Status" = Rec."Processing Status"::"Review Required" then
                SendforReviewBoolean1 := true;

        RepeatApplicationShow := False;
        IF Rec."Application Type" = Rec."Application Type"::Repeated then
            RepeatApplicationShow := true;

        PageCaption := '';
        PageCaption := Format(Rec."Processing Status") + ' ' + 'MSPE Application Card';

        CurrPage.Caption := PageCaption;

        ShowNewPageGroup := false;
        ShowRepeatPageGroup := false;

        If Rec."Application Type" = Rec."Application Type"::New then
            ShowNewPageGroup := true;

        If Rec."Application Type" = Rec."Application Type"::Repeated then
            ShowRepeatPageGroup := true;

        ShowDocAtt := false;
        If Rec."Processing Status" In [Rec."Processing Status"::" ", Rec."Processing Status"::Pending, Rec."Processing Status"::"In-Progress", Rec."Processing Status"::Completed] then
            ShowDocAtt := true;

        ShowRepeatButton := false;
        If (Rec."Processing Status" <> Rec."Processing Status"::Completed) then
            ShowRepeatButton := true;
    End;



    var
        StudentMaster: Record "Student Master-CS";
        CU50034: Codeunit WebServicesFunctionsCSL;
        SendforReviewBoolean: Boolean;
        SendforReviewBoolean1: Boolean;
        PageCaption: Text;
        RepeatApplicationShow: Boolean;
        ShowNewPageGroup: Boolean;
        ShowRepeatPageGroup: Boolean;
        ShowDocAtt: Boolean;
        ShowRepeatButton: Boolean;

    // procedure SendEmailcomplete()
    // Var
    //     SMTPSetup_lRec: Record "Email Account";
    //     SMTP_lCU: Codeunit "Email Message";
    //     tempblob: Codeunit "TempBlob Test";
    //     completedmspeapp: record MSPE;
    //     Subject_lTxt: Text;
    //     Body_lTxt: Text;
    //     EmailId_lTxt: Text;
    //     Parameters: Text;
    //     Recipients: List of [Text];
    //     filename: text;
    //     ostream: OutStream;
    //     istream: instream;
    //     recref: RecordRef;
    // begin
    //     SMTPSetup_lRec.Reset();
    //     Clear(Recipients);
    //     EmailId_lTxt := '';
    //     Clear(SMTP_lCU);
    //     completedmspeapp.reset();
    //     completedmspeapp.SetRange("Application No", Rec."Application No");
    //     if completedmspeapp.FindFirst() then
    //         recref.GetTable(completedmspeapp);

    //     TempBlob.CreateOutStream(ostream);
    //     TempBlob.CreateInStream(istream);
    //     report.SaveAs(50207, Parameters, REPORTFORMAT::Pdf, OStream, recref);

    //     SMTPSetup_lRec.Get();
    //     StudentMaster.get(Rec."Student No");
    //     EmailId_lTxt := StudentMaster."E-Mail Address";
    //     Recipients := EmailId_lTxt.Split(';');

    //     Subject_lTxt := '';
    //     Body_lTxt := '';

    //     Subject_lTxt := Rec."Application No" + ': Your MSPE Application is Completed!';

    //     // SMTP_lCU.Create('MEA', SMTPSetup_lRec."User ID", Recipients, Subject_lTxt, '', true);//GMCSCOM
    //     SMTP_lCU.AppendtoBody('Dear ' + StudentMaster."Name as on Certificate");
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('Please find the completed MSPE application attached for your reference.');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('For any further information please contact Graduate Affairs team at jferron@auamed.org or contact at 212-661-8899 x 161.');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('Regards');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('Graduate Affairs Team');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('<HR>');
    //     SMTP_lCU.AppendtoBody('THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL');
    //     //SMTP_lCU.AddAttachmentStream(istream, Rec."Application No" + '.pdf');//GMCSCOM
    //     //SMTP_lCU.Send();
    //     Message('Mail sent Succesfully.');
    // end;
}
