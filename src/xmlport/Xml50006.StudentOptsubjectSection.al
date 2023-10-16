xmlport 50006 "Student Opt subject Section"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Optional Student Subject-CS"; "Optional Student Subject-CS")
            {
                AutoUpdate = true;
                RequestFilterFields = "Subject Code", "Academic Year", Semester;
                XmlName = 'StudentOptSubject';
                fieldelement(StudentNo; "Optional Student Subject-CS"."Student No.")
                {
                }
                fieldelement(EnrollmentNo; "Optional Student Subject-CS"."Enrollment No")
                {
                }
                fieldelement(AcademicYear; "Optional Student Subject-CS"."Academic Year")
                {
                }
                fieldelement(SubjectCode; "Optional Student Subject-CS"."Subject Code")
                {
                }
                fieldelement(Semester; "Optional Student Subject-CS".Semester)
                {
                }
                fieldelement(Course; "Optional Student Subject-CS".Course)
                {
                }
                fieldelement(Section; "Optional Student Subject-CS".Section)
                {
                }

                trigger OnAfterModifyRecord()
                begin
                    "Optional Student Subject-CS".SETFILTER("Optional Student Subject-CS"."Elective Group Code", '<>%1', '');
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
}

