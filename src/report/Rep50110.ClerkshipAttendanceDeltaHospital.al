report 50110 "Clerkship Attendance Delta"
{
    Caption = 'Clerkship Attendance Delta Hospital';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Clerkship Atten. Delta Hos.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Roster Ledger Entry"; "Roster Ledger Entry")

        {
            column(Hospital_Name; "Hospital Name")
            {

            }
            column(Hospital_ID; "Hospital ID")
            {

            }
            column(Rotation_Description; "Rotation Description")
            { }
            column(Clerkship_Type; "Clerkship Type")
            { }
            column(StudentEnrollID_gText; StudentEnrollID_gText)
            { }

            column(Student_ID; "Student ID")
            { }
            column(Student_Name; "Student Name")
            { }
            column(Start_Date; "Start Date")
            { }
            column(End_Date; "End Date")
            { }
            column(Length_gInt; Length_gInt)
            { }
            column(StudentEmail_gText; StudentEmail_gText)
            { }
            column(StudentPhone_gText; StudentPhone_gText)
            { }
            column(StartDate_gDate; StartDate_gDate)
            { }
            column(EndDate_gDate; EndDate_gDate)
            { }

            trigger OnPreDataItem()
            begin
                //"Roster Ledger Entry".SetRange("Start Date", StartDate_gDate);
                //"Roster Ledger Entry".SetRange("End Date", EndDate_gDate);
            end;

            trigger OnAfterGetRecord()
            begin
                Length_gInt := 0;
                Length_gInt := Round(ABS("Roster Ledger Entry"."Start Date" - "Roster Ledger Entry"."End Date") / 7, 1);

                StudentEmail_gText := '';
                StudentPhone_gText := '';
                StudentEnrollID_gText := '';
                StudentMaster_gRec.Reset();
                StudentMaster_gRec.SetRange("No.", "Roster Ledger Entry"."Student ID");
                IF StudentMaster_gRec.FindFirst() then begin
                    StudentEnrollID_gText := StudentMaster_gRec."Enrollment No.";
                    StudentEmail_gText := StudentMaster_gRec."E-Mail Address";
                    StudentPhone_gText := StudentMaster_gRec."Phone Number";
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
                        caption = 'End Date';
                        ApplicationArea = all;
                    }
                }
            }
        }


    }


    var
        StudentMaster_gRec: Record "Student Master-CS";
        StudentEnrollID_gText: Text;
        Length_gInt: Integer;

        StartDate_gDate: Date;
        EndDate_gDate: Date;
        StudentEmail_gText: Text;
        StudentPhone_gText: Text;

    trigger OnPreReport()
    begin
        //If (StartDate_gDate = 0D) OR (EndDate_gDate = 0D) then
        //  Error('Please Enter Start Date & End Date');

    end;

}