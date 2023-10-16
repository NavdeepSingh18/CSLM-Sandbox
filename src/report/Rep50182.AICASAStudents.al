report 50182 "AICASA Students"
{
    Caption = 'AICASA Students';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AICASA Students.rdlc';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = sorting("No.");
            column(Filter_Caption1; GETFILTERS())
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
            Column("Institute_Email"; RecEduSetup."Institute E-Mail")
            {

            }
            Column("Institute_FaxNo"; RecEduSetup."Institute Fax No.")
            {

            }
            column(No_; "No.")
            {

            }
            column(E_Mail_Address; "E-Mail Address")
            {

            }
            column(Last_Name; "Last Name")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Status; Status)
            {

            }
            column(Semester; Semester)
            {

            }
            column(Course_Name; "Course Name")
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
                        Editable = false;
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

    trigger OnInitReport()
    Begin
        InstituteCode := '9100';
    End;

    var
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
}