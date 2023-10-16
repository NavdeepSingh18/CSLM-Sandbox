report 50235 "Schedule of Rotation"
{
    Caption = 'Schedule of Rotation';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Schedule of Rotation.rdl';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            RequestFilterFields = "Student No.", "Hospital ID", "Academic Year", "Elective Course Code";

            column(Rotation_ID; "Rotation ID")
            {

            }
            column(Rotation_No_; "Rotation No.")
            {

            }
            column(Student_No_; "Student No.")
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Course_Code; CourseCode)
            {

            }
            column(Rotation_Description; "Rotation Description")
            {

            }
            column(Start_Date; "Start Date")
            {

            }
            column(End_Date; "End Date")
            {

            }
            column(Hospital_ID; "Hospital ID")
            {

            }
            column(Hospital_Name; "Hospital Name")
            {

            }

            column(Logo; EducationSetup_Rec."Clinical Science Logo")
            {

            }
            column(Institute_Name; EducationSetup_Rec."Institute Name")
            {

            }
            column(filters; filters)
            {


            }
            trigger OnPreDataItem()
            var
            begin
                // filters := "Roster Scheduling Line".GetFilters;
                SetFilter(Status, '%1|%2', Status::Published, Status::Scheduled);
                UserSetupRec.Get(UserId);
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code",
                                                UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");

            end;

            trigger OnAfterGetRecord()
            begin
                if "Clerkship Type" = "Clerkship Type"::Elective then
                    CourseCode := "Elective Course Code"
                else
                    CourseCode := "Course Code";

            end;
        }
    }

    var
        UserSetupRec: Record "User Setup";
        EducationSetup_Rec: Record "Education Setup-CS";
        CourseCode: Text;
        filters: Text;
}