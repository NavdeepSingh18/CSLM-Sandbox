report 50050 "Bonifide Certificate CS"
{
    // version V.001-CS

    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/Bonifide Certificate CS.rdlc';
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
            column(Attachment_ApplicationCertificateCOL; "Certificates Application-CS".Attachment)
            {
            }
            column(DESC; DESC)
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
            column(CGPAPSemester; CGPAPSemester)
            {
            }
            column(TotCredit; TotCredit)
            {
            }
            column(MName; MName)
            {
            }
            column(PermanentAdd; PermanentAdd)
            {
            }
            column(PassportNum; PassportNum)
            {
            }
            column(PassportIssueDt; PassportIssueDt)
            {
            }
            column(PassportValidDt; PassportValidDt)
            {
            }
            column(VisaNum; VisaNum)
            {
            }
            column(VisaIssueDt; VisaIssueDt)
            {
            }
            column(VisaValidDt; VisaValidDt)
            {
            }
            column(HostelAdd; HostelAdd)
            {
            }
            column(DurationCourse; DurationCourse)
            {
            }
            column(FirstYearAdmisBranch; FirstYearAdmisBranch)
            {
            }
            column(NewPresentBranch; NewPresentBranch)
            {
            }
            column(NewEnrollNumber; NewEnrollNumber)
            {
            }
            column(DateWithdrawal; DateWithdrawal)
            {
            }
            column(NameRP; NameRP)
            {
            }
            column(RegistrationRP; RegistrationRP)
            {
            }
            column(SemesterRP; SemesterRP)
            {
            }
            column(ProgrammeBranchRP; ProgrammeBranchRP)
            {
            }
            column(CGPARP; CGPARP)
            {
            }
            column(DOBRP; DOBRP)
            {
            }
            column(FatherNameRP; FatherNameRP)
            {
            }
            column(MotherNameRP; MotherNameRP)
            {
            }
            column(DurationCourseRP; DurationCourseRP)
            {
            }
            column(MediumInstructionRP; MediumInstructionRP)
            {
            }
            column(ModeProgramRP; ModeProgramRP)
            {
            }
            column(PhotoRP; PhotoRP)
            {
            }
            column(PermanentAddRP; PermanentAddRP)
            {
            }
            column(HostelAddRP; HostelAddRP)
            {
            }
            column(CharacterConductRP; CharacterConductRP)
            {
            }
            column(PassportNumberRP; PassportNumberRP)
            {
            }
            column(PassportIssueDTRP; PassportIssueDTRP)
            {
            }
            column(PassportValidTillRP; PassportValidTillRP)
            {
            }
            column(VisaNumberRP; VisaNumberRP)
            {
            }
            column(VisaIssueDtRP; VisaIssueDtRP)
            {
            }
            column(VisaValidTillRP; VisaValidTillRP)
            {
            }
            column(VacationPeriodRP; VacationPeriodRP)
            {
            }
            column(CommencementClassRP; CommencementClassRP)
            {
            }
            column(EvaluationPatternRP; EvaluationPatternRP)
            {
            }
            column(DateAdmissionRP; DateAdmissionRP)
            {
            }
            column(DateWithdrawalRP; DateWithdrawalRP)
            {
            }
            column(AdmissionBranchRP; AdmissionBranchRP)
            {
            }
            column(RegistrationNumberRP; RegistrationNumberRP)
            {
            }
            column(PresentBranchRP; PresentBranchRP)
            {
            }
            column(NewRegistrationNumRP; NewRegistrationNumRP)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CertificatesApplicationCS.Reset();
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Application No.", "Application No.");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Enrollment No.", "Enrollment No.");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS."Application Category", "Application Category");
                CertificatesApplicationCS.SETRANGE(CertificatesApplicationCS.Purpose, Purpose);
                IF CertificatesApplicationCS.findfirst() THEN BEGIN
                    ApplicationCertOptionCS.Reset();
                    ApplicationCertOptionCS.SETRANGE("Application Number", "Certificates Application-CS"."Application No.");
                    IF ApplicationCertOptionCS.findset() THEN
                        REPEAT
                            AllOption := ApplicationCertOptionCS."App Option Code";
                            ApplicationOptionMasterCS.Reset();
                            ApplicationOptionMasterCS.SETRANGE(ApplicationOptionMasterCS.Code, AllOption);
                            IF ApplicationOptionMasterCS.findfirst() THEN BEGIN
                                DESC := format(ApplicationOptionMasterCS.Description);

                                IF DESC = 'Name' THEN
                                    NameRP := Format(DESC);
                                IF DESC = 'Semester' THEN
                                    SemesterRP := Format(DESC);
                                IF DESC = 'Mode of Programme' THEN
                                    ModeProgramRP := Format(DESC);
                                IF DESC = 'CGPA' THEN
                                    CGPARP := Format(DESC);
                                IF DESC = 'Photo' THEN
                                    PhotoRP := Format(DESC);
                                IF DESC = 'Registration No.' THEN
                                    RegistrationRP := Format(DESC);
                                IF DESC = 'Programme & Branch' THEN
                                    ProgrammeBranchRP := Format(DESC);
                                IF DESC = 'Date of Birth' THEN
                                    DOBRP := Format(DESC);
                                IF DESC = 'Fathers Name' THEN
                                    FatherNameRP := Format(DESC);
                                IF DESC = 'Mothers Name' THEN
                                    MotherNameRP := Format(DESC);
                                IF DESC = 'Duration of the Course' THEN
                                    DurationCourseRP := Format(DESC);
                                IF DESC = 'Medium of Instruction' THEN
                                    MediumInstructionRP := Format(DESC);
                                IF DESC = 'Permanent Address' THEN
                                    PermanentAddRP := Format(DESC);
                                IF DESC = 'Hostel Address' THEN
                                    HostelAddRP := Format(DESC);
                                IF DESC = 'Character & Conduct' THEN
                                    CharacterConductRP := Format(DESC);
                                IF DESC = 'Passport Number' THEN
                                    PassportNumberRP := Format(DESC);
                                IF DESC = 'Passport Issue Date' THEN
                                    PassportIssueDTRP := Format(DESC);
                                IF DESC = 'Passport Valid Till' THEN
                                    PassportValidTillRP := Format(DESC);
                                IF DESC = 'Visa Number' THEN
                                    VisaNumberRP := Format(DESC);
                                IF DESC = 'Visa Issue Date' THEN
                                    VisaIssueDtRP := Format(DESC);
                                IF DESC = 'Visa Valid Till' THEN
                                    VisaValidTillRP := Format(DESC);
                                IF DESC = 'Vacation Period' THEN
                                    VacationPeriodRP := Format(DESC);
                                IF DESC = 'Commencement of Classes' THEN
                                    CommencementClassRP := Format(DESC);
                                IF DESC = 'Evaluation Pattern' THEN
                                    EvaluationPatternRP := Format(DESC);
                                IF DESC = 'Date of Admission' THEN
                                    DateAdmissionRP := Format(DESC);
                                /*
                                IF DESC ='Date of Withdrawal' THEN
                                  DateWithdrawalRP:=DESC;
                                  */

                                IF DESC = 'Expected Year Of Course Completion' THEN
                                    DateWithdrawalRP := Format(DESC);

                                IF DESC = 'First Year Admission Branch' THEN
                                    AdmissionBranchRP := Format(DESC);
                                IF DESC = 'First Year Registration Number' THEN
                                    RegistrationNumberRP := Format(DESC);
                                IF DESC = 'Present Branch (after branch change)' THEN
                                    PresentBranchRP := Format(DESC);
                                IF DESC = 'New Registration Number' THEN
                                    NewRegistrationNumRP := Format(DESC);
                            END;
                        UNTIL ApplicationCertOptionCS.NEXT() = 0;

                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE(StudentMasterCS."Enrollment No.", "Enrollment No.");
                    IF StudentMasterCS.findfirst() THEN BEGIN
                        //StudentMasterCS.CALCFIELDS(StudentMasterCS."Student Image");
                        AdYear := StudentMasterCS."Academic Year";
                        StudName := StudentMasterCS."Name as on Certificate";
                        StudentMasterCS.CALCFIELDS(StudentMasterCS."Course Type");
                        CourseType1 := StudentMasterCS."Degree Code";//- Field type change
                        CourseDesc := StudentMasterCS."Course Name";
                        AppNo := StudentMasterCS."Application No.";
                        DateJoin := StudentMasterCS."Date of Joining";
                        DateLeaving := StudentMasterCS."Date of Leaving";
                        DateWithdrawal := StudentMasterCS."Date of Leaving";
                        DOB := StudentMasterCS."Date of Birth";
                        FName := StudentMasterCS."Fathers Name";
                        MName := StudentMasterCS."Mothers Name";
                        PermanentAdd := StudentMasterCS.Addressee + ' ' + StudentMasterCS.Address1 + ' ' + StudentMasterCS.Address2 + ' ' + StudentMasterCS.City + ' ' + StudentMasterCS."Post Code";

                        StudentHostelCS.Reset();
                        StudentHostelCS.SETRANGE(StudentHostelCS."Student No.", StudentMasterCS."No.");
                        IF StudentHostelCS.findfirst() THEN
                            HostelAdd := StudentHostelCS."Hostel Block" + ', ' + StudentHostelCS."Hostel Room No.";

                        IF StudentMasterCS."Lateral Student" = TRUE THEN begin
                            IF (StudentMasterCS.Graduation = 'UG') THEN
                                DurationCourse := '3 YEARS CONSISTING OF 6 SEMESTERS (B.TECH.-Lateral)';
                        end ELSE
                            IF (StudentMasterCS.Graduation = 'UG') THEN
                                DurationCourse := '4 YEARS CONSISTING OF 8 SEMESTERS (B.TECH.)'
                            ELSE
                                DurationCourse := '2 YEARS CONSISTING OF 4 SEMESTERS (M.TECH. & MCA)';

                        PassportNum := StudentMasterCS."Pass Port No.";
                        PassportIssueDt := StudentMasterCS."Pass Port Issued Date";
                        PassportValidDt := StudentMasterCS."Pass Port Expiry Date";
                        VisaNum := StudentMasterCS."Visa No.";
                        VisaIssueDt := StudentMasterCS."Visa Issued Date";
                        VisaValidDt := StudentMasterCS."Visa Expiry Date";
                        //VacationPd:=????????
                        //CommencementClass:=???????
                        CGPAPSemester := StudentMasterCS."Net Semester CGPA";

                        /*
                        WithdrawalCollege.Reset();
                        WithdrawalCollege.SETRANGE(WithdrawalCollege."Student No.",StudentMasterCS."No.");
                        IF WithdrawalCollege.findfirst() THEN BEGIN
                          DateWithdrawal:=WithdrawalCollege."Withdrawal date";
                        END;
                        */
                        BranchTransferCS.Reset();
                        BranchTransferCS.SETRANGE(BranchTransferCS."No.", StudentMasterCS."No.");
                        IF BranchTransferCS.findfirst() THEN BEGIN
                            FirstYearAdmisBranch := BranchTransferCS."Course Code";
                            NewPresentBranch := BranchTransferCS."Transfer To Course";
                            NewEnrollNumber := BranchTransferCS."New Enrollment No.";
                        END;

                        TotCredit := StudentMasterCS."Total Credits";
                        SemesterMasterCS.Reset();
                        SemesterMasterCS.SETRANGE(SemesterMasterCS.Code, StudentMasterCS.Semester);
                        IF SemesterMasterCS.findfirst() THEN
                            Sem1 := SemesterMasterCS.Description;
                        CASE Sem1 OF
                            '1st Sem':
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
        StudentHostelCS: Record "Student Hostel-CS";

        BranchTransferCS: Record "Branch Transfer-CS";
        ApplicationCertOptionCS: Record "Application Cert. Option-CS";
        ApplicationOptionMasterCS: Record "Application Option Master-CS";
        CourseDesc: Text[100];
        CourseType1: Code[20];
        Sem1: Text[100];
        AdYear: Code[20];
        AppNo: Code[20];
        DateJoin: Date;
        DateLeaving: Date;
        DOB: Date;
        FName: Text[40];
        TotCredit: Decimal;
        CGPAPSemester: Decimal;
        MName: Text[40];
        PermanentAdd: Code[250];
        PassportNum: Code[20];
        PassportIssueDt: Date;
        PassportValidDt: Date;
        VisaNum: Code[20];
        VisaIssueDt: Date;
        VisaValidDt: Date;
        HostelAdd: Text[250];
        DurationCourse: Text[80];
        DateWithdrawal: Date;
        FirstYearAdmisBranch: Code[20];
        NewPresentBranch: Code[20];
        NewEnrollNumber: Code[20];

        AllOption: Code[20];
        DESC: Text[50];
        NameRP: Text[10];
        RegistrationRP: Text[20];
        SemesterRP: Text[10];
        ProgrammeBranchRP: Text[20];
        CGPARP: Text[5];
        DOBRP: Text[30];
        FatherNameRP: Text[30];
        MotherNameRP: Text[30];
        DurationCourseRP: Text[30];
        MediumInstructionRP: Text[30];
        ModeProgramRP: Text[30];
        PhotoRP: Text[10];
        PermanentAddRP: Text[20];
        HostelAddRP: Text[20];
        CharacterConductRP: Text[30];
        PassportNumberRP: Text[30];
        PassportIssueDTRP: Text[30];
        PassportValidTillRP: Text[30];
        VisaNumberRP: Text[30];
        VisaIssueDtRP: Text[30];
        VisaValidTillRP: Text[30];
        VacationPeriodRP: Text[30];
        CommencementClassRP: Text[40];
        EvaluationPatternRP: Text[30];
        DateAdmissionRP: Text[50];
        DateWithdrawalRP: Text[50];
        AdmissionBranchRP: Text[50];
        RegistrationNumberRP: Text[50];
        PresentBranchRP: Text[50];
        NewRegistrationNumRP: Text[50];
        StudName: Text[100];
}