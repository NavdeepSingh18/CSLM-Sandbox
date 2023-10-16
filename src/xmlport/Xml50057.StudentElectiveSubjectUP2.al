xmlport 50057 "Student Elective Subject UP 2"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Optional Student Subject-CS"; "Optional Student Subject-CS")
            {
                AutoUpdate = true;
                XmlName = 'StudentElectiveSubject';
                fieldelement(EnrollmentNo; "Optional Student Subject-CS"."Enrollment No")
                {

                    trigger OnAfterAssignField()
                    begin
                        CLEAR(StudentMasterCS."No.");
                        CLEAR(StudentMasterCS."Student Name");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Optional Student Subject-CS"."Enrollment No");
                        IF StudentMasterCS.FINDFIRST() THEN
                            "Optional Student Subject-CS"."Student No." := StudentMasterCS."No."

                    end;
                }
                fieldelement(StudentNo; "Optional Student Subject-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Optional Student Subject-CS"."Student No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(CourseCode; "Optional Student Subject-CS".Course)
                {

                    trigger OnAfterAssignField()
                    begin
                        CourseCodeCOn := '0' + FORMAT("Optional Student Subject-CS".Course);
                        "Optional Student Subject-CS".Course := CourseCodeCOn;

                        CourseMasterCS.Reset();
                        CourseMasterCS.SETRANGE(Code, CourseCodeCOn);
                        IF CourseMasterCS.FINDFIRST() THEN
                            "Optional Student Subject-CS".Graduation := CourseMasterCS.Graduation;

                    end;
                }
                fieldelement(Semester; "Optional Student Subject-CS".Semester)
                {

                    trigger OnAfterAssignField()
                    begin
                        IF "Optional Student Subject-CS".Semester = 'III' THEN
                            STuYear := '2ND'
                        ELSE
                            IF "Optional Student Subject-CS".Semester = 'VII' THEN
                                STuYear := '4TH';
                    end;
                }
                fieldelement(AcademicYear; "Optional Student Subject-CS"."Academic Year")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Optional Student Subject-CS"."Academic Year" := '2017-2018';
                    end;
                }
                fieldelement(SubjectCode; "Optional Student Subject-CS"."Subject Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Optional Student Subject-CS".VALIDATE("Subject Code", "Optional Student Subject-CS"."Subject Code");
                        "Optional Student Subject-CS"."Actual Subject Code" := "Optional Student Subject-CS"."Subject Code";
                    end;
                }
                fieldelement(Section; "Optional Student Subject-CS".Section)
                {
                }
                fieldelement(ElectiveGroup; "Optional Student Subject-CS"."Elective Group Code")
                {
                }
                fieldelement(Updated; "Optional Student Subject-CS".Updated)
                {
                }
                fieldelement(StudentName; "Optional Student Subject-CS"."Student Name")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Optional Student Subject-CS"."Student Name" := StudentMasterCS."Student Name";
                    end;
                }
                fieldelement(RollNo; "Optional Student Subject-CS"."Roll No.")
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
        CourseMasterCS: Record "Course Master-CS";
        CourseCodeCOn: Code[10];

        STuYear: Code[10];
}

