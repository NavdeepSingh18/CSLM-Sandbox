page 50647 "Residency Details"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Student Master-CS";
    Caption = 'Residency Details';
    // Editable = false;
    // ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = False;
    layout
    {
        area(content)
        {
            group("Residency Details")
            {
                field("Residency Hospital 1"; Rec."Residency Hospital 1")
                {
                    Caption = 'Residency Hospital 1';
                    ApplicationArea = All;
                }
                field("Residency Hospital 2"; Rec."Residency Hospital 2")
                {
                    Caption = 'Residency Hospital 2';
                    ApplicationArea = All;
                }
                field("Residency Status"; Rec."Residency Status")
                {
                    Caption = 'Residency Status';
                    ApplicationArea = All;
                }
                field("Residency City"; Rec."Residency City")
                {
                    Caption = 'Residency City';
                    ApplicationArea = All;
                }
                field("Residency Specialty 1"; Rec."Residency Specialty 1")
                {
                    Caption = 'Residency Specialty 1';
                    ApplicationArea = All;
                }
                field("Residency Specialty 2"; Rec."Residency Specialty 2")
                {
                    Caption = 'Residency Specialty 2';
                    ApplicationArea = All;
                }
                field("Residency State"; Rec."Residency State")
                {
                    Caption = 'Residency State';
                    ApplicationArea = All;
                }
                field("Residency Year"; Rec."Residency Year")
                {
                    Caption = 'Residency Year';
                    ApplicationArea = All;
                }
            }
        }
    }
}