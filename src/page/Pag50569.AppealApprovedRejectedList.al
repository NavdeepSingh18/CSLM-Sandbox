page 50569 "Appeal Approved/Rejected List"
{
    ApplicationArea = All;
    Caption = 'Appeal Approved/Rejected List';
    CardPageId = "Appeal Pending Card";
    PageType = List;
    SourceTable = "Opt Out";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = Where(Status = filter(Rejected), Status = filter(Approved), "Application Type" = filter(Appeal));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Percentage Obtained"; Rec."Percentage Obtained")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
