report 50167 "Finance Fee"
{
    Caption = 'Student Fee Component Details';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Finance Fee.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            column(SNo; SNo)
            {

            }
            column(No; "No.")
            {

            }
            column(Semester; Semester)
            {

            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {

            }
            column(Academic_Year; "Academic Year")
            {

            }
            column(Term; Term)
            {

            }
            column(Student_Name; "Student Name")
            {

            }
            column(Image; EducationSetup."Logo Image")
            {

            }
            dataitem("Fee Course Head-CS"; "Fee Course Head-CS")
            {
                DataItemLink = "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code"), Semester = FIELD(Semester), "Academic Year" = FIELD("Academic Year"), "Course Code" = field("Course Code");
                DataItemTableView = WHERE("Other Fees" = FILTER(false));

                dataitem("Fee Course Line-CS"; "Fee Course Line-CS")
                {
                    DataItemLink = "Document No." = FIELD("No.");

                    column(GenAmt; GenAmt)
                    {

                    }
                    column(Fee_Code; "Fee Code")
                    {

                    }
                    column(NotGeneratedAmt; NotGeneratedAmt)
                    {

                    }
                    column(ActualAmt; ActualAmt)
                    {

                    }
                    column(FeeGroup; FeeGroup)
                    {

                    }
                    column(FeeType; FeeType)
                    {

                    }
                    trigger OnAfterGetRecord()
                    begin
                        GenAmt := 0;
                        ActualAmt := 0;
                        NotGeneratedAmt := 0;
                        FeeType := '';

                        FeeComp.Get("Fee Course Line-CS"."Fee Code");
                        SAPCode.Reset();
                        SAPCode.SetRange("SAP Code", FeeComp."SAP Code");
                        IF SAPCode.FindFirst() then
                            FeeType := SAPCode."SAP Company Code";

                        FeeGroup := Format(FeeComp."Fee Group");

                        ActualAmt := FeeGeneration.StudentTotalFee("Student Master-CS"."No.", "Fee Course Line-CS"."Fee Code", '', '', false, SemFee, Grenville);

                        GLEntry.Reset();
                        GLEntry.SETRANGE("Enrollment No.", "Student Master-CS"."Enrollment No.");
                        GLEntry.SETRANGE("Academic Year", "Student Master-CS"."Academic Year");
                        GLEntry.SETRANGE(Semester, "Student Master-CS".Semester);
                        GLEntry.SetRange("Fee Code", "Fee Course Line-CS"."Fee Code");
                        IF GLEntry.FindSet() THEN BEGIN
                            repeat
                                GenAmt += -1 * GLEntry.Amount;
                            until GLEntry.Next() = 0;
                        end;

                        If (ActualAmt = 0) AND (GenAmt = 0) then
                            CurrReport.Skip();

                        NotGeneratedAmt := ActualAmt - GenAmt;

                    end;

                }
            }

            trigger OnPreDataItem()
            begin
                SNo := 0;
                SetRange("Global Dimension 1 Code", InstituteCode);
                SETRANGE("Academic Year", AcademicYear);
                IF SemesterCode <> '' THEN
                    SetFilter(Semester, SemesterCode);
                IF EnrollmentNo <> '' THEN
                    SetFilter("Enrollment No.", EnrollmentNo);

                EducationSetup.Reset();
                EducationSetup.SetRange("Global Dimension 1 Code", InstituteCode);
                If EducationSetup.FindFirst() then
                    EducationSetup.CalcFields(EducationSetup."Logo Image");

            end;

            trigger OnAfterGetRecord()
            begin
                SNo := SNo + 1;

            End;
        }
    }
    requestpage
    {

        layout
        {
            area(content)
            {
                field("Institute Code"; InstituteCode)
                {
                    ApplicationArea = All;
                    Caption = 'Institute Code';
                    ToolTip = 'Institute Code may have a value';
                    TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('INSTITUTE'));
                }
                field("Academic Year"; AcademicYear)
                {
                    ApplicationArea = All;
                    Caption = 'Academic Year';
                    ToolTip = 'Academic Year must have a value';
                    TableRelation = "Academic Year Master-CS";

                }
                field("Semester Code"; SemesterCode)
                {
                    ApplicationArea = ALL;
                    TableRelation = "Semester Master-CS".code;
                    Caption = 'Semester';
                    ToolTip = 'Semester must have a value';
                }
                field("Enrollment No"; EnrollmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    ToolTip = 'Enrollment No. must have a value';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        StudentMasterCS.Reset();
                        StudentMasterCS.findset();
                        IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                            EnrollmentNo := StudentMasterCS."Enrollment No.";
                    end;
                }

            }
        }
    }
    trigger OnPreReport()
    begin
        IF (InstituteCode = '') THEN
            ERROR('Institude Code must have a value in it');

    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        GLEntry: Record "G/L Entry";
        FeeComp: Record "Fee Component Master-CS";
        EducationSetup: Record "Education Setup-CS";
        SAPCode: Record "SAP Fee Code";
        FeeGeneration: Report "Fee Generation New";
        InstituteCode: Code[20];
        AcademicYear: Code[100];
        EnrollmentNo: Code[2048];
        SemesterCode: Code[2048];
        ActualAmt: Decimal;
        GenAmt: Decimal;
        NotGeneratedAmt: Decimal;
        SNo: Integer;
        FeeGroup: Text;
        FeeType: Code[20];
        SemFee: Decimal;
        Grenville: Decimal;

    procedure VariablePassing(GD1: Code[20]; AdYear: Code[20]; Sem: Code[20]; EnRoll: Code[20]);
    begin
        InstituteCode := GD1;
        AcademicYear := AdYear;
        SemesterCode := Sem;
        EnrollmentNo := EnRoll;
    end;
}