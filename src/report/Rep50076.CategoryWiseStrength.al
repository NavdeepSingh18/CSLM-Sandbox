report 50076 "Category Wise Strength"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Category Wise Strength.rdlc';
    PreviewMode = PrintLayout;
    ProcessingOnly = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE("Student Status" = FILTER(Student | "Reject & Rejoin"),
                                      Disability = FILTER(false));
            RequestFilterFields = Graduation, "Academic Year", Year, "Admitted Year", "Course Code";
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(FeeClassificationCode_StudentMasterCS; "Fee Classification Code")
            {
            }
            column(AcademicYear_StudentMasterCS; "Academic Year")
            {
            }
            column(NameasonCertificate_StudentMasterCS; "Name as on Certificate")
            {
            }
            column(CourseCode_StudentMasterCS; "Course Code")
            {
            }
            column(Section_StudentMasterCS; Section)
            {
            }
            column(Gender_StudentMasterCS; Gender)
            {
            }
            column(Getfilters; GETFILTERS())
            {
            }
            column(Pro1; Pro1)
            {
            }
            column(CountryName; CountryName)
            {
            }
            column(Male1; Male1)
            {
            }
            column(Male2; Male2)
            {
            }
            column(Female1; Female1)
            {
            }
            column(Female2; Female2)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF "Student Master-CS"."Fee Classification Code" = 'GENERAL' THEN
                    IF "Student Master-CS".Gender = "Student Master-CS".Gender::Male THEN
                        Male1 := Male1 + 1
                    ELSE
                        Female1 := Female1 + 1;




                IF ("Student Master-CS"."Fee Classification Code" = 'FOREIGN/NRI') OR ("Student Master-CS"."Fee Classification Code" = 'NRI SPECIAL') THEN
                    IF "Student Master-CS".Gender = "Student Master-CS".Gender::Male THEN
                        Male2 := Male2 + 1
                    ELSE
                        Female2 := Female2 + 1;

            end;

            trigger OnPreDataItem()
            begin

                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '9000');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);


                IF "Student Master-CS".GETFILTER("Student Master-CS".Graduation) = 'UG' THEN
                    Pro1 := 'B.Tech'
                ELSE
                    Pro1 := 'M.Tech / MCA'

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
        DimensionValue: Record "Dimension Value";
        Pro1: Text[20];

        CountryName: Text[50];
        Male1: Integer;
        Male2: Integer;
        Female1: Integer;
        Female2: Integer;
}

