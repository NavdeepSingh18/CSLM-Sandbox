page 50714 "Immigration Approved Card"
{
    PageType = Card;
    Caption = 'Immigration Approved/Rejected Card';
    UsageCategory = None;
    SourceTable = "Immigration Header";
    DataCaptionFields = "Document No.", "Student Name";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = False;
    SourceTableView = sorting("Document No.") where("Document Status" = filter(Verified | Rejected));

    layout
    {
        area(content)
        {
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
                Field("AUA Email ID"; Rec."AUA Email ID")
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
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
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

}

