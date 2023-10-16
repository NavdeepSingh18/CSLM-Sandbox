page 51046 GradeBooks
{
    PageType = List;
    Caption = 'Grade Books';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = GradeBookHeader;
    SourceTable = "Grade Book Header";
    SourceTableView = where(Status = Filter(Open | Rejected));
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                // Field(Course; Course)
                // {
                //     ApplicationArea = All;
                //     Visible = "Global Dimension 1 Code" = '9100';
                // }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Grade Book")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction();
                var
                    ImportGradeBook: xmlport "Grade Book Header ";
                begin
                    Clear(ImportGradeBook);
                    ImportGradeBook.Run();

                end;
            }
        }
    }
}