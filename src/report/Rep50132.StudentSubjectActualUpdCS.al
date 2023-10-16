report 50132 "Student Subject Actual UpdCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Main Student Subject-CS")
        {

            trigger OnAfterGetRecord()
            begin
                VALIDATE("Subject Code");
                Modify();
            end;
        }
        dataitem(DataItem1000000001; "Optional Student Subject-CS")
        {

            trigger OnAfterGetRecord()
            begin
                VALIDATE("Subject Code");
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

