report 50180 "New Student WithoutSchoolEmail"
{
    Caption = 'New Students Without School Email Accounts';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/New Students Without School Email Accounts.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.") where("E-Mail Address" = filter(''));
            column(Filter_Caption1; Allfilters)
            {

            }
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
            Column("Institute_Email"; RecEduSetup.url)
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(Campus; "Global Dimension 1 Code")
            { }
            column(Start_Date; "Date of Joining")
            { }
            column(E_Mail_Address; "E-Mail Address")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(First_Name; "First Name")
            {

            }

            column(School_Status; Status)
            {

            }
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
                IF Semester1 <> '' THEN
                    SetFilter(Semester, Semester1);
                IF AcademicYear <> '' THEN
                    SetFilter("Academic Year", AcademicYear);
            end;

            trigger OnAfterGetRecord()
            begin
                InstituteCodeFilter := '';
                EnrollmentFilter := '';
                SemesterFilter := '';
                AcademicYearFilter := '';
                AllFilters := '';

                IF InstituteCode <> '' then
                    InstituteCodeFilter := 'Institute Code:' + "Global Dimension 1 Code";
                IF EnrollmentNo <> '' then
                    EnrollmentFilter := ', Enrollment No.:' + "Enrollment No.";
                IF Semester1 <> '' then
                    SemesterFilter := ', Semester:' + Semester;
                IF AcademicYear <> '' then
                    AcademicYearFilter := ', Academic Year:' + "Academic Year";

                AllFilters := InstituteCodeFilter + EnrollmentFilter + SemesterFilter + AcademicYearFilter;


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
                        Caption = 'Institute Code';
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
    trigger OnPreReport()
    begin
        IF InstituteCode = '' THEN
            ERROR('Institute Code must have a value in it');

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");
    End;


    var
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";

        RecEduSetupAUA: Record "Education Setup-CS";
        RecEduSetupAICASA: Record "Education Setup-CS";
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
        AllFilters: Text;
        InstituteCodeFilter: Code[20];
        SemesterFilter: Code[100];
        AcademicYearFilter: Text;
        EnrollmentFilter: Code[2048];
}