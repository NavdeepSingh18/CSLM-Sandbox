page 50249 "Stud. Course Eval Detail-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Stud. Course Eval Detail';
    Editable = true;
    PageType = List;
    SourceTable = "Course wise Evaluation-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Method Code"; Rec."Evaluation Method Code")
                {
                    ApplicationArea = All;
                }
                field("Maximum Mark"; Rec."Maximum Mark")
                {
                    ApplicationArea = All;
                }
                field("Pass Mark"; Rec."Pass Mark")
                {
                    ApplicationArea = All;
                }
                field(Compulsory; Rec.Compulsory)
                {
                    ApplicationArea = All;
                }
                field("Int Evaluation Date"; Rec."Int Evaluation Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

