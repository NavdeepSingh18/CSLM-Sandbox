page 50321 "Approval List Stu. (CBCS )-CS"
{
    // version V.001-CS

    Caption = 'Student CBCS Appro. List - Col';
    CardPageID = "Student App. Hdr(CBCS) -CS";
    Editable = false;
    PageType = List;
    SourceTable = "CBCS Student Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Stude&nt CBCS Approval")
            {
                Caption = 'Stude&nt CBCS Approval';
                /* action("C&ard")
                 {
                     Caption = 'C&ard';
                     Image = EditLines;
                     RunPageOnRec = true;
                     ShortCutKey = 'Shift+F7';
                     ApplicationArea = All;
                 }*/
            }
        }
    }
}