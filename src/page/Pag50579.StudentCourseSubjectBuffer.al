page 50579 "Course Subject Buffer List"
{

    PageType = API;
    SourceTable = "Student Course Subject Buffer";
    Caption = 'Student Course Subject Buffer List';
    EntityName = 'cS';
    EntitySetName = 'cS';
    DelayedInsert = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    APIPublisher = 'cS01';
    APIGroup = 'cS';

    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(studentNo; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field(academicYear; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(courseCode; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(subjectCode; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field(terM; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(sectiOn; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field(semestEr; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(sLcMSubjectCode; Rec."SLcM Subject Code")
                {
                    ApplicationArea = All;
                }
                field(globaldimension1code; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        RecMainStudentSubject: Record "Main Student Subject-CS";
        RecEducationSetup: Record "Education Setup-CS";


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Student No.");
        Rec.TestField("Academic Year");
        Rec.TestField("Course Code");
        Rec.TestField("Subject Code");
        Rec.TestField(Semester);
        Rec.TestField("SLcM Subject Code");

        RecMainStudentSubject.Init();
        RecMainStudentSubject.Validate("Student No.", Rec."Student No.");
        RecMainStudentSubject.Validate(Course, Rec."Course Code");
        RecMainStudentSubject.Validate("Subject Code", Rec."Subject Code");
        RecMainStudentSubject.Validate(Semester, Rec.Semester);
        RecMainStudentSubject.Validate("Academic Year", Rec."Academic Year");
        RecMainStudentSubject.Validate(Section, Rec.Section);
        Rec.TestField("Global Dimension 1 Code");
        RecEducationSetup.Reset();
        RecEducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecEducationSetup.FindFirst();
        RecMainStudentSubject.Validate("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        RecMainStudentSubject.Validate("SLcM Subject Code", Rec."SLcM Subject Code");
        RecMainStudentSubject.Insert(true);
    end;
}
