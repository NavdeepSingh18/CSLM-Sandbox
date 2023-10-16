report 50114 "CLear Alloted  Room CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Header-CS"; "External Attendance Header-CS")
        {
            RequestFilterFields = "Exam Date";
            dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
            {
                DataItemLink = "Document No." = FIELD("No.");

                trigger OnAfterGetRecord()
                begin
                    "External Attendance Header-CS"."Sitting Plan" := FALSE;
                    "External Attendance Header-CS"."Room No." := '';
                    "External Attendance Header-CS".Modify();
                end;
            }

            trigger OnAfterGetRecord()
            begin
                "External Attendance Header-CS"."Sitting Plan" := FALSE;
                "External Attendance Header-CS".Modify();
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnPreReport()
    begin
        ExamLog.Reset();
        ExamLog.SETRANGE("Exam Date", 20171124D);
        ExamLog.deleteall();

        RoomMaster.Reset();
        RoomMaster.SETRANGE("Exam Date", 20171124D);
        RoomMaster.MODIFYALL("Allot For Examination", FALSE);
    end;

    var
        ExamLog: Record "Examination Log Details-CS";
        RoomMaster: Record "Rooms-CS";
}

