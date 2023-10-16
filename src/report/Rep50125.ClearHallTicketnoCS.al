report 50125 "Clear Hall Ticket noCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "External Attendance Line-CS")
        {
            RequestFilterFields = "Exam Schedule No.";

            trigger OnAfterGetRecord()
            begin
                "Hall Ticket No." := '';
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

