report 50080 "Course Completion Cert. CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Course Completion Cert. CS.rdlc';
    PreviewMode = PrintLayout;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Certificates Application-CS"; "Certificates Application-CS")
        {
            DataItemTableView = SORTING("Application No.");
            RequestFilterFields = "Enrollment No.", "Application Category", Purpose;
            column(StudName; StudName)
            {
            }
            column(StudentName_ApplicationCertificateCOL; "Certificates Application-CS"."Student Name")
            {
            }
            column(EnrollmentNo_ApplicationCertificateCOL; "Certificates Application-CS"."Enrollment No.")
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
            column(AdYear1; AdYear1)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF RemarkNew = '' THEN
                    RemarkOld2 := "Certificates Application-CS".Statement
                ELSE BEGIN
                    RemarkOld := RemarkNew;
                    RemarkOld1 := RemarkNew1;
                    RemarkOld2 := RemarkOld + RemarkOld1;
                END;

                CertificatesApplicationCS.Reset();
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Application No.", "Application No.");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Enrollment No.", "Enrollment No.");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS.Purpose, Purpose);
                IF CertificatesApplicationCS.findfirst() THEN BEGIN
                    CertificatesApplicationCS.Remark := RemarkOld;
                    CertificatesApplicationCS.Remark1 := RemarkOld1;
                    CertificatesApplicationCS.Modify();
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                    IF StudentMasterCS.findfirst() THEN BEGIN
                        StudName := StudentMasterCS."Name as on Certificate";
                        AdYear := StudentMasterCS."Academic Year";
                        AdYear1 := COPYSTR(AdYear, 6, 9);
                        StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
                        CourseType1 := StudentMasterCS."Degree Code";//- Field type change
                        CourseDesc := StudentMasterCS."Course Name";
                        AppNo := StudentMasterCS."Application No.";
                        DateJoin := FORMAT(StudentMasterCS."Date of Joining");
                        DateLeaving := FORMAT(StudentMasterCS."Date of Leaving");
                        DOB := FORMAT(StudentMasterCS."Date of Birth");
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
                                Sem1 := 'FOURTH SEMESTER';
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
                END;
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
                        ApplicationArea = All;
                        Caption = 'Enrollment No.';
                        ToolTip = 'Enrollment No. may have a value';

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            CLEAR(ApplicationCategory);
                            CLEAR(EnrollmentNo);
                            CertificatesApplicationCS.Reset();
                            IF CertificatesApplicationCS.findset() THEN
                                IF PAGE.RUNMODAL(0, CertificatesApplicationCS) = ACTION::LookupOK THEN
                                    EnrollmentNo := CertificatesApplicationCS."Enrollment No.";

                        end;
                    }
                    field("Application Category"; ApplicationCategory)
                    {
                        ApplicationArea = All;
                        Caption = 'Application Category';
                        ToolTip = 'Application Category may have a value';
                        Visible = false;


                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            CLEAR(ApplicationCategory);
                            IF EnrollmentNo <> '' THEN BEGIN
                                "Certificates Application-CS".SETRANGE("Certificates Application-CS"."Enrollment No.", EnrollmentNo);
                                IF PAGE.RUNMODAL(0, "Certificates Application-CS") = ACTION::LookupOK THEN
                                    ApplicationCategory := "Certificates Application-CS"."Application Category";

                            END;
                        end;
                    }
                    field("Certificate Purpose"; CertificatePurpose)
                    {
                        ApplicationArea = All;
                        Caption = 'Certificate Purpose';
                        ToolTip = 'Certificate Purpose may have a value';
                        Visible = false;

                        trigger OnLookup(var Text: Text): Boolean
                        begin

                            ApplicationCertPurposeCS.Reset();
                            ApplicationCertPurposeCS.SETRANGE(ApplicationCertPurposeCS.Code, "Certificates Application-CS".Purpose);
                            ApplicationCertPurposeCS.findset();
                            IF PAGE.RUNMODAL(50371, ApplicationCertPurposeCS) = ACTION::LookupOK THEN
                                CertificatePurpose := ApplicationCertPurposeCS.Code;
                        end;
                    }
                    field(Remark; RemarkNew)
                    {
                        ApplicationArea = All;
                        Caption = 'Remarks';
                        ToolTip = 'Remark may have a value';
                    }
                    field(Remark1; RemarkNew1)
                    {
                        ApplicationArea = All;
                        Caption = 'Remark1';
                        ToolTip = 'Remark1 may have a value';
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
        CertificatesApplicationCS: Record "Certificates Application-CS";
        ApplicationCertPurposeCS: Record "Application Cert Purpose-CS";
        CourseDesc: Text[100];
        CourseType1: Text[30];
        Sem1: Text[100];

        EnrollmentNo: Code[20];

        ApplicationCategory: Code[20];

        CertificatePurpose: Code[20];

        AdYear: Code[20];
        AppNo: Code[20];
        DateJoin: Code[20];
        DateLeaving: Code[20];
        RemarkOld: Text[250];
        RemarkOld1: Text[250];
        RemarkNew: Text[250];
        RemarkNew1: Text[250];
        RemarkOld2: Text[500];

        DOB: Code[20];
        FName: Text[40];
        TotCredit: Decimal;
        CGPANew: Decimal;
        AdYear1: Text;
        StudName: Text[100];
}