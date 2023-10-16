Page 50591 "Withdrawal Department List"
{

    PageType = List;
    SourceTable = "Withdrawal Department";
    Caption = 'Withdrawal Department List';
    ApplicationArea = All;
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }
                field("User E-Mail"; Rec."User E-Mail")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = false;
                }
                field("CC E-Mail"; Rec."CC E-Mail")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("User Phone No."; Rec."User Phone No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Final Approval"; Rec."Final Approval")
                {
                    ApplicationArea = All;
                }
                field("Waiver Calculation Allowed"; Rec."Waiver Calculation Allowed")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Update DOD"; Rec."Update DOD")
                {
                    ToolTip = 'Specifies the value of the Update DOD field.';
                    ApplicationArea = All;
                }
                field("Update LDA"; Rec."Update LDA")
                {
                    ToolTip = 'Specifies the value of the Update LDA field.';
                    ApplicationArea = All;
                }
                field("Update NSLDS"; Rec."Update NSLDS")
                {
                    ToolTip = 'Specifies the value of the Update NSLDS field.';
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                    Caption = 'Sequence';
                }
                field("Reject Permission"; Rec."Reject Permission")
                {
                    ApplicationArea = All;
                    Enabled = Rec."Document Type" = Rec."Document Type"::ELOA;
                }

            }
        }
    }

}
