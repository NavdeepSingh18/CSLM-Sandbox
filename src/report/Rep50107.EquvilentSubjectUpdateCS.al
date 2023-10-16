report 50107 "Equvilent Subject Update CS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Subject Substitute Info-CS"; "Subject Substitute Info-CS")
        {

            trigger OnAfterGetRecord()
            begin
                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE(Course, "Subject Substitute Info-CS"."Course Code");
                MainStudentSubjectCS.SETRANGE(Semester, "Subject Substitute Info-CS".Semester);
                MainStudentSubjectCS.SETRANGE("Subject Code", "Subject Substitute Info-CS"."Subject Code");
                MainStudentSubjectCS.SETRANGE("Student No.", "Subject Substitute Info-CS"."Student No.");
                IF MainStudentSubjectCS.findfirst() THEN BEGIN
                    MainStudentSubjectCS."Actual Subject Code" := "Subject Substitute Info-CS"."Actual Subject Code";
                    MainStudentSubjectCS."Actual Subject Description" := "Subject Substitute Info-CS"."Actual Description";
                    MainStudentSubjectCS.Modify();
                    "Subject Substitute Info-CS".Updated := TRUE;
                    "Subject Substitute Info-CS".Modify();
                END;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE(Course, "Subject Substitute Info-CS"."Course Code");
                OptionalStudentSubjectCS.SETRANGE(Semester, "Subject Substitute Info-CS".Semester);
                OptionalStudentSubjectCS.SETRANGE("Subject Code", "Subject Substitute Info-CS"."Subject Code");
                OptionalStudentSubjectCS.SETRANGE("Student No.", "Subject Substitute Info-CS"."Student No.");
                IF OptionalStudentSubjectCS.findfirst() THEN BEGIN
                    OptionalStudentSubjectCS."Actual Subject Code" := "Subject Substitute Info-CS"."Actual Subject Code";
                    OptionalStudentSubjectCS."Actual Subject Description" := "Subject Substitute Info-CS"."Actual Description";
                    OptionalStudentSubjectCS.Modify();
                    "Subject Substitute Info-CS".Updated := TRUE;
                    "Subject Substitute Info-CS".Modify();
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

    trigger OnPostReport()
    begin
        MESSAGE('Done');
    end;

    var
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
}

