page 50123 StudentSubjectExamAPI
{
    PageType = API;
    Caption = 'Student Subject Exam';
    APIPublisher = 'sLcM';
    APIGroup = 'boTmind';
    APIVersion = 'v0.1';
    EntityName = 'studentsubjectExam';
    EntitySetName = 'studentsubjectExams';
    SourceTable = "Student Subject Exam";
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
                field(description; Rec.Description)
                {
                    Caption = 'Description';
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
                field(studentName; Rec."Student Name")
                {
                    Caption = 'Student Name';
                }
                field(maximumMark; Rec."Maximum Mark")
                {
                    Caption = 'Maximum Mark';
                }
                field(percentageObtained; Rec."Percentage Obtained")
                {
                    Caption = 'Percentage Obtained';
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Global Dimension 1 Code';
                }
                field(year; Rec.Year)
                {
                    Caption = 'Year';
                }
                field(enrollmentNo; Rec."Enrollment No")
                {
                    Caption = 'Enrollment No.';
                }
                field(term; Rec.Term)
                {
                    Caption = 'Term';
                }
                field(schoolID; Rec."School ID")
                {
                    Caption = 'SLcM School ID';
                }
                field(tc; Rec.TC)
                {
                    Caption = 'TC';
                }
                field(scoreType; Rec."Score Type")
                {
                    Caption = 'Score Type';
                }
                field(originalStudentNo; Rec."Original Student No.")
                {
                    Caption = 'Original Student No.';
                }
                field(examWindow; Rec."Exam Window")
                {
                    Caption = 'Exam Window';
                }
                field(sittingDate; Rec."Sitting Date")
                {
                    Caption = 'Exam Date';
                }
                field(examLocation; Rec."Exam. Location")
                {
                    Caption = 'Exam. Location';
                }
                field(published; Rec.Published)
                {
                    Caption = 'Published';
                }
                field(examSequence; Rec."Exam Sequence")
                {
                    Caption = 'Exam Sequence';
                }
                field(coreClerkshipSubjectCode; Rec."Core Clerkship Subject Code")
                {
                    Caption = 'Core Clerkship Subject Code';
                }
                field(coreClerkshipSubjectDesc; Rec."Core Clerkship Subject Desc")
                {
                    Caption = 'Core Clerkship Subject Description';
                }
                field(shelfExamValue; Rec."Shelf Exam Value")
                {
                    Caption = 'Shelf Exam Value';
                }
                field(consideredInGrading; Rec."Considered in Grading")
                {
                    Caption = 'Considered in Grading';
                }
                field(cbseVersion; Rec."CBSE Version")
                {
                    Caption = 'CBSE Version';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }
                field(cReationDate; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field(MoDiFicationDate; Rec."Modification Date")
                {
                    ApplicationArea = All;
                }

            }
        }
    }


}