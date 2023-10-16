page 51004 "KK Report Data"
{

    Caption = 'KK Report Data';
    PageType = List;
    SourceTable = "Temp Record";
    Editable = false;
    SourceTableView = sorting("Entry No") order(ascending);

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
                field("Course UID"; Rec."Course UID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Course Start Date"; Rec."Course Start Date")
                {
                    ApplicationArea = All;
                }
                field("Course End Date"; Rec."Course End Date")
                {
                    ApplicationArea = All;
                }
                field("Hospital UID"; Rec."Hospital UID")
                {
                    ApplicationArea = All;
                }
                field("Est Rotation Wk Cost"; Rec."Est Rotation Wk Cost")
                {
                    ApplicationArea = All;
                }
                field("Est Rotation Total Cost"; Rec."Est Rotation Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Valid Rotation"; Rec."Valid Rotation")
                {
                    ApplicationArea = All;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Course Credit Weeks"; Rec."Course Credit Weeks")
                {
                    ApplicationArea = All;
                }
                field("Course Core Clinical Req."; Rec."Course Core Clinical Req.")
                {
                    ApplicationArea = All;
                }
                field("Weeks Completed"; Rec."Weeks Completed")
                {
                    ApplicationArea = All;
                }
                field("Weeks Paid"; Rec."Weeks Paid")
                {
                    ApplicationArea = All;
                }
                field("Weeks Invoiced"; Rec."Weeks Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Total Invoiced"; Rec."Total Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Weeks Credited"; Rec."Weeks Credited")
                {
                    ApplicationArea = All;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                field(Graded; Rec.Graded)
                {
                    ApplicationArea = All;
                }
                field("Invoice Balance"; Rec."Invoice Balance")
                {
                    ApplicationArea = All;
                }
                field("Expense Realized"; Rec."Expense Realized")
                {
                    ApplicationArea = All;
                }
                field("Total Paid"; Rec."Total Paid")
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
                field("Student Spec. Prog."; Rec."Student Spec. Prog.")
                {
                    ApplicationArea = All;
                }
                field("Rate Table Rate"; Rec."Rate Table Rate")
                {
                    ApplicationArea = All;
                }
                field("Accrual Week End"; Rec."Accrual Week End")
                {
                    ApplicationArea = All;
                }
                field("Invoice Rate"; Rec."Invoice Rate")
                {
                    ApplicationArea = All;
                }
                field("Rate Used"; Rec."Rate Used")
                {
                    ApplicationArea = All;
                }
                field("Rate Type"; Rec."Rate Type")
                {
                    ApplicationArea = All;
                }
                field("Unpaid Wks Completed"; Rec."Unpaid Wks Completed")
                {
                    ApplicationArea = All;
                }
                field("Expense Accrual"; Rec."Expense Accrual")
                {
                    ApplicationArea = All;
                }
                field("Hospital Invoice Number"; Rec."Hospital Invoice Number")
                {
                    ApplicationArea = All;
                }
                field("Hospital Payment Number"; Rec."Hospital Payment Number")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Pre Payment"; Rec."Pre Payment")
                {
                    ApplicationArea = All;
                }
                field("Weeks Delivered Current Period"; Rec."Weeks Delivered Current Period")
                {
                    ApplicationArea = All;
                }
                field("Weeks Del. All Prior Periods"; Rec."Weeks Del. All Prior Periods")
                {
                    ApplicationArea = All;
                }
                field("Rotation ID"; Rec."Rotation ID")
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
    end;
}
