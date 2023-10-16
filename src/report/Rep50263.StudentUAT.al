report 50263 StudentUAT
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Students That Have Not Registered';
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/StudentDetails.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("No.") where("Student Group" = Filter(' '));

            column(Filter_Caption1; AllFilters)
            { }
            Column(LogoImageAUA; RecEduSetup."Logo Image")
            {

            }
            Column("Institute_Name"; RecEduSetup."Institute Name")
            {

            }
            Column("Institute_Address"; RecEduSetup."Institute Address")
            {

            }
            Column("Institute_Address2"; RecEduSetup."Institute Address 2")
            {

            }
            Column("Institute_City"; RecEduSetup."Institute City")
            {

            }
            Column("Institute_PostCode"; RecEduSetup."Institute Post Code")
            {

            }
            Column("Institute_Phone"; RecEduSetup."Institute Phone No.")
            {

            }
            Column("Institute_Email"; RecEduSetup."Institute E-Mail")
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(StudentNumber; "No.")
            { }
            column(EMAIL; "Student Master-CS"."E-Mail Address")
            { }
            column(Last_Name; "Last Name")
            { }
            column(First_Name; "First Name")
            { }
            column(Citizenship; Citizenship)
            { }
            column(Semester; Semester)
            { }
            column(School_Status; Status)
            { }
            column(CompInfo; CompInfo.Name)
            { }
            column(ImageAUA; RecEduSetupAUA."Logo Image")
            {
            }
            column(ImageAICASA; RecEduSetupAICASA."Logo Image")
            {
            }
            column(Code1; Code1)
            {
                Caption = 'Code';
            }

            column(Result; Result)
            {

            }

            trigger OnPreDataItem()
            begin


                Setfilter(Status, '%1|%2|%3', 'ENR', 'PROB', 'EXTLOA');
                SetRange("Global Dimension 1 Code", InstituteCode);
                if StudentNo <> '' then
                    SetFilter("No.", StudentNo);
                // if Semester1 <> '' then
                //     SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);

                IF SemesterFilter <> '' then
                    SetFilter(Semester, SemesterFilter);
            end;

            trigger OnAfterGetRecord()
            var

                StudentSubjectExam: Record "Student Subject Exam";
            begin
                Code1 := '';
                SemesterFilter := '';
                StudentNoFilter := '';
                AllFilters := '';
                InstituteCodeFilter := '';
                EnrollmentFilter := '';
                AcademicYearFilter := '';

                // SemesterMaster_gRec.Reset();
                // SemesterMaster_gRec.SetRange(Code, "Student Master-CS".Semester);
                // IF SemesterMaster_gRec.FindFirst() then
                //     IF SemesterMaster_gRec.Sequence <> 4 then
                //         CurrReport.Skip();



                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                if StudentNo <> '' then
                    StudentNoFilter := ', Student No.:' + "No.";
                //if Semester1 <> '' then
                SemesterFilter := ', Semester:' + "Student Master-CS".Semester;
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";


                AllFilters := InstituteCodeFilter + EnrollmentFilter + StudentNoFilter + SemesterFilter + AcademicYearFilter;
                IF InstituteCode = '9000' then begin
                    RecEduSetupAUA.Reset();
                    RecEduSetupAUA.SetRange("Global Dimension 1 Code", '9000');
                    IF RecEduSetupAUA.FindFirst() then
                        RecEduSetupAUA.CALCFIELDS("Logo Image");
                end;
                IF InstituteCode = '9100' then begin
                    RecEduSetupAICASA.Reset();
                    RecEduSetupAICASA.SetRange("Global Dimension 1 Code", '9100');
                    IF RecEduSetupAICASA.FindFirst() then
                        RecEduSetupAICASA.CALCFIELDS("Logo Image");
                End;
                Code1 := 'CK';

            end;

        }

    }
    requestpage
    {

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Institute Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Institute Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
                    }
                    // field("Semester"; Semester1)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Semester';
                    //     TableRelation = "Semester Master-CS";
                    // }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        TableRelation = "Academic Year Master-CS";
                    }
                    Field(SemesterFilter; SemesterFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester Filter';
                        TableRelation = "Semester Master-CS";
                    }

                }

            }
        }

    }

    trigger OnInitReport()
    begin
        CompInfo.GET();
    end;

    trigger OnPreReport()
    begin
        IF InstituteCode = '' THEN
            ERROR('Institute Code must have a value in it');

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");
    end;

    var
        CompInfo: Record "Company Information";
        RecEduSetupAUA: Record "Education Setup-CS";
        RecEduSetupAICASA: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        SemesterMaster_gRec: Record "Semester Master-CS";
        Semester1: Code[100];
        StudentNo: Code[2048];
        Code1: Text[50];
        AllFilters: Text;
        SemesterFilter: Code[100];
        StudentNoFilter: Code[2048];
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        InstituteCodeFilter: Code[20];
        AcademicYearFilter: Text;
        EnrollmentFilter: Code[2048];

}