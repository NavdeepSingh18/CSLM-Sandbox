report 50245 "1st Core"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/1st Core.rdl';
    Caption = 'First Core Report';

    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            DataItemTableView = sorting("Student No.", "Start Date") where("Clerkship Type" = filter(Core), Status = filter(<> Cancelled));
            RequestFilterFields = "Student No.", "Hospital ID", "Start Date";
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
            column(Rotation_Description; "Rotation Description")
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
            end;

            trigger OnAfterGetRecord()
            var
                RSL: Record "Roster Scheduling Line";
                FirstRSL: Record "Roster Scheduling Line";
                FirstCoreDate: Date;
            begin
                RSL.Reset();
                RSL.SetRange("Clerkship Type", RSL."Clerkship Type"::"FM1/IM1");
                RSL.SetRange("Student No.", "Student No.");
                if RSL.FindFirst() then;
                begin
                    FirstRSL.Reset();
                    FirstRSL.SetRange("Clerkship Type", FirstRSL."Clerkship Type"::Core);
                    FirstRSL.SetRange("Student No.", "Student No.");
                    FirstRSL.SetFilter("Start Date", '>%1', RSL."Start Date");
                    if FirstRSL.FindFirst() then
                        FirstCoreDate := FirstRSL."Start Date";
                end;

                if "Start Date" <> FirstCoreDate then
                    CurrReport.Skip();
            end;
        }
    }

    var
        EducationSetup_Rec: Record "Education Setup-CS";
}