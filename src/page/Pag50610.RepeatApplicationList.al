page 50610 "Repeat Application List"
{

    ApplicationArea = All;
    Caption = 'Repeat Application';
    PageType = List;
    CardPageId = "Repeat Application Card";
    SourceTable = "Opt Out";
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Open), "Application Type" = filter("Repeat"));

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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
