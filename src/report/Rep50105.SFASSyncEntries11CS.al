report 50105 "SFAS Sync Entries11 CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("Posting Date")
                                ORDER(Ascending)
                                WHERE("Synchronised with SFAS" = FILTER(True),
                                      "Actual Synch to SFAS" = FILTER(False));
            MaxIteration = 80;
            RequestFilterFields = "Posting Date";

            trigger OnAfterGetRecord()
            begin
                i += 1;
                /*
                "G/L Entry".Reset();
                "G/L Entry".SETRANGE("G/L Entry"."Synchronised with SFAS",TRUE);
                "G/L Entry".SETRANGE("G/L Entry"."Actual Synch to SFAS",FALSE);
                IF "G/L Entry".findfirst() THEN BEGIN
                  AzureIntegration.InsertDatainTempManual("G/L Entry"."Document No.");
                END;
                */
                // AzureIntegration.InsertDatainTempManual("G/L Entry"."Document No.");

            end;

            trigger OnPostDataItem()
            begin
                //MESSAGE('%1',i,'-Done');
            end;

            trigger OnPreDataItem()
            begin
                i := 0;
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

    var
        i: Integer;
}

