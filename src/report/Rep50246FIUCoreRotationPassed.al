report 50246 "FIU Core Rotation Passed"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/FIU Core Rotation Passed.rdl';

    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            DataItemTableView = sorting("Student No.", "Start Date") where("Clerkship Type" = filter(Core), Status = filter(<> Cancelled));
            RequestFilterFields = "Student No.";
            column(First_Name; "First Name")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(Student_No_; "Student No.")
            {

            }
            column(Hospital_Name; "Hospital Name")
            {

            }
            column(Start_Date; "Start Date")
            {

            }
            column(End_Date; "End Date")
            {

            }
            column(Rotation_Description; "Rotation Description")
            {

            }
            column(OverdueDays; OverdueDays)
            {

            }
            column(InstName; EducationSetup_Rec."Institute Name")
            {

            }
            column(LogoImage; EducationSetup_Rec."Clinical Science Logo")
            {

            }
            trigger OnPreDataItem()
            begin
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");
                StudentNo := '';
            end;

            trigger OnAfterGetRecord()
            var
                Vendor: Record Vendor;
            begin
                Vendor.Reset();
                if Vendor.Get("Hospital ID") then
                    if Vendor."FIU Hospital" = false then
                        CurrReport.Skip();

                if StudentNo <> "Student No." then begin
                    RotationCount := 0;
                    StudentNo := "Student No.";
                end;

                RotationCount := RotationCount + 1;
                if RotationCount < 6 then
                    CurrReport.Skip();

                if "Start Date" > Today then
                    CurrReport.Skip();

                OverdueDays := 0;
                OverdueDays := Today - "End Date";
            end;
        }
    }

    var
        EducationSetup_Rec: Record "Education Setup-CS";
        RotationCount: Integer;
        StudentNo: Code[20];
        OverdueDays: Integer;
}