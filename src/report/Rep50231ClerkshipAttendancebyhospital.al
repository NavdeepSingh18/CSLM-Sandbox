report 50231 "ClerkshipAttendancebyhospital"
{
    Caption = 'Clerkship Attendance by hospital';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clerkship Attendance by hospital.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;


    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            DataItemTableView = sorting("Rotation ID");
            RequestFilterFields = "Clerkship Type", "Student No.";

            column(Grouping; Grouping)
            {

            }
            column(Start_Date; "Roster Scheduling Line"."Start Date")
            {

            }
            column(End_Date; "Roster Scheduling Line"."End Date")
            {

            }
            column(No__of_Weeks; "Roster Scheduling Line"."No. of Weeks")
            {

            }
            column(Subject_Description; "Rotation Description")
            {

            }
            column(Cancelled_Date; "Roster Scheduling Line"."Cancelled Date")
            {

            }
            column(Clerkship_Type; "Roster Scheduling Line"."Clerkship Type")
            {

            }
            column(Hospital_ID; "Roster Scheduling Line"."Hospital ID")
            {

            }
            // column(Student_Name; Delchr("First Name", '=', ' ') + ' ' + Delchr("Middle Name", '=', ' ') + ' ' + Delchr("Last Name", '=', ' '))
            // {
            //CSPL-00307-as per ajay comment this 25-05-23
            // }
            column(Student_Name; "Student Name")
            {

            }
            column(New_Ret; "New/Returning")
            {

            }
            column(Status; "Roster Scheduling Line".Status)
            {

            }
            column(Year; StudentMasterCS.Year)
            {

            }
            column(Email; StudentMasterCS."E-Mail Address")
            {

            }
            column(Phone; StudentMasterCS."Phone Number")
            {

            }

            column(Hospital_Name; "Roster Scheduling Line"."Hospital Name")
            {

            }

            column(Logo; EducationSetup_Rec."Clinical Science Logo")
            {

            }
            column(Institute_Name; EducationSetup_Rec."Institute Name")
            {

            }
            column(AddedDate; "Roster Scheduling Line"."Published On")
            {

            }
            column(StartDate_Fromt; StartDate_From)
            {

            }
            column(StartDate_To; StartDate_To)
            {

            }
            column(Filters; Filters)
            {


            }
            column(UserName; UserName)
            {

            }
            column(AsOfDate; today)
            {

            }
            column(Student_No_; StudentMasterCS."Original Student No.")
            {

            }
            trigger OnPreDataItem()
            var
            begin
                SetRange("Start Date", StartDate_From, StartDate_To);
                if HospitalID <> '' then
                    SetFilter("Hospital ID", HospitalID);

                UserSetupRec.Get(UserId);
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code", '9000');
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");

                Filters := GetFilters;
                Clear(DataNotFound);
            end;

            trigger OnAfterGetRecord()
            var
            begin

                If "Roster Scheduling Line".Status = "Roster Scheduling Line".Status::Cancelled then
                    CurrReport.Skip();

                DataNotFound += 1;
                if StudentMasterCS.Get("Roster Scheduling Line"."Student No.") then;

                Grouping := '';
                if "Roster Scheduling Line".Status = "Roster Scheduling Line".Status::Cancelled then
                    Grouping := 'Cancelled'
                else
                    Grouping := 'New Rotation';

                UserName := '';
                if Status = Status::Published then
                    UserName := "Published By";
                if Status = Status::Cancelled then
                    UserName := "Cancelled By";
            end;

            // trigger OnPostDataItem()
            // begin
            //     if DataNotFound = 0 then
            //         Message('Records not found in (F)ilter');
            // end;

        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("Option")
                {
                    field("StartDate From"; StartDate_From)
                    {
                        ApplicationArea = All;
                        Caption = 'StartDate From';
                    }
                    field("StartDate To"; StartDate_To)
                    {
                        ApplicationArea = All;
                        Caption = 'StartDate To';

                    }
                    field(HospitalName; HospitalName)
                    {
                        ApplicationArea = All;
                        Caption = 'Hospital Name';
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Hospital: Record Vendor;
                        begin
                            Hospital.Reset();
                            Hospital.SetRange("Vendor Sub Type", Hospital."Vendor Sub Type"::Hospital);
                            IF Page.RUNMODAL(27, Hospital) = Action::LookupOK THEN begin
                                HospitalName := Hospital.Name;
                                HospitalID := Hospital."No.";
                            end;
                        end;
                    }
                    field("Affilitated Hospital"; Affilitated_Hospital)
                    {
                        ApplicationArea = all;
                        Caption = 'Affilitated Hospital';
                        Visible = false;
                    }
                    // field("ClerkShip Type"; ClerkShip_Type1)
                    // {
                    //     OptionCaption = ' ,Core,Elective,FM1/IM1';
                    // }

                }
            }
        }

    }
    trigger OnPostReport()
    begin
        if DataNotFound = 0 then
            Message('There is no record with in the given filter(s).');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        EducationSetup_Rec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        StartDate_From: Date;
        StartDate_To: Date;
        Grouping: Text;
        Affilitated_Hospital: Boolean;
        Filters: Text;
        UserName: Text;
        DataNotFound: Integer;
        HospitalID: Code[20];
        HospitalName: Text[100];
}