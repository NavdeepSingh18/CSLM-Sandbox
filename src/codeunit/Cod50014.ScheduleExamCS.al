codeunit 50014 "Schedule Exam -CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   15/02/2019     AdmitCrdAllotmentGenration()-Function       Code added for admit card genration.


    trigger OnRun()
    begin
    end;

    var
        Text000Lbl: Label 'Halls are not available';
        Text001Lbl: Label 'Process completed';
        Text002Lbl: Label 'Hall Allotment Already Done,Do you want to update';

    procedure AdmitCrdAllotmentGenration("DocNo.": Code[20])
    var
        ExamTimeTableHistoryCS: Record "Exam Time Table History-CS";
        ExamTimeTableHeadCS: Record "Exam Time Table Head-CS";
        ExamTimeTableLineCS: Record "Exam Time Table Line-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        AcademicsSetupCS: Record "Academics Setup-CS";
        HallMaster: Record "Confrance Hall-CS";
        ExamTimeTableHistoryCS1: Record "Exam Time Table History-CS";
        ConfranceHallCS: Record "Confrance Hall-CS";
        IntHistory: Integer;
        IntHallCapacity: Integer;
    // IntAllotedSeats: Integer;

    begin
        //Code added for admit card genration::CSPL-00059::15022019: Start
        AcademicsSetupCS.FINDFIRST();
        ExamTimeTableHistoryCS.Reset();
        ExamTimeTableHistoryCS.SETRANGE("Exam Schedule No.", "DocNo.");
        IF ExamTimeTableHistoryCS.FINDFIRST() THEN
            IF CONFIRM(Text002Lbl, FALSE) THEN
                ExamTimeTableHistoryCS.DELETEALL()
            ELSE
                EXIT;
        ExamTimeTableHeadCS.GET("DocNo.");
        ExamTimeTableHistoryCS.Reset();
        IF ExamTimeTableHistoryCS.FINDLAST() THEN
            IntHistory := ExamTimeTableHistoryCS."No."
        ELSE
            IntHistory := 0;

        IF (ExamTimeTableHeadCS."Exam Type" = ExamTimeTableHeadCS."Exam Type"::External) OR (ExamTimeTableHeadCS."Exam Type" = ExamTimeTableHeadCS."Exam Type"::Internal) THEN BEGIN
            HallMaster.Reset();
            IF HallMaster.FINDFIRST() THEN
                HallMaster.MODIFYALL(Filled, FALSE);

            ExamTimeTableLineCS.Reset();
            ExamTimeTableLineCS.SETRANGE("Document No.", "DocNo.");
            IF ExamTimeTableLineCS.FINDSET() THEN
                REPEAT
                    IF ExamTimeTableLineCS."Subject Type" = AcademicsSetupCS."Common Subject Type" THEN BEGIN
                        AdmitCardLineCS.Reset();
                        AdmitCardLineCS.SETRANGE("Academic Year", ExamTimeTableLineCS."Academic Year");
                        AdmitCardLineCS.SETRANGE("Subject Type", AcademicsSetupCS."Common Subject Type");
                        AdmitCardLineCS.SETRANGE(Course, ExamTimeTableLineCS."Course Code");
                        AdmitCardLineCS.SETRANGE("Subject Code", ExamTimeTableLineCS."Subject Code");
                    END ELSE
                        IF ExamTimeTableLineCS."Subject Type" = AcademicsSetupCS."CBCS Subject Type" THEN BEGIN
                            AdmitCardLineCS.Reset();
                            AdmitCardLineCS.SETRANGE("Academic Year", ExamTimeTableLineCS."Academic Year");
                            AdmitCardLineCS.SETRANGE("Subject Type", AcademicsSetupCS."CBCS Subject Type");
                            AdmitCardLineCS.SETRANGE("Subject Code", ExamTimeTableLineCS."Subject Code");
                        END;
                    AdmitCardLineCS.SETRANGE("Result Generated", FALSE);
                    IF AdmitCardLineCS.FINDSET() THEN
                        REPEAT
                            HallMaster.Reset();
                            HallMaster.SETRANGE(Filled, FALSE);
                            IF HallMaster.FINDFIRST() THEN BEGIN
                                ExamTimeTableHistoryCS.INIT();
                                ExamTimeTableHistoryCS."No." := IntHistory + 1;
                                ExamTimeTableHistoryCS."Exam Date" := ExamTimeTableHeadCS.Date;
                                ExamTimeTableHistoryCS."Course Code" := ExamTimeTableLineCS."Course Code";
                                ExamTimeTableHistoryCS."Semester Code" := ExamTimeTableLineCS."Semester Code";
                                ExamTimeTableHistoryCS."Subject Type" := ExamTimeTableLineCS."Subject Type";
                                ExamTimeTableHistoryCS."Subject Code" := ExamTimeTableLineCS."Subject Code";
                                ExamTimeTableHistoryCS."Student No." := AdmitCardLineCS."Student No.";
                                ExamTimeTableHistoryCS."Hall Code" := HallMaster."Hall Code";
                                ExamTimeTableHistoryCS."Exam Type" := ExamTimeTableHeadCS."Exam Type";
                                ExamTimeTableHistoryCS."Exam Slot" := ExamTimeTableHeadCS."Exam Slot";
                                ExamTimeTableHistoryCS."Exam Method" := ExamTimeTableHeadCS."Exam Method";
                                ExamTimeTableHistoryCS."Exam Schedule No." := "DocNo.";
                                ExamTimeTableHistoryCS."Academic Year" := ExamTimeTableHeadCS."Academic Year";
                                ExamTimeTableHistoryCS.INSERT();
                                IntHistory += 1;
                            END ELSE
                                ERROR(Text000Lbl);
                            IntHallCapacity := HallMaster.Capacity;

                            ExamTimeTableHistoryCS1.Reset();

                            ExamTimeTableHistoryCS1.SETRANGE("Exam Date", ExamTimeTableHeadCS.Date);
                            ExamTimeTableHistoryCS1.SETRANGE("Hall Code", HallMaster."Hall Code");
                            ExamTimeTableHistoryCS1.SETRANGE("Exam Slot", ExamTimeTableHeadCS."Exam Slot");
                            IF ExamTimeTableHistoryCS1.COUNT() >= IntHallCapacity THEN
                                IF ConfranceHallCS.GET(HallMaster."Hall Code") THEN BEGIN
                                    ConfranceHallCS.Filled := TRUE;
                                    ConfranceHallCS.MODIFY();
                                END;
                        UNTIL AdmitCardLineCS.NEXT() = 0;
                UNTIL ExamTimeTableLineCS.NEXT() = 0;
            MESSAGE(Text001Lbl);
        END;
        //Code added for admit card genration::CSPL-00059::15022019: End
    end;
}

