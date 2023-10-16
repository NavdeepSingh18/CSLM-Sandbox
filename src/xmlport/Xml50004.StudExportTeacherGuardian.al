xmlport 50004 "Stud. Export Teacher Guardian"
{
    // version V.001-CS

    Direction = Export;
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Student Master-CS"; "Student Master-CS")
            {
                XmlName = 'Student';
                fieldelement("No."; "Student Master-CS"."No.")
                {
                }
                fieldelement(StudentName; "Student Master-CS"."Student Name")
                {
                }
                fieldelement(Program; "Student Master-CS".Graduation)
                {
                }
                fieldelement(Section; "Student Master-CS".Section)
                {
                }
                fieldelement(FatherName; "Student Master-CS"."Fathers Name")
                {
                }
                fieldelement(MotherName; "Student Master-CS"."Mothers Name")
                {
                }
                fieldelement(StudentPhoneNo; "Student Master-CS"."Phone Number")
                {
                }
                fieldelement("FatherContactNo."; "Student Master-CS"."Father Contact Number")
                {
                }
                fieldelement(StudentEmailAddress; "Student Master-CS"."E-Mail Address")
                {
                }
                fieldelement(FatherEmailId; "Student Master-CS"."Father Email ID")
                {
                }
                fieldelement("D.O.B"; "Student Master-CS"."Date of Birth")
                {
                }
                fieldelement(EnrollmentNo; "Student Master-CS"."Enrollment No.")
                {
                }
                fieldelement(Batch; "Student Master-CS".Batch)
                {
                }
                fieldelement(Group; "Student Master-CS".Group)
                {
                }
                fieldelement(InstituteCode; "Student Master-CS"."Global Dimension 1 Code")
                {
                }
                fieldelement(DepartmentCode; "Student Master-CS"."Global Dimension 2 Code")
                {
                }
                fieldelement(Semester; "Student Master-CS".Semester)
                {
                }
                fieldelement(Year; "Student Master-CS".Year)
                {
                }
                fieldelement(Course; "Student Master-CS"."Course Code")
                {
                }
                fieldelement(TypeofCourse; "Student Master-CS"."Type Of Course")
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


    }
}

