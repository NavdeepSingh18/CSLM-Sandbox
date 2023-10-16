page 50882 "Withdrawal Student SubjectCard"
{
    PageType = CardPart;
    UsageCategory = None;
    SourceTable = "Withdrawal Student Subject";
    DelayedInsert = true;
    Caption = 'Withdrawal Student Subject';

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
                field(StudentNo; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(StudentName; Rec."Student Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}