report 50145 "Convert Customer To Student CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Customer"; "Customer")
        {
            DataItemTableView = WHERE("Convert to Student" = FILTER(False));

            trigger OnPostDataItem()
            begin
                MESSAGE('%1', StudentRec.Code);
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
        MESSAGE('%1', 'Done');
    end;

    var
        StudentRec: Record "Co-Curricular Activities-CS";
}