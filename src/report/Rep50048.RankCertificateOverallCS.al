report 50048 "Rank Certificate(Overall)CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Rank Certificate(Overall)CS.rdlc';
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
            column(CurrentSem; CurrentSem)
            {
            }
            column(OverAllSemRank; OverAllSemRank)
            {
            }

            trigger OnAfterGetRecord()
            begin

                IF RemarkNew = '' THEN
                    RemarkOld2 := "Certificates Application-CS".Statement
                ELSE BEGIN
                    RemarkOld := RemarkNew;
                    RemarkOld1 := RemarkNew1;
                    RemarkOld2 := format(RemarkOld + RemarkOld1);
                END;

                CertificatesApplicationCS.Reset();
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Application No.", "Application No.");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Enrollment No.", "Enrollment No.");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Application Category", "Application Category");
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
                                Sem1 := 'FIRST SEMESTER';
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
                                Seq := SemesterMasterCS.Sequence - 1;
                                SemesterMasterCS1.Reset();
                                SemesterMasterCS1.SETRANGE(SemesterMasterCS1.Sequence, Seq);
                                IF SemesterMasterCS1.findfirst() THEN
                                    IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::"Course Completion" THEN
                                        CurrentSem := StudentMasterCS.Semester
                                    ELSE
                                        CurrentSem := SemesterMasterCS1.Code;
                                StudentExtensionNewCS.Reset();
                                StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                                IF StudentExtensionNewCS.findfirst() THEN
                                    OverAllSemRank := StudentExtensionNewCS."Final Rank";

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
                        Caption = 'Enrollment No.';
                        ToolTip = 'Enrollment No. may have a value';
                        ApplicationArea = All;

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
                        Caption = 'Application Category';
                        Visible = false;
                        Tooltip = 'Application Category may have a value';
                        ApplicationArea = All;

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
                        Caption = 'Certificate Purpose';
                        Visible = false;
                        ToolTip = 'Certificate Purpose may have a value';
                        ApplicationArea = All;

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
                        Caption = 'Remark';
                        Tooltip = 'Remarks may have a value';
                        ApplicationArea = All;
                    }
                    field(Remark1; RemarkNew1)
                    {
                        Caption = 'Remark1';
                        Tooltip = 'Remark1 may have a value';
                        ApplicationArea = All;
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
        StudentExtensionNewCS: Record "Student Extension New-CS";
        SemesterMasterCS1: Record "Semester Master-CS";
        CourseDesc: Text[100];
        CourseType1: Code[20];
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
        RemarkOld2: Text[250];

        DOB: Code[20];
        FName: Text[40];
        TotCredit: Decimal;
        CGPANew: Decimal;
        StudName: Text[100];

        OverAllSemRank: Text[30];
        CurrentSem: Code[10];
        Seq: Integer;

}

