page 50705 "Housing Issue Fact"
{
    Caption = 'Housing Issue List';
    PageType = List;
    ApplicationArea = all;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = "Housing Issue";
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Code"; Rec."Issue Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Description"; Rec."Issue Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }

                field("Accepted In Days"; Rec."Accepted In Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}