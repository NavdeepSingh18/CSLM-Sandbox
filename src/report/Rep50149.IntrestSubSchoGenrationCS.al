report 50149 "Intrest Sub.Scho.Genration-CS"
{
    // version V.001-CS

    ProcessingOnly = true;

    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Customer"; "Customer")
        {

            trigger OnAfterGetRecord()
            begin
                //Customer.GET();
                ScholarshipHeaderCS.Reset();
                ScholarshipHeaderCS.SETCURRENTKEY("Scholarship Code", "Source Code", "Fee Classification Code", "Admitted Year");
                ScholarshipHeaderCS.SETRANGE("Scholarship Code", 'INSUB');
                ScholarshipHeaderCS.SETRANGE("Source Code", 'LOAN');
                ScholarshipHeaderCS.SETRANGE("Fee Classification Code", Customer."Fee Classification Code");
                ScholarshipHeaderCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                ScholarshipHeaderCS.SETRANGE("Global Dimension 1 Code", Customer."Global Dimension 1 Code");
                //ScholarshipHeaderCS.SETRANGE("Global Dimension 2 Code",Customer."Global Dimension 2 Code");
                IF ScholarshipHeaderCS.findfirst() THEN
                    ManagementsFeeCS.FeeDiscountCalcCS(Customer."No.", ManualAmount, ScholarshipHeaderCS."G/L Account No.");

            end;

            trigger OnPreDataItem()
            begin
                //Customer.GET(CustomerNo);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Customer No"; CustomerNo)
                {
                    TableRelation = Customer;
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                    ToolTip = 'Customer No. may have a value';
                }
                field(Amount; ManualAmount)
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                    ToolTip = 'Amount may have a value';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        ScholarshipHeaderCS: Record "Scholarship Header-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        ManualAmount: Decimal;
        CustomerNo: Code[20];
}

