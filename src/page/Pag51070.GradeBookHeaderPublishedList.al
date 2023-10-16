page 51070 GradeBooksPublished
{
    PageType = List;
    Caption = 'Grade Books Published';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = GradeBookHeader;
    SourceTable = "Grade Book Header";
    SourceTableView = where(Status = Filter(Published));
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
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = all;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = all;
                }
                field("Published Time"; Rec."Published Time")
                {
                    ApplicationArea = all;
                }

            }
        }

    }


}