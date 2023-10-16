page 50595 "Approved Withdrawal Card"
{

    PageType = Card;
    Caption = 'Approved Withdrawal Card';
    UsageCategory = None;
    SourceTable = "Withdrawal Student-CS";
    Editable = False;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = False;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit() THEN
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
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
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal date"; Rec."Withdrawal date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                 field("Semester Start Date"; Rec."Semester Start Date")
                {
                    ApplicationArea = All;
                }
                field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = All;
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = All;
                }
                field("Last Date Of Attendance"; Rec."Last Date Of Attendance")
                {
                    ApplicationArea = All;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                }
                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Status"; Rec."Withdrawal Status")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

            }
            part("Withdrawal Approval Status"; "Withdrawal Approval Status")
            {
                visible = Boolean_gBool;
                SubPageLink = "Withdrawal No." = FIELD("No.");
                ApplicationArea = All;
            }
            group("Bank Details")
            {
                Visible = false;

                field("Bank Acc Holder Name"; Rec."Bank Acc Holder Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No/IBAN Number"; Rec."Bank Account No/IBAN Number")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("IFSC Code Number/Swift Code"; Rec."IFSC Code Number/Swift Code")
                {
                    ApplicationArea = All;
                }
                field(Refund; Rec.Refund)
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
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Student Ledger Entries")
            {
                ApplicationArea = All;
                Image = CustomerLedger;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false; //CS_SG 20230504
                trigger OnAction()
                var
                    CustomerLedEntries: Record "Cust. Ledger Entry";
                    StudentMasterRec: Record "Student Master-CS";
                begin
                    StudentMasterRec.Get(Rec."Student No.");
                    CustomerLedEntries.FilterGroup(0);
                    CustomerLedEntries.reset();
                    CustomerLedEntries.SetRange("Customer No.", StudentMasterRec."Original Student No.");
                    CustomerLedEntries.SetRange(Semester, StudentMasterRec.Semester);
                    CustomerLedEntries.SetFilter("Enrollment No.", StudentMasterRec."Enrollment No.");
                    if CustomerLedEntries.FindFirst() then begin
                        page.Run(25, CustomerLedEntries);
                        CustomerLedEntries.FilterGroup(2);
                    end;
                end;
            }
        }
    }
    var
        Boolean_gBool: Boolean;

    trigger OnOpenPage()
    begin
        Boolean_gBool := true;
        If Rec."Withdrawal Status" = Rec."Withdrawal Status"::Approved then
            Boolean_gBool := false;
    end;

    trigger OnAfterGetRecord()
    Begin

        Boolean_gBool := true;
        If Rec."Withdrawal Status" = Rec."Withdrawal Status"::"Pending for Approval" then
            Boolean_gBool := false;

    End;
}