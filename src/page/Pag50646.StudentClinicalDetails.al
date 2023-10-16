page 50646 "Student Clinical Details"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Student Master-CS";
    Caption = 'Student Clinical Coordinator Details';
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = False;

    layout
    {
        area(content)
        {
            group("Student Clinical Coordinator Details")
            {
                field("Document Specialist"; Rec."Document Specialist")
                {
                    Caption = 'Document Specialist';
                    ApplicationArea = All;
                }
                field("FM1/IM1 Coordinator"; Rec."FM1/IM1 Coordinator")
                {
                    Caption = 'FM1/IM1 Coordinator';
                    ApplicationArea = All;
                }
                field("Clinical Coordinator"; Rec."Clinical Coordinator")
                {
                    Caption = 'Clinical Coordinator';
                    ApplicationArea = All;
                }
            }
        }
    }
}