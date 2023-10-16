report 50079 "Student Promotion Process"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Promotion Header-CS"; "Promotion Header-CS")
        {
            RequestFilterFields = "No.";
            dataitem("Promotion Line-CS"; "Promotion Line-CS")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE("Not Eligible" = FILTER(FALSE),
                                          "In Active" = FILTER(FALSE),
                                          "Student Promoted" = FILTER(FALSE));

                trigger OnAfterGetRecord()
                begin
                    IF (("Promotion Line-CS".Semester = 'II') OR ("Promotion Line-CS".Semester = 'IV') OR
                       ("Promotion Line-CS".Semester = 'VI') OR ("Promotion Line-CS".Semester = 'VIII')) THEN BEGIN

                        PromotionCriteriaCS.Reset();
                        PromotionCriteriaCS.SETRANGE(Course, "Promotion Line-CS"."Course Code");
                        IF "Promotion Line-CS"."Type Of Course" = "Promotion Line-CS"."Type Of Course"::Semester THEN
                            PromotionCriteriaCS.SETRANGE(Semester, "Promotion Line-CS".Semester)
                        ELSE
                            PromotionCriteriaCS.SETRANGE(Year, "Promotion Line-CS".Year);
                        PromotionCriteriaCS.SETRANGE("Academic Year", "Promotion Line-CS"."Academic Year");
                        PromotionCriteriaCS.SETRANGE("Global Dimension 1 Code", "Promotion Line-CS"."Global Dimension 1 Code");
                        IF PromotionCriteriaCS.findfirst() THEN BEGIN
                            IF "Promotion Line-CS"."Lateral Student" = TRUE THEN
                                MinimumCredit := PromotionCriteriaCS."Lateral Credit"
                            ELSE
                                MinimumCredit := PromotionCriteriaCS."Minimum Credit";
                        END ELSE BEGIN
                            PromotionCriteriaCS1.Reset();
                            PromotionCriteriaCS1.SETRANGE(Course, '');
                            IF "Promotion Line-CS"."Type Of Course" = "Promotion Line-CS"."Type Of Course"::Semester THEN
                                PromotionCriteriaCS1.SETRANGE(Semester, "Promotion Line-CS".Semester)
                            ELSE
                                PromotionCriteriaCS1.SETRANGE(Year, "Promotion Line-CS".Year);
                            PromotionCriteriaCS1.SETRANGE("Academic Year", "Promotion Line-CS"."Academic Year");
                            PromotionCriteriaCS1.SETRANGE("Global Dimension 1 Code", "Promotion Line-CS"."Global Dimension 1 Code");
                            IF PromotionCriteriaCS1.findfirst() THEN BEGIN
                                IF "Promotion Line-CS"."Lateral Student" = TRUE THEN
                                    MinimumCredit := PromotionCriteriaCS1."Lateral Credit"
                                ELSE
                                    MinimumCredit := PromotionCriteriaCS1."Minimum Credit"
                            END ELSE
                                ERROR(Text_1002Lbl);
                        END;

                        IF (MinimumCredit <= "Promotion Line-CS".Credit) THEN
                            InformationOfStudentCS.ProcessPromotionCS("Promotion Line-CS")
                        ELSE
                            IF (MinimumCredit > "Promotion Line-CS".Credit) THEN BEGIN
                                "Promotion Line-CS"."Promoted  Academic Year" := AdmissionSetupCS."Admission Year";
                                "Promotion Line-CS"."Not Eligible" := TRUE;
                                "Promotion Line-CS".Modify();

                                CourseMasterCS.Reset();
                                CourseMasterCS.SETRANGE(Code, "Promotion Line-CS"."Course Code");
                                IF CourseMasterCS.findfirst() THEN
                                    ApplicableYear := 2 * CourseMasterCS."Duration of Years";

                                StudentMasterCS.Reset();
                                StudentMasterCS.SETRANGE("No.", "Promotion Line-CS"."Student No.");
                                IF StudentMasterCS.findfirst() THEN BEGIN
                                    EVALUATE(AdmittedYear, COPYSTR(StudentMasterCS."Admitted Year", 1, 4));
                                    EVALUATE(CurrentYear, COPYSTR(AdmissionSetupCS."Admission Year", 1, 4));
                                    NumberofYear := CurrentYear - AdmittedYear;

                                    IF StudentMasterCS."Lateral Student" = TRUE THEN BEGIN
                                        IF NumberofYear = ApplicableYear - 1 THEN
                                            StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::NFT;
                                    END ELSE
                                        IF StudentMasterCS."Lateral Student" = FALSE THEN
                                            IF NumberofYear = ApplicableYear THEN
                                                StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::NFT;


                                    IF StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Student THEN
                                        StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::Casual
                                    ELSE
                                        IF (StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::Casual) OR (StudentMasterCS."Student Status" = StudentMasterCS."Student Status"::"Reject & Rejoin") THEN
                                            StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::NFT;
                                    StudentMasterCS."Academic Year" := AdmissionSetupCS."Admission Year";
                                    StudentMasterCS.Modify();
                                END;

                            END;
                    END ELSE
                        InformationOfStudentCS.ProcessPromotionCS("Promotion Line-CS");
                end;

                trigger OnPreDataItem()
                begin
                    AdmissionSetupCS.GET();
                    AdmissionSetupCS.TESTFIELD("Admission Year");
                end;
            }
            dataitem("Student Promotion Line - COL1"; "Promotion Line-CS")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    WHERE("In Active" = FILTER(true));

                trigger OnAfterGetRecord()
                begin
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Student No.");
                    IF StudentMasterCS.findfirst() THEN BEGIN
                        StudentMasterCS."Student Status" := StudentMasterCS."Student Status"::Inactive;
                        StudentMasterCS.Modify();
                    END;
                end;
            }
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

    trigger OnPostReport()
    begin
        MESSAGE('%1', Text001Lbl);
    end;

    var
        StudentMasterCS: Record "Student Master-CS";

        CourseMasterCS: Record "Course Master-CS";

        AdmissionSetupCS: Record "Admission Setup-CS";
        PromotionCriteriaCS: Record "Promotion Criteria-CS";
        PromotionCriteriaCS1: Record "Promotion Criteria-CS";
        InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
        Text001Lbl: Label 'Student Updated';
        MinimumCredit: Decimal;
        Text_1002Lbl: Label 'Promotion Criteria Not Defined !!';
        AdmittedYear: Integer;
        CurrentYear: Integer;
        NumberofYear: Integer;
        ApplicableYear: Integer;
}

