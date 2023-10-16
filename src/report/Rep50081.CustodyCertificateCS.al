report 50081 "Custody Certificate CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Custody Certificate CS.rdlc';
    ApplicationArea = All;
    UsageCategory = Administration;
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
            column(Sem1; Sem1)
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
            column(CourseDesc; CourseDesc)
            {
            }
            column(CourseType1; CourseType1)
            {
            }
            column(RemarkOld2; RemarkOld2)
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
                    CertificatesApplicationCS.MODIFY();
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                    IF StudentMasterCS.findfirst() THEN BEGIN
                        StudName := StudentMasterCS."Name as on Certificate";
                        AdYear := StudentMasterCS."Academic Year";
                        StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
                        CourseType1 := StudentMasterCS."Degree Code";//- Field type change
                        CourseDesc := StudentMasterCS."Course Name";
                        AppNo := StudentMasterCS."Enrollment No.";
                        DateJoin := FORMAT(StudentMasterCS."Date of Joining");
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
                    }
                    field("Application Category"; ApplicationCategory)
                    {
                        ApplicationArea = All;
                        Caption = 'Application Category';
                        ToolTip = 'Application Category may have a value';
                        Visible = false;
                    }
                    field("Certificate Purpose"; CertificatePurpose)
                    {
                        ApplicationArea = All;
                        Caption = 'Certificate Purpose';
                        ToolTip = 'Certificate Purpose may have a value';
                        Visible = false;
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

        trigger OnOpenPage()
        begin

            EnrollmentNo := '';
            ApplicationCategory := '';
            CertificatePurpose := '';
        end;
    }

    labels
    {
    }

    var
        SemesterMasterCS: Record "Semester Master-CS";
        StudentMasterCS: Record "Student Master-CS";
        CertificatesApplicationCS: Record "Certificates Application-CS";
        CourseDesc: Text[100];
        CourseType1: Code[20];
        Sem1: Text[100];

        EnrollmentNo: Code[20];
        ApplicationCategory: Code[20];

        CertificatePurpose: Code[20];
        AdYear: Code[20];
        AppNo: Code[20];
        DateJoin: Code[20];
        RemarkOld: Text[250];
        RemarkOld1: Text[250];
        RemarkNew: Text[250];
        RemarkNew1: Text[250];
        RemarkOld2: Text[500];
        StudName: Text[100];
}

