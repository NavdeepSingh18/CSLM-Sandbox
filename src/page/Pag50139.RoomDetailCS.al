page 50139 "Room Detail-CS"
{
    // version V.001-CS

    CardPageID = "Room Master Card-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Rooms-CS";
    Caption = 'Room Detail';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field("Display Room No."; Rec."Display Room No.")
                {
                    ApplicationArea = All;
                }
                field("Room Description"; Rec."Room Description")
                {
                    ApplicationArea = All;
                }
                field("Room Type"; Rec."Room Type")
                {
                    ApplicationArea = All;
                }
                field("Floor No."; Rec."Floor No.")
                {
                    ApplicationArea = All;
                }
                field("Building Number"; Rec."Building Number")
                {
                    ApplicationArea = All;
                }
                field("Building Name"; Rec."Building Name")
                {
                    ApplicationArea = All;
                }
                field("Class Capacity"; Rec."Class Capacity")
                {
                    ApplicationArea = All;
                }
                field("Exam Capacity"; Rec."Exam Capacity")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Academic Block"; Rec."Academic Block")
                {
                    ApplicationArea = All;
                }
                field("Examination Department Code"; Rec."Examination Department Code")
                {
                    ApplicationArea = All;
                }
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ApplicationArea = All;
                }
                field("Allot For Examination"; Rec."Allot For Examination")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

