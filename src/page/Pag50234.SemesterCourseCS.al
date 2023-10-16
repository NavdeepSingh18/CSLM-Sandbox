page 50234 "Semester Course-CS"
{
    // version V.001-CS

    Caption = 'Semester Course';
    PageType = List;
    SourceTable = "Course Sem. Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    DelayedInsert = true;
    layout
    {
        area(content)
        {
            repeater(group)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Sequence No"; Rec."Sequence No")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("Fee Due Date"; Rec."Fee Due Date")
                {
                    ApplicationArea = all;
                }
                field("Dismissal Percentage"; Rec."Dismissal Percentage")
                {
                    ApplicationArea = all;
                }
                field("New OLR Start Date"; Rec."New OLR Start Date")
                {
                    ApplicationArea = all;
                }
                field("New OLR End Date"; Rec."New OLR End Date")
                {
                    ApplicationArea = all;
                }
                field("Returning OLR Start Date"; Rec."Returning OLR Start Date")
                {
                    ApplicationArea = all;
                }
                field("Returning OLR End Date"; Rec."Returning OLR End Date")
                {
                    ApplicationArea = all;
                }
                field("Start Date Not Applicable"; Rec."Start Date Not Applicable")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field("Final Years Course"; Rec."Final Years Course")
                {
                    ApplicationArea = All;
                }
                field("MSPE Application"; Rec."MSPE Application")
                {
                    ApplicationArea = All;
                }
                field("Elective Offering"; Rec."Elective Offering")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

