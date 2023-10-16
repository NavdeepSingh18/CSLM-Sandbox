report 50098 "Student GroupCS"
{
    // version V.001-CS

    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = Administration;
    dataset
    {
        dataitem("Student Master-CS"; "Student Master-CS")
        {
            DataItemTableView = WHERE(Semester = FILTER('I' | 'II'));

            trigger OnAfterGetRecord()
            begin

                MainStudentSubjectCS.Reset();
                MainStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                IF MainStudentSubjectCS.findset() THEN
                    REPEAT
                        MainStudentSubjectCS."Previous Detained Status" := MainStudentSubjectCS.Detained;
                        MainStudentSubjectCS.Modify();
                    UNTIL MainStudentSubjectCS.NEXT() = 0;

                OptionalStudentSubjectCS.Reset();
                OptionalStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                IF OptionalStudentSubjectCS.findset() THEN
                    REPEAT
                        OptionalStudentSubjectCS."Previous Detained Status" := OptionalStudentSubjectCS.Detained;
                        OptionalStudentSubjectCS.Modify();
                    UNTIL OptionalStudentSubjectCS.NEXT() = 0;
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