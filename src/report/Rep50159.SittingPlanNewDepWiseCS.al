report 50159 "Sitting Plan New Dep WiseCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("External Attendance Header-CS"; "External Attendance Header-CS")
        {
            DataItemTableView = WHERE("Attendance Not Applicable" = CONST(False));
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
                        ExternalAttendanceLineCS1.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS."Global Dimension 2 Code");
                        IF NOT ExternalAttendanceLineCS1.findfirst() THEN BEGIN
                            ExternalAttendanceLineCS1.init();
                            ExternalAttendanceLineCS1."Line No." += 10000;
                            ExternalAttendanceLineCS1."Document No." := ExternalAttendanceLineCS."Document No.";
                            ExternalAttendanceLineCS1."Global Dimension 2 Code" := ExternalAttendanceLineCS."Global Dimension 2 Code";
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
        ExternalAttendanceHeaderCS1: Record "External Attendance Header-CS";
        ExaminationLogDetailsCS2: Record "Examination Log Details-CS";
        RoomsCS: Record "Rooms-CS";
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
        ExternalAttendanceLineCS1.SETCURRENTKEY("Document No.");
        IF ExternalAttendanceLineCS1.findfirst() THEN
            REPEAT
                //MESSAGE('%1--%2',ExternalAttendanceLineCS1."Global Dimension 2 Code",ExternalAttendanceLineCS1."Document No.");
                IF DocNO <> ExternalAttendanceLineCS1."Document No." THEN BEGIN
                    i := 0;
                    RoomCap := 0;
                    "RoomNo." := '';
                    CNT := 0;
                    i += 1;
                    IF i = 1 THEN BEGIN
                        RoomsCS.Reset();
                        RoomsCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS1."Global Dimension 2 Code");
                        IF RoomsCS.findfirst() THEN BEGIN
                            RoomCap := RoomsCS."Exam Capacity";
                            "RoomNo." := RoomsCS."Room No.";
                        END;
                    END;
                END;

                DocNO := ExternalAttendanceLineCS1."Document No.";
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceLineCS1."Document No.");
                ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS1."Global Dimension 2 Code");
                IF ExternalAttendanceLineCS.findset() THEN
                    REPEAT
                        CNT += 1;
                        IF CNT <= RoomCap THEN BEGIN
                            ExternalAttendanceLineCS."Room Alloted No." := "RoomNo.";
                            ExternalAttendanceLineCS.Modify();
                        END ELSE BEGIN
                            CNT := 0;
                            RoomsCS.Reset();
                            RoomsCS.SETRANGE("Room No.", "RoomNo.");
                            IF RoomsCS.findfirst() THEN BEGIN
                                RoomsCS."Allot For Examination" := TRUE;
                                RoomsCS.Modify();
                            END;

                            "RoomNo." := '';
                            //RoomCap :=0;
                            RoomsCS.Reset();
                            RoomsCS.SETCURRENTKEY("Global Dimension 2 Code", "Room No.");
                            RoomsCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS1."Global Dimension 2 Code");
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

                        CreateLogCS(ExternalAttendanceLineCS."Exam Date", ExternalAttendanceLineCS."Exam Slot",
                                  ExternalAttendanceLineCS."Academic Year", ExternalAttendanceLineCS."Room Alloted No.");
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;
            UNTIL ExternalAttendanceLineCS1.NEXT() = 0;
    end;

    procedure CreateLogCS(ExamDate: Date; Examslot: Code[20]; AcedmicYear: Code[20]; RoomNo: Code[20])
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
    begin
        ExternalAttendanceLineCS1.Reset();
        IF ExternalAttendanceLineCS1.findfirst() THEN
            REPEAT
                RoomsCS.Reset();
                RoomsCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS1."Global Dimension 2 Code");
                IF RoomsCS.findset() THEN
                    REPEAT
                        ExaminationLogDetailsCS2.Reset();
                        ExaminationLogDetailsCS2.SETRANGE("Exam Date", ExternalAttendanceLineCS1."Exam Date");
                        ExaminationLogDetailsCS2.SETRANGE("Time Slot", ExternalAttendanceLineCS1."Exam Slot");
                        ExaminationLogDetailsCS2.SETRANGE("Room No.", RoomsCS."Room No.");
                        IF ExaminationLogDetailsCS2.findfirst() THEN
                            ERROR('Room No. %1 alloted for Exam date %2 at %3 for Course %4 Please Contact your System Administrator', RoomsCS."Room No.",
                                  ExternalAttendanceLineCS1."Exam Date", ExternalAttendanceLineCS1."Exam Slot", ExternalAttendanceLineCS1."Global Dimension 2 Code");
                    UNTIL RoomsCS.NEXT() = 0;


                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETRANGE("Document No.", ExternalAttendanceLineCS1."Document No.");
                ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS1."Global Dimension 2 Code");
                IF ExternalAttendanceLineCS.findset() THEN BEGIN
                    RoomCapity := 0;
                    RoomsCS.Reset();
                    RoomsCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS1."Global Dimension 2 Code");
                    IF RoomsCS.findset() THEN BEGIN
                        REPEAT
                            RoomCapity := RoomCapity + RoomsCS."Exam Capacity";
                        UNTIL RoomsCS.NEXT() = 0;
                        IF ExternalAttendanceLineCS.COUNT() > RoomCapity THEN
                            ERROR('No. of Student is %1 but room capacity is %2 for %3 . Please contact your System Administrator  ', ExternalAttendanceLineCS.COUNT(), RoomCapity, ExternalAttendanceLineCS1."Global Dimension 2 Code")
                    END ELSE
                        ERROR('Department not mapped with Room!!');
                END;
            UNTIL ExternalAttendanceLineCS1.NEXT() = 0;
    end;
}

