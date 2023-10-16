report 50054 "Branch Section Wise Strength"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Branch Section Wise Strength.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Master-CS"; "Course Master-CS")
        {
            DataItemTableView = SORTING(Code);
            PrintOnlyIfDetail = true;
            column(DimensionValue_Image; DimensionValue.Image)
            {
            }
            column(Code_CourseCOLLEGE; "Course Master-CS".Code)
            {
            }
            column(Description_CourseCOLLEGE; "Course Master-CS".Description)
            {
            }
            column(Semester_CourseCOLLEGE; "Course Master-CS".Semester)
            {
            }
            column(AcademicYear_CourseCOLLEGE; "Course Master-CS"."Academic Year")
            {
            }
            dataitem("Student Master-CS"; "Student Master-CS")
            {
                DataItemLink = "Course Code" = FIELD("Code");
                DataItemTableView = WHERE("Course Code" = FILTER(<> ''),
                                          Year = FILTER(<> '1ST'),
                                          "Graduation" = FILTER('UG'),
                                          "Student Status" = FILTER(Student | "Reject & Rejoin"),
                                          Disability = FILTER(false));
                RequestFilterFields = "Course Code", "Academic Year", Year;
                column(NameasonCertificate_StudentCOLLEGE; "Student Master-CS"."Name as on Certificate")
                {
                }
                column(CourseCode_StudentCOLLEGE; "Student Master-CS"."Course Code")
                {
                }
                column(Section_StudentCOLLEGE; "Student Master-CS".Section)
                {
                }
                column(Gender_StudentCOLLEGE; "Student Master-CS".Gender)
                {
                }
                column(CourseDesc; CourseDesc)
                {
                }
                column(CompName; CompanyInformation.Name)
                {
                }
                column(Add; CompanyInformation.Address)
                {
                }
                column(Add2; CompanyInformation."Address 2")
                {
                }
                column(City; CompanyInformation.City)
                {
                }
                column(Postcode; CompanyInformation."Post Code")
                {
                }
                column(Picture; CompanyInformation.Picture)
                {
                }
                column(Getfilters; "Student Master-CS".GETFILTERS())
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CourseMasterCS.Reset();
                    CourseMasterCS.SETRANGE(Code, "Course Code");
                    IF CourseMasterCS.findfirst() THEN
                        CourseDesc := CourseMasterCS.Description;
                end;

                trigger OnPreDataItem()
                begin
                    CompanyInformation.GET();
                    CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
                end;
            }

            trigger OnAfterGetRecord()
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
            area(content)
            {
                group(Options)
                {
                    field("Academic Year"; Academic1)
                    {
                        TableRelation = "Academic Year Master-CS".Code;
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        ToolTip = 'Academic Year may have a value';
                    }
                    field(Semester; Semester1)
                    {
                        TableRelation = "Semester Master-CS".Code;
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'Semester';
                        ToolTip = 'Semester may have a value';
                    }
                    field(Year; Year1)
                    {
                        TableRelation = "Year Master-CS".Code;
                        Visible = false;
                        ApplicationArea = All;
                        Caption = 'Year';
                        ToolTip = 'Year may have a value';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CourseMasterCS: Record "Course Master-CS";
        CompanyInformation: Record "Company Information";
        DimensionValue: Record "Dimension Value";
        CourseDesc: Text[100];
        Semester1: Code[10];
        Academic1: Code[10];
        Year1: Code[10];

}

