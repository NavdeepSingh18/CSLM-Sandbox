page 50694 "Immigration Header"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Immigration Header";
    Caption = 'Immigration Card';
    DataCaptionFields = "Document No.", "Student Name";
    DeleteAllowed = false;
    SourceTableView = sorting("Document No.") where("Document Status" = filter(" " | "Pending for Verification"));

    layout
    {
        area(content)
        {
            field(""; ImmigrationHold)
            {
                Caption = ' ';
                ApplicationArea = all;
                Style = Attention;
                Editable = false;
            }
            group(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.';
                    Importance = Standard;

                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Enrollment No"; Rec."Enrollment No")
                {
                    ApplicationArea = All;
                }
                field("AUA Email ID"; Rec."AUA Email ID")
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
                }
                field(Addressee; Rec.Addressee)
                {
                    Caption = 'Permanent Address1';
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field(Address1; Rec.Address1)
                {
                    Caption = 'Permanent Address2';
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field(Address2; Rec.Address2)
                {
                    Caption = 'Permanent Address3';
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }

                field("Immigration Application Date"; Rec."Immigration Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rejection Remark"; Rec."Rejection Remark")
                {
                    ApplicationArea = All;
                    MultiLine = True;
                }
                field("Document Status"; Rec."Document Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
            }
            group("Passport Details")
            {
                field("Pass Port No. 1"; Rec."Pass Port No. 1")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued Date 1"; Rec."Pass Port Issued Date 1")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued By 1"; Rec."Pass Port Issued By 1")
                {
                    ApplicationArea = all;

                }
                field("Pass Port Expiry Date 1"; Rec."Pass Port Expiry Date 1")
                {
                    ApplicationArea = all;
                }
                field("Pass Port No. 2"; Rec."Pass Port No. 2")
                {
                    ApplicationArea = all;

                }
                field("Pass Port Issued Date 2"; Rec."Pass Port Issued Date 2")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued By 2"; Rec."Pass Port Issued By 2")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Expiry Date 2"; Rec."Pass Port Expiry Date 2")
                {
                    ApplicationArea = all;
                }
                field("Pass Port No. 3"; Rec."Pass Port No. 3")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued Date 3"; Rec."Pass Port Issued Date 3")
                {
                    ApplicationArea = all;
                }
                field("Pass Port Issued By 3"; Rec."Pass Port Issued By 3")
                {
                    ApplicationArea = all;

                }
                field("Pass Port Expiry Date 3"; Rec."Pass Port Expiry Date 3")
                {
                    ApplicationArea = all;
                }
            }

            group("Visa Details")
            {
                field("Visa No."; Rec."Visa No.")
                {

                    ApplicationArea = all;
                }
                field("Visa Issued Date"; Rec."Visa Issued Date")
                {
                    ApplicationArea = all;

                }
                field("Visa Extension Date"; Rec."Visa Extension Date")
                {
                    ApplicationArea = all;
                }
                field("Visa Expiry Date"; Rec."Visa Expiry Date")
                {
                    ApplicationArea = all;
                }
                Field("Immigration Issuance Date"; Rec."Immigration Issuance Date")
                {
                    ApplicationArea = All;
                }
            }
            part(ImmigrationSubPage; "Immigration SubPage")
            {
                SubPageLink = "SLcM Document No" = FIELD("Document No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No");
            }
            action("&Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentDocAttachment: Record "Student Document Attachment";
                    RecStudentWiseHold: Record "Student Wise Holds";
                    StudentMaster: Record "Student Master-CS";
                    StudentHoldRec: Record "Student Hold";
                    RecCodeUnit50037: Codeunit "Hosusing Mail";
                begin
                    IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                        StudentDocAttachment.Reset();
                        StudentDocAttachment.SetRange("SLcM Document No", Rec."Document No.");
                        If NOT StudentDocAttachment.FindFirst() Then
                            Error('Please attach at least one Document.');

                        StudentDocAttachment.Reset();
                        StudentDocAttachment.SetRange("SLcM Document No", Rec."Document No.");
                        StudentDocAttachment.SetFilter("Document Status", '<>%1', StudentDocAttachment."Document Status"::Verified);
                        If StudentDocAttachment.FindFirst() Then begin
                            Error('All Uploaded Document Not Verified');
                        end Else begin
                            Rec.TestField("Document Status", Rec."Document Status"::"Pending for Verification");
                            Rec."Document Status" := Rec."Document Status"::Verified;
                            Rec."Approved/Rejected By" := UserId();
                            Rec."Approved/Rejected On" := Today();
                            Rec.Modify();

                            StudentMaster.Reset();
                            StudentMaster.SetRange("No.", Rec."Student No");
                            IF StudentMaster.FindFirst() then begin
                                IF Rec."First Name" <> '' then
                                    StudentMaster."First Name" := Rec."First Name";
                                IF Rec."Last Name" <> '' then
                                    StudentMaster."Last Name" := Rec."Last Name";
                                IF Rec."Country Code" <> '' then
                                    StudentMaster."Country Code" := Rec."Country Code";
                                IF Rec."Post Code" <> '' then
                                    StudentMaster."Post Code" := Rec."Post Code";
                                IF Rec.Addressee <> '' then
                                    StudentMaster.Addressee := Rec.Addressee;
                                IF Rec.Address1 <> '' then
                                    StudentMaster.Address1 := Rec.Address1;
                                IF Rec.Address2 <> '' then
                                    StudentMaster.Address2 := Rec.Address2;
                                IF Rec."Visa No." <> '' then
                                    StudentMaster."Visa No." := Rec."Visa No.";
                                IF Rec."Visa Issued Date" <> 0D then
                                    StudentMaster."Visa Issued Date" := Rec."Visa Issued Date";
                                IF Rec."Visa Expiry Date" <> 0D then
                                    StudentMaster."Visa Expiry Date" := Rec."Visa Expiry Date";
                                IF Rec."Visa Extension Date" <> 0D then
                                    StudentMaster."Visa Extension Date" := Rec."Visa Extension Date";
                                IF Rec."Pass Port No. 1" <> '' then
                                    StudentMaster."Pass Port No." := Rec."Pass Port No. 1";
                                IF Rec."Pass Port Issued By 1" <> '' then
                                    StudentMaster."Pass Port Issued By" := Rec."Pass Port Issued By 1";
                                IF Rec."Pass Port Issued Date 1" <> 0D then
                                    StudentMaster."Pass Port Issued Date" := Rec."Pass Port Issued Date 1";
                                IF Rec."Pass Port Expiry Date 1" <> 0D then
                                    StudentMaster."Pass Port Expiry Date" := Rec."Pass Port Expiry Date 1";
                                IF Rec."Visa Extension Date" <> 0D then
                                    StudentMaster."Immigration Expiration Date" := Rec."Visa Extension Date";
                                IF Rec."Immigration Issuance Date" <> 0D then
                                    StudentMaster."Immigration Issuance Date" := Rec."Immigration Issuance Date";
                                StudentMaster.Modify();
                            end;

                            StudentHoldRec.Reset();
                            StudentHoldRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Immigration);
                            StudentHoldRec.FindFirst();

                            RecStudentWiseHold.Reset();
                            RecStudentWiseHold.SetRange("Student No.", Rec."Student No");
                            // RecStudentWiseHold.SetRange("Academic Year", "Academic Year");
                            // RecStudentWiseHold.SetRange(Semester, Semester);
                            RecStudentWiseHold.SetRange("Hold Type", RecStudentWiseHold."Hold Type"::"Immigration");
                            IF RecStudentWiseHold.FindFirst() then begin
                                RecStudentWiseHold.Status := RecStudentWiseHold.Status::Disable;
                                RecStudentWiseHold."Hold Description" := StudentHoldRec."Signoff Description";
                                IF RecStudentWiseHold.Modify() then begin
                                    RecCodeUnit50037.HoldStatusLedgerEntryInsert(Rec."Student No", RecStudentWiseHold."Hold Code",
                         RecStudentWiseHold."Hold Description", RecStudentWiseHold."Hold Type"::Immigration, RecStudentWiseHold.Status::Disable);
                                end;
                            end;
                            //MailSendforImmigrationDocumentApproved("Student No");//GMCSCOM
                        end;
                        CurrPage.Update();
                    End;
                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentDocAttachment_lRec: Record "Student Document Attachment";
                begin
                    IF CONFIRM(Text002Lbl, FALSE) THEN BEGIN
                        Rec.TestField("Document Status", Rec."Document Status"::"Pending for Verification");
                        Rec.TestField("Rejection Remark");
                        Rec."Document Status" := Rec."Document Status"::Rejected;
                        Rec."Approved/Rejected By" := UserId();
                        Rec."Approved/Rejected On" := Today();
                        Rec.Modify();
                        StudentDocAttachment_lRec.Reset();
                        StudentDocAttachment_lRec.SetRange("SLcM Document No", Rec."Document No.");
                        IF StudentDocAttachment_lRec.FindSet() then begin
                            repeat
                                StudentDocAttachment_lRec."Document Status" := StudentDocAttachment_lRec."Document Status"::Rejected;
                                StudentDocAttachment_lRec.Modify();
                            until StudentDocAttachment_lRec.Next() = 0;
                        end;
                        //MailSendforImmigrationApplicationRejected("Student No");//GMCSCOM
                    End;
                    CurrPage.Update();
                end;
            }
            action("&Hold")
            {
                ApplicationArea = All;
                Caption = 'Hold';
                Image = Action;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    StudentWiseHold: Record "Student Wise Holds";
                    StudentWiseHold1: Record "Student Wise Holds";
                    StudentHold: Record "Student Hold";
                    RecCodeUnit50037: Codeunit "Hosusing Mail";
                begin
                    IF CONFIRM(Text003Lbl, FALSE, Rec."Student No") THEN BEGIN
                        StudentWiseHold.Reset();
                        StudentWiseHold.SetRange("Student No.", Rec."Student No");
                        StudentWiseHold.SetRange("Hold Type", StudentWiseHold."Hold Type"::"Immigration");
                        If Not StudentWiseHold.FindFirst() then begin
                            StudentHold.Reset();
                            StudentHold.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                            StudentHold.SetRange("Hold Type", StudentHold."Hold Type"::"Immigration");
                            If StudentHold.FindFirst() then begin
                                StudentWiseHold1.Init();
                                StudentWiseHold1.Validate("Student No.", Rec."Student No");
                                StudentWiseHold1.Validate("Hold Code", StudentHold."Hold Code");
                                StudentWiseHold1.Validate(Status, StudentWiseHold1.Status::Enable);
                                If StudentWiseHold1.Insert() then begin
                                    ImmigrationHold := 'Immigration Hold';
                                    Rec.Modify();
                                    CurrPage.Update();
                                    RecCodeUnit50037.HoldStatusLedgerEntryInsert(Rec."Student No", StudentWiseHold1."Hold Code",
                         StudentWiseHold1."Hold Description", StudentWiseHold1."Hold Type"::Immigration, StudentWiseHold1.Status::Enable);
                                    //MailSendforImmigrationHold("Student No");//GMCSCOM
                                end;
                            end;
                        end Else begin
                            StudentWiseHold.Status := StudentWiseHold.Status::Enable;
                            IF StudentWiseHold.Modify() then begin
                                ImmigrationHold := 'Immigration Hold';
                                Rec.Modify();
                                RecCodeUnit50037.HoldStatusLedgerEntryInsert(Rec."Student No", StudentWiseHold1."Hold Code",
                         StudentWiseHold1."Hold Description", StudentWiseHold1."Hold Type"::Immigration, StudentWiseHold1.Status::Enable);
                                CurrPage.Update();
                                //MailSendforImmigrationHold("Student No");//GMCSCOM
                            end;
                        end;
                    end;
                End;
            }
            action("&Student Notes")//GAURAV//21.1222//
            {
                ApplicationArea = All;
                Caption = 'Student Notes';
                Image = Notes;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ClinicalBaseAppSubscribe: Codeunit "Clinical Base App. Subscribe";
                    TemplateType: Option " ",Residency,"Clinical Clerkship",Student,Other;
                    GroupType: Option " ","Residency Note","Residency Employement Note","Clinical Clerkship",Student,Other;
                begin
                    Rec.TestField("Student No");
                    TemplateType := TemplateType::Student;
                    GroupType := GroupType::Student;
                    ClinicalBaseAppSubscribe.ViewEditStudentNote(Rec."Student No", Rec."Student No", TemplateType, GroupType);
                end;
            }
            action("Email Notification")//GAURAV//21.1222//
            {
                ApplicationArea = All;
                Caption = 'Email Notification';
                Image = Email;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Trigger OnAction()
                var
                    EmailnotificationRec: Record "Email Notification";
                    EmailNotificationPage: Page "E-Mail Notification List";
                Begin
                    Clear(EmailNotificationPage);
                    EmailnotificationRec.Reset();
                    EmailnotificationRec.Setfilter(ReceiverId, Rec."Student No" + '*');
                    EmailNotificationPage.SetTableView(EmailnotificationRec);
                    EmailNotificationPage.Run();
                End;
            }
        }
    }
    trigger OnOpenPage()
    begin
        FieldEditable := true;
        IF Rec.ImmigrationHoldCheck(Rec."Student No") = true then begin
            ImmigrationHold := 'Immigration Hold';
            FieldEditable := false
        end else
            ImmigrationHold := '';

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Status" := Rec."Document Status"::"Pending for Verification";
        Rec."Immigration Application Date" := WorkDate();
        FieldEditable := true;
    end;

    var
        ImmigrationHold: code[20];
        FieldEditable: Boolean;
        Text001Lbl: Label 'Do you want to approve Immigration Application?';
        Text002Lbl: Label 'Do you want to reject Immigration Application?';
        Text003Lbl: Label 'Do you want to apply Immigration Hold for Student No. %1?';
}

