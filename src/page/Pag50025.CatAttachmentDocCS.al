page 50025 "Cat Attachment & Doc-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Doc & Cate Attachment-CS";
    Caption = 'Document Sub Category';
    DelayedInsert = True;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }

                field("Department View"; Rec."Department View")
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Document No. Required"; Rec."Document No. Required")
                {
                    ApplicationArea = All;
                }
                field("Portal Menu ID"; Rec."Portal Menu ID")
                {
                    ApplicationArea = All;
                }
                field(Mandatory; Rec.Mandatory)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Expiry Not Applicable"; Rec."Expiry Not Applicable")
                {
                    ApplicationArea = All;
                }
                field("Validity Days"; Rec."Validity Days")
                {
                    ApplicationArea = All;
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                }
                field("Sorting No."; Rec."Sorting No.")
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
                    Visible = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Show on Portal"; Rec."Show on Portal")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

