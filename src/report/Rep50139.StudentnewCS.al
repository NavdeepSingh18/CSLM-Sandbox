report 50139 "Student new CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';

            trigger OnAfterGetRecord()
            begin
                Counter := Counter + 1;
                "Student Master-CS".Section := '';
                "Student Master-CS"."Roll No." := '';
                "Student Master-CS".Batch := '';
                "Student Master-CS"."Section & Roll No." := FALSE;
                "Student Master-CS".Modify();

                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));
            end;

            trigger OnPostDataItem()
            begin
                PROGRESS.close();
            end;

            trigger OnPreDataItem()
            begin
                TotalCount := "Student Master-CS".count();
                PROGRESS.OPEN(Text_10001Lbl);
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
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label 'PROCESSING #1  Out Of  @2 .', Comment = '#1 = No. of Counts';
}