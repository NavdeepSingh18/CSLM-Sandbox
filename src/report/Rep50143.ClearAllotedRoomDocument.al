report 50143 "Clear Alloted Room Document"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clear Alloted Room Document.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Line-CS"; "External Attendance Line-CS")
        {
            DataItemTableView = SORTING("Room Alloted No.")
                                ORDER(Ascending);
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                IF RoomNo <> "External Attendance Line-CS"."Room Alloted No." THEN BEGIN
                    RoomNo := "External Attendance Line-CS"."Room Alloted No.";
                    RoomsCS.Reset();
                    RoomsCS.SETRANGE("Display Room No.", RoomNo);
                    RoomsCS.SETRANGE("Exam Date", "External Attendance Line-CS"."Exam Date");
                    RoomsCS.SETRANGE("Exam Slot", "External Attendance Line-CS"."Exam Slot");
                    IF RoomsCS.findfirst() THEN BEGIN
                        RoomsCS."Allot For Examination" := FALSE;
                        RoomsCS.Modify();
                    END;

                    ExaminationLogDetailsCS.Reset();
                    ExaminationLogDetailsCS.SETRANGE("Room No.", RoomNo);
                    ExaminationLogDetailsCS.SETRANGE("Exam Date", "External Attendance Line-CS"."Exam Date");
                    ExaminationLogDetailsCS.SETRANGE("Time Slot", "External Attendance Line-CS"."Exam Slot");
                    IF ExaminationLogDetailsCS.findfirst() THEN
                        ExaminationLogDetailsCS.Delete();
                END;
                "External Attendance Line-CS"."Room Alloted No." := '';
                "External Attendance Line-CS"."Sitting Plan" := FALSE;
                "External Attendance Line-CS".Modify();

                IF ExternalAttendanceHeaderCS.GET("External Attendance Line-CS"."Document No.") THEN BEGIN
                    ExternalAttendanceHeaderCS."Sitting Plan" := FALSE;
                    ExternalAttendanceHeaderCS.Modify();
                END;
            end;

            trigger OnPreDataItem()
            begin
                RoomNo := '';
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

    var
        RoomsCS: Record "Rooms-CS";
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS";
        RoomNo: Code[20];
}

