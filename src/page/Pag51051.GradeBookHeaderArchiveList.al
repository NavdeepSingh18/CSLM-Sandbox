page 51051 GradeBooksArchive
{
    PageType = List;
    Caption = 'Grade Book Archives';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = GradeBookHeaderArchive;
    SourceTable = "Grade Book Header Archive";
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
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
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
                field("Archive No."; Rec."Archive No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Archived On"; Rec."Archived On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Archived Time"; Rec."Archived Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
        area(Factboxes)
        {

        }
    }


}