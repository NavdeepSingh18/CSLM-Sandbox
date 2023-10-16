page 50778 "Ferpa Information Header"
{
    Caption = 'Ferpa Information Header';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "FERPA Information Header";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Info Header No"; Rec."Info Header No")
                {
                    ApplicationArea = All;
                }
                field("Student No"; Rec."Student No")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("Share Start Date"; Rec."Share Start Date")
                {
                    ApplicationArea = All;
                }
                field("Share End Date"; Rec."Share End Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Can Amend"; Rec."Can Amend")
                {
                    ApplicationArea = All;
                }
                field("Can Review"; Rec."Can Review")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

}