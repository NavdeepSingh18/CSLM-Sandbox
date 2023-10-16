report 50037 "Transfer CertificateNavOnlyCS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Transfer CertificateNavOnlyCS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Transfer Certificate Nav Only';
    dataset
    {
        dataitem(DataItem1000000024; "Student Master-CS")
        {
            DataItemTableView = SORTING("Enrollment No.");
            RequestFilterFields = "Enrollment No.";
            column(StudName; StudName)
            {
            }
            column(EnrollmentNo_StudentCOLLEGE; "Enrollment No.")
            {
            }
            column(FName; FName)
            {
            }
            column(AdYear; AdYear)
            {
            }
            column(AppNo; AppNo)
            {
            }
            column(DateJoin; DateJoin)
            {
            }
            column(DateLeaving; DateLeaving)
            {
            }
            column(DOB; DOB)
            {
            }
            column(CourseDesc; CourseDesc)
            {
            }
            column(CourseType1; CourseType1)
            {
            }
            column(Sem1; Sem1)
            {
            }
            column(RemarkOld2; RemarkOld2)
            {
            }
            column(CGPANew; CGPANew)
            {
            }
            column(TotCredit; TotCredit)
            {
            }
            column(Year1; Year1)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RemarkOld := RemarkNew;
                RemarkOld1 := RemarkNew1;
                RemarkOld2 := RemarkOld + RemarkOld1;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                IF StudentMasterCS.findfirst() THEN BEGIN
                    StudName := StudentMasterCS."Name as on Certificate";
                    AdYear := StudentMasterCS."Academic Year";
                    StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
                    CourseType1 := StudentMasterCS."Degree Code";//- 
                    CourseDesc := StudentMasterCS."Course Name";
                    AppNo := StudentMasterCS."Application No.";
                    DateJoin := StudentMasterCS."Date of Joining";
                    DateLeaving := StudentMasterCS."Date of Leaving";
                    DOB := StudentMasterCS."Date of Birth";
                    FName := StudentMasterCS."Fathers Name";
                    CGPANew := StudentMasterCS."Net Semester CGPA";
                    TotCredit := StudentMasterCS."Total Credits";
                    SemesterMasterCS.Reset();
                    SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, StudentMasterCS.Semester);
                    IF SemesterMasterCS.findfirst() THEN
                        Sem1 := SemesterMasterCS.Description;
                    CASE Sem1 OF
                        'Ist Sem':
                            Sem1 := 'ONE SEMESTER';
                        '2nd Sem':
                            Sem1 := 'SECOND SEMESTER';
                        '3rd Sem':
                            Sem1 := 'THIRD SEMESTER';
                        '4th Sem':
                            Sem1 := 'FORTH SEMESTER';
                        '5th Sem':
                            Sem1 := 'FIFTH SEMESTER';
                        '6th Sem':
                            Sem1 := 'SIXTH SEMESTER';
                        '7th Sem':
                            Sem1 := 'SEVENTH SEMESTER';
                        '8th Sem':
                            Sem1 := 'EIGHTH SEMESTER';
                        ELSE
                            Sem1 := ' ';
                    END;
                END;

                Year1 := '20' + COPYSTR(FORMAT(System.WorkDate()), 7, 8);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("Enrollment No"; EnrollmentNo)
                    {
                        Visible = false;
                        Caption = 'Enrollment No.';
                        ToolTip = 'Enrollment No. may have a value';
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            //CLEAR(ApplicationCategory);
                            CLEAR(EnrollmentNo);
                            StudentMasterCS.Reset();
                            IF StudentMasterCS.findset() THEN
                                IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                                    EnrollmentNo := StudentMasterCS."Enrollment No.";

                        end;
                    }
                    field(Remark; RemarkNew)
                    {
                        Caption = 'Remark';
                        ToolTip = 'Remark may have a value';
                        ApplicationArea = all;
                    }
                    field(Remark1; RemarkNew1)
                    {
                        Caption = 'Remark1';
                        ToolTip = 'Remark1 may have a value';
                        ApplicationArea = all;
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
        SemesterMasterCS: Record "Semester Master-CS";
        StudentMasterCS: Record "Student Master-CS";

        CourseDesc: Text[100];
        CourseType1: Code[20];
        Sem1: Text[100];
        EnrollmentNo: Code[20];
        AdYear: Code[20];
        AppNo: Code[20];
        DateJoin: Date;
        DateLeaving: Date;
        RemarkOld: Text[250];
        RemarkOld1: Text[250];
        RemarkNew: Text[250];
        RemarkNew1: Text[250];
        RemarkOld2: Text[500];
        DOB: Date;
        FName: Text[40];
        TotCredit: Decimal;
        CGPANew: Decimal;
        StudName: Text[100];
        Year1: Code[20];
}

