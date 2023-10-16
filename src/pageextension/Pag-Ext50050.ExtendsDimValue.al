pageextension 50050 "ExtendsDimValue" extends "Dimension Values"
{
    layout
    {
        addafter("Consolidation Code")
        {
            field("Core Clinical Roster Nos."; Rec."Core Clinical Roster Nos.")
            {
                ApplicationArea = All;
            }
            field("Elective Clinical Roster Nos."; Rec."Elective Clinical Roster Nos.")
            {
                ApplicationArea = All;
            }
            field("FM1_IM1 Clerkship Nos."; Rec."FM1_IM1 Clerkship Nos.")
            {
                ApplicationArea = All;
            }
            field("Requisition Approver Level 1"; Rec."Requisition Approver Level 1")
            {
                ApplicationArea = All;
            }
            field("Requisition Approver Level 2"; Rec."Requisition Approver Level 2")
            {
                ApplicationArea = All;
            }
            field("Requisition Approver Level 3"; Rec."Requisition Approver Level 3")
            {
                ApplicationArea = All;
            }
        }
    }
}