page 50004 "Blackboard Grading"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BlackboardGrading;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                Field("Grade Column ID"; Rec."Grade Column ID")
                {
                    ApplicationArea = All;
                }
                Field("Grade Column Name"; Rec."Grade Column Name")
                {
                    ApplicationArea = All;
                }
                Field("Grade Value"; Rec."Grade Value")
                {
                    ApplicationArea = All;
                }
                Field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                Field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                Field("Blackboard course id"; Rec."Blackboard course id")
                {
                    ApplicationArea = All;
                }
                Field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                Field("Academic year"; Rec."Academic year")
                {
                    ApplicationArea = All;
                }
                Field("Term 1"; Rec."Term 1")
                {
                    ApplicationArea = All;
                }

            }

        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}