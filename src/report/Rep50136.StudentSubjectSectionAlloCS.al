report 50136 "Student Subject Section AlloCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {

            trigger OnAfterGetRecord()
            begin

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        MainStudentSubjectCS.RENAME(MainStudentSubjectCS."Student No.", MainStudentSubjectCS.Course, MainStudentSubjectCS.Semester,
                                              MainStudentSubjectCS."Academic Year", MainStudentSubjectCS."Subject Code", "Student Master-CS".Section);
                        MainStudentSubjectCS."Roll No." := "Student Master-CS"."Roll No.";
                        MainStudentSubjectCS.Modify();
                    UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                IF OptionalStudentSubjectCS.findset() THEN
                    REPEAT
                        OptionalStudentSubjectCS.RENAME(OptionalStudentSubjectCS."Student No.", OptionalStudentSubjectCS.Course, OptionalStudentSubjectCS.Semester,
                                              OptionalStudentSubjectCS."Academic Year", OptionalStudentSubjectCS."Subject Code", "Student Master-CS".Section);
                        OptionalStudentSubjectCS."Roll No." := "Student Master-CS"."Roll No.";
                        OptionalStudentSubjectCS.Modify();
                    UNTIL MainStudentSubjectCS.NEXT() = 0;
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

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
}

