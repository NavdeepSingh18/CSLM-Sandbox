xmlport 50001 "Student Data Upload-CS"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;
    Caption = 'Student Data Upload';

    schema
    {
        textelement(Root)
        {
            tableelement("Student Master-CS"; "Student Master-CS")
            {
                XmlName = 'Student';
                fieldelement("ApplicationNo."; "Student Master-CS"."Application No.")
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignField()
                    begin
                        "Student Master-CS"."New Student" := TRUE;
                    end;
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
                Fieldelement("SF18DigitID"; "Student Master-CS"."18 Digit ID")
                {
                }
                fieldelement(Semester; "Student Master-CS".Semester)
                {
                }
                fieldelement(AcademicYear; "Student Master-CS"."Academic Year")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DOB; "Student Master-CS"."Date of Birth")
                {
                }
                fieldelement(Gender; "Student Master-CS".Gender)
                {
                }
                fieldelement(CategoryofAdmission; "Student Master-CS"."Fee Classification Code")
                {
                    MinOccurs = Zero;
                }

                fieldelement(Mobileno; "Student Master-CS"."Mobile Number")
                {
                }
                fieldelement(Email; "Student Master-CS"."E-Mail Address")
                {
                }
                fieldelement(ScholarshipCode; "Student Master-CS"."Scholarship Source")
                {
                }
                fieldelement(GrantCode1; "Student Master-CS"."Grant Code 1")
                {
                }
                fieldelement(GrantCode2; "Student Master-CS"."Grant Code 2")
                {
                }
                fieldelement(GrantCode3; "Student Master-CS"."Grant Code 3")
                {
                }
                fieldelement(Year; "Student Master-CS".Year)
                {
                }
                fieldelement(AdmittedYear; "Student Master-CS"."Admitted Year")
                {
                }
                fieldelement(CourseCode; "Student Master-CS"."Course Code")
                {
                    // FieldValidate = Yes;
                }

                trigger OnAfterInsertRecord()
                begin
                    Counter := Counter + 1;
                    Window.UPDATE(1, "Student Master-CS"."No.");
                    Window.UPDATE(2, ROUND(Counter / CounterTotal * 10000, 1));

                    CounterOK := CounterOK + 1;
                end;

                trigger OnBeforeInsertRecord()
                begin

                    CounterTotal := "Student Master-CS".count();
                    Window.OPEN(Text0001Lbl);
                end;

                trigger OnAfterInitRecord()
                begin
                    IF FirstLine = TRUE THEN BEGIN
                        FirstLine := FALSE;
                        currXMLport.SKIP();
                    END;
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
    trigger OnPreXmlPort()
    begin
        FirstLine := TRUE;
    end;

    trigger OnPostXmlPort()
    var
    begin
        // StudentMasterCS.Reset();
        // StudentMasterCS.SETRANGE("New Student", TRUE);
        //  REPORT.RUN(50022, FALSE, FALSE, StudentMasterCS);
        // WebServicesFunctionsCS.StudentCreation("No.", "Enrollment No.");
        // IF StudentMasterCS.FINDSET() THEN
        //     StudentMasterCS.MODIFYALL("New Student", FALSE);

        Window.CLOSE();
        MESSAGE('Completed.');
    end;

    var
        Counter: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        CounterOK: Integer;
        FirstLine: Boolean;
        Text0001Lbl: Label 'Uploading Students  #1########## @2@@@@@@@@@@@@@';

}