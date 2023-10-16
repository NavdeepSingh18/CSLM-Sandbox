page 50716 "Pending Customer Invoices"
{

    PageType = API;
    EntityName = 'pcI';
    EntitySetName = 'pcI';
    DelayedInsert = true;
    Caption = 'Pending Customer Invoices';
    SourceTable = "Cust. Ledger Entry";
    SourceTableView = where("Document Type" = CONST(Invoice), Reversed = FILTER(false), "Remaining Amount" = FILTER(> 0), Reversed = const(false), "Financial Aid Approved" = filter(false));
    UsageCategory = Administration;
    ApplicationArea = All;
    APIPublisher = 'pcI01';
    APIGroup = 'pcI';

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(customerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(enrollmentNo; Rec."Enrollment No.")
                {
                    ApplicationArea = all;
                }
                field(semesTer; Rec.Semester)
                {
                    ApplicationArea = all;
                }
                field(currencyCode; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(postingDate; Format(Rec."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                    ApplicationArea = All;
                }
                field(documentNo; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(academicYear; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(terM; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(entryNo; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field(descriPtion; Rec.Description)
                {
                    ApplicationArea = All;
                }
                // field(descriPtion;Rec."Fee Description")
                // {
                //     ApplicationArea = all;
                // }
                field(dueDate; Format(Rec."Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                    ApplicationArea = All;
                }
                field(amouNt; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(remainingAmount; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field(paidAmount; (Rec.Amount - Rec."Remaining Amount"))
                {
                    ApplicationArea = All;
                }
                field(departCode; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field(departName; departName)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Error('You cannot Insert into the Customer Ledger Entry Table');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Error('You cannot Modify the record of Customer Ledger Entry Table');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Error('You cannot Delete the record of Customer Ledger Entry Table');
    end;

    trigger OnAfterGetRecord()
    begin
        departName := '';
        GenLedSetup.get();

        DimVal.Reset();
        DimVal.SetRange("Dimension Code", GenLedSetup."Global Dimension 2 Code");
        DimVal.SetRange(Code, Rec."Global Dimension 2 Code");
        if DimVal.FindFirst() then
            departName := DimVal.Name;

    end;

    var
        GenLedSetup: Record "General Ledger Setup";
        DimVal: Record "Dimension Value";
        departName: Text[50];
}