report 50075 "State Wise Strength"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/State Wise Strength.rdlc';
    PreviewMode = PrintLayout;
    ProcessingOnly = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE("Country Code" = FILTER('IN'),
                                      State = FILTER(<> ''),
                                      "Student Status" = FILTER(Student | "Reject & Rejoin"),
                                      Disability = FILTER(false));
            RequestFilterFields = Graduation, "Academic Year", Year, "Admitted Year";
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(State_StudentMasterCS; State)
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

            trigger OnAfterGetRecord()
            begin
                StateRec.Reset();
                StateRec.SETRANGE(Code, "Student Master-CS".State);
                IF StateRec.findfirst() THEN
                    CountryName := StateRec.Code;

            end;

            trigger OnPreDataItem()
            begin
                DimensionValue.Reset();
                DimensionValue.SETRANGE(DimensionValue.Code, '09');
                DimensionValue.findfirst();
                DimensionValue.CALCFIELDS(DimensionValue.Image);

                IF "Student Master-CS".GETFILTER("Student Master-CS".Graduation) = 'UG' then
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
        StateRec: Record "Country/Region";
        DimensionValue: Record "Dimension Value";
        Pro1: Text[20];

        CountryName: Text[50];
}

