xmlport 50008 "Student Subject"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Main Student Subject-CS"; "Main Student Subject-CS")
            {
                AutoUpdate = true;
                XmlName = 'Student';
                fieldelement(EnrollmentNo; "Main Student Subject-CS"."Enrollment No")
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignField()
                    begin

                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Main Student Subject-CS"."Enrollment No");
                        IF StudentMasterCS.FINDFIRST() THEN
                            //  "Main Student Subject-CS"."Student No." := StudentMasterCS."No.";
                            "Main Student Subject-CS"."Student Name" := StudentMasterCS."Name as on Certificate";

                    end;
                }
                fieldelement(StudentNo; "Main Student Subject-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Main Student Subject-CS"."Student No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(Course; "Main Student Subject-CS".Course)
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Main Student Subject-CS".Course := '0' + "Main Student Subject-CS".Course;
                    end;
                }
                fieldelement(Semester; "Main Student Subject-CS".Semester)
                {
                }
                fieldelement(ActualSemester; "Main Student Subject-CS"."Actual Semester")
                {
                }
                fieldelement(Section; "Main Student Subject-CS".Section)
                {
                }
                fieldelement(RollNo; "Main Student Subject-CS"."Roll No.")
                {
                }
                fieldelement(AcademicYear; "Main Student Subject-CS"."Academic Year")
                {
                }
                fieldelement(ActualAcademic; "Main Student Subject-CS"."Actual Academic Year")
                {
                }
                fieldelement(SubjectCode; "Main Student Subject-CS"."Subject Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Main Student Subject-CS".VALIDATE("Subject Code","Main Student Subject-CS"."Subject Code");
                    end;
                }
                fieldelement(ActualSubjectCode; "Main Student Subject-CS"."Actual Subject Code")
                {
                }
                fieldelement(Description; "Main Student Subject-CS".Description)
                {
                }
                fieldelement(Credit; "Main Student Subject-CS".Credit)
                {
                }
                fieldelement(SubjectType; "Main Student Subject-CS"."Subject Type")
                {
                }
                fieldelement(InternalMarks; "Main Student Subject-CS"."Internal Mark")
                {
                }
                fieldelement(TotalInternal; "Main Student Subject-CS"."Total Internal")
                {
                }
                fieldelement(Grade; "Main Student Subject-CS".Grade)
                {
                }
                fieldelement(MaximumMarks; "Main Student Subject-CS"."Maximum Mark")
                {
                }
                fieldelement(Detained; "Main Student Subject-CS".Detained)
                {
                }
                fieldelement(GD1; "Main Student Subject-CS"."Global Dimension 1 Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Main Student Subject-CS"."Global Dimension 1 Code" := '0' + "Main Student Subject-CS"."Global Dimension 1 Code";
                    end;
                }
                fieldelement(GD2; "Main Student Subject-CS"."Global Dimension 2 Code")
                {
                }
                fieldelement(TypeofCourse; "Main Student Subject-CS"."Type Of Course")
                {
                }
                fieldelement(Year; "Main Student Subject-CS".Year)
                {
                }
                fieldelement(InternalMaximum; "Main Student Subject-CS"."Internal Maximum")
                {
                }
                fieldelement(ExternalMaximum; "Main Student Subject-CS"."External Maximum")
                {
                }
                fieldelement(group; "Main Student Subject-CS".Group)
                {
                }
                fieldelement(ExternalMarks; "Main Student Subject-CS"."External Mark")
                {
                }
                fieldelement(Total; "Main Student Subject-CS".Total)
                {
                }
                fieldelement(Result; "Main Student Subject-CS".Result)
                {
                }
                fieldelement(AttendanceType; "Main Student Subject-CS"."Attendance Type")
                {
                }
                fieldelement(AttendancePercentage; "Main Student Subject-CS"."Attendance Percentage")
                {
                }
                fieldelement(AttendanceOnDate; "Main Student Subject-CS"."Attendance % as on Date")
                {
                }
                fieldelement(GraceMarks; "Main Student Subject-CS"."Grace Marks")
                {
                }
                fieldelement(CreditEarn; "Main Student Subject-CS"."Credit Earned")
                {
                }
                fieldelement(CreditEarnPoints; "Main Student Subject-CS"."Credit Grade Points Earned")
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
        MESSAGE('Done !');
    end;

    trigger OnPreXmlPort()
    begin
        //MESSAGE('Done 22222!');
    end;

    var

        StudentMasterCS: Record "Student Master-CS";

}

