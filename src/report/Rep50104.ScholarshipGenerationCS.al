report 50104 "Scholarship Generation CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Customer"; "Customer")
        {
            DataItemTableView = WHERE("Student Status" = FILTER(Student),
                                      "Course Code" = FILTER(<> ' '));

            trigger OnAfterGetRecord()
            begin

                StudentMasterCS.GET(Customer."No.");


                YearMasterCS.Reset();
                YearMasterCS.SETRANGE(YearMasterCS.Code, Customer.Year);
                IF YearMasterCS.findfirst() THEN
                    YearMasterCS1.Reset();
                YearMasterCS1.SETRANGE("Sequence No.", YearMasterCS."Sequence No." - 1);
                IF YearMasterCS1.findfirst() THEN
                    LastYear := YearMasterCS1.Code;
                //MESSAGE('Year,LastYear,%1,%2',Customer.Year,LastYear);

                AllClear := FALSE;
                MainStudentSubjectCS1.Reset();
                MainStudentSubjectCS1.SETRANGE("Student No.", Customer."No.");
                MainStudentSubjectCS1.SETRANGE(Year, LastYear);
                IF MainStudentSubjectCS1.findfirst() THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE("Student No.", Customer."No.");
                    MainStudentSubjectCS.SETRANGE(Year, LastYear);
                    MainStudentSubjectCS.SETRANGE(Grade, 'F');
                    IF NOT MainStudentSubjectCS.findfirst() THEN
                        AllClear := TRUE;
                    MESSAGE('%1', AllClear);
                END;



                IF (Customer.Year = '1ST') OR ((Customer."Lateral Student" = TRUE) AND (Customer.Year = '2ND')) THEN BEGIN
                    ManagementsFeeCS.ScholarshipGenration1stYearCS(Customer."No.");
                    MESSAGE('Scholarship Generated');
                    //END ELSE IF Customer.Year <> '1ST' THEN BEGIN

                END ELSE
                    IF Customer.Year = '2ND' THEN BEGIN
                        BranchInformationStudCS.Reset();
                        BranchInformationStudCS.SETRANGE("Student No.", Customer."No.");
                        IF BranchInformationStudCS.findfirst() THEN BEGIN
                            IF BranchInformationStudCS."Branch Transfer Compleated" = TRUE THEN BEGIN
                                SchoContinuationcriteriaCS.Reset();
                                SchoContinuationcriteriaCS.SETRANGE("Scholarship Code", Customer.Category);
                                SchoContinuationcriteriaCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                                IF SchoContinuationcriteriaCS.findfirst() THEN
                                    IF SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::Clear THEN                                     //ResultRequired := SchoContinuationcriteriaCS.Result;
                                        IF (AllClear = TRUE) THEN
                                            ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                                IF SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::CGPA THEN BEGIN
                                    CGPARequired := SchoContinuationcriteriaCS."Applicable CGPA";
                                    StudentMasterCS.CALCFIELDS(CGPA);
                                    IF (AllClear = TRUE) AND (StudentMasterCS.CGPA >= CGPARequired) THEN
                                        ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                                END ELSE
                                    IF (SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::None) OR
                             (SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::"Branch Transfer") THEN
                                        ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                                MESSAGE('Scholarship Generated');
                            END;
                        END ELSE BEGIN
                            SchoContinuationcriteriaCS.Reset();
                            SchoContinuationcriteriaCS.SETRANGE("Scholarship Code", Customer.Category);
                            SchoContinuationcriteriaCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                            IF SchoContinuationcriteriaCS.findfirst() THEN
                                IF SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::Clear THEN                                //ResultRequired := SchoContinuationcriteriaCS.Result;
                                    IF (AllClear = TRUE) THEN
                                        ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                            IF SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::CGPA THEN BEGIN
                                CGPARequired := SchoContinuationcriteriaCS."Applicable CGPA";
                                StudentMasterCS.CALCFIELDS(CGPA);
                                IF (AllClear = TRUE) AND (StudentMasterCS.CGPA >= CGPARequired) THEN
                                    ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                            END ELSE
                                IF (SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::None) OR
                         (SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::"Branch Transfer") THEN
                                    ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                            MESSAGE('Scholarship Generated');
                        END;

                    END ELSE
                        IF (Customer.Year = '3RD') OR (Customer.Year = '4TH') THEN BEGIN
                            SchoContinuationcriteriaCS.Reset();
                            SchoContinuationcriteriaCS.SETRANGE("Scholarship Code", Customer.Category);
                            SchoContinuationcriteriaCS.SETRANGE("Admitted Year", Customer."Admitted Year");
                            IF SchoContinuationcriteriaCS.findfirst() THEN
                                IF SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::Clear THEN                                 //ResultRequired := SchoContinuationcriteriaCS.Result;
                                    IF (AllClear = TRUE) THEN
                                        ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                            IF SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::CGPA THEN BEGIN
                                CGPARequired := SchoContinuationcriteriaCS."Applicable CGPA";
                                StudentMasterCS.CALCFIELDS(CGPA);
                                IF (AllClear = TRUE) AND (StudentMasterCS.CGPA >= CGPARequired) THEN
                                    ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");
                            END ELSE
                                IF (SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::None) OR
                         (SchoContinuationcriteriaCS."Applicable Code" = SchoContinuationcriteriaCS."Applicable Code"::"Branch Transfer") THEN
                                    ManagementsFeeCS.ScholarshipGenrationRestYearsCS(Customer."No.");

                            MESSAGE('Scholarship Generated');
                        END;
            end;

            trigger OnPreDataItem()
            begin
                IF EnrollmentNo <> '' THEN
                    Customer.SETRANGE(Customer."Enrollment No.", EnrollmentNo);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    field("Enrollment No"; EnrollmentNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Enrollment No.';
                        ToolTip = 'Enrollment No. may have a value';

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

        actions
        {
        }
    }

    labels
    {
    }

    var

        SchoContinuationcriteriaCS: Record "Scho Continuation criteria-CS";
        YearMasterCS: Record "Year Master-CS";
        YearMasterCS1: Record "Year Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        MainStudentSubjectCS1: Record "Main Student Subject-CS";
        StudentMasterCS: Record "Student Master-CS";
        BranchInformationStudCS: Record "Branch Information Stud-CS";
        ManagementsFeeCS: Codeunit "Managements Fee -CS";
        CGPARequired: Decimal;
        LastYear: Code[10];

        AllClear: Boolean;

        EnrollmentNo: Code[20];
}