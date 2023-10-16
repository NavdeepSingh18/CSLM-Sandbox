xmlport 50003 "Student Data Upload New"
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
                RequestFilterFields = "Enrollment No.";
                XmlName = 'Student';
                fieldelement("ApplicationNo."; "Student Master-CS"."Application No.")
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
                fieldelement(StudentStatus; "Student Master-CS"."Student Status")
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    //Counter := Counter + 1;
                    //Window.UPDATE(1,"Student Master-CS"."No.");
                    //Window.UPDATE(2,ROUND(Counter / CounterTotal * 10000,1));

                    //CounterOK := CounterOK + 1;
                    /*
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Application No.");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Enrollment No.");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."First Name");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Course Code");
                    "Student Master-CS".TESTFIELD("Student Master-CS".Gender);
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Fee Classification Code");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Date of Birth");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Academic Year");
                    "Student Master-CS".TESTFIELD("Student Master-CS".Semester);
                    "Student Master-CS".TESTFIELD("Student Master-CS".Category);
                    "Student Master-CS".TESTFIELD("Student Master-CS"."E-Mail Address");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Entrance Test Rank");
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Mobile Number");
                    IF "Student Master-CS"."Fee Classification Code" = 'GENERAL' THEN
                      "Student Master-CS".TESTFIELD("Student Master-CS"."Entrance Test Rank");
                    IF CourseMasterCS.GET("Student Master-CS"."Course Code") THEN BEGIN
                      IF (CourseMasterCS."Group Mandatory") AND ("Student Master-CS".Year = '1ST')  THEN
                        "Student Master-CS".TESTFIELD("Student Master-CS".Group);
                      END;
                    IF ("Student Master-CS".Year = '2ND') OR ("Student Master-CS".Year = '3RD') OR ("Student Master-CS".Year = '4TH') THEN BEGIN
                      IF "Student Master-CS".Group <> '' THEN
                        ERROR('Group Should Not have the value in it');
                    END;
                    
                    "Student Master-CS".TESTFIELD("Student Master-CS"."Parents Income");
                    //"Student Master-CS".TESTFIELD("Student Master-CS"."Scholarship Source");
                    */

                end;

                trigger OnBeforeInsertRecord()
                begin
                    //CounterTotal := "Student Master-CS".count();
                    //Window.OPEN(Text0001Lbl);
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
        //REPORT.RUN(50039,FALSE,FALSE,"Student Master-CS");
        //REPORT.RUN(50108,FALSE,FALSE,StudentMasterCS);
        ///Window.Close();
        MESSAGE('Completed.');
    end;

    var


}

