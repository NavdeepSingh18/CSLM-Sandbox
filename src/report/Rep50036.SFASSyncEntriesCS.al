report 50036 "SFAS Sync Entries-CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                // AzureIntegration.InsertDatainTempManual("G/L Entry"."Document No.");
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('Done');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

