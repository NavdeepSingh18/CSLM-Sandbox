page 50178 "Roles-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Institute Role-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Role Code"; Rec."Role Code")
                {
                    ApplicationArea = All;
                }
                field("Role Name"; Rec."Role Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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

    actions
    {
    }
}

