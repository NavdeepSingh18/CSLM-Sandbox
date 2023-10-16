page 50151 "Appl Prequal Marks Detail-CS"
{
    // version V.001-CS

    Caption = 'Appl Prequal Marks List - COL';
    DelayedInsert = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Appl Prequalification-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Caption = 'Stream';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Year of passing"; Rec."Year of passing")
                {
                    ApplicationArea = All;
                }
                field("School/ College Name"; Rec."School/ College Name")
                {
                    ApplicationArea = All;
                }
                field("Name of Board/Univ."; Rec."Name of Board/Univ.")
                {
                    ApplicationArea = All;
                }
                field(Maximum; Rec.Maximum)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mark Obtained"; Rec."Mark Obtained")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Percentage of Mark"; Rec."Percentage of Mark")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Overall Percentage"; Rec."Overall Percentage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    var
    //Application: Record "Student Task-CS";
}

