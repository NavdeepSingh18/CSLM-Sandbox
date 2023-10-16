xmlport 50011 "Student Data ModificationCS"
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
                fieldelement(EntranceTestRank; "Student Master-CS"."Entrance Test Rank")
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
                fieldelement(Mobileno; "Student Master-CS"."Mobile Number")
                {
                }
                fieldelement(Email; "Student Master-CS"."E-Mail Address")
                {
                }
                fieldelement(LateralStudent; "Student Master-CS"."Lateral Student")
                {
                }
                fieldelement(Group; "Student Master-CS".Group)
                {
                }
                fieldelement(EnrollmentNo; "Student Master-CS"."Enrollment No.")
                {
                }
                fieldelement(ParentIncome; "Student Master-CS"."Parents Income")
                {
                }
                fieldelement(ScholarshipSource; "Student Master-CS"."Scholarship Source")
                {
                }
                fieldelement(Year; "Student Master-CS".Year)
                {
                }
                fieldelement(AdmittedYear; "Student Master-CS"."Admitted Year")
                {
                }
                fieldelement(Section; "Student Master-CS".Section)
                {
                }
                fieldelement(RollNo; "Student Master-CS"."Roll No.")
                {
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

        Counter: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        CounterOK: Integer;
        Text0001Lbl: Label 'Uploading Students  #1########## @2@@@@@@@@@@@@@';

}

