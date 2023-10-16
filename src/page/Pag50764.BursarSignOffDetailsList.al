page 50764 BursarSignoffDetailsList
{
    PageType = CardPart;
    Caption = 'Bursar Signoff Details Lines';
    ApplicationArea = None;
    UsageCategory = Lists;
    SourceTable = "Current Semester Fee";

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
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ApplicationArea = All;

                }
                field("Fixed Amount"; Rec."Fixed Amount")
                {
                    ApplicationArea = All;

                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     begin

            //     end;
            // }
        }
    }
}