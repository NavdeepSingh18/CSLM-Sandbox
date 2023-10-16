report 50240 "Clinical Roster List"
{
    Caption = 'Clinical Roster List';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clinical Roster List.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            DataItemTableView = sorting("Rotation ID");
            RequestFilterFields = "Course Code", "Student No.", "Hospital ID";

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
            column(Clerkship_Type; "Clerkship Type")
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
            column(ClerkShip_Type1; ClerkShip_Type1)
            {

            }
            column(Hospital_Name1; Hospital_Name1)
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
            column(Student_No_; "Student No.")
            {

            }

            column(Last_Name; "Last Name")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Student_Status; StudentStatus.Description)
            {

            }
            column(Course_Code; "Course Code")
            {

            }
            column(Course_Prefix_Code; "Course Prefix Code")
            {

            }
            column(HospitalCity; HospitalList.City)
            {

            }
            column(HospitalZipCode; HospitalList."Post Code")
            {

            }
            // column(HospitalList; HospitalList."State Code")
            // {

            // }
            column(NewReturning; "New/Returning")
            {

            }

            trigger OnPreDataItem()
            var
            begin
                if StartDate_From <> 0D then
                    SetRange("Start Date", StartDate_From, StartDate_To);

                // SetFilter(Status, '%1|%2', Status::Published, Status::Cancelled);

                // if not (ClerkShip_Type1 = ClerkShip_Type1::" ") then
                //     SetRange("Clerkship Type", ClerkShip_Type1);

                UserSetupRec.Get(UserId);
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code",
                                                UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");

                Clear(NotFound);

                W.Open('Clinical Rotations List...\' + Text001Lbl);
                T := Count;
                C := 0;
            end;

            trigger OnAfterGetRecord()
            var
            begin
                C += 1;
                W.Update(1, Format(C) + ' of ' + Format(T));

                NotFound += 1;
                if StudentMasterCS.Get("Roster Scheduling Line"."Student No.") then;

                if StudentStatus.Get(StudentMasterCS.Status, "Global Dimension 1 Code") then;

                if HospitalList.get("Hospital ID") then;

                TypeVar := '';
                case "Clerkship Type" of
                    "Clerkship Type"::Core:
                        TypeVar := 'CORE';
                    "Clerkship Type"::Elective:
                        TypeVar := 'ELE';
                    "Clerkship Type"::"FM1/IM1":
                        TypeVar := 'FM';
                end;


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
                    field(Hospital_Name; Hospital_Name1)
                    {
                        ApplicationArea = all;
                        Caption = 'Hospital';
                        Visible = false;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Hospital: Record Vendor;
                            Hospital1: Record Vendor;
                        begin
                            IF Page.RUNMODAL(50435, Hospital, Hospital."No.") = Action::LookupOK THEN
                                Hospital1.get(Hospital."No.");
                            Hospital_Name1 := Hospital1.Name;
                        end;
                    }

                    // field("Clerkship Type"; ClerkShip_Type1)
                    // {
                    //     OptionCaption = ' ,Core,Elective,FM1/IM1';
                    // }
                }
            }
        }

    }

    trigger OnPostReport()
    begin
        if NotFound = 0 then
            Message('There is no record with in the given filter(s).');

        W.Close();
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        EducationSetup_Rec: Record "Education Setup-CS";
        HospitalList: Record Vendor;
        UserSetupRec: Record "User Setup";
        StudentStatus: Record "Student Status";
        StartDate_From: Date;
        StartDate_To: Date;
        DeltaFrom: Date;
        DeltaTo: Date;
        Grouping: Text;
        // ApplyDelta: Boolean;
        Hospital_Name1: Text;
        ClerkShip_Type1: Option " ",Core,Elective,"FM1/IM1";
        TypeVar: Text;
        UserName: Text;
        NotFound: Integer;
        Text001Lbl: Label 'Processing Rotations      ############1################\';
        W: Dialog;
        T: Integer;
        C: Integer;
    // AsOnDate: Date;



}