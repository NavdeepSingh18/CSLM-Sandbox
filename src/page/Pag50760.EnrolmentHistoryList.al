page 50760 "Enrollment History List"
{

    PageType = List;
    Caption = 'Enrollment History';
    SourceTable = "Enrollment History";
    UsageCategory = Administration;
    ApplicationArea = All;
    //ModifyAllowed = false;
    DeleteAllowed = false;
    //InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(EnrollmentHistoryNo; Rec."Enrollment History No.")
                {
                    ApplicationArea = all;
                    Caption = 'Enrollment History No.';

                }

                field(SchoolNo; Rec."School No.")
                {
                    ApplicationArea = all;
                    Visible = False;
                    Caption = 'School No.';

                }
                Field("School Name"; Rec."School Name")
                {
                    ApplicationArea = All;
                }
                field(StudentNo; Rec."Student No.")
                {
                    ApplicationArea = all;
                    Caption = 'Student No.';
                }
                field(CollegeofGraduation; Rec."College of Graduation")
                {
                    ApplicationArea = all;
                    Caption = 'College of Graduation';
                }
                field(CurrentlyEnrolled; Rec."Currently Enrolled")
                {
                    ApplicationArea = all;
                    Caption = 'Currently Enrolled';
                }
                field(DegreeCandidate; Rec."Degree Candidate")
                {
                    ApplicationArea = all;
                    Caption = 'Degree Candidate';
                }
                field(DegreeEarned; Rec."Degree Earned")
                {
                    ApplicationArea = all;
                    Caption = 'Degree Earned';
                }
                field(DegreeType; Rec."Degree Type")
                {
                    ApplicationArea = all;
                    Caption = 'Degree Type';
                }

                field(DidyouGraduate; Rec."Did you Graduate")
                {
                    ApplicationArea = all;
                    Caption = 'Did you Graduate';
                }

                field(EarnedCredits; Rec."Earned Credits")
                {
                    ApplicationArea = all;
                    Caption = 'Earned Credits';
                }
                field(EndDate; Rec."End Date")
                {
                    ApplicationArea = all;
                    Caption = 'End Date';
                }
                field(GPACredits; Rec."GPA Credits")
                {
                    ApplicationArea = all;
                    Caption = 'GPA Credits';
                }
                field(GraduationDate; Rec."Graduation Date")
                {
                    ApplicationArea = all;
                    Caption = 'Graduation Date';
                }
                field(GraduationYear; Rec."Graduation Year")
                {
                    ApplicationArea = all;
                    Caption = 'Graduation Year';
                    MinValue = 1990;
                    MaxValue = 2020;
                }
                field(OfficialGPAScale; Rec."Official GPA Scale")
                {
                    ApplicationArea = all;
                    Caption = 'Official GPA Scale';
                }

                field(OfficialGPA; Rec."Official GPA")
                {
                    ApplicationArea = all;
                    Caption = 'Official GPA';
                }
                field(OfficialRecalculatedGPA; Rec."Official Recalculated GPA")
                {
                    ApplicationArea = all;
                    Caption = 'Official Recalculated GPA';
                }
                field(OfficialTranscriptsReceived; Rec."Official Transcripts Received")
                {
                    ApplicationArea = all;
                    Caption = 'Official Transcripts Received';
                }
                field(PreReqCredits; Rec."Pre-Req Credits")
                {
                    ApplicationArea = all;
                    Caption = 'Pre-Req Credits';
                }
                field(PreReqQualityPoints; Rec."Pre-Req Quality Points")
                {
                    ApplicationArea = all;
                    Caption = 'Pre-Req Quality Points';
                }

                field(PreviouslyAttendedMedicalSchool; Rec."Prev. Attended Medical School")
                {
                    ApplicationArea = all;
                    Caption = ' Previously Attended Medical School?';
                }
                field(PrimaryCollege; Rec."Primary College")
                {
                    ApplicationArea = all;
                    Caption = 'Primary College';
                }
                field(QualityPoints; Rec."Quality Points")
                {
                    ApplicationArea = all;
                    Caption = 'Quality Points';
                }
                field(ReasonforTransfer; Rec."Reason for Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Reason for Transfer';
                }
                field(SchoolLevel; Rec."School Level")
                {
                    ApplicationArea = all;
                    Caption = 'School Level';
                }
                field(SelfReportedGraduationYear; Rec."Self-Reported Graduation Year")
                {
                    ApplicationArea = all;
                    Caption = 'Self-Reported Graduation Year';
                }
                field(StartDate; Rec."Start Date")
                {
                    ApplicationArea = all;
                    Caption = 'Start Date';
                }
                field(TestsTaken; Rec."Tests Taken")
                {
                    ApplicationArea = all;
                    Caption = 'Tests Taken';
                }
                field(Transfer; Rec."Transfer")
                {
                    ApplicationArea = all;
                    Caption = 'Transfer';
                }
                field(Type; Rec."Type")
                {
                    ApplicationArea = all;
                    Caption = 'Type';

                }
                field("18DigitEnrollmentId"; Rec."18 Digit EnrollmentId")
                {
                    ApplicationArea = all;
                    Caption = '18 Digit EnrollmentId';
                }
            }
        }

    }
}