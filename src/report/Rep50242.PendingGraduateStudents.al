report 50242 "Pending Graduate Students"
{
    Caption = 'Pending Graduate Students Report';
    UsageCategory = none;
    //ApplicationArea = All;
    RDLCLayout = './src/reportrdlc/Pending Graduate Students.rdl';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = where("Global Dimension 1 Code" = Filter('9000'), USMLEID = Filter(<> ''));
            RequestFilterFields = "No.", "Academic Year";
            column(Student_ID; "Original Student No.")
            {

            }
            column(SLcM_No; "No.")
            {

            }
            column(Enrollemnt_No; "Enrollment No.")
            {

            }
            column(StudentName; "Student Name")
            {

            }
            column(FirstName; "First Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(Course_Code; "Course Code")
            {

            }
            column(Academic_Year; "Academic Year")
            {

            }
            column(Status; Status)
            {

            }
            column(UsmleID; UsmleID)
            {

            }

            column(Logo; EducationSetup_Rec."Logo Image")
            {

            }
            column(Institute_Name; EducationSetup_Rec."Institute Name")
            {

            }
            column(NSLDSwithdrawaldate; NSLDSwithdrawaldate)
            {

            }
            column(LDA; LDA)
            {

            }




            trigger OnPreDataItem()
            begin
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Logo Image");
            end;

            trigger OnAfterGetRecord()
            begin

                if StudentStatusRec.Get("Student Master-CS".Status, "Student Master-CS"."Global Dimension 1 Code") then
                    if (StudentStatusRec.Status in [StudentStatusRec.Status::Deferred, StudentStatusRec.Status::Declined,
                    StudentStatusRec.Status::Suspension, StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Dismissed,
                    StudentStatusRec.Status::Deceased, StudentStatusRec.Status::Graduated, StudentStatusRec.Status::TOPROG
                    , StudentStatusRec.Status::"Re-Entry", StudentStatusRec.Status::"Re-Admitted"]) then
                        CurrReport.Skip();

                If "Student Master-CS"."Course Code" In ['GFP', 'MSHHS'] then
                    CurrReport.Skip();

                // CalcFields("Step 2 CK Exam Pass");
                // IF not "Step 2 CK Exam Pass" then
                //     CurrReport.Skip();

                TotalWeeks := 0;
                RosterSchedulingLineRec.Reset();
                // RosterSchedulingLineRec.SetCurrentKey("Student No.", "Start Date");
                RosterSchedulingLineRec.SetCurrentKey("Student No.", "End Date");
                RosterSchedulingLineRec.SetRange("Student No.", "No.");
                RosterSchedulingLineRec.SetFilter("End Date", '<%1', Today());
                // RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6&<>%7', '', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                if RosterSchedulingLineRec.FindSet() then
                    repeat
                        TotalWeeks := TotalWeeks + RosterSchedulingLineRec."No. of Weeks";
                    until RosterSchedulingLineRec.Next() = 0;


                ClinicalCurriculumTxt := '';
                ClinicalCurriculumInt := 0;
                IF "Student Master-CS"."Clinical Curriculum" <> "Student Master-CS"."Clinical Curriculum"::" " then begin
                    ClinicalCurriculumTxt := Format("Student Master-CS"."Clinical Curriculum");
                    If ClinicalCurriculumTxt <> '' then
                        Evaluate(ClinicalCurriculumInt, ClinicalCurriculumTxt);
                end;

                if TotalWeeks < ClinicalCurriculumInt then
                    CurrReport.Skip();


                Clear(NSLDSwithdrawaldate);
                Clear(LDA);
                RosterSchedulingLineRec.Reset();
                RosterSchedulingLineRec.SetCurrentKey("Student No.", "End Date");
                RosterSchedulingLineRec.SetAscending("End Date", false);
                RosterSchedulingLineRec.SetRange("Student No.", "No.");
                RosterSchedulingLineRec.SetFilter("End Date", '<=%1', Today());
                RosterSchedulingLineRec.SetFilter(Status, '<>%1', RosterSchedulingLineRec.Status::Cancelled);
                // RosterSchedulingLineRec.SetFilter("Rotation Grade", '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'X', 'TC', 'UC', 'SC', 'R', 'F');
                if RosterSchedulingLineRec.FindFirst() then
                    NSLDSwithdrawaldate := RosterSchedulingLineRec."End Date";

                StudentSubjectExams.Reset();
                StudentSubjectExams.SetCurrentKey("Sitting Date");
                StudentSubjectExams.SetAscending("Sitting Date", false);
                StudentSubjectExams.SetRange("Student No.", "Student Master-CS"."No.");
                StudentSubjectExams.SetRange(Published, true);
                IF StudentSubjectExams.FindFirst() then begin
                    IF NSLDSwithdrawaldate > StudentSubjectExams."Sitting Date" then
                        LDA := NSLDSwithdrawaldate
                    else
                        LDA := StudentSubjectExams."Sitting Date";
                end else
                    LDA := NSLDSwithdrawaldate;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }

            }
        }

    }

    trigger OnPreReport()
    Begin

    End;


    var
        StudentStatusRec: Record "Student Status";
        EducationSetup_Rec: Record "Education Setup-CS";
        //  UserSetupRec: Record "User Setup";
        RosterSchedulingLineRec: Record "Roster Scheduling Line";
        StudentSubjectExams: Record "Student Subject Exam";
        TotalWeeks: Integer;
        ClinicalCurriculumInt: Integer;
        ClinicalCurriculumTxt: Text;
        NSLDSwithdrawaldate: Date;
        LDA: Date;

}
