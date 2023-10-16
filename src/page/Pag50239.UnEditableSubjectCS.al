page 50239 "Un Editable Subject-CS"
{
    // version V.001-CS
    Caption = 'Un Editable Subject';
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Subject Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Classification"; Rec."Subject Classification")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field("Min. Capacity"; Rec."Min. Capacity")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Internal Maximum"; Rec."Internal Maximum")
                {
                    ApplicationArea = All;
                }
                field("External Pass"; Rec."External Pass")
                {
                    ApplicationArea = All;
                }
                field("External Maximum"; Rec."External Maximum")
                {
                    ApplicationArea = All;
                }
                field("Total Pass"; Rec."Total Pass")
                {
                    ApplicationArea = All;
                }
                field("Total Maximum"; Rec."Total Maximum")
                {
                    ApplicationArea = All;
                }
                field("Exam Fee"; Rec."Exam Fee")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Internal Subject Code"; Rec."Internal Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Max. Capacity UG"; Rec."Max. Capacity UG")
                {
                    ApplicationArea = All;
                }
                field("Max. Capacity PG"; Rec."Max. Capacity PG")
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Elective Group Code"; Rec."Elective Group Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Closed"; Rec."Subject Closed")
                {
                    ApplicationArea = All;
                }
                field("Audit Subject"; Rec."Audit Subject")
                {
                    ApplicationArea = All;
                }
                field("Program/Open Elective Temp"; Rec."Program/Open Elective Temp")
                {
                    ApplicationArea = All;
                }
                field("Assign max marks"; Rec."Assign max marks")
                {
                    ApplicationArea = All;
                }
                field("Assigment Calculation"; Rec."Assigment Calculation")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field("Internal Pass"; Rec."Internal Pass")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

