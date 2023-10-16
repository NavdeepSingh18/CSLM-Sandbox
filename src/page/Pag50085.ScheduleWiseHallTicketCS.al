page 50085 "Schedule Wise Hall Ticket-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  16-04-19   Function-HallTicketGeneartion()  Code added for Hall Ticket Generation.
    // 02.   CSPL-00174  16-04-19   Execute - OnAction()             Code added for Validation with Call the Function.
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            field("Exam Schedule No"; ExamScheduleNo)
            {
                TableRelation = "Exam Time Table Head-CS"."No.";
                ApplicationArea = All;
                Caption = 'Exam Schedule No';
            }
            field("Institute Code"; InstituteCode)
            {
                Caption = 'Institute Code';
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('INSTITUTE'));
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Execute)
            {
                Image = ExecuteBatch;
                Promoted = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    //Code added for Validation with Call the Function:CSPL-00174::160419: Start
                    IF ExamScheduleNo = '' THEN
                        ERROR('Exam Schedule No. Should Have Value !!');
                    IF InstituteCode = '' THEN
                        ERROR('Institute Code Should Have Value !!');
                    IF NOT CONFIRM(Text0001Lbl) THEN
                        EXIT
                    ELSE
                        HallTicketGeneartion(ExamScheduleNo, InstituteCode);
                    CurrPage.Close();
                    //Code added for Validation with Call the Function:CSPL-00174::160419: End
                end;
            }
        }
    }

    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        ExternalAttendanceLineCS: Record "External Attendance Line-CS";
        NoSeries: Record "No. Series Line";
        ExternalAttendanceLineCS2: Record "External Attendance Line-CS";

        EducationSetupCS: Record "Education Setup-CS";

        AdmitCardHeaderCS: Record "Admit Card Header-CS";
        AdmitCardLineCS: Record "Admit Card Line-CS";
        StudentMasterCS: Record "Student Master-CS";
        AdmitCardHeaderCS2: Record "Admit Card Header-CS";
        ExamScheduleNo: Code[20];
        Text0001Lbl: Label 'Do you want to Generate the Hall Ticket?';
        InstituteCode: Code[20];
        Studentno: Code[20];
        Docno: Code[20];

        Lineno: Integer;
        NoofHallTicket: Integer;


    procedure HallTicketGeneartion(ExamScheduleNo: Code[20]; InstituteCodeValue: Code[20])
    var
        SubjectClassificationCS: Record "Subject Classification-CS";
        Counter: Integer;
        TotalCount: Integer;
        PROGRESS: Dialog;
        Text_10001Lbl: Label ' UPLOADING... #1  Out Of  @2 .';

    begin
        //Code added for Students Hall Ticket Generation::CSPL-00174::160419: Start
        EducationSetupCS.Reset();
        EducationSetupCS.SETRANGE("Global Dimension 1 Code", InstituteCodeValue);
        IF NOT EducationSetupCS.FINDFIRST() THEN
            ERROR('Education Setup For Institute Code %1 Not Defined !!');
        AcademicsSetupCS.GET();
        NoofHallTicket := 0;
        AdmitCardHeaderCS2.Reset();
        AdmitCardHeaderCS2.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        AdmitCardHeaderCS2.SETRANGE("Global Dimension 1 Code", EducationSetupCS."Global Dimension 1 Code");
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            AdmitCardHeaderCS2.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                AdmitCardHeaderCS2.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        AdmitCardHeaderCS2.SETRANGE("Exam Schedule No.", ExamScheduleNo);
        IF AdmitCardHeaderCS2.FINDSET() THEN
            ERROR('Hall Ticket Entry Already Generated !!');

        ExternalAttendanceLineCS2.Reset();
        ExternalAttendanceLineCS2.SETCURRENTKEY("Student No.");
        ExternalAttendanceLineCS2.SETRANGE("Exam Schedule No.", ExamScheduleNo);
        ExternalAttendanceLineCS2.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
        ExternalAttendanceLineCS2.SETRANGE("Attendance Not Applicable", FALSE);
        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN
            ExternalAttendanceLineCS2.SETFILTER(Semester, '%1|%2|%3|%4', 'II', 'IV', 'VI', 'VIII')
        ELSE
            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN
                ExternalAttendanceLineCS2.SETFILTER(Semester, '%1|%2|%3|%4', 'I', 'III', 'V', 'VII');
        ExternalAttendanceLineCS2.SETFILTER("Hall Ticket No.", '%1', '');
        ExternalAttendanceLineCS2.SETRANGE("Subject Class", 'THEORY');
        IF ExternalAttendanceLineCS2.FINDSET() THEN BEGIN
            TotalCount := ExternalAttendanceLineCS2.count();
            PROGRESS.OPEN(Text_10001Lbl);
            REPEAT
                Counter := Counter + 1;
                PROGRESS.UPDATE(1, Counter);
                PROGRESS.UPDATE(2, ROUND(Counter / TotalCount * 10000, 1));

                SubjectClassificationCS.Reset();
                SubjectClassificationCS.SETRANGE(Code, ExternalAttendanceLineCS2."Subject Class");
                SubjectClassificationCS.SETRANGE("Hall Ticket", TRUE);
                IF SubjectClassificationCS.FINDFIRST() THEN
                    IF Studentno <> ExternalAttendanceLineCS2."Student No." THEN BEGIN
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETCURRENTKEY("No.");
                        StudentMasterCS.SETRANGE("No.", ExternalAttendanceLineCS2."Student No.");
                        StudentMasterCS.SETFILTER("Student Status", '%1|%2|%3|%4', StudentMasterCS."Student Status"::Student,
                                      StudentMasterCS."Student Status"::Casual, StudentMasterCS."Student Status"::"Reject & Rejoin", StudentMasterCS."Student Status"::"NFT-Extended");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            NoSeries.Reset();
                            NoSeries.SETRANGE(NoSeries."Series Code", AcademicsSetupCS."Hall Ticket Entry No.");
                            IF NoSeries.FINDFIRST() THEN
                                IF NoSeries."Last No. Used" <> '' THEN
                                    Docno := INCSTR(NoSeries."Last No. Used")
                                ELSE
                                    Docno := INCSTR(NoSeries."Starting No.");

                            NoofHallTicket := NoofHallTicket + 1;
                            AdmitCardHeaderCS.INIT();
                            AdmitCardHeaderCS."No." := Docno;
                            AdmitCardHeaderCS.VALIDATE("Student No.", StudentMasterCS."No.");
                            AdmitCardHeaderCS."Course Code" := StudentMasterCS."Course Code";
                            AdmitCardHeaderCS."Type Of Course" := StudentMasterCS."Type Of Course";
                            AdmitCardHeaderCS."Program" := StudentMasterCS.Graduation;
                            AdmitCardHeaderCS."Academic Year" := EducationSetupCS."Academic Year";
                            AdmitCardHeaderCS.Semester := StudentMasterCS.Semester;
                            AdmitCardHeaderCS.Year := StudentMasterCS.Year;
                            AdmitCardHeaderCS.Section := StudentMasterCS.Section;
                            AdmitCardHeaderCS."Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                            AdmitCardHeaderCS."Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                            AdmitCardHeaderCS."Receipt No." := '';
                            AdmitCardHeaderCS."Result Generated" := FALSE;
                            AdmitCardHeaderCS."Exam Schedule No." := ExternalAttendanceLineCS2."Exam Schedule No.";
                            AdmitCardHeaderCS."User ID" := COPYSTR(USERID(), 1, 20);
                            AdmitCardHeaderCS."Created By" := FORMAT(UserId());
                            AdmitCardHeaderCS."Created On" := TODAY();
                            AdmitCardHeaderCS.INSERT();

                            ExternalAttendanceLineCS.Reset();
                            ExternalAttendanceLineCS.SETCURRENTKEY("Student No.");
                            ExternalAttendanceLineCS.SETRANGE("Exam Schedule No.", ExamScheduleNo);
                            ExternalAttendanceLineCS.SETRANGE("Student No.", ExternalAttendanceLineCS2."Student No.");
                            ExternalAttendanceLineCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                            ExternalAttendanceLineCS.SETFILTER("Hall Ticket No.", '%1', '');
                            ExternalAttendanceLineCS.SETRANGE("Subject Class", 'THEORY');
                            IF ExternalAttendanceLineCS.FINDSET() THEN
                                REPEAT
                                    AdmitCardLineCS.Reset();
                                    AdmitCardLineCS.SETCURRENTKEY("Document No.");
                                    AdmitCardLineCS.SETRANGE("Document No.", Docno);
                                    IF AdmitCardLineCS.FINDLAST() THEN
                                        Lineno := AdmitCardLineCS."Line No." + 10000
                                    ELSE
                                        Lineno := 10000;
                                    AdmitCardLineCS.INIT();
                                    AdmitCardLineCS."Document No." := Docno;
                                    AdmitCardLineCS."Line No." := Lineno;
                                    AdmitCardLineCS.VALIDATE("Student No.", ExternalAttendanceLineCS."Student No.");
                                    AdmitCardLineCS.Course := ExternalAttendanceLineCS.Course;
                                    AdmitCardLineCS."Type Of Course" := ExternalAttendanceLineCS."Type Of Course";
                                    AdmitCardLineCS."Program" := ExternalAttendanceLineCS."Program";
                                    AdmitCardLineCS."Academic Year" := ExternalAttendanceLineCS."Academic Year";
                                    AdmitCardLineCS.Semester := ExternalAttendanceLineCS.Semester;
                                    AdmitCardLineCS.Year := ExternalAttendanceLineCS.Year;
                                    AdmitCardLineCS.Section := ExternalAttendanceLineCS.Section;
                                    AdmitCardLineCS."Global Dimension 1 Code" := ExternalAttendanceLineCS."Global Dimension 1 Code";
                                    AdmitCardLineCS."Global Dimension 2 Code" := ExternalAttendanceLineCS."Global Dimension 2 Code";
                                    AdmitCardLineCS."Subject Class" := ExternalAttendanceLineCS."Subject Class";
                                    AdmitCardLineCS.VALIDATE("Subject Type", ExternalAttendanceLineCS."Subject Type");
                                    AdmitCardLineCS.VALIDATE("Subject Code", ExternalAttendanceLineCS."Subject Code");
                                    AdmitCardLineCS."Apply Type" := ExternalAttendanceLineCS."Exam Type";
                                    AdmitCardLineCS."Time Slot" := ExternalAttendanceLineCS."Exam Slot";
                                    AdmitCardLineCS.Date := ExternalAttendanceLineCS."Exam Date";
                                    AdmitCardLineCS."Actual Per%" := ExternalAttendanceLineCS."Attendance %";
                                    AdmitCardLineCS."Applicable Per %" := ExternalAttendanceLineCS."Applicable Att Per%";
                                    AdmitCardLineCS.Detained := ExternalAttendanceLineCS.Detained;
                                    AdmitCardLineCS."Exam Schedule No." := ExternalAttendanceLineCS."Exam Schedule No.";
                                    ExternalAttendanceLineCS."Hall Ticket No." := Docno;
                                    ExternalAttendanceLineCS.Modify();
                                    AdmitCardLineCS.INSERT();
                                UNTIL ExternalAttendanceLineCS.NEXT() = 0;
                            NoSeries.Reset();
                            NoSeries.SETRANGE(NoSeries."Series Code", AcademicsSetupCS."Hall Ticket Entry No.");
                            IF NoSeries.FINDFIRST() THEN BEGIN
                                NoSeries."Last No. Used" := Docno;
                                NoSeries.Modify();
                            END;
                            Studentno := ExternalAttendanceLineCS2."Student No.";
                        END;
                    END;

            UNTIL ExternalAttendanceLineCS2.NEXT() = 0
        END ELSE
            ERROR('Student Ext. Exam Attn. Line Not Exist !!');
        PROGRESS.Close();
        MESSAGE('%1 Hall ticket generated..', NoofHallTicket);
        // Code added for Students Hall Ticket Generation::CSPL-00174::160419: End
    end;
}