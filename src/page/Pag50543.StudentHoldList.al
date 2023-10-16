page 50543 "Student Hold List"
{

    PageType = List;
    SourceTable = "Student Hold";
    Caption = 'Student Hold List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Hold Code"; Rec."Hold Code")
                {
                    ApplicationArea = All;
                }
                field("Hold Description"; Rec."Hold Description")
                {
                    ApplicationArea = All;
                }
                field("Signoff Description"; Rec."Signoff Description")
                {
                    ApplicationArea = All;
                }
                field("Hold Type"; Rec."Hold Type")
                {
                    ApplicationArea = All;
                }
                field("Sign-off"; Rec."Sign-off")
                {
                    ApplicationArea = All;
                }
                field("Potal Login Restriction"; Rec."Potal Login Restriction")
                {
                    ApplicationArea = All;
                }
                field("Transcript Print"; Rec."Transcript Print")
                {
                    ApplicationArea = All;
                }
                field(Progression; Rec.Progression)
                {
                    ApplicationArea = All;
                }
                field(Billing; Rec.Billing)
                {
                    ApplicationArea = All;
                }
                field("Clinical Rotation"; Rec."Clinical Rotation")
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
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
