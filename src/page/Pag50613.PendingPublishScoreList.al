page 50613 PendingPublishScoreList
{

    PageType = List;
    SourceTable = "Publish Scores";
    Caption = 'Publish Score List';
    SourceTableView = sorting("Document No.")
                      order(descending) where(Status = filter(Pending));
    CardPageId = "Publish Score Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Score Type"; Rec."Score Type")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
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
            action("Student List")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student List';
                Runobject = page "Student Details-CS";
                //   RunPageLink = "Original Student No." = FIELD(ID);
            }
        }
    }
}
