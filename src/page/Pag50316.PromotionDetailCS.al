page 50316 "Promotion Detail-CS"
{
    // version V.001-CS

    Caption = 'Promotion Detail';
    Editable = false;
    PageType = Card;
    SourceTable = "Promotion Details-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            //repeater(Group)
            Group(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Promoted Academic Year"; Rec."Promoted Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Promoted Course"; Rec."Promoted Course")
                {
                    ApplicationArea = All;
                }
                field("Promoted Semester"; Rec."Promoted Semester")
                {
                    ApplicationArea = All;
                }
                field("Promoted Section"; Rec."Promoted Section")
                {
                    ApplicationArea = All;
                }
                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

