codeunit 50045 "Leave of Absence Automation"
{
    trigger OnRun()
    begin
        SetStudentStatusforStartDate();
        SetStudentStatusforEndDate();
        // UpdateCLNDoccumentStatusExpired();//CSPL-00307-11-01-23 
        PGR_Automation();//CSPL-00307 21-07-2022
        SLOA_StatusChangeLog();//CSPL-00307 
    end;

    procedure SetStudentStatusforStartDate()
    var
        StudentMaster: Record "Student Master-CS";
        Studentleaveofabsence: Record "Student Leave of Absence";
        //entryno: Integer;
        studentstatus: Code[20];
    begin
        Studentleaveofabsence.reset();
        Studentleaveofabsence.SetRange("Leave Types", Studentleaveofabsence."Leave Types"::CLOA);
        Studentleaveofabsence.setrange(Status, Studentleaveofabsence.Status::Approved);
        Studentleaveofabsence.SetFilter("Start Date", '<=%1', Today);
        Studentleaveofabsence.SetFilter("End Date", '>=%1', Today);
        Studentleaveofabsence.setrange(CLOA_Start_Log_Created, False);
        if Studentleaveofabsence.FindSet() then
            repeat
                studentstatus := '';
                StudentMaster.Get(Studentleaveofabsence."Student No.");
                if (StudentMaster.Status <> 'CLOA') then begin
                    studentstatus := StudentMaster.status;
                    StudentMaster.Validate(Status, 'CLOA');
                    //entryno := studentmaster.exittimelineentryNo();
                    StudentMaster.Modify(true);
                    //updatestudenttimeline(entryno);
                    Studentleaveofabsence."Last Student Status Updated" := studentstatus;
                    Studentleaveofabsence.CLOA_Start_Log_Created := True;
                    Studentleaveofabsence.Modify();
                end;
            until Studentleaveofabsence.next() = 0;
    end;

    procedure SetStudentStatusforEndDate()
    var
        StudentMaster: Record "Student Master-CS";
        Studentleaveofabsence: Record "Student Leave of Absence";
    //entryno: Integer;
    //studentstatus: Code[20];
    begin
        //studentstatus := '';
        Studentleaveofabsence.reset();
        Studentleaveofabsence.SetRange("Leave Types", Studentleaveofabsence."Leave Types"::CLOA);
        Studentleaveofabsence.setrange(Status, Studentleaveofabsence.Status::Approved);
        Studentleaveofabsence.SetFilter("End Date", '<%1', Today);
        Studentleaveofabsence.setrange(CLOA_End_Log_Created, False);
        if Studentleaveofabsence.FindSet() then
            repeat
                //studentstatus := '';
                StudentMaster.Get(Studentleaveofabsence."Student No.");
                if StudentMaster.Status = 'CLOA' then begin
                    if (Studentleaveofabsence."Last Student Status Updated" <> '') then begin
                        //studentstatus := StudentMaster.status;
                        if Studentleaveofabsence."Last Student Status Updated" in ['TWD'] then
                            StudentMaster.Validate(Status, 'ATT')
                        else
                            if Studentleaveofabsence."Last Student Status Updated" <> 'CLOA' then
                                StudentMaster.Validate(Status, Studentleaveofabsence."Last Student Status Updated");
                        //entryno := studentmaster.exittimelineentryNo();
                        StudentMaster.Modify(true);
                        //updatestudenttimeline(entryno);
                        //Studentleaveofabsence."Last Student Status Updated" := studentstatus;
                        Studentleaveofabsence.CLOA_End_Log_Created := True;
                        Studentleaveofabsence.Modify();
                    end;
                end;
            until Studentleaveofabsence.next() = 0;
    end;

    procedure updatestudenttimeline(entryno: Integer)
    var
        studenttimeline: Record "Student Time Line";
    begin
        studenttimeline.Reset();
        studenttimeline.SetRange("Entry No.", entryno);
        if studenttimeline.FindFirst() then begin
            studenttimeline."Created By" := 'Automation';
            studenttimeline.Modify();
        end

    end;

    procedure UpdateCLNDoccumentStatusExpired() //CSPL-00307 - 
    var
        StudentDocAttachment: record "Student Document Attachment";
    begin
        StudentDocAttachment.Reset();
        StudentDocAttachment.SetCurrentKey("Entry No.");
        StudentDocAttachment.SetFilter("Document Category", 'CLINICAL');
        StudentDocAttachment.SetFilter("SLcM Document No", 'CLINICAL_DOCUMENTS');
        StudentDocAttachment.SetFilter("Document Status", '<>%1', StudentDocAttachment."Document Status"::Expired);
        StudentDocAttachment.SetFilter("Expiry Date", '<>0D');
        StudentDocAttachment.SetAscending("Entry No.", false);
        if StudentDocAttachment.FindSet(True) then
            repeat
                IF StudentDocAttachment."Expiry Date" < workdate() then begin
                    StudentDocAttachment."Document Status" := StudentDocAttachment."Document Status"::Expired;
                    StudentDocAttachment.Modify();
                end;
            until StudentDocAttachment.Next() = 0;
    end;

    procedure SLOA_StatusChangeLog()
    var
        RecSLOA: Record "Student Leave of Absence";
        StatusChangeLog: Record "Status Change Log entry";
        // StatusChangeLog2: Record "Status Change Log entry";
        RecStudent: Record "Student Master-CS";
        EffectiveDate: Date;
        CuttOffDate: Date;
        StatusSLOA: Boolean;
        StatusReverse: Boolean;
    begin
        //CSPL-00307-SLOA_Change
        CuttOffDate := 20230505D;
        RecSLOA.Reset();
        RecSLOA.SetRange("Leave Types", RecSLOA."Leave Types"::SLOA);
        RecSLOA.SetRange(Status, RecSLOA.Status::Approved);
        RecSLOA.Setfilter("Approved On", '>=%1', CuttOffDate);
        RecSLOA.SetRange(LogComplete, false);
        If RecSLOA.FindSet() then
            repeat
                Clear(StatusReverse);
                Clear(StatusSLOA);
                StatusChangeLog.Reset();
                StatusChangeLog.SetRange("Application No", RecSLOA."Application No.");
                if StatusChangeLog.FindSet() then begin
                    if StatusChangeLog.Count = 1 then
                        StatusSLOA := true;
                    if StatusChangeLog.Count > 1 then begin
                        StatusReverse := true;
                        RecSLOA.LogComplete := true;
                        RecSLOA.Modify();
                    end;
                end;
                IF StatusReverse = false then begin
                    StatusChangeLog.Reset();
                    StatusChangeLog.SetCurrentKey("Student No.", "Effective Date");
                    StatusChangeLog.SetRange("Student No.", RecSLOA."Student No.");
                    IF RecSLOA."Approved On" IN [RecSLOA."Start Date" .. RecSLOA."End Date"] then
                        StatusChangeLog.SetFilter("Effective Date", '<=%1', RecSLOA."Approved On")
                    else
                        StatusChangeLog.SetFilter("Effective Date", '<=%1', RecSLOA."Start Date");
                    If StatusChangeLog.FindLast() then begin
                        RecStudent.Reset();
                        IF RecStudent.Get(RecSLOA."Student No.") then;

                        IF (RecSLOA."Start Date" < RecSLOA."Approved On") AND (RecSLOA."End Date" < RecSLOA."Approved On") then begin
                            IF StatusSLOA = false then begin
                                EffectiveDate := RecSLOA."Start Date";
                                InsertStatusChangeLog(RecStudent."No.", RecStudent."Student Name", StatusChangeLog."Status change to", 'SLOA', UserId(), Today(), RecStudent.Reason, RecStudent."Reason Description", '', RecStudent."NSLDS Withdrawal Date", RecStudent."Date Of Determination", RecStudent.LDA, EffectiveDate, Today(), RecStudent."Dismissal Date", RecSLOA."Application No.");
                                EffectiveDate := RecSLOA."End Date";
                                InsertStatusChangeLog(RecStudent."No.", RecStudent."Student Name", 'SLOA', StatusChangeLog."Status change to", UserId(), Today(), RecStudent.Reason, RecStudent."Reason Description", '', RecStudent."NSLDS Withdrawal Date", RecStudent."Date Of Determination", RecStudent.LDA, EffectiveDate, Today(), RecStudent."Dismissal Date", RecSLOA."Application No.");
                            end;
                        end else
                            IF (RecSLOA."Start Date" < RecSLOA."Approved On") AND (RecSLOA."End Date" >= RecSLOA."Approved On") then begin
                                EffectiveDate := RecSLOA."Start Date";
                                IF StatusSLOA = false then begin
                                    InsertStatusChangeLog(RecStudent."No.", RecStudent."Student Name", StatusChangeLog."Status change to", 'SLOA', UserId(), Today(), RecStudent.Reason, RecStudent."Reason Description", '', RecStudent."NSLDS Withdrawal Date", RecStudent."Date Of Determination", RecStudent.LDA, EffectiveDate, Today(), RecStudent."Dismissal Date", RecSLOA."Application No.");
                                    RecStudent.Status := 'SLOA';
                                    RecStudent.Modify();
                                    StatusSLOA := true;
                                end;
                            end;
                    end;

                    IF RecSLOA."Start Date" = Today then begin
                        EffectiveDate := RecSLOA."Start Date";
                        IF StatusSLOA = false then begin
                            IF RecStudent.Status <> 'SLOA' then begin
                                InsertStatusChangeLog(RecStudent."No.", RecStudent."Student Name", RecStudent.Status, 'SLOA', UserId(), Today(), RecStudent.Reason, RecStudent."Reason Description", '', RecStudent."NSLDS Withdrawal Date", RecStudent."Date Of Determination", RecStudent.LDA, EffectiveDate, Today(), RecStudent."Dismissal Date", RecSLOA."Application No.");
                                RecStudent.Status := 'SLOA';
                                RecStudent.Modify();
                            end;
                        end;
                    end;
                    StatusChangeLog.Reset();
                    StatusChangeLog.SetRange("Application No", RecSLOA."Application No.");
                    IF StatusChangeLog.FindLast() then begin
                        If StatusChangeLog.Count = 1 then
                            IF RecSLOA."End Date" < Today then begin
                                EffectiveDate := RecSLOA."End Date";
                                IF RecStudent.Status <> StatusChangeLog."Status change From" then begin
                                    InsertStatusChangeLog(RecStudent."No.", RecStudent."Student Name", 'SLOA', StatusChangeLog."Status change From", UserId(), Today(), RecStudent.Reason, RecStudent."Reason Description", '', RecStudent."NSLDS Withdrawal Date", RecStudent."Date Of Determination", RecStudent.LDA, EffectiveDate, Today(), RecStudent."Dismissal Date", RecSLOA."Application No.");
                                    RecStudent.Status := StatusChangeLog."Status change From";
                                    RecStudent.Modify();
                                end;
                            end;
                    end;

                end;
                Commit();
            until RecSLOA.Next() = 0;
    end;

    Procedure InsertStatusChangeLog(StudNOPara: Code[20]; StudNamePara: Text[80]; StatusChangeFromPara: Code[20]; StatusChangeToPara: Code[20]; ModifiedByPara: Code[50]; ModifiedOnPara: Date;
 ReasonCode: Code[10]; ReasonDesc: Text[2048]; Comment: Text[255]; NSDLWithdrawalDate: Date; DateofDetermination: Date; LastDateofAttendance: Date; EffectiveDate: Date; BeginDate: Date; DismissalDate: Date; ApplicationNo: Code[20])
    var
        StatusChangeLog: Record "Status Change Log entry";
        StatusChangeLog1: Record "Status Change Log entry";
    begin
        StatusChangeLog1.Reset();
        IF StatusChangeLog1.FindLast() then;

        StatusChangeLog.Init();
        StatusChangeLog.Validate("Student No.", StudNOPara);
        StatusChangeLog.Validate("Student Name", StudNamePara);
        StatusChangeLog.Validate("Status change From", StatusChangeFromPara);
        StatusChangeLog.Validate("Status change to", StatusChangeToPara);
        StatusChangeLog.Validate("Modified By", ModifiedByPara);
        StatusChangeLog.Validate("Modified on", ModifiedOnPara);
        StatusChangeLog.Validate("Reason Code", ReasonCode);
        StatusChangeLog.Validate("Reason Description", ReasonDesc);
        StatusChangeLog.Validate(Comment, Comment);
        StatusChangeLog.Validate("NSLDS Withdrawal Date", NSDLWithdrawalDate);
        StatusChangeLog.Validate("Date Of Determination", DateofDetermination);
        StatusChangeLog.Validate("Last Date Of Attendance", LastDateofAttendance);
        StatusChangeLog.Validate("Begin Date", BeginDate);
        StatusChangeLog.Validate("Effective Date", EffectiveDate);
        StatusChangeLog.Validate("Dismissal Date", DismissalDate);
        StatusChangeLog."Entry No" := StatusChangeLog1."Entry No" + 1;
        StatusChangeLog."Application No" := ApplicationNo;
        StatusChangeLog.Insert();
    end;

    procedure PGR_Automation()
    var
        RecStudentMaster: Record "Student Master-CS";
        StatusChangeLogEntry: Record "Status Change Log entry";
        StudentStatusRec: Record "Student Status";
        StudentTimeLine: Record "Student Time Line";
        RosterSchedulingLineRec: Record "Roster Scheduling Line";
        StudentSubjectExams: Record "Student Subject Exam";
        WebServiceFn: Codeunit WebServicesFunctionsCSL;
        SLcM_TO_SalesForce: Codeunit SLcMToSalesforce;
        OldStatus: Code[20];
        TotalWeeks: Integer;
        ClinicalCurriculumInt: Integer;
        ClinicalCurriculumTxt: Text;
        NSLDSwithdrawaldate: Date;
        LDA: Date;
    begin
        IF Date2DWY(WorkDate(), 1) = 1 then begin
            RecStudentMaster.Reset();
            RecStudentMaster.SetFilter("Global Dimension 1 Code", '9000');
            RecStudentMaster.SetFilter(UsmleID, '<>%1', '');
            RecStudentMaster.SetFilter(Status, '<>PGR');
            IF RecStudentMaster.FindSet() then begin
                repeat
                    if StudentStatusRec.Get(RecStudentMaster.Status, RecStudentMaster."Global Dimension 1 Code") then begin

                        if NOT (StudentStatusRec.Status in [StudentStatusRec.Status::Deferred, StudentStatusRec.Status::Declined,
                        StudentStatusRec.Status::Suspension, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                        StudentStatusRec.Status::Deceased, StudentStatusRec.Status::Graduated, StudentStatusRec.Status::TOPROG
                        , StudentStatusRec.Status::"Re-Entry", StudentStatusRec.Status::"Re-Admitted"]) then begin

                            If NOT (RecStudentMaster."Course Code" In ['GFP', 'MSHHS']) then begin

                                // RecStudentMaster.CalcFields("Step 2 CK Exam Pass");
                                // IF RecStudentMaster."Step 2 CK Exam Pass" then begin

                                TotalWeeks := 0;
                                RosterSchedulingLineRec.Reset();
                                RosterSchedulingLineRec.SetCurrentKey("Student No.", "End Date");
                                RosterSchedulingLineRec.SetRange("Student No.", RecStudentMaster."No.");
                                RosterSchedulingLineRec.SetFilter("End Date", '<%1', Today());
                                RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                                if RosterSchedulingLineRec.FindSet() then
                                    repeat
                                        TotalWeeks := TotalWeeks + RosterSchedulingLineRec."No. of Weeks";
                                    until RosterSchedulingLineRec.Next() = 0;

                                ClinicalCurriculumTxt := '';
                                ClinicalCurriculumInt := 0;
                                IF RecStudentMaster."Clinical Curriculum" <> RecStudentMaster."Clinical Curriculum"::" " then begin
                                    ClinicalCurriculumTxt := Format(RecStudentMaster."Clinical Curriculum");
                                    If ClinicalCurriculumTxt <> '' then
                                        Evaluate(ClinicalCurriculumInt, ClinicalCurriculumTxt);
                                end;

                                if TotalWeeks >= ClinicalCurriculumInt then begin
                                    Clear(NSLDSwithdrawaldate);
                                    Clear(LDA);
                                    RosterSchedulingLineRec.Reset();
                                    RosterSchedulingLineRec.SetCurrentKey("Student No.", "End Date");
                                    RosterSchedulingLineRec.SetAscending("End Date", false);
                                    RosterSchedulingLineRec.SetRange("Student No.", RecStudentMaster."No.");
                                    RosterSchedulingLineRec.SetFilter("End Date", '<=%1', Today());
                                    RosterSchedulingLineRec.SetFilter(Status, '<>%1', RosterSchedulingLineRec.Status::Cancelled);
                                    if RosterSchedulingLineRec.FindFirst() then
                                        NSLDSwithdrawaldate := RosterSchedulingLineRec."End Date";

                                    StudentSubjectExams.Reset();
                                    StudentSubjectExams.SetCurrentKey("Sitting Date");
                                    StudentSubjectExams.SetRange("Student No.", RecStudentMaster."No.");
                                    StudentSubjectExams.SetRange(Published, true);
                                    StudentSubjectExams.SetAscending("Sitting Date", false);
                                    IF StudentSubjectExams.FindFirst() then begin
                                        IF NSLDSwithdrawaldate > StudentSubjectExams."Sitting Date" then
                                            LDA := NSLDSwithdrawaldate
                                        else
                                            LDA := StudentSubjectExams."Sitting Date";
                                    end else
                                        LDA := NSLDSwithdrawaldate;
                                    OldStatus := RecStudentMaster.Status;
                                    RecStudentMaster.Status := 'PGR';
                                    RecStudentMaster.Modify();

                                    IF RecStudentMaster.Status = 'PGR' then begin
                                        StatusChangeLogEntry.InsertRecordfun(RecStudentMaster."No.", RecStudentMaster."Student Name", OldStatus, RecStudentMaster.Status, UserId(), Today(), RecStudentMaster.Reason, RecStudentMaster."Reason Description", '', NSLDSwithdrawaldate, RecStudentMaster."Date Of Determination", LDA, Today(), Today(), RecStudentMaster."Dismissal Date");
                                        StudentTimeLine.InsertRecordFun(RecStudentMaster."No.", RecStudentMaster."Student Name", 'Student Status has been changed ' + OldStatus + ' to ' + RecStudentMaster.Status, UserId(), Today());
                                        RecStudentMaster.StatusOnvalidate(RecStudentMaster);
                                    end;
                                    SLcM_TO_SalesForce.StudentStatusSFInsert(RecStudentMaster);
                                    Commit();
                                end;
                                // end;
                            end;
                        end;
                    end;
                until RecStudentMaster.Next() = 0;
            end;
        end;
    end;
}
