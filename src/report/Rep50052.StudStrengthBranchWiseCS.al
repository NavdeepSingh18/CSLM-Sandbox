report 50052 "Stud Strength-Branch WiseCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Stud Strength-Branch WiseCS.rdlc';
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
            column(AcademicYear_CourseCOLLEGE; "Course Master-CS"."Academic Year")
            {
            }
            column(Semester_CourseCOLLEGE; "Course Master-CS".Semester)
            {
            }
            column(CourseType_CourseCOLLEGE; "Course Master-CS"."Course Type")
            {
            }
            dataitem("Student Master-CS"; "Student Master-CS")
            {
                DataItemLink = "Course Code" = FIELD("Code");
                DataItemTableView = WHERE("Course Code" = FILTER(<> ''),
                                          "Student Status" = FILTER(Student | "Reject & Rejoin"),
                                          Disability = FILTER(false));


                RequestFilterFields = Graduation, "Academic Year", Year;
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
                column(Pro1; Pro1)
                {
                }

                trigger OnPreDataItem()
                begin

                    IF "Student Master-CS".GETFILTER("Student Master-CS".Graduation) = 'UG' THEN
                        Pro1 := 'B.Tech'
                    ELSE
                        Pro1 := 'M.Tech / MCA';
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE(DimensionValue.Code, '9000');
                    DimensionValue.findfirst();
                    DimensionValue.CALCFIELDS(DimensionValue.Image);
                end;
            }

            trigger OnAfterGetRecord()
            begin

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
        DimensionValue: Record "Dimension Value";
        CompanyInformation: Record "Company Information";
        Semester1: Code[10];
        Academic1: Code[10];
        Year1: Code[10];
        Pro1: Text[20];

}

