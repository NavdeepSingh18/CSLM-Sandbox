report 50078 "Student Details List"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Details List.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE("Student Status" = FILTER(Student | "Reject & Rejoin"),
                                      Disability = FILTER(false));
            RequestFilterFields = "Academic Year", Year, "Course Code", Gender, Graduation, Section;
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(Gender_StudentMasterCS; Gender)
            {
            }
            column(Section_StudentMasterCS; Section)
            {
            }
            column(StudentName_StudentMasterCS; "Student Name")
            {
            }
            column(RollNo_StudentMasterCS; "Roll No.")
            {
            }
            column(EnrollmentNo_StudentMasterCS; "Enrollment No.")
            {
            }
            column(CourseCode_StudentMasterCS; "Course Code")
            {
            }
            column(CourseName_StudentMasterCS; "Course Name")
            {
            }
            column(FeeClassificationCode_StudentMasterCS; "Fee Classification Code")
            {
            }
            column(GETFILTERS; GETFILTERS())
            {
            }
            column(RollNo1; RollNo1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "Student Master-CS"."Roll No." <> '' THEN BEGIN
                    EVALUATE(VarInteger, "Student Master-CS"."Roll No.");
                    RollNo1 := VarInteger;
                END;
            end;

            trigger OnPreDataItem()
            begin
                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '9000');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);
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

    trigger OnPreReport()
    begin
        IF ("Student Master-CS".GETFILTER("Student Master-CS".Year) = '1ST') AND
           ("Student Master-CS".GETFILTER("Student Master-CS"."Course Code") <> '') AND ("Student Master-CS".GETFILTER("Student Master-CS".Graduation) = 'UG') THEN
            ERROR('IF Year 1ST Then Course Code Not Mandatory');

        IF ("Student Master-CS".GETFILTER("Student Master-CS".Graduation) = '') THEN
            ERROR('Please Mandatory a Graduation Filter');
    end;

    var
        DimensionValue: Record "Dimension Value";

        RollNo1: Integer;
        VarInteger: Integer;
}

