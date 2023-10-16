report 50147 "Due Certificate List-CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Due Certificate List-CS.rdlc';

    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Due Clearance-CS"; "Due Clearance-CS")
        {
            RequestFilterFields = Date;
            column(StudentNo_DueClearance; "Student No.")
            {
            }
            column(Date_DueClearance; FORMAT(Date))
            {
            }
            column(EnrollmentNo_DueClearance; "Enrollment No.")
            {
            }
            column(StudentName_DueClearance; "Student Name")
            {
            }
            column(CourseCode_DueClearance; "Course Code")
            {
            }
            column(CourseName_DueClearance; "Course Name")
            {
            }
            column(GlobalDimension1Code_DueClearance; "Global Dimension 1 Code")
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            column(CompInfo_Address; CompInfo.Address)
            {
            }
            column(CompInfo_Address2; CompInfo."Address 2")
            {
            }
            column(Srno; Srno)
            {
            }
            column(GetFilter; GETFILTERS())
            {
            }

            trigger OnAfterGetRecord()
            begin
                Srno += 1;
            end;

            trigger OnPreDataItem()
            begin
                CompInfo.GET();

                Srno := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompInfo: Record "Company Information";
        Srno: Integer;
}

