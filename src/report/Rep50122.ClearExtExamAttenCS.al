report 50122 "Clear Ext. Exam Atten.CS"
{
    // version V.001-CS
    Caption = 'Clear Ext Exam Attendance';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Exam Time Table Line-CS")
        {
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                "Ext Exam Attendance No." := '';
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

