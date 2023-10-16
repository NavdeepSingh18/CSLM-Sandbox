page 50776 "Student Ethnicity List"
{
    Caption = 'Student Ethnicity List';
    PageType = List;
    SourceTable = "Student Ethnicity";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Ethnicity Code"; Rec."Ethnicity Code")
                {
                    ApplicationArea = All;
                }
                field("Ethnicity Name"; Rec."Ethnicity Name")
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}


