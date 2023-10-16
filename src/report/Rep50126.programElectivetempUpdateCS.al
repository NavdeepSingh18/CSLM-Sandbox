report 50126 "program/Elective temp UpdateCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem(DataItem1000000000; "Class Time Table Line-CS")
        {

            trigger OnAfterGetRecord()
            begin
                SubjectMasterCS.Reset();
                SubjectMasterCS.SETRANGE(SubjectMasterCS."Code", "Subject Code");
                IF SubjectMasterCS.findfirst() THEN BEGIN
                    "Program/Open Elective Temp" := SubjectMasterCS."Program/Open Elective Temp";
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
        SubjectMasterCS: Record "Subject Master-CS";
}

