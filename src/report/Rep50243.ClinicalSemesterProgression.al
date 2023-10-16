report 50243 "Clinical Semester Progression"
{

    Caption = 'Clinical Semester Analysis';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clinical Semester Progression.rdl';
    UsageCategory = Administration;
    ApplicationArea = All;
    // ProcessingOnly = true;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {


            RequestFilterFields = "No.", Semester, "Course Code", Status;
            DataItemTableView = sorting("No.") where("Semester" = filter('CLN5' | 'CLN6' | 'CLN7' | 'CLN8' | 'CLN9'));
            column(No_; "No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Completed_Weeks; Abs(Completed_Weeks))
            {

            }
            column(EstimatedSemester; EstimatedSemester)
            {

            }
            column(InstName; EducationSetup_Rec."Institute Name")
            {

            }
            column(LogoImage; EducationSetup_Rec."Clinical Science Logo")
            {

            }
            column(Status; Status)
            { }
            column(Academic_Year; "Academic Year")
            { }
            trigger OnPreDataItem()
            var
            begin
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");
            end;

            trigger OnAfterGetRecord()
            var
            begin

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetFilter("Rotation Grade", '%1|%2|%3|%4|%5|%6|%7|%8', 'H', 'HP', 'P', 'A', 'B', 'C', 'M', '');
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', ToDate);
                if not RosterLedgerEntry.FindFirst() then
                    CurrReport.Skip();

                Completed_Weeks := 0;
                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Student ID", "Student Master-CS"."No.");
                RosterLedgerEntry.SetFilter("Rotation Grade", '%1|%2|%3|%4|%5|%6|%7|%8', 'H', 'HP', 'P', 'A', 'B', 'C', 'M', '');
                RosterLedgerEntry.SetFilter("Start Date", '<=%1', ToDate);
                if RosterLedgerEntry.FindSet() then
                    repeat
                        if ToDate < RosterLedgerEntry."End Date" then
                            Completed_Weeks += round((ToDate - RosterLedgerEntry."Start Date") / 7, 1, '=')
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

                if Semester <> EstimatedSemester then
                    if StudentSemesterUpdate then begin
                        StudentTimeLine.InsertRecordFun("No.", "Student Name", 'Semester has been changed ' + Semester + ' to ' + EstimatedSemester,
                            UserId(), Today());
                        Semester := EstimatedSemester;
                        Modify();

                    end;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field(To_Date; ToDate)
                    {
                        Caption = 'ToDate';
                        ApplicationArea = All;

                    }
                    field(Student_Semester_Update; StudentSemesterUpdate)
                    {
                        Caption = 'Student Semester Update';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            if not ((UserId() = 'AUAPROSRV002\MANIPALADMIN1') or (UserId() = 'AUAUATSRV003\MANIPALADMIN')) then
                                error('You are not authorized to perform this activity');
                        end;
                    }
                }
            }
        }

    }

    var
        RosterLedgerEntry: Record "Roster Ledger Entry";
        EducationSetup_Rec: Record "Education Setup-CS";
        StudentTimeLine: Record "Student Time Line";
        Completed_Weeks: Integer;
        ToDate: Date;
        EstimatedSemester: Text;
        StudentSemesterUpdate: Boolean;
}