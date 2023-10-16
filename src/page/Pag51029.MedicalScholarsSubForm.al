page 51029 "Medical Scholars SubForm"
{
    //  ApplicationArea = All;
    //  UsageCategory = Administration;
    SourceTable = "Medical Scholars Line";
    Caption = 'Lines';
    //  DelayedInsert = true;
    LinksAllowed = false;
    //   MultipleNewLines = true;
    ApplicationArea = ALl;
    UsageCategory = Administration;
    PageType = ListPart;
    AutoSplitKey = true;


    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                // field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Course Code"; Rec."Course Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Semster No."; Rec."Semster No")
                // {
                //     ApplicationArea = All;
                // }
                // field(Subject; Rec.Subject)
                // {
                //     ApplicationArea = All;
                // }
                field("Subject Name"; Rec."Subect Name ")
                {
                    Caption = ' ';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Position; Rec.Position)
                {
                    Caption = ' ';
                    ToolTip = 'Specifies the value of the Position field.';
                    ApplicationArea = All;
                }
                // field("Role Applied"; Rec."Role Applied")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}