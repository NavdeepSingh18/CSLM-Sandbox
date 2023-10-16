page 50759 "Enrollment History Buffer List"
{

    PageType = API;
    APIGroup = 'eH';
    APIPublisher = 'slcM';
    EntityName = 'eH';
    EntitySetName = 'eH';
    DelayedInsert = true;
    Caption = 'Enrollment History Buffer List';
    SourceTable = "Enrollment History Buffer";
    UsageCategory = Administration;
    ApplicationArea = All;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {

                field(enrollmenthistoryNo; Rec."Enrollment History No.")
                {
                    ApplicationArea = all;
                    Caption = 'Enrollment History No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    ApplicationArea = all;
                    Caption = 'Line No.';

                }
                field(schoolNo; Rec."School No.")
                {
                    ApplicationArea = all;
                    Caption = 'School No.';


                }
                field(studentNo; Rec."Student No.")
                {
                    ApplicationArea = all;
                    Caption = 'Student No.';


                }
                field(collegeofGraduation; Rec."College of Graduation")
                {
                    ApplicationArea = all;
                    Caption = 'College of Graduation';


                }
                field(currentlyEnrolled; Rec."Currently Enrolled")
                {
                    ApplicationArea = all;
                    Caption = 'Currently Enrolled';


                }
                field(degreeCandidate; Rec."Degree Candidate")
                {
                    ApplicationArea = all;
                    Caption = 'Degree Candidate';


                }
                field(degreeEarned; Rec."Degree Earned")
                {
                    ApplicationArea = all;
                    Caption = 'Degree Earned';
                }
                field(degreeType; Rec."Degree Type")
                {
                    ApplicationArea = all;
                    Caption = 'Degree Type';
                }
                field(didyouGraduate; Rec."Did you Graduate")
                {
                    ApplicationArea = all;
                    Caption = 'Did you Graduate';
                }
                field(earnedCredits; Rec."Earned Credits")
                {
                    ApplicationArea = all;
                    Caption = 'Earned Credits';
                }
                field(endDate; Rec."End Date")
                {
                    ApplicationArea = all;
                    Caption = 'End Date';
                }
                field(gpaCredits; Rec."GPA Credits")
                {
                    ApplicationArea = all;
                    Caption = 'GPA Credits';
                }
                field(graduationDate; Rec."Graduation Date")
                {
                    ApplicationArea = all;
                    Caption = 'Graduation Date';
                }
                field(graduationYear; Rec."Graduation Year")
                {
                    ApplicationArea = all;
                    Caption = 'Graduation Year';
                    MinValue = 1950;
                    MaxValue = 2100;
                }
                field(officialGPAScale; Rec."Official GPA Scale")
                {
                    ApplicationArea = all;
                    Caption = 'Official GPA Scale';
                }

                field(officialGPA; Rec."Official GPA")
                {
                    ApplicationArea = all;
                    Caption = 'Official GPA';
                }
                field(officialRecalculatedGPA; Rec."Official Recalculated GPA")
                {
                    ApplicationArea = all;
                    Caption = 'Official Recalculated GPA';
                }
                field(officialTranscriptsReceived; Rec."Official Transcripts Received")
                {
                    ApplicationArea = all;
                    Caption = 'Official Transcripts Received';
                }
                field(preReqCredits; Rec."Pre-Req Credits")
                {
                    ApplicationArea = all;
                    Caption = 'Pre-Req Credits';
                }
                field(preReqQualityPoints; Rec."Pre-Req Quality Points")
                {
                    ApplicationArea = all;
                    Caption = 'Pre-Req Quality Points';
                }

                field(previouslyAttendedMedicalSchool; Rec."Prev. Attended Medical School")
                {
                    ApplicationArea = all;
                    Caption = ' Previously Attended Medical School?';
                }
                field(primaryCollege; Rec."Primary College")
                {
                    ApplicationArea = all;
                    Caption = 'Primary College';
                }
                field(qualityPoints; Rec."Quality Points")
                {
                    ApplicationArea = all;
                    Caption = 'Quality Points';
                }
                field(reasonforTransfer; Rec."Reason for Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Reason for Transfer';
                }
                field(schoolLevel;
                Rec."School Level")
                {
                    ApplicationArea = all;
                    Caption = 'School Level';

                }
                field(selfReportedGraduationYear; Rec."Self-Reported Graduation Year")
                {
                    ApplicationArea = all;
                    Caption = 'Self-Reported Graduation Year';

                }
                field(startDate; Rec."Start Date")
                {
                    ApplicationArea = all;
                    Caption = 'Start Date';

                }
                field(testsTaken; Rec."Tests Taken")
                {
                    ApplicationArea = all;
                    Caption = 'Tests Taken';

                }
                field(transFer; Rec."Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Transfer';

                }
                field(tyPe; Rec."Type")
                {
                    ApplicationArea = all;
                    Caption = 'Type';


                }
                field("digitenrollmentId"; Rec."18 Digit EnrollmentId")
                {
                    ApplicationArea = all;
                    Caption = '18 Digit EnrollmentId';
                }
            }
        }

    }

    var
        RecEnrolmentHistory: Record "Enrollment History";
        RecEnrolmentHistory2: Record "Enrollment History";
        RecEnrolmentHistoryBuffer: Record "Enrollment History Buffer";
        RecEducationSetup: Record "Education Setup-CS";
        Student: Record "Student Master-CS";
        School: Record School;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Student.Get(Rec."Student No.");
        School.Get(Rec."School No.");

        if Rec."Enrollment History No." = '' then begin
            RecEducationSetup.reset();
            RecEducationSetup.SetRange("Global Dimension 1 Code", Student."Global Dimension 1 Code");
            RecEducationSetup.FindFirst();
            RecEducationSetup.Testfield("Enrolment History Nos.");
            Rec.Validate("Enrollment History No.", NoSeriesMgt.GetNextNo(RecEducationSetup."Enrolment History Nos.", 0D, TRUE));

            RecEnrolmentHistory.Reset();
            RecEnrolmentHistory.SetRange("18 Digit EnrollmentId", Rec."18 Digit EnrollmentId");
            if RecEnrolmentHistory.FindFirst() then
                Error('"18 Digit Enrollment No." %1 already exists for "Enrollment History No." %2', Rec."18 Digit EnrollmentId", RecEnrolmentHistory."Enrollment History No.");

            RecEnrolmentHistory.Init();
            RecEnrolmentHistory.validate("Enrollment History No.", Rec."Enrollment History No.");
            RecEnrolmentHistory.Insert(True);
            Rec."Line No." := 10000;
        end else
            if Rec."Enrollment History No." <> '' then begin
                RecEnrolmentHistory.reset();
                RecEnrolmentHistory.Get(Rec."Enrollment History No.");

                If RecEnrolmentHistory."Student No." <> Rec."Student No." then
                    Error('Student No. %1 does not belong to Enrollment History No. %2', Rec."Student No.", Rec."Enrollment History No.");

                If RecEnrolmentHistory."School No." <> Rec."School No." then
                    Error('School No. %1 does not belong to Enrollment History No. %2', Rec."School No.", Rec."Enrollment History No.");
                RecEnrolmentHistoryBuffer.Reset();
                RecEnrolmentHistoryBuffer.SetRange("Enrollment History No.", Rec."Enrollment History No.");
                RecEnrolmentHistoryBuffer.FindLast();
                Rec."Line No." := RecEnrolmentHistoryBuffer."Line No." + 10000

            end;

        Rec."Entry From Salesforce" := true;
        RecEnrolmentHistory."Entry From Salesforce" := true;
        RecEnrolmentHistory.Validate("School No.", Rec."School No.");
        RecEnrolmentHistory.Validate("Student No.", Rec."Student No.");
        RecEnrolmentHistory.Validate("College of Graduation", Rec."College of Graduation");
        RecEnrolmentHistory.Validate("Currently Enrolled", Rec."Currently Enrolled");
        RecEnrolmentHistory.Validate("Degree Candidate", Rec."Degree Candidate");
        RecEnrolmentHistory.Validate("Degree Earned", Rec."Degree Earned");
        RecEnrolmentHistory.Validate("Degree Type", Rec."Degree Type");
        RecEnrolmentHistory.Validate("Did you Graduate", Rec."Did you Graduate");
        RecEnrolmentHistory.Validate("Earned Credits", Rec."Earned Credits");
        RecEnrolmentHistory.Validate("End Date", Rec."End Date");
        RecEnrolmentHistory.Validate("GPA Credits", Rec."GPA Credits");
        RecEnrolmentHistory.Validate("Graduation Date", Rec."Graduation Date");
        RecEnrolmentHistory.Validate("Graduation Year", Rec."Graduation Year");
        RecEnrolmentHistory.Validate("Official GPA Scale", Rec."Official GPA Scale");
        RecEnrolmentHistory.Validate("Official GPA", Rec."Official GPA");
        RecEnrolmentHistory.Validate("Official Recalculated GPA", Rec."Official Recalculated GPA");
        RecEnrolmentHistory.Validate("Official Transcripts Received", Rec."Official Transcripts Received");
        RecEnrolmentHistory.Validate("Pre-Req Credits", Rec."Pre-Req Credits");
        RecEnrolmentHistory.Validate("Pre-Req Quality Points", Rec."Pre-Req Quality Points");
        RecEnrolmentHistory.Validate("Prev. Attended Medical School", Rec."Prev. Attended Medical School");
        RecEnrolmentHistory.Validate("Primary College", Rec."Primary College");
        RecEnrolmentHistory.Validate("Quality Points", Rec."Quality Points");
        RecEnrolmentHistory.Validate("Reason for Transfer", Rec."Reason for Transfer");
        RecEnrolmentHistory.Validate("School Level", Rec."School Level");
        RecEnrolmentHistory.Validate("Self-Reported Graduation Year", Rec."Self-Reported Graduation Year");
        RecEnrolmentHistory.Validate("Start Date", Rec."Start Date");
        RecEnrolmentHistory.Validate("Tests Taken", Rec."Tests Taken");
        RecEnrolmentHistory.Validate(Transfer, Rec.Transfer);
        RecEnrolmentHistory.Validate(Type, Rec.Type);
        RecEnrolmentHistory.Validate("18 Digit EnrollmentId", Rec."18 Digit EnrollmentId");
        RecEnrolmentHistory.Modify(true);
    end;

}