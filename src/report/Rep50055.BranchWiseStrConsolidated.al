report 50055 "Branch Wise Str-Consolidated"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Branch Wise Str-Consolidated.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Course Master-CS"; "Course Master-CS")
        {
            dataitem("Student Master-CS"; "Student Master-CS")
            {
                DataItemLink = "Course Code" = FIELD("Code"),
                               Graduation = FIELD(Graduation);
                DataItemTableView = WHERE("Course Code" = FILTER(<>''),
                                          "Student Status" = FILTER(Student | "Reject & Rejoin"),
                                          "Disability" = FILTER(false));
                RequestFilterFields = Graduation, "Academic Year", "Course Code";
                column(NameasonCertificate_StudentCOLLEGE; "Student Master-CS"."Name as on Certificate")
                {
                }
                column(AcademicYear_StudentCOLLEGE; "Student Master-CS"."Academic Year")
                {
                }
                column(CourseCode_StudentCOLLEGE; "Student Master-CS"."Course Code")
                {
                }
                column(CourseName_StudentCOLLEGE; "Student Master-CS"."Course Name")
                {
                }
                column(Section_StudentCOLLEGE; "Student Master-CS".Section)
                {
                }
                column(Gender_StudentCOLLEGE; "Student Master-CS".Gender)
                {
                }
                column(CourseType_StudentCOLLEGE; "Student Master-CS"."Course Type")
                {
                }
                column(Getfilters; "Student Master-CS".GETFILTERS())
                {
                }
                column(Pro1; Pro1)
                {
                }
                column(Year_StudentCOLLEGE; "Student Master-CS".Year)
                {
                }
                column(DimensionValue_Image; DimensionValue.Image)
                {
                }
                column(Male1; Male1)
                {
                }
                column(Female1; Female1)
                {
                }
                column(Male2; Male2)
                {
                }
                column(Female2; Female2)
                {
                }
                column(Male3; Male3)
                {
                }
                column(Female3; Female3)
                {
                }
                column(Male4; Male4)
                {
                }
                column(Female4; Female4)
                {
                }
                column(TotalMale1; TotalMale1)
                {
                }
                column(TotalFemale1; TotalFemale1)
                {
                }
                column(TotalMale2; TotalMale2)
                {
                }
                column(TotalFemale2; TotalFemale2)
                {
                }
                column(TotalMale3; TotalMale3)
                {
                }
                column(TotalFemale3; TotalFemale3)
                {
                }
                column(TotalMale4; TotalMale4)
                {
                }
                column(TotalFemale4; TotalFemale4)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    DimensionValue.Reset();
                    DimensionValue.SETRANGE(DimensionValue.Code, '9000');
                    DimensionValue.findfirst();
                    DimensionValue.CALCFIELDS(DimensionValue.Image);

                    IF "Student Master-CS".GETFILTER("Student Master-CS".Graduation) = 'UG' THEN
                        Pro1 := 'B.Tech'
                    ELSE
                        Pro1 := 'M.Tech / MCA';



                    IF "Student Master-CS".Year = '1ST' THEN
                        IF "Student Master-CS".Gender = "Student Master-CS".Gender::Male THEN BEGIN
                            Male1 := Male1 + 1;
                            TotalMale1 := TotalMale1 + 1;
                        END ELSE BEGIN
                            Female1 := Female1 + 1;
                            TotalFemale1 := TotalFemale1 + 1;
                        END;



                    IF "Student Master-CS".Year = '2ND' THEN
                        IF "Student Master-CS".Gender = "Student Master-CS".Gender::Male THEN BEGIN
                            Male2 := Male2 + 1;
                            TotalMale2 := TotalMale2 + 1;
                        END ELSE BEGIN
                            Female2 := Female2 + 1;
                            TotalFemale2 := TotalFemale2 + 1;
                        END;


                    IF "Student Master-CS".Year = '3RD' THEN
                        IF "Student Master-CS".Gender = "Student Master-CS".Gender::Male THEN BEGIN
                            Male3 := Male3 + 1;
                            TotalMale3 := TotalMale3 + 1;
                        END ELSE BEGIN
                            Female3 := Female3 + 1;
                            TotalFemale3 := TotalFemale3 + 1;
                        END;



                    IF "Student Master-CS".Year = '4TH' THEN
                        IF "Student Master-CS".Gender = "Student Master-CS".Gender::Male THEN BEGIN
                            Male4 := Male4 + 1;
                            TotalMale4 := TotalMale4 + 1;
                        END ELSE BEGIN
                            Female4 := Female4 + 1;
                            TotalFemale4 := TotalFemale4 + 1;
                        END;

                end;

                trigger OnPreDataItem()
                begin

                    Male1 := 0;
                    Female1 := 0;
                    Male2 := 0;
                    Female2 := 0;
                    Male3 := 0;
                    Female3 := 0;
                    Male4 := 0;
                    Female4 := 0;
                end;
            }
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
                        TableRelation = "Course Master-CS".Code;
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
        Male1: Integer;
        Female1: Integer;
        Semester1: Code[10];
        Academic1: Code[10];
        Year1: Code[10];
        Pro1: Text[20];

        Male2: Integer;
        Female2: Integer;
        Male3: Integer;
        Female3: Integer;
        Male4: Integer;
        Female4: Integer;
        TotalMale1: Integer;
        TotalFemale1: Integer;
        TotalMale2: Integer;
        TotalFemale2: Integer;
        TotalMale3: Integer;
        TotalFemale3: Integer;
        TotalMale4: Integer;
        TotalFemale4: Integer;
}

