report 50232 "ClerkshipAttendanceDelta"
{
    Caption = 'Clerkship Attendance Delta Hospital List';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clerkship Attendance Delta Hospital List.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            DataItemTableView = sorting("Rotation ID");
            RequestFilterFields = "Clerkship Type", "Hospital ID";

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
            column(Clerkship_Type; TypeVar)
            {

            }
            column(Hospital_ID; "Roster Scheduling Line"."Hospital ID")
            {

            }
            column(Student_Name; "Roster Scheduling Line"."Student Name" + ' (' + "Student No." + ')')
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
            column(DeltaFrom; DeltaFrom)
            {

            }
            column(DeltaTo; DeltaTo)
            {

            }
            column(ClerkShipType; ClerkShipType)
            {

            }
            column(StartDate_From; StartDate_From)
            {

            }
            column(StartDate_To; StartDate_To)
            {

            }
            column(UserName; UserName)
            {

            }
            column(CurentDate; Today)
            {

            }


            trigger OnPreDataItem()
            var
            begin
                if StartDate_From <> 0D then
                    SetRange("Start Date", StartDate_From, StartDate_To);

                SetFilter(Status, '%1|%2', Status::Published, Status::Cancelled);

                UserSetupRec.Get(UserId);
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code",
                                                UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");

                Clear(NotFound);

                WindowDialog.Open('Running Report Clerkship Attendance Delta Hospital List...\' + Text001Lbl);
                T := Count;
                C := 0;
            end;

            trigger OnAfterGetRecord()
            var
            begin
                C += 1;
                WindowDialog.Update(1, Format(C) + ' of ' + Format(T));

                NotFound += 1;
                if StudentMasterCS.Get("Roster Scheduling Line"."Student No.") then;

                TypeVar := '';

                case "Clerkship Type" of
                    "Clerkship Type"::Core:
                        TypeVar := 'CORE';
                    "Clerkship Type"::Elective:
                        TypeVar := 'ELE';
                    "Clerkship Type"::"FM1/IM1":
                        TypeVar := 'FM';
                end;

                Grouping := '';
                if "Roster Scheduling Line".Status = "Roster Scheduling Line".Status::Cancelled then
                    Grouping := 'Cancelled'
                else
                    Grouping := 'New Rotation';

                ApplyDelta := false;
                if "Roster Scheduling Line"."Published On" in [DeltaFrom .. DeltaTo] then
                    ApplyDelta := true;

                if "Roster Scheduling Line"."Cancelled Date" in [DeltaFrom .. DeltaTo] then
                    ApplyDelta := true;

                if ApplyDelta = false then
                    CurrReport.Skip();

                UserName := '';
                if Status = Status::Published then
                    UserName := "Published By";
                if Status = Status::Cancelled then
                    UserName := "Cancelled By";
            end;
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
                        Caption = 'Start Date From';
                    }
                    field("StartDate To"; StartDate_To)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date To';

                    }

                    field("Delta From"; DeltaFrom)
                    {
                        ApplicationArea = all;
                        Caption = 'Delta From';
                    }

                    field("Delta To"; DeltaTo)
                    {
                        ApplicationArea = all;
                        Caption = 'Delta To';

                    }
                }
            }
        }

    }

    trigger OnPostReport()
    begin
        if NotFound = 0 then
            Message('There is no record with in the given filter(s).');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        EducationSetup_Rec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        StartDate_From: Date;
        StartDate_To: Date;
        DeltaFrom: Date;
        DeltaTo: Date;
        Grouping: Text;
        ApplyDelta: Boolean;
        //Hospital_Name1: Text;
        //Affilitated_Hospital: Boolean;
        ClerkShipType: Option " ",Core,Elective,"FM1/IM1";
        TypeVar: Text;
        UserName: Text;
        NotFound: Integer;
        WindowDialog: Dialog;
        Text001Lbl: Label 'Rows Processed      ############1################\';
        T: Integer;
        C: Integer;
}