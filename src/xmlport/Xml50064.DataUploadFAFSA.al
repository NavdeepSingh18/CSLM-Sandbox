xmlport 50064 "Data Upload FAFSA"
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
                XmlName = 'Student';
                fieldelement(StudentNo; "Student Master-CS"."No.")
                {
                    MinOccurs = Zero;

                }
                fieldelement(FirstName; "Student Master-CS"."First Name")
                {
                }
                fieldelement(MiddleName; "Student Master-CS"."Middle Name")
                {
                }
                fieldelement(LastName; "Student Master-CS"."Last Name")
                {
                }
                fieldelement(Semester; "Student Master-CS".Semester)
                {
                }
                fieldelement(AcademicYear; "Student Master-CS"."Academic Year")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EnrollmentNo; "Student Master-CS"."Enrollment No.")
                {
                }

                fieldelement(AdmittedYear; "Student Master-CS"."Admitted Year")
                {
                }
                fieldelement(GD1; "Student Master-CS"."Global Dimension 1 Code")
                {

                }
                fieldelement(GD2; "Student Master-CS"."Global Dimension 2 Code")
                {

                }

                trigger OnAfterInsertRecord()
                begin
                    Counter := Counter + 1;
                    Window.UPDATE(1, "Student Master-CS"."No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));
                    CounterOK := CounterOK + 1;
                    "Student Master-CS".TESTFIELD("Student Master-CS"."No.");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Enrollment No.");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."First Name");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Academic Year");
                    "Student Master-CS".TESTFIELD("Student Master-CS".Semester);
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Global Dimension 1 Code");

                end;

                trigger OnBeforeInsertRecord()
                begin

                    CounterTotal := "Student Master-CS".count();
                    Window.OPEN(Text0001Lbl);
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

        Window.CLOSE();
        MESSAGE('Completed.');
    end;

    var
        Counter: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        CounterOK: Integer;
        Text0001Lbl: Label 'Uploading Students  #1########## @2@@@@@@@@@@@@@';

}