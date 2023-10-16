page 50184 "Grade List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id       Date       Trigger              Remarks
    // ------------------------------------------------------------------------------------------------------------
    // 01.    CSPL-00174   04-03-19   Grade - OnAction()   Code added for update grade  .

    Caption = 'Passing Grade';
    PageType = List;
    // InsertAllowed = false;
    // DeleteAllowed = false;
    // ModifyAllowed = false;
    // Editable = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Grade Master-CS";

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
                field(Failed; Rec.Failed)
                {
                    ApplicationArea = all;
                }
                field(Points; Rec.Points)
                {
                    ApplicationArea = All;
                }
                field("Min Percentage"; Rec."Min Percentage")
                {
                    ToolTip = 'Min Percentage';
                    ApplicationArea = All;
                }
                field("Max Percentage"; Rec."Max Percentage")
                {
                    ApplicationArea = All;
                }
                field("Standard Formula"; Rec."Standard Formula")
                {
                    ApplicationArea = All;
                }
                field("Grade Points"; Rec."Grade Points")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Blocked for Grading"; Rec."Blocked for Grading")
                {
                    ApplicationArea = all;
                }
                field("Grade Level ID"; Rec."Grade Level ID")
                {
                    ApplicationArea = All;
                }
                field("Grade Scale ID"; Rec."Grade Scale ID")
                {
                    ApplicationArea = All;
                }

                Field("Consider for GPA"; Rec."Consider for GPA")
                {
                    ApplicationArea = All;
                }
                Field("Show Grade Description"; Rec."Show Grade Description")
                {
                    ApplicationArea = All;
                }
                Field("Update Credit Attempt"; Rec."Update Credit Attempt")
                {
                    ApplicationArea = All;
                }
                field("Consider for GPA (MHS)"; Rec."Consider for GPA (MHS)")
                {
                    ApplicationArea = All;
                }
                field("BSIC Grading Calc."; Rec."BSIC Grading Calc.")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Grade")
            {
                Caption = '&Grade';
                action(Grade)
                {
                    Caption = '&Copy Grades';
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for update grade::CSPL-00174::040319: Start
                        VerticalEducationCS.GradesCopy();
                        //Code added for update grade::CSPL-00174::040319:End
                    end;
                }
            }
        }
    }

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}