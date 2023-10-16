codeunit 50011 "Student Master Data Job Queue"
{
    trigger OnRun()
    begin
        ClinicalSemesterProgression();
        StudentMaster_gRec.Reset();
        StudentMaster_gRec.SetRange("Student Group", StudentMaster_gRec."Student Group"::"On-Ground Check-In Completed");
        StudentMaster_gRec.SetRange("Registrar Signoff", False);
        IF StudentMaster_gRec.FindSet() then begin
            repeat
                StudentMaster_gRec.OnGroundCheckInToComplete(StudentMaster_gRec);
            until StudentMaster_gRec.Next() = 0;
        end;
    end;

    var
        StudentMaster_gRec: Record "Student Master-CS";

    procedure ClinicalSemesterProgression()
    var
        StudentMaster_lRec: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        StudentTimeLine: Record "Student Time Line";
        EducationSetup_lRec: Record "Education Setup-CS";
        SemesterFilter: Text;
        Completed_Weeks: Integer;
        EstimatedSemester: Text;
        StudentNo: Text;
    Begin
        //StudentNo := '101503|2000064A|2000091A|2000162A|2000268|2000474|2000496|2000576|2000611|2000747|2000765|2000772|2000825|2001006|2001099|2001273|2001475|2001478A|2001854|2002059A|360096A|370035A|370046|370201A|380018A|390038|390099A|390186A|390394|390397A|390430|390440|390448|390463|390484A|400081|400141A|400239A|420008A|420089|420091|420109|420126A|420228|420242|420254A|420265|420266A|420273|420281|420313|450001';
        SemesterFilter := 'CLN5|CLN6|CLN7|CLN8|CLN9';
        StudentMaster_lRec.Reset();
        //StudentMaster_lRec.SetFilter("No.", StudentNo);
        StudentMaster_lRec.SetFilter(Semester, SemesterFilter);
        IF StudentMaster_lRec.FindSet() then begin
            repeat

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", StudentMaster_lRec."No.");
                RosterLedgerEntry.SetFilter("Rotation Grade", '%1|%2|%3|%4|%5|%6|%7|%8', 'H', 'HP', 'P', 'A', 'B', 'C', 'M', '');
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', Today());
                if RosterLedgerEntry.FindFirst() then begin
                    Completed_Weeks := 0;
                    RosterLedgerEntry.Reset();
                    RosterLedgerEntry.SetRange("Student ID", StudentMaster_lRec."No.");
                    RosterLedgerEntry.SetFilter("Rotation Grade", '%1|%2|%3|%4|%5|%6|%7|%8', 'H', 'HP', 'P', 'A', 'B', 'C', 'M', '');
                    RosterLedgerEntry.SetFilter("Start Date", '<=%1', Today());
                    if RosterLedgerEntry.FindSet() then
                        repeat
                            if Today() < RosterLedgerEntry."End Date" then
                                Completed_Weeks += round((Today() - RosterLedgerEntry."Start Date") / 7, 1, '=')
                            else
                                Completed_Weeks += Round((RosterLedgerEntry."End Date" - RosterLedgerEntry."Start Date") / 7, 1, '=');
                        until RosterLedgerEntry.Next() = 0;

                    Clear(EstimatedSemester);
                    if Abs(Completed_Weeks) in [1 .. 21] then
                        EstimatedSemester := 'CLN5';

                    if Abs(Completed_Weeks) in [22 .. 42] then
                        EstimatedSemester := 'CLN6';

                    if abs(Completed_Weeks) in [43 .. 63] then
                        EstimatedSemester := 'CLN7';

                    if Abs(Completed_Weeks) >= 64 then
                        EstimatedSemester := 'CLN8';

                    iF EstimatedSemester <> '' then
                        if StudentMaster_lRec.Semester <> EstimatedSemester then begin

                            StudentTimeLine.InsertRecordFun(StudentMaster_lRec."No.", StudentMaster_lRec."Student Name", 'Semester has been changed to ' + EstimatedSemester,
                                UserId(), Today());
                            StudentMaster_lRec.Semester := EstimatedSemester;
                            EducationSetup_lRec.Reset();
                            EducationSetup_lRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                            IF EducationSetup_lRec.FindFirst() then begin
                                StudentMaster_lRec."Academic Year" := EducationSetup_lRec."Academic Year";
                                StudentMaster_lRec.Term := EducationSetup_lRec."Even/Odd Semester";
                            end;

                            StudentMaster_lRec.Modify();


                        end;
                end;
            until StudentMaster_lRec.Next() = 0;
        end;
    End;
}