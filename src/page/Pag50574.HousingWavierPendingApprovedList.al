page 50574 "Housing Wavier PendingApproval"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Opt Out";
    Editable = false;
    insertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Housing Waiver Pending Approval';
    SourceTableView = Where(Status = filter("Pending for Approval"), "Application Type" = filter("Housing Wavier"));
    CardPageId = "Pending Housing Wavier Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Caption = 'Application Date';
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    Caption = 'Application Type';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Caption = 'Student Name';
                }
                field("Present Address1"; Rec."Present Address1")
                {
                    ApplicationArea = All;

                }
                field("Present Address2"; Rec."Present Address2")
                {
                    ApplicationArea = All;

                }
                field("Present Address3"; Rec."Present Address3")
                {
                    ApplicationArea = All;

                }
                field("Lease Agreement/Contract No."; Rec."Lease Agreement/Contract No.")
                {
                    ApplicationArea = All;

                }
                field("Lease Agreement Group"; Rec."Lease Agreement Group")
                {
                    ApplicationArea = All;

                }
                field(Transportation; Rec.Transportation)
                {
                    ApplicationArea = All;

                }
                field("Transport Cell"; Rec."Transport Cell")
                {
                    ApplicationArea = All;

                }

                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Semester';
                }

                field("Subject 1"; Rec."Subject 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 1';
                }
                field("Subject Description 1"; Rec."Subject Description 1")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 1';
                }
                field("Subject 2"; Rec."Subject 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 2';
                }
                field("Subject Description 2"; Rec."Subject Description 2")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 2';
                }
                field("Subject 3"; Rec."Subject 3")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 3';

                }
                field("Subject Description 3"; Rec."Subject Description 3")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 3';
                }
                field("Subject 4"; Rec."Subject 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 4';
                }
                field("Subject Description 4"; Rec."Subject Description 4")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 4';
                }
                field("Subject 5"; Rec."Subject 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject 5';
                }
                field("Subject Description 5"; Rec."Subject Description 5")
                {
                    ApplicationArea = All;
                    Caption = 'Subject Description 5';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Approved Condition Failed"; Rec."Approved Condition Failed")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Condition Failed';
                }

            }
        }
    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -

}