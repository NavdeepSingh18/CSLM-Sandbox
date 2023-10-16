xmlport 50062 "Equalent Subject Info"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Subject Substitute Info-CS"; "Subject Substitute Info-CS")
            {
                XmlName = 'EqualentSubjectInfo';
                fieldelement(StudentName; "Subject Substitute Info-CS"."Student Name")
                {
                }
                fieldelement(EnrollmentNo; "Subject Substitute Info-CS"."Enrollment No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        StudentMasterCS.RESET();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Subject Substitute Info-CS"."Enrollment No.");
                        IF StudentMasterCS.FINDFIRST() THEN
                            "Subject Substitute Info-CS"."Student No." := StudentMasterCS."No.";

                    end;
                }
                fieldelement(Course; "Subject Substitute Info-CS"."Course Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Subject Substitute Info-CS"."Course Code" := '0' + "Subject Substitute Info-CS"."Course Code";
                    end;
                }
                fieldelement(Semester; "Subject Substitute Info-CS".Semester)
                {
                }
                fieldelement(SubjectCode; "Subject Substitute Info-CS"."Subject Code")
                {
                }
                fieldelement(Description; "Subject Substitute Info-CS".Description)
                {
                }
                fieldelement(ActualSubjectCode; "Subject Substitute Info-CS"."Actual Subject Code")
                {
                }
                fieldelement(ActualDescription; "Subject Substitute Info-CS"."Actual Description")
                {
                }
                fieldelement(Grade; "Subject Substitute Info-CS".Grade)
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

