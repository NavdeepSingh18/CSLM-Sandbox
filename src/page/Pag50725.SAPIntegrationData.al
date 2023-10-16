page 50725 "SAP Integration Data"
{

    Caption = 'SAP Integration Data';
    PageType = List;
    SourceTable = "G/L Entries Date Wise";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }

                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ApplicationArea = All;
                }
                // field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                // {
                //     ApplicationArea = All;
                // }
                // field("Gen. Posting Type"; Rec."Gen. Posting Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                // {
                //     ApplicationArea = All;
                // }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                // field("Currency Code"; Rec."Currency Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Currency Factor"; Rec."Currency Factor")
                // {
                //     ApplicationArea = All;
                // }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }

                // field("Financial Aid Approved"; Rec."Financial Aid Approved")
                // {
                //     ApplicationArea = All;
                // }
                // field("Payment Plan Applied"; Rec."Payment Plan Applied")
                // {
                //     ApplicationArea = All;
                // }
                // field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                // {
                //     ApplicationArea = All;
                // }
                // field("Payment By Financial Aid"; Rec."Payment By Financial Aid")
                // {
                //     ApplicationArea = All;
                // }
                field("Fund Type"; Rec."Fund Type")
                {
                    ApplicationArea = All;
                }
                field("SAP Assignment Code"; Rec."SAP Assignment Code")
                {
                    ApplicationArea = All;
                }
                field("SAP Bus. Area"; Rec."SAP Bus. Area")
                {
                    ApplicationArea = All;
                }
                field("SAP Code"; Rec."SAP Code")
                {
                    ApplicationArea = All;
                }
                field("SAP Company Code"; Rec."SAP Company Code")
                {
                    ApplicationArea = All;
                }
                field("SAP Cost Centre"; Rec."SAP Cost Centre")
                {
                    ApplicationArea = All;
                }
                field("SAP Description"; Rec."SAP Description")
                {
                    ApplicationArea = All;
                }
                field("SAP G/L Account"; Rec."SAP G/L Account")
                {
                    ApplicationArea = All;
                }
                field("SAP Profit Centre"; Rec."SAP Profit Centre")
                {
                    ApplicationArea = All;
                }
                // field("Self Payment Applied"; Rec."Self Payment Applied")
                // {
                //     ApplicationArea = All;
                // }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                }
                // field("System-Created Entry"; Rec."System-Created Entry")
                // {
                //     ApplicationArea = All;
                // }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                }
                // field(Posted; Rec.Posted)
                // {
                //     ApplicationArea = All;
                // }
                // field(Quantity; Rec.Quantity)
                // {
                //     ApplicationArea = All;
                // }
                // field(Reversed; Rec.Reversed)
                // {
                //     ApplicationArea = All;
                // }
                // field("Applies To Rev. Doc. No."; Rec."Applies To Rev. Doc. No.")
                // {
                //     ApplicationArea = All;
                // }

                // field("Business Unit Code"; Rec."Business Unit Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                }
                field("Cheque No."; Rec."Cheque No.")
                {
                    ApplicationArea = All;
                }

                field("Credit Memo Type"; Rec."Credit Memo Type")
                {
                    ApplicationArea = All;
                }
                // field("Currency Code Receipt"; Rec."Currency Code Receipt")
                // {
                //     ApplicationArea = All;
                // }

                // field("Customer Bank Branch Code"; Rec."Customer Bank Branch Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Customer Bank Code"; Rec."Customer Bank Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Waiver/Scholar/Grant Code"; Rec."Waiver/Scholar/Grant Code")
                {
                    ApplicationArea = All;
                }
                field("Waiver/Scholar/Grant Desc"; Rec."Waiver/Scholar/Grant Desc")
                {
                    ApplicationArea = All;
                }
                // field("Withdrawal No."; Rec."Withdrawal No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("Deposit Type"; Rec."Deposit Type")
                // {
                //     ApplicationArea = All;
                // }
                // field("Dimension Set ID"; Rec."Dimension Set ID")
                // {
                //     ApplicationArea = All;
                // }

                // field("FA Entry No."; Rec."FA Entry No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("FA Entry Type"; Rec."FA Entry Type")
                // {
                //     ApplicationArea = All;
                // }

                field("Fee Group"; Rec."Fee Group")
                {
                    ApplicationArea = All;
                }

                // field("GST/HST"; Rec."GST/HST")
                // {
                //     ApplicationArea = All;
                // }
                // field("Reason Code"; Rec."Reason Code")
                // {
                //     ApplicationArea = All;
                // }
                // field(Reason; Rec.Reason)
                // {
                //     ApplicationArea = All;
                // }
                // field("Tax Area Code"; Rec."Tax Area Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Tax Group Code"; Rec."Tax Group Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Tax Liable"; Rec."Tax Liable")
                // {
                //     ApplicationArea = All;
                // }
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                // field("Transaction Number"; Rec."Transaction Number")
                // {
                //     ApplicationArea = All;
                // }
                // field("UnRelazised Doc No."; Rec."UnRelazised Doc No.")
                // {
                //     ApplicationArea = All;
                // }
                // field("VAT Amount"; Rec."VAT Amount")
                // {
                //     ApplicationArea = All;
                // }
                // field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                // {
                //     ApplicationArea = All;
                // }
                // field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                // {
                //     ApplicationArea = All;
                // }

                field(customerNo; customerNo)
                {
                    Caption = 'Customer No.';
                    ApplicationArea = all;
                }

                field(customerName; customerName)
                {
                    Caption = 'Customer Name.';
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("SAP-Upload Export To Excel")
            {
                ApplicationArea = All;
                Caption = 'SAP-Upload Export To Excel';
                Image = Report2;
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    Report.Run(Report::"SAP-UploadExportToExcel", false, false, Rec);
                end;
            }
        }
    }
    var
        customerRec: Record "Student Master-CS";
        customerNo: Code[20];
        customername: Text;

    trigger OnAfterGetRecord()
    begin
        customerNo := '';
        customername := '';
        customerRec.reset();
        customerRec.SetRange("Enrollment No.", Rec."Enrollment No.");
        if customerRec.FindFirst() then begin
            customerNo := customerRec."Original Student No.";
            customername := customerRec."First Name" + ' ' + customerRec."Last Name";
        end else begin
            customerNo := '';
            customername := '';
        end;

    end;
}

