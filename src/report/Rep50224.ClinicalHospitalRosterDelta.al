report 50224 "Clinical Hospital Roster Delta"
{
    Caption = 'Clinical Hospital Roster Delta';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clinical Hospital Roster Delta.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Roster Scheduling Line"; "Roster Scheduling Line")
        {
            DataItemTableView = sorting("Rotation ID");
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
            column(Subject_Description; "Roster Scheduling Line"."Rotation Description")
            {

            }
            column(Cancelled_Date; CanceledDate)
            {

            }
            column(Clerkship_Type; "Roster Scheduling Line"."Clerkship Type")
            {

            }
            column(Hospital_ID; "Roster Scheduling Line"."Hospital ID")
            {

            }
            column(Student_Name; "Roster Scheduling Line"."Student Name" + ' (' + "Student No." + ')')
            {

            }

            column(New_Ret; "Roster Scheduling Line"."New/Returning")
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
            column(AddedDate; PublishedDate)
            {

            }
            column(StartDate_From; StartDate_From)
            {

            }
            column(StartDate_To; StartDate_To)
            {

            }
            column(DeltaFrom; DeltaFrom)
            {

            }
            column(DeltaTo; DeltaTo)
            {

            }
            column(CurrentDate; Today)
            {

            }
            column(CourseCode; "Course Code")
            {

            }
            column(Student_No_; "Student No.")
            {

            }
            column(UserName; UserName)
            {

            }


            trigger OnPreDataItem()
            var
            begin
                Clear(NotFound);
                IF (StartDate_From <> 0D) AND (StartDate_To <> 0D) then//CSPL-00307 -05-09-2022- As per Ajay  
                    SetRange("Start Date", StartDate_From, StartDate_To);
                // SetFilter("End Date", '<=%1', StartDate_To);

                SetFilter(Status, '%1|%2', Status::Published, Status::Cancelled);
                UserSetupRec.Get(UserId);
                EducationSetup_Rec.Reset();
                EducationSetup_Rec.SetRange("Global Dimension 1 Code",
                                                UserSetupRec."Global Dimension 1 Code");
                if EducationSetup_Rec.FindFirst() then
                    EducationSetup_Rec.CalcFields("Clinical Science Logo");


            end;

            trigger OnAfterGetRecord()
            var
            begin
                NotFound += 1;
                if StudentMasterCS.Get("Roster Scheduling Line"."Student No.") then;

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

                PublishedDate := 0D;
                CanceledDate := 0D;
                if Status = Status::Cancelled then
                    CanceledDate := "Cancelled Date"
                else
                    PublishedDate := "Published On";


                if ApplyDelta = false then
                    CurrReport.Skip();

                UserName := '';
                if Status = Status::Published then
                    UserName := "Published By";
                if Status = Status::Cancelled then
                    UserName := "Cancelled By";

            end;

            trigger OnPostDataItem()
            begin

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
        PublishedDate: Date;
        CanceledDate: Date;
        UserName: text;
        NotFound: Integer;
}