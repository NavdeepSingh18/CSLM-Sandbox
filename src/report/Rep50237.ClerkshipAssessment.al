report 50237 "Clerkship Assessment"
{
    Caption = 'Clerkship Assessment';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clerkship Assessment.rdl';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("DocuSign Assessment Scores"; "DocuSign Assessment Scores")
        {
            column(StudentID; "Student No.")
            {

            }
            column(StudentFirstName; StudentMaster."First Name")
            {

            }
            column(StudentLastName; StudentMaster."Last Name")
            {

            }
            column(Course_Start_Date; "Course Start Date")
            {

            }
            column(Course_End_Date; "Course End Date")
            {

            }
            column(CourseCreditWeeks; CourseCreditWeeks)
            {

            }
            column(CourseUID; "Course Code")
            {

            }
            column(CourseTitle; "Course Name")
            {

            }
            column(HospitalName; RosterLedgerEntry."Hospital Name")
            {

            }
            column(HospitalState; '')
            {

            }
            column(Patient_Care; PatientCare)
            {

            }
            column(MedicalKnowledge; MedicalKnowledge)
            {

            }
            column(Interpersonal; Inter)
            {

            }
            column(PracticeBased; PracticeBase)
            {

            }
            column(SystemsBased; SystemBased)
            {

            }
            column(Professionalism; Prof)
            {

            }
            column(CCSSEScore; "CCSSE Score")
            {

            }
            column(CCSSEScore2; '')
            {

            }
            column(EvalCount; '')
            {

            }
            column(EvalSum; "DocuSign Assessment Scores"."Assessment Total Score")
            {

            }
            column(EvalPercent; "Assessment Percentage")
            {

            }
            column(ShelfValue; "CCSSE Weightage")
            {

            }
            column(GradePercent; "Final Percentage")
            {

            }
            column(Grade; "DocuSign Assessment Scores".Grade)
            {

            }

            trigger OnAfterGetRecord()
            begin
                if StudentMaster.Get("Student No.") then;
                CourseCreditWeeks := 0;
                CourseCreditWeeks := Round(("Course End Date" - "Course Start Date") / 7, 1, '=');

                RosterLedgerEntry.Reset();
                RosterLedgerEntry.SetRange("Entry No.", "Rotation Entry No.");
                if RosterLedgerEntry.FindFirst() then;


                if "DocuSign Assessment Scores"."Patient Care" = "DocuSign Assessment Scores"."Patient Care"::"Outstanding" then
                    PatientCare := 4;
                if "DocuSign Assessment Scores"."Patient Care" = "DocuSign Assessment Scores"."Patient Care"::Competent then
                    PatientCare := 3;
                if "DocuSign Assessment Scores"."Patient Care" = "DocuSign Assessment Scores"."Patient Care"::"Adequate" then
                    PatientCare := 2;
                if "DocuSign Assessment Scores"."Patient Care" = "DocuSign Assessment Scores"."Patient Care"::"Inadequate-Remediation required" then
                    PatientCare := 1;

                if "DocuSign Assessment Scores"."Medical Knowledge" = "DocuSign Assessment Scores"."Medical Knowledge"::"Outstanding" then
                    MedicalKnowledge := 4;
                if "DocuSign Assessment Scores"."Medical Knowledge" = "DocuSign Assessment Scores"."Medical Knowledge"::Competent then
                    MedicalKnowledge := 3;
                if "DocuSign Assessment Scores"."Medical Knowledge" = "DocuSign Assessment Scores"."Medical Knowledge"::"Adequate" then
                    MedicalKnowledge := 2;
                if "DocuSign Assessment Scores"."Medical Knowledge" = "DocuSign Assessment Scores"."Medical Knowledge"::"Inadequate-Remediation required" then
                    MedicalKnowledge := 1;

                if "DocuSign Assessment Scores"."Interpersonal and Comm. Skills" = "DocuSign Assessment Scores"."Interpersonal and Comm. Skills"::"Outstanding" then
                    Inter := 4;
                if "DocuSign Assessment Scores"."Interpersonal and Comm. Skills" = "DocuSign Assessment Scores"."Interpersonal and Comm. Skills"::Competent then
                    Inter := 3;
                if "DocuSign Assessment Scores"."Interpersonal and Comm. Skills" = "DocuSign Assessment Scores"."Interpersonal and Comm. Skills"::"Adequate" then
                    Inter := 2;
                if "DocuSign Assessment Scores"."Interpersonal and Comm. Skills" = "DocuSign Assessment Scores"."Interpersonal and Comm. Skills"::"Inadequate-Remediation required" then
                    Inter := 1;

                if "DocuSign Assessment Scores"."Practice Base Learn and Impro" = "DocuSign Assessment Scores"."Practice Base Learn and Impro"::"Outstanding" then
                    PracticeBase := 4;
                if "DocuSign Assessment Scores"."Practice Base Learn and Impro" = "DocuSign Assessment Scores"."Practice Base Learn and Impro"::Competent then
                    PracticeBase := 3;
                if "DocuSign Assessment Scores"."Practice Base Learn and Impro" = "DocuSign Assessment Scores"."Practice Base Learn and Impro"::"Adequate" then
                    PracticeBase := 2;
                if "DocuSign Assessment Scores"."Practice Base Learn and Impro" = "DocuSign Assessment Scores"."Practice Base Learn and Impro"::"Inadequate-Remediation required" then
                    PracticeBase := 1;

                if "DocuSign Assessment Scores"."System Based Learning" = "DocuSign Assessment Scores"."System Based Learning"::"Outstanding" then
                    PracticeBase := 4;
                if "DocuSign Assessment Scores"."System Based Learning" = "DocuSign Assessment Scores"."System Based Learning"::Competent then
                    PracticeBase := 3;
                if "DocuSign Assessment Scores"."System Based Learning" = "DocuSign Assessment Scores"."System Based Learning"::"Adequate" then
                    PracticeBase := 2;
                if "DocuSign Assessment Scores"."System Based Learning" = "DocuSign Assessment Scores"."System Based Learning"::"Inadequate-Remediation required" then
                    PracticeBase := 1;

                if "DocuSign Assessment Scores".Professionalism = "DocuSign Assessment Scores".Professionalism::"Outstanding" then
                    Prof := 4;
                if "DocuSign Assessment Scores".Professionalism = "DocuSign Assessment Scores".Professionalism::Competent then
                    Prof := 3;
                if "DocuSign Assessment Scores".Professionalism = "DocuSign Assessment Scores".Professionalism::"Adequate" then
                    Prof := 2;
                if "DocuSign Assessment Scores".Professionalism = "DocuSign Assessment Scores".Professionalism::"Inadequate-Remediation required" then
                    Prof := 1;
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(ActionName)
                // {
                //     ApplicationArea = All;

                // }
            }
        }
    }

    var
        StudentMaster: Record "Student Master-CS";
        RosterLedgerEntry: Record "Roster Ledger Entry";
        CourseCreditWeeks: Integer;
        // HospitalName: Text;
        // HospitalState: Text;
        PatientCare: Integer;
        MedicalKnowledge: Integer;
        Inter: Integer;
        PracticeBase: Integer;
        SystemBased: Integer;
        Prof: Integer;



}