page 50198 "SFAS Sync Error LogDtl-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    PageType = List;
    SourceTable = "Synch Error Log SFAS-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Error; Rec.Error)
                {
                    ApplicationArea = All;
                }
                field("Error Date"; Rec."Error Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

