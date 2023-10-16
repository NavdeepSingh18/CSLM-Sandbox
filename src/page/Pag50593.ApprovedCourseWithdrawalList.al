page 50593 "Approved Course Withdrawal"
{
    // version V.001-CS

    Caption = 'Approved Course Withdrawal List';
    CardPageID = "Approved Withdrawal Card";
    PageType = List;
    UsageCategory = Administration;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = False;
    ApplicationArea = All;
    SourceTable = "Withdrawal Student-CS";
    SourceTableView = WHERE("Withdrawal Status" = FILTER(Approved | Rejected), "Type of Withdrawal" = filter("Course-Withdrawal"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal date"; Rec."Withdrawal date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                }
                field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = All;
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = All;
                }
                field("Last Date Of Attendance"; Rec."Last Date Of Attendance")
                {
                    ApplicationArea = All;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Status"; Rec."Withdrawal Status")
                {
                    ApplicationArea = All;
                }
                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

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
                RunPageLink = "No." = FIELD("Student No.");
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

