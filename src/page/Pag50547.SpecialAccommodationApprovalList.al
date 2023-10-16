page 50547 "Spl Accommodation Approval"
{
    PageType = List;
    Caption = 'Special Accommodation Application Approval';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Spcl Accommodation Application";
    SourceTableView = sorting("Send for Approval") order(descending) where("Send for Approval" = filter(true), "Approval Status" = filter("Pending for Approval"));
    CardPageId = "Spl Accommodation Approval CRD";
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
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                ShortcutKey = 'F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Approve;
                Visible = false;
                trigger OnAction();
                begin
                    // if Confirm('Do you want to Approve the Special Considration Application for the Student %1 (%2)?', true, "Student No.", "Student Name") then begin
                        Rec.Validate("Approval Status", "Approval Status"::Approved);
                        Rec.Modify();
                    // end;
                end;
            }
            action("Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                ShortcutKey = 'Ctrl+F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                Visible = false;
                trigger OnAction();
                begin
                    // if Confirm('Do you want to Reject the Special Considration Application for the Student %1 (%2)?', true, "Student No.", "Student Name") then begin
                        Rec.Validate("Approval Status", "Approval Status"::Rejected);
                        Rec.Modify();
                    // end;
                end;
            }
        }
    }
}