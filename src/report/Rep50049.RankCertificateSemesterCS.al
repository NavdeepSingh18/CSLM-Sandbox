report 50049 "Rank Certificate(Semester)CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Rank Certificate(Semester)CS.rdlc';
    PreviewMode = PrintLayout;

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
            column(Sem1GPA; Sem1GPA)
            {
            }
            column(Sem2GPA; Sem2GPA)
            {
            }
            column(Sem3GPA; Sem3GPA)
            {
            }
            column(Sem4GPA; Sem4GPA)
            {
            }
            column(Sem5GPA; Sem5GPA)
            {
            }
            column(Sem6GPA; Sem6GPA)
            {
            }
            column(Sem7GPA; Sem7GPA)
            {
            }
            column(Sem8GPA; Sem8GPA)
            {
            }
            column(Sem1GPANew; Sem1GPANew)
            {
            }
            column(Sem2GPANew; Sem2GPANew)
            {
            }
            column(Sem3GPANew; Sem3GPANew)
            {
            }
            column(Sem4GPANew; Sem4GPANew)
            {
            }
            column(Sem5GPANew; Sem5GPANew)
            {
            }
            column(Sem6GPANew; Sem6GPANew)
            {
            }
            column(Sem7GPANew; Sem7GPANew)
            {
            }
            column(Sem8GPANew; Sem8GPANew)
            {
            }
            column(SemRank1; SemRank1)
            {
            }
            column(SemRank2; SemRank2)
            {
            }
            column(SemRank3; SemRank3)
            {
            }
            column(SemRank4; SemRank4)
            {
            }
            column(SemRank5; SemRank5)
            {
            }
            column(SemRank6; SemRank6)
            {
            }
            column(SemRank7; SemRank7)
            {
            }
            column(SemRank8; SemRank8)
            {
            }
            column(OverAllSemRank; OverAllSemRank)
            {
            }
            column(CurrentSem; CurrentSem)
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

                Sem1GPA := 0;
                Sem2GPA := 0;
                Sem3GPA := 0;
                Sem4GPA := 0;
                Sem5GPA := 0;
                Sem6GPA := 0;
                Sem7GPA := 0;
                Sem8GPA := 0;

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
                        StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
                        CourseType1 := StudentMasterCS."Degree Code";//- Field type change
                        CourseDesc := StudentMasterCS."Course Name";
                        AppNo := StudentMasterCS."Application No.";
                        DateJoin := FORMAT(StudentMasterCS."Date of Joining");
                        DateLeaving := FORMAT(StudentMasterCS."Date of Leaving");
                        DOB := FORMAT(StudentMasterCS."Date of Birth");
                        FName := StudentMasterCS."Fathers Name";
                        CGPANew := StudentMasterCS."Net Semester CGPA";
                        Sem1GPA := StudentMasterCS."Semester I GPA";
                        IF Sem1GPA > 0 THEN BEGIN
                            Sem1GPANew := Format('Sem I GPA   :' + '   ' + FORMAT(StudentMasterCS."Semester I GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank1 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester I Rank");
                        END ELSE
                            Sem1GPANew := '';

                        Sem2GPA := StudentMasterCS."Semester II GPA";
                        IF Sem2GPA > 0 THEN BEGIN
                            Sem2GPANew := Format('Sem II GPA  :' + '   ' + FORMAT(StudentMasterCS."Semester II GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank2 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester II Rank");
                        END ELSE
                            Sem2GPANew := '';


                        Sem3GPA := StudentMasterCS."Semester III GPA";
                        IF Sem3GPA > 0 THEN BEGIN
                            Sem3GPANew := Format('Sem III GPA :' + '   ' + FORMAT(StudentMasterCS."Semester III GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank3 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester III Rank");
                        END ELSE
                            Sem3GPANew := '';

                        Sem4GPA := StudentMasterCS."Semester IV GPA";
                        IF Sem4GPA > 0 THEN BEGIN
                            Sem4GPANew := Format('Sem IV GPA  :' + '   ' + FORMAT(StudentMasterCS."Semester IV GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank4 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester IV Rank");
                        END ELSE
                            Sem4GPANew := '';

                        Sem5GPA := StudentMasterCS."Semester V GPA";
                        IF Sem5GPA > 0 THEN BEGIN
                            Sem5GPANew := Format('Sem V GPA   :' + '   ' + FORMAT(StudentMasterCS."Semester V GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank5 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester V Rank");
                        END ELSE
                            Sem5GPANew := '';

                        Sem6GPA := StudentMasterCS."Semester VI GPA";
                        IF Sem6GPA > 0 THEN BEGIN
                            Sem6GPANew := Format('Sem VI GPA  :' + '   ' + FORMAT(StudentMasterCS."Semester VI GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank6 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester VI Rank");
                        END ELSE
                            Sem6GPANew := '';


                        Sem7GPA := StudentMasterCS."Semester VII GPA";
                        IF Sem7GPA > 0 THEN BEGIN
                            Sem7GPANew := Format('Sem VII GPA :' + '   ' + FORMAT(StudentMasterCS."Semester VII GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank7 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester VII Rank");
                        END ELSE
                            Sem7GPANew := '';


                        Sem8GPA := StudentMasterCS."Semester VIII GPA";
                        IF Sem8GPA > 0 THEN BEGIN
                            Sem8GPANew := Format('Sem VIII GPA:' + '   ' + FORMAT(StudentMasterCS."Semester VIII GPA"));
                            StudentExtensionNewCS.Reset();
                            StudentExtensionNewCS.SETRANGE(StudentExtensionNewCS."Enrollment No.", "Enrollment No.");
                            IF StudentExtensionNewCS.findfirst() THEN
                                SemRank8 := Format('POSITION' + '   ' + StudentExtensionNewCS."Semester VIII Rank");
                        END ELSE
                            Sem8GPANew := '';

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
                        END;
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
                        Caption = 'Application Category';
                        Visible = false;
                        ApplicationArea = All;
                        ToolTip = 'Appplication Category may have a value';

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
                        ApplicationArea = All;
                        ToolTip = 'Certificate Purpose may have a value';

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
                        Caption = 'Remark';
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
        RemarkOld2: Text[500];

        DOB: Code[20];
        FName: Text[40];
        TotCredit: Decimal;
        CGPANew: Decimal;
        Sem1GPA: Decimal;
        Sem2GPA: Decimal;
        Sem3GPA: Decimal;
        Sem4GPA: Decimal;
        Sem5GPA: Decimal;
        Sem6GPA: Decimal;
        Sem7GPA: Decimal;
        Sem8GPA: Decimal;
        Sem1GPANew: Text[30];
        Sem2GPANew: Text[30];
        Sem3GPANew: Text[30];
        Sem4GPANew: Text[30];
        Sem5GPANew: Text[30];
        Sem6GPANew: Text[30];
        Sem7GPANew: Text[30];
        Sem8GPANew: Text[30];
        StudName: Text[100];

        SemRank1: Text[30];
        Seq: Integer;

        CurrentSem: Code[10];
        OverAllSemRank: Text[30];
        SemRank2: Text[30];
        SemRank3: Text[30];
        SemRank4: Text[30];
        SemRank5: Text[30];
        SemRank6: Text[30];
        SemRank7: Text[30];
        SemRank8: Text[30];
}

