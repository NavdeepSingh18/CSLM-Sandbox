xmlport 50002 "Student Data Modification"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Student Master-CS"; "Student Master-CS")
            {
                AutoUpdate = true;
                XmlName = 'Student';
                fieldelement("ApplicationNo."; "Student Master-CS"."Application No.")
                {

                    trigger OnAfterAssignField()
                    begin

                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Application No.", "Student Master-CS"."Application No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            "Student Master-CS"."No." := StudentMasterCS."No.";

                    end;
                }
                fieldelement("StudentNo."; "Student Master-CS"."No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Student Master-CS"."No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(CategoryofAdmission; "Student Master-CS"."Fee Classification Code")
                {
                }
                fieldelement(CourseCode; "Student Master-CS"."Course Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Student Master-CS"."Course Code" := FORMAT('0' + "Student Master-CS"."Course Code");
                    end;
                }
                fieldelement(Category; "Student Master-CS".Category)
                {
                }
                fieldelement(EnrollmentNo; "Student Master-CS"."Enrollment No.")
                {
                }
                fieldelement(Section; "Student Master-CS".Section)
                {
                }
                fieldelement(RollNo; "Student Master-CS"."Roll No.")
                {
                }
                fieldelement(StudentStatus; "Student Master-CS"."Student Status")
                {
                }
                fieldelement(Semester; "Student Master-CS".Semester)
                {
                }
                fieldelement(AcademicYear; "Student Master-CS"."Academic Year")
                {
                }
                fieldelement(Updated; "Student Master-CS".Updated)
                {
                }

                trigger OnAfterModifyRecord()
                begin

                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                    MainStudentSubjectCS.SETRANGE(Semester, "Student Master-CS".Semester, 'VIII');
                    IF MainStudentSubjectCS.FINDSET() THEN
                        MainStudentSubjectCS.DELETEALL();

                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SETRANGE("Student No.", "Student Master-CS"."No.");
                    OptionalStudentSubjectCS.SETRANGE(Semester, "Student Master-CS".Semester, 'VIII');
                    IF OptionalStudentSubjectCS.FINDSET() THEN
                        OptionalStudentSubjectCS.DELETEALL();

                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("No.", "Student Master-CS"."No.");
                    IF StudentMasterCS.FINDFIRST() THEN
                        REPORT.RUNMODAL(50097, FALSE, FALSE, StudentMasterCS);

                end;
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

        MESSAGE('Completed.');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";

}