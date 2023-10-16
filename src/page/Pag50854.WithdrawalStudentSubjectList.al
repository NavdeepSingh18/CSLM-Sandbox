page 50854 "Withdrawal Student Subject"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Withdrawal Student Subject";
    DelayedInsert = true;
    Caption = 'Withdrawal Student Subject List';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Withdrawal Request No."; Rec."Withdrawal Request No.")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;

                }
                field("Subject Name"; Rec."Subject Name")
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

            }
        }
    }
}