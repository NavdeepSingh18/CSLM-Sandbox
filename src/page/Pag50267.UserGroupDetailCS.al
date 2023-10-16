page 50267 "User Group Detail-CS"
{
    // version V.001-CS
    Caption = 'User Group Detail-CS';
    PageType = List;
    SourceTable = "User Group-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User Group"; Rec."User Group")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Windows Login"; Rec."Windows Login")
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
                field("Faculty Role"; Rec."Faculty Role")
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

