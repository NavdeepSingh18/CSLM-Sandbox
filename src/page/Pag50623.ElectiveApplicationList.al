page 50623 "Elective Application List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Elective Application";
    CardPageId = "Elective Application Card";
    Editable = False;
    SourceTableView = where(Status = Filter(Open), "Application Type" = filter("Elective Application"));
    Caption = 'Elective Application List';
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
                // field("Subject 2"; Rec."Subject 2")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Subject 2';
                // }
                // field("Subject Description 2"; Rec."Subject Description 2")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Subject Description 2';
                // }
                // field("Subject 3"; Rec."Subject 3")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Subject 3';
                // }
                // field("Subject Description 3"; Rec."Subject Description 3")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Subject Description 3';
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}