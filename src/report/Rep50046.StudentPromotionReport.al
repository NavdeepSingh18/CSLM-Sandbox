report 50046 "Student Promotion Report"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Promotion Report.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Promotion Header-CS"; "Promotion Header-CS")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Promotion Line-CS"; "Promotion Line-CS")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.");
                column(StudentName_StudentPromotionLineCOL; "Promotion Line-CS"."Student Name")
                {
                }
                column(CourseCode_StudentPromotionLineCOL; "Promotion Line-CS"."Course Code")
                {
                }
                column(EnrollmentNo_StudentPromotionLineCOL; "Promotion Line-CS"."Enrollment No.")
                {
                }
                column(Section_StudentPromotionLineCOL; "Promotion Line-CS".Section)
                {
                }
                column(StudentPromoted_StudentPromotionLineCOL; "Promotion Line-CS"."Student Promoted")
                {
                }
                column(AcademicYear_StudentPromotionLineCOL; "Promotion Line-CS"."Academic Year")
                {
                }
                column(PromotedAcademicYear_StudentPromotionLineCOL; "Promotion Line-CS"."Promoted  Academic Year")
                {
                }
                column(Semester_StudentPromotionLineCOL; "Promotion Line-CS".Semester)
                {
                }
                column(PromotedSemester_StudentPromotionLineCOL; "Promotion Line-CS"."Promoted Semester")
                {
                }
                column(Year_StudentPromotionLineCOL; "Promotion Line-CS".Year)
                {
                }
                column(PromotedYear_StudentPromotionLineCOL; "Promotion Line-CS"."Promoted Year")
                {
                }
                column(CourseDesc; CourseDesc)
                {
                }
                column(Acadimic; Acadimic)
                {
                }
                column(Lebal; Lebal)
                {
                }
                column(SrudentPromoted; StudentPromoted)
                {
                }
                column(Filters; "Promotion Line-CS".GETFILTERS())
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
                column(CourseType1; CourseType1)
                {
                }
                column(Category1; Category1)
                {
                }
                column(SubCategory1; SubCategory1)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    CourseMasterCS.Reset();
                    CourseMasterCS.SETRANGE(Code, "Course Code");
                    IF CourseMasterCS.findfirst() THEN
                        CourseDesc := CourseMasterCS.Description;


                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Promotion Line-CS"."Enrollment No.");
                    IF StudentMasterCS.findfirst() THEN BEGIN
                        StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
                        CourseType1 := StudentMasterCS."Degree Code";
                        SubCategory1 := StudentMasterCS.Category;
                        Category1 := StudentMasterCS."Fee Classification Code";
                    END;


                    IF "Promotion Line-CS"."Student Promoted" = TRUE THEN BEGIN
                        Acadimic := "Promotion Line-CS"."Promoted  Academic Year";
                        Lebal := 'Student Promoted List';
                    END ELSE BEGIN
                        Acadimic := "Promotion Line-CS"."Academic Year";
                        Lebal := 'Eligible Student List';
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Promotion Line-CS"."Student Promoted", StudentPromoted);

                    IF StudentPromoted THEN BEGIN
                        IF AcademicYear1 <> '' THEN
                            SETFILTER("Promotion Line-CS"."Promoted  Academic Year", '%1', AcademicYear1);
                    END ELSE
                        IF AcademicYear1 <> '' THEN
                            SETFILTER("Promotion Line-CS"."Academic Year", '%1', AcademicYear1);

                    IF CourseCode <> '' THEN
                        SETFILTER("Promotion Line-CS"."Course Code", '%1', CourseCode);
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
                    field("Student Promoted"; StudentPromoted)
                    {
                        ApplicationArea = All;
                        Caption = 'Student Promoted';
                        ToolTip = 'Student Promoted may have a value';
                    }
                    field(Course; CourseCode)
                    {
                        TableRelation = "Course Master-CS".Code;
                        ApplicationArea = All;
                        Caption = 'Course';
                        ToolTip = 'Course may have a value';

                    }
                    field("Academic Year"; AcademicYear1)
                    {
                        TableRelation = "Academic Year Master-CS".Code;
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        ToolTip = 'Academic Year may have a value';
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

    trigger OnPreReport()
    begin

        CompanyInformation.GET();
        //CompanyInformation.CALCFIELDS(CompanyInformation.Picture);
    end;

    var
        CompanyInformation: Record "Company Information";
        CourseMasterCS: Record "Course Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        StudentPromoted: Boolean;
        CourseCode: Code[10];
        AcademicYear1: Code[20];
        CourseDesc: Text;
        Acadimic: Code[20];
        Lebal: Text[50];

        CourseType1: Text[30];
        Category1: Code[20];
        SubCategory1: Code[20];
}

