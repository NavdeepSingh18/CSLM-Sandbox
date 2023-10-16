report 50157 "Update GL EntryCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Update GL EntryCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = WHERE("Document No." = FILTER('@*OPN*'));

            trigger OnAfterGetRecord()
            begin
                "G/L Entry"."Actual Synch to SFAS" := TRUE;
                Modify();
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

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;
}

