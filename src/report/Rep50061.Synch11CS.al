report 50061 "Synch11CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    ApplicationArea = All;
    UsageCategory = Administration;
    RDLCLayout = './src/reportrdlc/Synch11CS.rdlc';

    dataset
    {
        dataitem("Synchronization-CS"; "Synchronization-CS")
        {

            trigger OnAfterGetRecord()
            begin
                GLEntry.Reset();
                GLEntry.SETRANGE("Document No.", "Synchronization-CS"."Document No.");
                IF GLEntry.findset() THEN
                    REPEAT
                        GLEntry."Actual Synch to SFAS" := TRUE;
                        GLEntry.Modify();
                    UNTIL GLEntry.NEXT() = 0;
            end;

            trigger OnPostDataItem()
            begin
                MESSAGE('DONE');
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
        GLEntry: Record "G/L Entry";
}

