xmlport 50055 "Student Subject Batch UP 2"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Main Student Subject-CS"; "Main Student Subject-CS")
            {
                AutoUpdate = true;
                XmlName = 'StudentSubject';
                fieldelement(EnrollmentNo; "Main Student Subject-CS"."Enrollment No")
                {

                    trigger OnAfterAssignField()
                    begin
                        CLEAR(StudentMasterCS."No.");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Main Student Subject-CS"."Enrollment No");
                        IF StudentMasterCS.FINDFIRST() THEN
                            "Main Student Subject-CS"."Student No." := StudentMasterCS."No."

                    end;
                }
                fieldelement(StudentNo; "Main Student Subject-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Main Student Subject-CS"."Student No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(CourseCode; "Main Student Subject-CS".Course)
                {

                    trigger OnAfterAssignField()
                    begin
                        CourseCode1 := '0' + format("Main Student Subject-CS".Course);
                        "Main Student Subject-CS".VALIDATE(Course, CourseCode1);
                    end;
                }
                fieldelement(Semester; "Main Student Subject-CS".Semester)
                {
                }
                fieldelement(AcademicYear; "Main Student Subject-CS"."Academic Year")
                {
                }
                fieldelement(SubjectCode; "Main Student Subject-CS"."Subject Code")
                {
                }
                fieldelement(Section; "Main Student Subject-CS".Section)
                {
                }
                fieldelement(Batch; "Main Student Subject-CS".Batch)
                {
                }
                fieldelement(Updated; "Main Student Subject-CS".Updated)
                {
                }
                fieldelement(StudentName; "Main Student Subject-CS"."Student Name")
                {
                }
                fieldelement(rollno; "Main Student Subject-CS"."Roll No.")
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
        CourseCode1: Code[20];
}

