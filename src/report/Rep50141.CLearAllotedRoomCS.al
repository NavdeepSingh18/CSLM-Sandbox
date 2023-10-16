report 50141 "CLear Alloted RoomCS"
{
    // version V.001-CS

    ApplicationArea = All;
    UsageCategory = Administration;
    ProcessingOnly = true;

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
                    "External Attendance Line-CS"."Sitting Plan" := FALSE;
                    "External Attendance Line-CS"."Room Alloted No." := '';
                    "External Attendance Line-CS".Modify();
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
        ExaminationLogDetailsCS.Reset();
        ExaminationLogDetailsCS.SETRANGE("Exam Date", 20171117D);
        ExaminationLogDetailsCS.deleteall();

        RoomsCS.Reset();
        RoomsCS.SETRANGE("Exam Date", 20171117D);
        RoomsCS.MODIFYALL("Allot For Examination", FALSE);
    end;

    var
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        RoomsCS: Record "Rooms-CS";
}

