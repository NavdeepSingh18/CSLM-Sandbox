page 51050 "Grade List GradeBook"
{
    // version V.001-CS

    // Sr.No  Emp.Id       Date       Trigger              Remarks
    // ------------------------------------------------------------------------------------------------------------
    // 01.    CSPL-00174   04-03-19   Grade - OnAction()   Code added for update grade  .

    Caption = 'Passing Grade - Grade Book';
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    // ModifyAllowed = false;
    // Editable = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Grade Master Grade Book";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
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


                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
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