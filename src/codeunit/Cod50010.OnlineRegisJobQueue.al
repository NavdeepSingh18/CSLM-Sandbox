codeunit 50010 OnlineRegistrationJobQueue
{
    trigger OnRun()
    begin
        OnlineRegistrationInsertProcess();
        SendStudentStatustoSF();
        UpdateBSICtoClinicalFile();//BSIC to CLN Semester Promotions Run on Every Monday Evening From 12-09-2022
    end;


    Procedure OnlineRegistrationInsertProcess()
    var
        StudentMaster_lRec: Record "Student Master-CS";
        EducationSetup_lRec: Record "Education Setup-CS";
        SalesForce_lCU: Codeunit SLcMToSalesforce;
    begin
        EducationSetup_lRec.Reset();
        IF EducationSetup_lRec.FindSet() then begin
            repeat
                StudentMaster_lRec.Reset();
                StudentMaster_lRec.SetRange("Global Dimension 1 Code", EducationSetup_lRec."Global Dimension 1 Code");
                StudentMaster_lRec.Setfilter("Academic Year", '%1|%2', EducationSetup_lRec."Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
                StudentMaster_lRec.SetFilter(Term, '%1|%2', EducationSetup_lRec."Even/Odd Semester", EducationSetup_lRec."Returning OLR Term");
                StudentMaster_lRec.SetRange("OLR Completed", true);
                StudentMaster_lRec.SetRange("Registrar Signoff", false);
                If StudentMaster_lRec.FindSet() then begin
                    repeat
                        If StudentMaster_lRec."Student Group" = StudentMaster_lRec."Student Group"::"On-Ground Check-In Completed" then
                            IF StudentMaster_lRec."On Ground Check-In Complete On" <> 0D then
                                IF ABS((Today() - StudentMaster_lRec."On Ground Check-In Complete On")) < 2 then
                                    SalesForce_lCU.OnlineRegistrationInsertJobQueue(StudentMaster_lRec);
                        If StudentMaster_lRec."Student Group" = StudentMaster_lRec."Student Group"::"On-Ground Check-In" then
                            SalesForce_lCU.OnlineRegistrationInsertJobQueue(StudentMaster_lRec);
                    until StudentMaster_lRec.Next() = 0;
                end;
            until EducationSetup_lRec.Next() = 0;
        end;

    end;

    Procedure SendStudentStatustoSF()
    var
        StudentMaster_lRec: Record "Student Master-CS";
        SalesForce_lCU: Codeunit SLcMToSalesforce;
    Begin
        StudentMaster_lRec.Reset();
        //StudentMaster_lRec.SetRange("OLR Completed", true);
        StudentMaster_lRec.SetRange("Status Sync", true);
        If StudentMaster_lRec.FindSet() then begin
            repeat
                SalesForce_lCU.StudentStatusSFInsert(StudentMaster_lRec);
                StudentMaster_lRec."Status Sync" := false;
                StudentMaster_lRec.Modify();
            until StudentMaster_lRec.Next() = 0;
        end
    End;

    procedure UpdateBSICtoClinicalFile()//GAURAV//
    var
        StudentMasterCS: Record "Student Master-CS";
        RosterSchedulingLine: Record "Roster Ledger Entry";
        StudentTimeline: Record "Student Time Line";
    begin
        IF (Date2DWY(Today, 1) = 1) and (Time > 030000T) then begin // 175900T = 06:00 PM
            StudentMasterCS.Reset();
            StudentMasterCS.SetRange(Semester, 'BSIC');
            IF StudentMasterCS.FindSet(True) then
                repeat
                    RosterSchedulingLine.Reset();
                    RosterSchedulingLine.SetRange("Student ID", StudentMasterCS."No.");
                    RosterSchedulingLine.SetFilter(Status, '<>%1', RosterSchedulingLine.Status::Cancelled);
                    RosterSchedulingLine.SetRange("Clerkship Type", RosterSchedulingLine."Clerkship Type"::"FM1/IM1");
                    RosterSchedulingLine.SetFilter("Start Date", '<=%1', Today());
                    RosterSchedulingLine.SetFilter("End Date", '>=%1', Today());
                    IF RosterSchedulingLine.FindLast() then begin
                        StudentMasterCS.Validate(Semester, 'CLN5');
                        StudentMasterCS.Modify(true);
                        StudentTimeline.InsertRecordFun(StudentMasterCS."Original Student No.", StudentMasterCS."Student Name", 'Semester has been changed to CLN5', UserId(), Today());
                    end;
                until StudentMasterCS.Next() = 0;
        End;
    end;


}