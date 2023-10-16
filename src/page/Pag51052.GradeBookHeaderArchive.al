page 51052 GradeBookHeaderArchive
{
    PageType = Card;
    Caption = 'Grade Book Achive';
    UsageCategory = None;
    SourceTable = "Grade Book Header Archive";
    Editable = false;


    layout
    {
        area(Content)
        {
            group(GroupName)

            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = false;
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
            part("Lines"; GradeBookArchiveSubform)
            {
                ApplicationArea = All;
                SubPageLink = "Grade Book No." = FIELD("Document No."), "Header Archive No." = field("Archive No.");
                Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GradeInput)
            {
                ApplicationArea = All;
                Caption = 'Grade Input';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "Grade Input Grade Book List";
                RunPageLink = "Grade Book No." = field("Document No.");
            }

            action(GradeList)
            {
                ApplicationArea = All;
                Caption = 'Grade List';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "Grade List GradeBook";
                RunPageLink = "Grade Book No." = field("Document No.");
            }
        }
    }

}