report 50244 "Missing Grade"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Missing Grade.rdl';

    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.") where("Rotation Grade" = filter('' | 'M'), "Start Date" = filter(<> 0D), "End Date" = Filter(<> 0D));
            RequestFilterFields = "Student ID", Status;

            column(First_Name; "First Name")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(Student_ID; "Student ID")
            {

            }
            column(StudentStatus; StudentStatus)
            {

            }
            column(StudentSemester; StudentSemester)
            {

            }
            column(Rotation_Name; "Rotation Description")
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
            column(DaysOverDue; DaysOverDue)
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

                CalDays := '-' + format(Days) + 'D';
                SetFilter("End Date", '<%1', CalcDate(CalDays, Today));
            end;

            trigger OnAfterGetRecord()
            var
                Vendor: Record Vendor;
                StudentMaster: Record "Student Master-CS";
                DocuSign: Record "DocuSign Assessment Scores";
            begin
                if "Clerkship Type" = "Clerkship Type"::Core then begin
                    Vendor.Reset();
                    if Vendor.Get("Hospital ID") then
                        if Vendor."FIU Hospital" then
                            CurrReport.Skip();
                end;
                StudentStatus := '';
                StudentSemester := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student ID") then begin
                    StudentStatus := StudentMaster.Status;
                    StudentSemester := StudentMaster.Semester;
                end;
                Clear(DaysOverDue);
                DaysOverDue := (Today - "Roster Ledger Entry"."End Date");

                if ExcludeSavedAssessments then begin
                    DocuSign.Reset();
                    DocuSign.SetCurrentKey("Rotation Entry No.");
                    DocuSign.SetRange("Rotation Entry No.", "Entry No.");
                    if DocuSign.FindFirst() then
                        CurrReport.Skip();
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
                group(Options)
                {
                    field(Days; Days)
                    {
                        Caption = 'Days';
                        ApplicationArea = All;
                    }
                    field(ExcludeSavedAssessments; ExcludeSavedAssessments)
                    {
                        Caption = 'Exclude Rotations on Saved Assessment Window';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    begin
        Days := 31;
    end;

    var
        EducationSetup_Rec: Record "Education Setup-CS";
        Days: Integer;
        CalDays: Text;
        DaysOverDue: Integer;
        StudentStatus: Code[20];
        StudentSemester: Code[20];
        ExcludeSavedAssessments: Boolean;
}