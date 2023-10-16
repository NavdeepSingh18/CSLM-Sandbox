xmlport 50056 "Student Elective Subject UP"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Stud Optional Subject UP-CS"; "Stud Optional Subject UP-CS")
            {
                XmlName = 'StudentElectiveSubjectUpdate';
                fieldelement(EnrollmentNo; "Stud Optional Subject UP-CS"."Enrollment No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        CLEAR(StudentMasterCS."No.");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Stud Optional Subject UP-CS"."Enrollment No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            "Stud Optional Subject UP-CS"."Student No." := StudentMasterCS."No."
                    end;
                }
                fieldelement(StudentNo; "Stud Optional Subject UP-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Stud Optional Subject UP-CS"."Student No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(StudentName; "Stud Optional Subject UP-CS"."Student Name")
                {
                }
                fieldelement(LineNo; "Stud Optional Subject UP-CS"."Line No.")
                {

                    trigger OnAfterAssignField()
                    begin

                        StudOptionalSubjectUPCS.Reset();
                        StudOptionalSubjectUPCS.SETRANGE("Enrollment No.", "Stud Optional Subject UP-CS"."Enrollment No.");
                        IF StudOptionalSubjectUPCS.FINDLAST() THEN
                            LineNo1 := StudOptionalSubjectUPCS."Line No." + 10000
                        ELSE
                            LineNo1 := 10000;

                        "Stud Optional Subject UP-CS"."Line No." := LineNo1;
                    end;
                }
                fieldelement(CourseCode; "Stud Optional Subject UP-CS"."Course Code")
                {

                    trigger OnAfterAssignField()
                    begin

                        "Stud Optional Subject UP-CS"."Course Code" := FORMAT('0' + "Stud Optional Subject UP-CS"."Course Code");
                    end;
                }
                fieldelement(Semester; "Stud Optional Subject UP-CS".Semester)
                {
                }
                fieldelement(Section; "Stud Optional Subject UP-CS".Section)
                {
                }
                fieldelement(RollNo; "Stud Optional Subject UP-CS"."Roll No.")
                {
                }
                fieldelement(ElectiveGroup; "Stud Optional Subject UP-CS"."Elective Group")
                {
                }
                fieldelement(SubjectCode; "Stud Optional Subject UP-CS"."Subject Code")
                {
                }
                fieldelement(AcademicYear; "Stud Optional Subject UP-CS"."Academic Year")
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
        StudOptionalSubjectUPCS: Record "Stud Optional Subject UP-CS";
        LineNo1: Integer;

}

