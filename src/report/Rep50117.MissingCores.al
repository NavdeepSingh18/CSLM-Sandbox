report 50117 "Missing Cores"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/MissingCores.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("No.");
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
            column(Last_Name; "Last Name")
            { }
            column(First_Name; "First Name")
            { }
            column(E_Mail_Address; "E-Mail Address")
            { }
            column(Semester; Semester)
            { }
            column(School_Status; "Student Status")
            { }
            column(CompInfo; CompInfo.Name)
            { }
            column(ImageAUA; RecEduSetupAUA."Logo Image")
            {
            }
            column(ImageAICASA; RecEduSetupAICASA."Logo Image")
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange("Global Dimension 1 Code", InstituteCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);
                if StudentNo <> '' then
                    "Student Master-CS".SetFilter("No.", StudentNo);
                if Semester1 <> '' then
                    "Student Master-CS".SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
            end;

            trigger OnAfterGetRecord()
            begin
                SemesterFilter := '';
                StudentNoFilter := '';
                AllFilters := '';
                InstituteCodeFilter := '';
                EnrollmentFilter := '';
                AcademicYearFilter := '';


                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                IF EnrollmentNo <> '' then
                    EnrollmentFilter := ', Enrollment No.:' + "Enrollment No.";
                if StudentNo <> '' then
                    StudentNoFilter := ', Student No.:' + "No.";
                if Semester1 <> '' then
                    SemesterFilter := ', Semester:' + Semester;
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";


                AllFilters := InstituteCodeFilter + EnrollmentFilter + StudentNoFilter + SemesterFilter + AcademicYearFilter;

                RecEduSetupAUA.Reset();
                RecEduSetupAUA.SetRange("Global Dimension 1 Code", '9000');
                IF RecEduSetupAUA.FindFirst() then
                    RecEduSetupAUA.CALCFIELDS("Logo Image");

                RecEduSetupAICASA.Reset();
                RecEduSetupAICASA.SetRange("Global Dimension 1 Code", '9100');
                IF RecEduSetupAICASA.FindFirst() then
                    RecEduSetupAICASA.CALCFIELDS("Logo Image");


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
                        Caption = 'Institude Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field("Enrollment No"; EnrollmentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Enrollment No.';
                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            StudentMasterCS.Reset();
                            StudentMasterCS.findset();
                            IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                                EnrollmentNo := StudentMasterCS."Enrollment No.";
                        end;
                    }
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
                    }
                    field("Semester"; Semester1)
                    {
                        ApplicationArea = All;
                        Caption = 'Semester';
                        TableRelation = "Semester Master-CS";

                    }
                    field("Academic Year"; AcademicYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Academic Year';
                        TableRelation = "Academic Year Master-CS";
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
        Semester1: Code[100];
        StudentNo: Code[2048];
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