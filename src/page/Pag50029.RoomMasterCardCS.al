page 50029 "Room Master Card-CS"
{
    // version V.001-CS

    PageType = Card;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Rooms-CS";
    Caption = 'Room Master Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                }
                field("Display Room No."; Rec."Display Room No.")
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
                field("Building Name"; Rec."Building Name")
                {
                    ApplicationArea = All;
                }
                field("Class Capacity"; Rec."Class Capacity")
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
                field("Examination Department Code"; Rec."Examination Department Code")
                {
                    ApplicationArea = All;
                }
                field("Allot For Examination"; Rec."Allot For Examination")
                {
                    ApplicationArea = All;
                }
                field("Exam Capacity"; Rec."Exam Capacity")
                {
                    ApplicationArea = All;
                }
                field("Building Number"; Rec."Building Number")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
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
                field("Exam Date"; Rec."Exam Date")
                {
                    ApplicationArea = All;
                }
                field("Exam Slot"; Rec."Exam Slot")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}