Page 50785 "Student Honors"
{
    Caption = 'Student Honors';
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Student Honors";
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
                field("Honors Code"; Rec."Honors Code")
                {
                    ApplicationArea = All;
                }
                field("Honors Name"; Rec."Honors Name")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Min. Range"; Rec."Min. Range")
                {
                    ApplicationArea = All;
                }
                field("Max. Range"; Rec."Max. Range")
                {
                    ApplicationArea = All;
                }
                // field("Global Dimension 2 Code";Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }
                field(DateAwarded; Rec.DateAwarded)
                {
                    ApplicationArea = All;
                }
                field(DateCleared; Rec.DateCleared)
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

            }
        }
    }
}