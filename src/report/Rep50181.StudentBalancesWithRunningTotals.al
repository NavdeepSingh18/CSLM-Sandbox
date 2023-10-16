report 50181 "Student Balance Running Total"
{
    Caption = 'Student Balance With Running Total';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Student Balance With Running Total.rdlc';
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
            column(Student_Name; "Student Name")
            {

            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Enrollment No." = field("Enrollment No."), "Global Dimension 1 Code" = field("Global Dimension 1 Code");
                DataItemTableView = sorting("Entry No.");
                column(Filter_Caption; GETFILTERS())
                {

                }
                column(Enrollment_No_; "Enrollment No.")
                {

                }
                column(Document_Type; "Document Type")
                {

                }
                column(Description; Description)
                {

                }
                column(Posting_Date; "Posting Date")
                {

                }
                column(Amount; Amount)
                {

                }
                column(Balance; Balance)
                {

                }
                column(ChargeType; ChargeType)
                {

                }
                column(SNo; SNo)
                {

                }
                trigger OnPreDataItem()
                begin
                    GD2 := '';
                    SetCurrentKey("Global Dimension 2 Code");
                    If ToDate <> 0D then
                        SETRANGE("Posting Date", 0D, ToDate)
                    Else
                        SETRANGE("Posting Date", 0D, WorkDate());
                End;

                trigger OnAfterGetRecord()
                begin
                    IF GD2 <> "Global Dimension 2 Code" then begin
                        IF GD2 = '' then begin
                            Balance := 0;
                            ChargeType := 'Housing';
                            SNo := 0;
                        end;
                    end;
                    SNo += 1;
                    Balance := Balance + "G/L Entry".Amount;
                    GD2 := "Global Dimension 2 Code";
                end;
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
                ChargeType := 'Tuition';
                Balance := 0;
                GD2 := '';
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
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                    }
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
        IF ToDate = 0D THEN
            ERROR('ToDate must have a value.');

        RecEduSetup.Reset();
        RecEduSetup.SetRange("Global Dimension 1 Code", InstituteCode);
        IF RecEduSetup.FindFirst() then
            RecEduSetup.CALCFIELDS("Logo Image");
    End;

    var
        StudentMasterCS: Record "Student Master-CS";
        RecEduSetup: Record "Education Setup-CS";
        ToDate: Date;
        InstituteCode: Code[20];
        EnrollmentNo: Code[2048];
        AcademicYear: Code[20];
        Semester1: Code[100];
        Balance: Decimal;
        GD2: Code[20];
        ChargeType: Text[20];
        SNo: Integer;
}