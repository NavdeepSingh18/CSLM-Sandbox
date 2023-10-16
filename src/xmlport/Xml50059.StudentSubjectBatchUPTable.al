xmlport 50059 "Student Subject Batch UP Table"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Main Stud Sub Batch Update-CS"; "Main Stud Sub Batch Update-CS")
            {
                AutoUpdate = true;
                XmlName = 'StudentSubjectBatchUpdate';
                fieldelement(EnrollmentNo; "Main Stud Sub Batch Update-CS"."Enrollment No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        CLEAR(StudentMasterCS."No.");
                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Main Stud Sub Batch Update-CS"."Enrollment No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            "Main Stud Sub Batch Update-CS"."Student No." := StudentMasterCS."No."

                    end;
                }
                fieldelement(StudentNo; "Main Stud Sub Batch Update-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Main Stud Sub Batch Update-CS"."Student No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(StudentName; "Main Stud Sub Batch Update-CS"."Student Name")
                {
                }
                fieldelement(LineNo; "Main Stud Sub Batch Update-CS"."Line No.")
                {

                    trigger OnAfterAssignField()
                    begin

                        MainStudSubBatchUpdateCS.Reset();
                        MainStudSubBatchUpdateCS.SETRANGE("Enrollment No.", "Main Stud Sub Batch Update-CS"."Enrollment No.");
                        IF MainStudSubBatchUpdateCS.FINDLAST() THEN
                            LineNo1 := MainStudSubBatchUpdateCS."Line No." + 10000
                        ELSE
                            LineNo1 := 10000;

                        "Main Stud Sub Batch Update-CS"."Line No." := LineNo1;
                    end;
                }
                fieldelement(CourseCode; "Main Stud Sub Batch Update-CS"."Course Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Main Stud Sub Batch Update-CS"."Course Code" := FORMAT('0' + "Main Stud Sub Batch Update-CS"."Course Code");
                    end;
                }
                fieldelement(Semester; "Main Stud Sub Batch Update-CS".Semester)
                {
                }
                fieldelement(Section; "Main Stud Sub Batch Update-CS".Section)
                {
                }
                fieldelement(RollNo; "Main Stud Sub Batch Update-CS"."Roll No.")
                {
                }
                fieldelement(Group; "Main Stud Sub Batch Update-CS"."Student Group")
                {
                }
                fieldelement(Batch; "Main Stud Sub Batch Update-CS"."Student Batch")
                {
                }
                fieldelement(SubjectCode; "Main Stud Sub Batch Update-CS"."Subject Code")
                {
                }
                fieldelement(AcademicYear; "Main Stud Sub Batch Update-CS"."Academic Year")
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
        MainStudSubBatchUpdateCS: Record "Main Stud Sub Batch Update-CS";
        LineNo1: Integer;
}

