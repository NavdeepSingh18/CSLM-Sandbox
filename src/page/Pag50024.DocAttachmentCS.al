page 50024 "Doc. Attachment-CS"
{
    // version V.001-CS

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "File Attachment-CS";
    Caption = 'Document Category';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("User Group"; Rec."User Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Type Category No. SchoolDocs"; Rec."Type Category No. SchoolDocs")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Document No. Required"; Rec."Document No. Required")
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
                field("Check Duplicate Entries"; Rec."Check Duplicate Entries")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Document Sub Category")
            {
                ApplicationArea = All;
                Caption = 'Document Sub Category';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = ListPage;
                RunObject = page "Cat Attachment & Doc-CS";
                RunPageLink = "Document Type" = field("Code");
            }
        }
    }

}

