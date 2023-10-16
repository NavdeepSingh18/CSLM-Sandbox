report 50111 "Clinical Rotation Attendance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/ClinicalRotationAttHospital.rdlc';
    Caption = 'Clinical Rotation Attendance by Hospital';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")
        {
            column(Company_Name; Companyinfo_gRec.Name)
            {

            }
            column(Company_Picture; Companyinfo_gRec.Picture)
            { }
            column(StartDate_gDate; StartDate_gDate)
            { }
            column(EndDate_gDate; EndDate_gDate)
            { }
            column(Hospital_ID; "Hospital ID")
            { }
            column(Hospital_Name; "Hospital Name")
            { }
            column(Rotation_Type; "Clerkship Type")
            { }
            column(Subject_Code; "Course Code")
            { }
            column(Subject_Description; "Course Description")
            {
            }
            column(Student_ID; "Student ID")
            { }
            column(Student_Name; "Student Name")
            { }
            column(Start_Date; "Start Date")
            { }
            column(End_Date; "End Date")
            { }
            column(Total_No__of_Weeks; "Total No. of Weeks")
            { }
            column(Student_Email_gTxt; Student_Email_gTxt)
            { }
            column(Student_Phone_gTxt; Student_Phone_gTxt)
            { }
            column(Student_EnrollID_gTxt; Student_EnrollID_gTxt)
            { }

            trigger OnPreDataItem()
            begin
                //"Roster Ledger Entry".SetRange("Start Date", StartDate_gDate);
                //"Roster Ledger Entry".SetRange("End Date", EndDate_gDate);
            end;

            trigger OnAfterGetRecord()
            begin
                Companyinfo_gRec.Get();
                Companyinfo_gRec.CalcFields(Picture);

                Student_Email_gTxt := '';
                Student_Phone_gTxt := '';
                Student_EnrollID_gTxt := '';
                StudentMaster_gRec.Reset();
                StudentMaster_gRec.SetRange("No.", "Roster Ledger Entry"."Student ID");
                IF StudentMaster_gRec.FindFirst() then begin
                    Student_Email_gTxt := StudentMaster_gRec."E-Mail Address";
                    Student_Phone_gTxt := StudentMaster_gRec."Phone Number";
                    Student_EnrollID_gTxt := StudentMaster_gRec."Enrollment No.";
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
                    field("Start Date"; StartDate_gDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = all;

                    }
                    field("End Date"; EndDate_gDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {

            }
        }
    }

    var
        Companyinfo_gRec: Record "Company Information";
        StudentMaster_gRec: Record "Student Master-CS";
        StartDate_gDate: Date;
        EndDate_gDate: Date;
        Student_Email_gTxt: Text;
        Student_Phone_gTxt: Text;
        Student_EnrollID_gTxt: Text;

    trigger OnPreReport()
    begin
        //IF (StartDate_gDate = 0D) or (EndDate_gDate = 0D) then
        //  Error('Please Enter Start Date & End Date');
    end;
}