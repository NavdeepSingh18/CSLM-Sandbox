page 50549 "Spl Accommodation Applications"
{
    PageType = List;
    Caption = 'Special Accommodation Applications (Approved/Reject)';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Spcl Accommodation Application";
    SourceTableView = sorting("Approval Status On") order(descending) where("Send for Approval" = filter(true), "Approval Status" = filter(<> "Pending for Approval"));
    CardPageId = "Spl Accommodation Approved CRD";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Send_for_Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Send for Approval';
                }
                field("Send for Approval On"; Rec."Send for Approval On")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Approval Status On"; Rec."Approval Status On")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
    }
}