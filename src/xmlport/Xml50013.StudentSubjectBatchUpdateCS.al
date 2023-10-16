xmlport 50013 "StudentSubjectBatchUpdateCS"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Main Batch Update-CS"; "Main Batch Update-CS")
            {
                AutoUpdate = true;
                XmlName = 'StudentSubjectBatchUpdate';
                fieldelement(StudentNo; "Main Batch Update-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        IF "Main Batch Update-CS"."Enrollment No." <> '' THEN
                            "Main Batch Update-CS"."Student No." := StudentMasterCS."No.";

                    end;
                }
                fieldelement(EnrollmentNo; "Main Batch Update-CS"."Enrollment No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        IF "Main Batch Update-CS"."Enrollment No." <> '' THEN BEGIN
                            StudentMasterCS.Reset();
                            StudentMasterCS.SETRANGE("Enrollment No.", "Main Batch Update-CS"."Enrollment No.");
                            IF StudentMasterCS.FINDFIRST() THEN
                                "Main Batch Update-CS"."Student No." := StudentMasterCS."No.";
                        END;
                    end;
                }
                fieldelement(CourseCode; "Main Batch Update-CS"."Course Code")
                {
                }
                fieldelement(Semester; "Main Batch Update-CS".Semester)
                {
                }
                fieldelement(Section; "Main Batch Update-CS".Section)
                {
                }
                fieldelement(RollNo; "Main Batch Update-CS"."Roll No")
                {
                }
                fieldelement(AcademicYear; "Main Batch Update-CS"."Academic Year")
                {
                }
                fieldelement(SubjectCode; "Main Batch Update-CS"."Subject Code")
                {
                }
                fieldelement(Batch; "Main Batch Update-CS".Batch)
                {
                }
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

    trigger OnPostXmlPort()
    begin
        MESSAGE('Done');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
}

