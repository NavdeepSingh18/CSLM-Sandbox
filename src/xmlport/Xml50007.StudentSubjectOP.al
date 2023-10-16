xmlport 50007 "Student Subject OP"
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
                XmlName = 'Student';
                fieldelement(EnrollmentNo; "Optional Student Subject-CS"."Enrollment No")
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignField()
                    begin

                        StudentMasterCS.Reset();
                        StudentMasterCS.SETRANGE("Enrollment No.", "Optional Student Subject-CS"."Enrollment No");
                        IF StudentMasterCS.FINDFIRST() THEN BEGIN
                            "Optional Student Subject-CS"."Student No." := StudentMasterCS."No.";
                            "Optional Student Subject-CS"."Student Name" := StudentMasterCS."Name as on Certificate";
                        END;

                        /*
                        END ELSE BEGIN
                          MainOptionalSubArchiveCS.INIT();
                          MainOptionalSubArchiveCS.Semester += 10000;
                          MainOptionalSubArchiveCS."Student No."  := "Optional Student Subject-CS"."Enrollment No";
                          MainOptionalSubArchiveCS.INSERT();
                        END;
                        */

                    end;
                }
                fieldelement(StudentNo; "Optional Student Subject-CS"."Student No.")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Optional Student Subject-CS"."Student No." := StudentMasterCS."No.";
                    end;
                }
                fieldelement(Course; "Optional Student Subject-CS".Course)
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Optional Student Subject-CS".Course := '0' + "Optional Student Subject-CS".Course;
                    end;
                }
                fieldelement(Semester; "Optional Student Subject-CS".Semester)
                {
                }
                fieldelement(ActualSemester; "Optional Student Subject-CS"."Actual Semester")
                {
                }
                fieldelement(Section; "Optional Student Subject-CS".Section)
                {
                }
                fieldelement(RollNo; "Optional Student Subject-CS"."Roll No.")
                {
                }
                fieldelement(AcademicYear; "Optional Student Subject-CS"."Academic Year")
                {
                }
                fieldelement(ActualAcademic; "Optional Student Subject-CS"."Actual Academic Year")
                {
                }
                fieldelement(SubjectCode; "Optional Student Subject-CS"."Subject Code")
                {
                }
                fieldelement(ActualSubjectCode; "Optional Student Subject-CS"."Actual Subject Code")
                {
                }
                fieldelement(Description; "Optional Student Subject-CS".Description)
                {
                }
                fieldelement(Credit; "Optional Student Subject-CS".Credit)
                {
                }
                fieldelement(SubjectType; "Optional Student Subject-CS"."Subject Type")
                {
                }
                fieldelement(InternalMarks; "Optional Student Subject-CS"."Internal Obtained")
                {
                }
                fieldelement(TotalInternal; "Optional Student Subject-CS"."Total Internal")
                {
                }
                fieldelement(Grade; "Optional Student Subject-CS".Grade)
                {
                }
                fieldelement(MaximumMarks; "Optional Student Subject-CS"."Maximum Mark")
                {
                }
                fieldelement(Detained; "Optional Student Subject-CS".Detained)
                {
                }
                fieldelement(GD1; "Optional Student Subject-CS"."Global Dimension 1 Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        //"Optional Student Subject-CS"."Global Dimension 1 Code" := '0' + "Optional Student Subject-CS"."Global Dimension 1 Code";
                    end;
                }
                fieldelement(GD2; "Optional Student Subject-CS"."Global Dimension 2 Code")
                {
                }
                fieldelement(TypeofCourse; "Optional Student Subject-CS"."Type Of Course")
                {
                }
                fieldelement(Year; "Optional Student Subject-CS".Year)
                {
                }
                fieldelement(InternalMaximum; "Optional Student Subject-CS"."Internal Maximum")
                {
                }
                fieldelement(ExternalMaximum; "Optional Student Subject-CS"."External Maximum")
                {
                }
                fieldelement(group; "Optional Student Subject-CS".Group)
                {
                }
                fieldelement(ExternalMarks; "Optional Student Subject-CS"."External Obtained")
                {
                }
                fieldelement(Total; "Optional Student Subject-CS".Total)
                {
                }
                fieldelement(Result; "Optional Student Subject-CS".Result)
                {
                }
                fieldelement(Attendancetype; "Optional Student Subject-CS"."Attendance Type")
                {
                }
                fieldelement(AttendancePercentage; "Optional Student Subject-CS"."Attendance Percentage")
                {
                }
                fieldelement(AttendanceOnDate; "Optional Student Subject-CS"."Attendance % as on Date")
                {
                }
                fieldelement(Grace; "Optional Student Subject-CS"."Grace Marks")
                {
                }
                fieldelement(Creditearn; "Optional Student Subject-CS"."Credit Earned")
                {
                }
                fieldelement(CreditearnPoint; "Optional Student Subject-CS"."Credit Grade Points Earned")
                {
                }
                fieldelement(ElectiveGroup; "Optional Student Subject-CS"."Elective Group Code")
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

