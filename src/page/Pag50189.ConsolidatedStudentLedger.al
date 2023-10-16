page 50189 "Consolidated Student Ledger"
{

    PageType = List;
    SourceTable = "Temp Record";
    Caption = 'Consolidated Student Ledger';
    UsageCategory = None;
    SourceTableView = sorting("Entry No") order(ascending);
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field("Student Last Name"; Rec."Student Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student First Name"; Rec."Student First Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Program; Rec.Program)
                {
                    ApplicationArea = All;
                }

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Doc. Type"; Rec."Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Doc. No."; Rec."Doc. No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Bill Code"; Rec."Bill Code")
                {
                    ApplicationArea = All;
                }
                field("Bill Discription"; Rec."Bill Discription")
                {
                    ApplicationArea = All;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Running Balance"; Rec."Running Balance")
                {
                    ApplicationArea = All;
                }
                field("Fee Group"; Rec."Fee Group")
                {
                    ApplicationArea = All;
                }
                field("Institute Code"; Rec."Institute Code")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if Confirm('Do you want to exit!', false) then begin

        end else
            Error('');
        ;
    end;

}
