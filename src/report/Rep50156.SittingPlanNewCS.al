report 50156 "Sitting Plan NewCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Sitting Plan NewCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Header-CS"; "External Attendance Header-CS")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                ExternalAttendanceHeaderCS.deleteall();
                IF "Sitting Plan" = TRUE THEN
                    ERROR(Text0001Lbl, "External Attendance Header-CS"."Subject Code");
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Document No.", "External Attendance Header-CS"."No.");
                IF ExternalAttendanceLineCS.findset() THEN
                    REPEAT

                        ExternalAttendanceLineCS1.Reset();
                        ExternalAttendanceLineCS1.SETRANGE("Document No.", ExternalAttendanceLineCS."Document No.");
                        ExternalAttendanceLineCS1.SETRANGE(Course, ExternalAttendanceLineCS.Course);
                        IF NOT ExternalAttendanceLineCS1.findfirst() THEN BEGIN
                            ExternalAttendanceLineCS1.init();
                            ExternalAttendanceLineCS1."Line No." += 10000;
                            ExternalAttendanceLineCS1."Document No." := ExternalAttendanceLineCS."Document No.";
                            ExternalAttendanceLineCS1.Course := ExternalAttendanceLineCS.Course;
                            ExternalAttendanceLineCS1."Exam Slot" := ExternalAttendanceLineCS."Exam Slot";
                            ExternalAttendanceLineCS1."Exam Date" := ExternalAttendanceLineCS."Exam Date";
                            ExternalAttendanceLineCS1."Sitting Plan" := ExternalAttendanceLineCS."Sitting Plan";
                            ExternalAttendanceLineCS1.Insert();
                        END;
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
            end;

            trigger OnPostDataItem()
            begin
                CheckCapcityCS();
                RoomSittingCS();

                RoomsCS.Reset();
                RoomsCS.MODIFYALL("Allot For Examination", FALSE);
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

    var
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        ExternalAttendanceHeaderCS: Record "External Attendance Header-CS" temporary;
        ExternalAttendanceLineCS1: Record "External Attendance Line-CS" temporary;
        RoomsCS: Record "Rooms-CS";
        ExternalAttendanceHeaderCS1: Record "External Attendance Header-CS";
        RoomCap: Integer;
        "RoomNo.": Code[20];
        CNT: Integer;

        i: Integer;

        RoomCapity: Integer;
        Text0001Lbl: Label 'Sitting Plan Already generated for %1 subject', Comment = '%1 = Subject';
        DocNO: Code[20];

    local procedure RoomSittingCS()
    begin
        ExternalAttendanceLineCS1.Reset();
        IF ExternalAttendanceLineCS1.findfirst() THEN
            REPEAT
                IF DocNO <> ExternalAttendanceLineCS1."Document No." THEN BEGIN
                    i := 0;
                    RoomCap := 0;
                    "RoomNo." := '';
                    CNT := 0;
                    i += 1;
                    IF i = 1 THEN BEGIN
                        RoomsCS.Reset();
                        RoomsCS.SETRANGE(Course, ExternalAttendanceLineCS1.Course);
                        IF RoomsCS.findfirst() THEN BEGIN
                            RoomCap := RoomsCS."Exam Capacity";
                            "RoomNo." := RoomsCS."Room No.";
                        END;
                    END;
                END;
                DocNO := ExternalAttendanceLineCS1."Document No.";
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE(Course, ExternalAttendanceLineCS1.Course);
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceLineCS1."Document No.");
                IF ExternalAttendanceLineCS.findset() THEN
                    REPEAT
                        CNT += 1;
                        IF CNT <= RoomCap THEN BEGIN
                            ExternalAttendanceLineCS."Room Alloted No." := "RoomNo.";
                            ExternalAttendanceLineCS.Modify();
                            //  CreateLog;

                        END ELSE BEGIN
                            CNT := 0;
                            RoomsCS.Reset();
                            RoomsCS.SETRANGE("Room No.", "RoomNo.");
                            IF RoomsCS.findfirst() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;
                            //
                            "RoomNo." := '';
                            // RoomCap :=0;
                            RoomsCS.Reset();
                            RoomsCS.SETCURRENTKEY(Course, "Room No.");
                            RoomsCS.SETRANGE(Course, ExternalAttendanceLineCS1.Course);
                            RoomsCS.SETRANGE("Allot For Examination", FALSE);
                            IF RoomsCS.findfirst() THEN BEGIN
                                "RoomNo." := RoomsCS."Room No.";
                                RoomCap := RoomsCS."Exam Capacity";
                            END;
                            ExternalAttendanceLineCS."Room Alloted No." := "RoomNo.";
                            ExternalAttendanceLineCS.Modify();
                            CNT += 1;
                        END;

                        ExternalAttendanceLineCS."Sitting Plan" := TRUE;
                        ExternalAttendanceLineCS.Modify();

                        IF ExternalAttendanceHeaderCS1.GET(ExternalAttendanceLineCS."Document No.") THEN BEGIN
                            ExternalAttendanceHeaderCS1."Sitting Plan" := TRUE;
                            ExternalAttendanceHeaderCS1.Modify();
                        END;
                        CreateLogCS(ExternalAttendanceLineCS."Exam Date", ExternalAttendanceLineCS."Exam Slot", ExternalAttendanceLineCS."Academic Year", ExternalAttendanceLineCS."Room Alloted No.");
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;

            UNTIL ExternalAttendanceLineCS1.NEXT() = 0;
    end;

    local procedure CreateLogCS(ExamDate: Date; Examslot: Code[20]; AcedmicYear: Code[20]; RoomNo: Code[20])
    var
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        ExaminationLogDetailsCS1: Record "Examination Log Details-CS";
        Entryno: Integer;
    begin

        ExaminationLogDetailsCS.Reset();
        ExaminationLogDetailsCS.SETRANGE("Exam Date", ExamDate);
        ExaminationLogDetailsCS.SETRANGE("Academic Year", AcedmicYear);
        ExaminationLogDetailsCS.SETRANGE("Time Slot", Examslot);
        ExaminationLogDetailsCS.SETRANGE("Room No.", RoomNo);
        IF NOT ExaminationLogDetailsCS.findfirst() THEN BEGIN
            ExaminationLogDetailsCS1.Reset();
            IF ExaminationLogDetailsCS1.Findlast() THEN
                Entryno := ExaminationLogDetailsCS1."Entry No" + 1
            ELSE
                Entryno := 1;

            ExaminationLogDetailsCS.init();
            ExaminationLogDetailsCS."Entry No" := Entryno;
            ExaminationLogDetailsCS."Exam Date" := ExamDate;
            ExaminationLogDetailsCS."Time Slot" := Examslot;
            ExaminationLogDetailsCS."Academic Year" := AcedmicYear;
            ExaminationLogDetailsCS.Semester := '';
            ExaminationLogDetailsCS."Room No." := "RoomNo.";
            ExaminationLogDetailsCS.Insert();
        END;
    end;

    procedure CheckCapcityCS()
    var
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
    begin
        ExternalAttendanceLineCS1.Reset();
        IF ExternalAttendanceLineCS1.findfirst() THEN
            REPEAT

                RoomsCS.Reset();
                RoomsCS.SETRANGE(Course, ExternalAttendanceLineCS1.Course);
                IF RoomsCS.findset() THEN
                    REPEAT
                        ExaminationLogDetailsCS.Reset();
                        ExaminationLogDetailsCS.SETRANGE("Exam Date", ExternalAttendanceLineCS1."Exam Date");
                        ExaminationLogDetailsCS.SETRANGE("Time Slot", ExternalAttendanceLineCS1."Exam Slot");
                        ExaminationLogDetailsCS.SETRANGE("Room No.", RoomsCS."Room No.");
                        IF ExaminationLogDetailsCS.findfirst() THEN
                            ERROR('Room No. %1 alloted for Exam date %2 at %3 for Course %4 Please Contact your System Administrator'
                          , RoomsCS."Room No.", ExternalAttendanceLineCS1."Exam Date", ExternalAttendanceLineCS1."Exam Slot", ExternalAttendanceLineCS1.Course);
                    UNTIL RoomsCS.NEXT() = 0;


                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceLineCS1."Document No.");
                ExternalAttendanceLineCS.SETRANGE(Course, ExternalAttendanceLineCS1.Course);
                IF ExternalAttendanceLineCS.findset() THEN BEGIN
                    RoomCapity := 0;
                    RoomsCS.Reset();
                    RoomsCS.SETRANGE(Course, ExternalAttendanceLineCS1.Course);
                    IF RoomsCS.findset() THEN BEGIN
                        REPEAT
                            RoomCapity := RoomCapity + RoomsCS."Exam Capacity";
                        UNTIL RoomsCS.NEXT() = 0;
                        IF ExternalAttendanceLineCS.COUNT() > RoomCapity THEN
                            ERROR('No. of Student is %1 but room capacity is %2 for %3 . Please contact your System Administrator  ', ExternalAttendanceLineCS.COUNT(), RoomCapity, ExternalAttendanceLineCS1.Course)
                    END;
                END;
            UNTIL ExternalAttendanceLineCS1.NEXT() = 0;
    end;
}
