report 50155 "Sitting PlanCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Sitting PlanCS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                ExternalAttendanceLineCS.Reset();
                ExternalAttendanceLineCS.SETCURRENTKEY("Exam Schedule No.", "Global Dimension 2 Code", "Subject Code");
                ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", SchedulNo);
                IF ExternalAttendanceLineCS.findset() THEN
                    REPEAT
                        ExternalAttendanceLineCS1.Reset();
                        ExternalAttendanceLineCS1.SETRANGE("Document No.", ExternalAttendanceLineCS."Global Dimension 2 Code");
                        ExternalAttendanceLineCS1.SETRANGE("Subject Code", ExternalAttendanceLineCS."Subject Code");
                        IF NOT ExternalAttendanceLineCS1.findfirst() THEN BEGIN
                            LineNo += 1000;
                            ExternalAttendanceLineCS1.init();
                            ExternalAttendanceLineCS1."Document No." := ExternalAttendanceLineCS."Global Dimension 2 Code";
                            ExternalAttendanceLineCS1."Line No." := LineNo;
                            ExternalAttendanceLineCS1."Subject Code" := ExternalAttendanceLineCS."Subject Code";
                            ExternalAttendanceLineCS1.Insert();

                            ExternalAttendanceLineCS2.init();
                            ExternalAttendanceLineCS2."Document No." := ExternalAttendanceLineCS."Global Dimension 2 Code";
                            ExternalAttendanceLineCS2."Line No." := LineNo;
                            ExternalAttendanceLineCS2."Subject Code" := ExternalAttendanceLineCS."Subject Code";
                            ExternalAttendanceLineCS2.Insert();
                        END
                    UNTIL ExternalAttendanceLineCS.NEXT() = 0;

                //
                RoomSittingCS();
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(General)
                {
                    field("Schedule No"; SchedulNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Schedule No.';
                        ToolTip = 'Schedule No. may have a value';
                        TableRelation = "Exam Time Table Head-CS"."No." WHERE("Ext Exam Attendance No." = FILTER(<> ''));
                    }
                }
            }
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
        ExternalAttendanceLineCS1: Record "External Attendance Line-CS" temporary;
        ExternalAttendanceLineCS2: Record "External Attendance Line-CS" temporary;
        RoomsCS: Record "Rooms-CS";
        ExaminationLogDetailsCS: Record "Examination Log Details-CS";
        ExaminationLogDetailsCS1: Record "Examination Log Details-CS";
        SchedulNo: Code[20];
        DepartCode: Code[20];
        LineNo: Integer;
        "RoomNo.": Code[20];
        RoomCap: Integer;
        CNT: Integer;
        i: Integer;

        Entryno: Integer;


    local procedure RoomSittingCS()
    begin
        ExternalAttendanceLineCS.Reset();
        IF ExternalAttendanceLineCS.findfirst() THEN
            REPEAT
                IF DepartCode <> ExternalAttendanceLineCS."Document No." THEN BEGIN
                    // i :=0;
                    //RoomCap:= 0;
                    //"RoomNo." := '';
                    i += 1;
                    IF i = 1 THEN BEGIN
                        RoomsCS.Reset();
                        RoomsCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS."Document No.");
                        IF RoomsCS.findfirst() THEN BEGIN
                            RoomCap := RoomsCS."Exam Capacity";
                            "RoomNo." := RoomsCS."Room No.";
                        END;
                        IF RoomCap = 0 THEN
                            ERROR('There is no capacity for %1 department ', ExternalAttendanceLineCS."Document No.")

                    END;

                    ExternalAttendanceLineCS2.Reset();
                    ExternalAttendanceLineCS2.SETRANGE("Document No.", ExternalAttendanceLineCS1."Document No.");
                    IF ExternalAttendanceLineCS2.findfirst() THEN
                        REPEAT
                            //CNT :=0;
                            ExternalAttendanceLineCS.Reset();
                            ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", SchedulNo);
                            ExternalAttendanceLineCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS2."Document No.");
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
                                        // RoomsCS.SETRANGE("Global Dimension 2 Code",ExternalAttendanceLineCS2."Document No.");
                                        RoomsCS.SETRANGE("Room No.", "RoomNo.");
                                        IF RoomsCS.findfirst() THEN BEGIN
                                            RoomsCS."Allot For Examination" := TRUE;
                                            RoomsCS.Modify();
                                        END;
                                        "RoomNo." := '';
                                        // RoomCap :=0;
                                        RoomsCS.Reset();
                                        RoomsCS.SETCURRENTKEY("Global Dimension 2 Code", "Room No.");
                                        RoomsCS.SETRANGE("Global Dimension 2 Code", ExternalAttendanceLineCS2."Document No.");
                                        RoomsCS.SETRANGE("Allot For Examination", FALSE);
                                        IF RoomsCS.findfirst() THEN BEGIN
                                            "RoomNo." := RoomsCS."Room No.";
                                            RoomCap := RoomsCS."Exam Capacity";
                                        END;
                                        ExternalAttendanceLineCS."Room Alloted No." := "RoomNo.";
                                        ExternalAttendanceLineCS.Modify();
                                        CNT += 1;
                                        //  CreateLog
                                    END;
                                UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                        UNTIL ExternalAttendanceLineCS2.NEXT() = 0;
                END;
                DepartCode := ExternalAttendanceLineCS."Document No.";
            UNTIL ExternalAttendanceLineCS.NEXT() = 0;
    end;

    local procedure CreateLogCS()
    begin
        ExaminationLogDetailsCS1.Reset();
        IF ExaminationLogDetailsCS1.Findlast() THEN
            Entryno := ExaminationLogDetailsCS1."Entry No" + 1
        ELSE
            Entryno := 1;

        ExaminationLogDetailsCS.init();
        ExaminationLogDetailsCS."Entry No" := Entryno;
        ExaminationLogDetailsCS."Exam Date" := ExternalAttendanceLineCS."Exam Date";
        ExaminationLogDetailsCS."Time Slot" := ExternalAttendanceLineCS."Exam Slot";
        ExaminationLogDetailsCS."Room No." := "RoomNo.";
        ExaminationLogDetailsCS.Insert();
    end;
}

