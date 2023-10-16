page 51055 GradeBooksApproved
{
    PageType = List;
    Caption = 'Grade Books Approved';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = GradeBookHeader;
    SourceTable = "Grade Book Header";
    SourceTableView = where(Status = Filter(Approved));
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}