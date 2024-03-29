page 50540 "Exam Opt Out List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Opt Out";
    CardPageId = "Exam Opt Out Card";
    Editable = False;
    SourceTableView = where(Status = Filter(Open), "Application Type" = filter("Bsic Opt Out"));
    Caption = 'Exam Opt Out List';
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
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
        }

    }
}