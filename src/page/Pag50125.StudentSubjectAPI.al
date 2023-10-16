page 50125 StudentSubjectAPI
{
    PageType = API;
    Caption = 'Student Subject';
    APIPublisher = 'sLcM';
    APIGroup = 'boTmind';
    APIVersion = 'v0.1';
    EntityName = 'studentsubject';
    EntitySetName = 'studentsubjects';
    SourceTable = "Main Student Subject-CS";
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(studentNo; Rec."Student No.")
                {
                    Caption = 'Student No.';
                }
                field(course; Rec.Course)
                {
                    Caption = 'Course';
                }
                field(semester; Rec.Semester)
                {
                    Caption = 'Semester';
                }
                field(academicYear; Rec."Academic Year")
                {
                    Caption = 'Academic Year';
                }
                field(subjectCode; Rec."Subject Code")
                {
                    Caption = 'Subject Code';
                }
                
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(teRm;Rec.Term)
                {
                    Caption = 'Term';
                }
                field(internalMark; Rec."Internal Mark")
                {
                    Caption = 'Internal Mark';
                }
                field(externalMark; Rec."External Mark")
                {
                    Caption = 'External Mark';
                }
                field(total; Rec.Total)
                {
                    Caption = 'Total';
                }
                field(result; Rec.Result)
                {
                    Caption = 'Result';
                }
                field(grade; Rec.Grade)
                {
                    Caption = 'Grade';
                }
                field(credit; Rec.Credit)
                {
                    Caption = 'Credit';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(enrollmentNo; Rec."Enrollment No")
                {
                    Caption = 'Enrollment No.';
                }
                field(creditEarned; Rec."Credit Earned")
                {
                    Caption = 'Credit Earned';
                }
                field(typeOfSubject; Rec."Type of Subject")
                {
                    Caption = 'Type of Subject';
                }
                field(categoryCourseDescription; Rec."Category-Course Description")
                {
                    Caption = 'Category-Course Description';
                }
                field(tc; Rec.TC)
                {
                    Caption = 'TC';
                }
                field(originalStudentNo; Rec."Original Student No.")
                {
                    Caption = 'Original Student No.';
                }
                field(failed; Rec.Failed)
                {
                    Caption = 'Failed';
                }
                field(dropped; Rec.Dropped)
                {
                    Caption = 'Dropped';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(numericGrade; Rec."Numeric Grade")
                {
                    Caption = 'Numeric Grade';
                }
                field(creditsAttempt; Rec."Credits Attempt")
                {
                    Caption = 'Credits Attempt';
                }
                field(mOdifiedoN; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}