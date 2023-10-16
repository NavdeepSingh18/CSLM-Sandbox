
report 50174 "Student Status"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Status.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = SORTING("No.");
            column(StudentNumber; "No.")
            { }
            column(Last_Name; "Last Name")
            { }
            column(First_Name; "First Name")
            { }
            column(Citizenship; Citizenship)
            { }
            column(Nationality; Nationality)
            { }
            column(Ethnicity; Ethnicity)
            { }
            column(City; City)
            { }
            column(Gender; Gender)
            { }
            column(Country_Code; "Country Code")
            { }
            column(Semester; Semester)
            { }
            column(School_Status; "Student Status")
            { }
            column(Status; Status)
            { }
            //  column("Cohort";"Cohort")
            // {}
            column(Separation_Date; "Separation Date")
            { }
            column(Degree_Code; "Degree Code")
            { }
            column(Date_Cleared; "Date Cleared")
            { }
            column(Date_Awarded; "Date Awarded")
            { }
            column(Academic_Year; "Academic Year")
            { }
            column(Institute_Code; "Global Dimension 1 Code")
            {
                Caption = 'Institute Code';
            }
            column(Filter_Caption; GETFILTERS())
            { }
            column(CompInfo; CompInfo.Name)
            { }
            column(Estimated_Graduation_Date; "Estimated Graduation Date")
            { }
            column(ImageAUA; RecEduSetupAUA."Logo Image")
            {
            }
            column(ImageAICASA; RecEduSetupAICASA."Logo Image")
            {
            }

            trigger OnAfterGetRecord()
            begin
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
                    field("No."; StudentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS";
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

    trigger OnInitReport()
    begin
        CompInfo.GET();
    end;

    var
        CompInfo: Record "Company Information";
        RecEduSetupAUA: Record "Education Setup-CS";
        RecEduSetupAICASA: Record "Education Setup-CS";
        StudentMasterCS: Record "Student Master-CS";
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
        StudentNo: Code[2048];


}