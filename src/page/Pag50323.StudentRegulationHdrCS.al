page 50323 "Student Regulation Hdr-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    Caption = 'Student Regulation Hdr';
    PageType = Card;
    SourceTable = "Student Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = ALl;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = ALl;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = ALl;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = ALl;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = ALl;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = ALl;
                }
            }
            part("Student Discipline Subform"; 50359)
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("No.");
            }
        }
    }

    actions
    {
    }
}

