report 50128 "Section Update in Time tableCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Section Update in Time tableCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Class Time Table Line-CS")
        {
            DataItemTableView = WHERE("Open Elective" = FILTER(FALSE),
                                      "Subject Code" = FILTER(<> 'HUM 5101'));

            trigger OnAfterGetRecord()
            begin
                ClassTimeTableHeaderCS.Reset();
                ClassTimeTableHeaderCS.SETRANGE(ClassTimeTableHeaderCS."No.", "Document No.");
                IF ClassTimeTableHeaderCS.findfirst() THEN BEGIN
                    Section := ClassTimeTableHeaderCS.Section;
                    Updated := TRUE;
                    Modify();
                END;
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

    var
        ClassTimeTableHeaderCS: Record "Class Time Table Header-CS";
}

