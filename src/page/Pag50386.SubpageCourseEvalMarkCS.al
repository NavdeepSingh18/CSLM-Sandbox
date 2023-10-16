page 50386 "Subpage Course Eval. Mark -CS"
{
    // version V.001-CS

    Caption = 'Subpage Course Eval. Mark -CS';
    PageType = CardPart;
    SourceTable = "Evaluation Course Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field("Attendance Status"; Rec."Attendance Status")
                {
                    ApplicationArea = All;
                }
                field("Marks Obtained"; Rec."Marks Obtained")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}