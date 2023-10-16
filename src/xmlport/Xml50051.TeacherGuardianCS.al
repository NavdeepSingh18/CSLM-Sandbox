xmlport 50051 "Teacher GuardianCS"
{
    // version V.001-CS

    Caption = 'Teacher Guardian';
    Direction = Both;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Student Teacher Guardian-CS"; "Student Teacher Guardian-CS")
            {
                XmlName = 'TeacherGuardian';
                fieldelement(No; "Student Teacher Guardian-CS"."No.")
                {
                }
                fieldelement(StudentName; "Student Teacher Guardian-CS"."Student Name")
                {
                }
                fieldelement(Program; "Student Teacher Guardian-CS".Program)
                {
                }
                fieldelement(Section; "Student Teacher Guardian-CS".Section)
                {
                }
                fieldelement(Fathername; "Student Teacher Guardian-CS"."Fathers Name")
                {
                }
                fieldelement(Mothername; "Student Teacher Guardian-CS"."Mothers Name")
                {
                }
                fieldelement(StudentPerhoneNo; "Student Teacher Guardian-CS"."Phone Number Student")
                {
                }
                fieldelement(FatherMotherMobileNo; "Student Teacher Guardian-CS"."Father/Mother Mobile No.")
                {
                }
                fieldelement(StudentEmailAddress; "Student Teacher Guardian-CS"."E-Mail Address Student")
                {
                }
                fieldelement(ParentEmailAddress; "Student Teacher Guardian-CS"."E-Mail Address Parent")
                {
                }
                fieldelement(DOB; "Student Teacher Guardian-CS"."Date of Birth")
                {
                }
                fieldelement(EnrollmentNo; "Student Teacher Guardian-CS"."Enrollment No.")
                {
                }
                fieldelement(Batch; "Student Teacher Guardian-CS".Batch)
                {
                }
                fieldelement(Group; "Student Teacher Guardian-CS".Group)
                {
                }
                fieldelement(InstituteCode; "Student Teacher Guardian-CS"."Global Dimension 1 Code")
                {
                }
                fieldelement(departmentCode; "Student Teacher Guardian-CS"."Global Dimension 2 Code")
                {
                }
                fieldelement(Semester; "Student Teacher Guardian-CS".Semester)
                {
                }
                fieldelement(Year; "Student Teacher Guardian-CS".Year)
                {
                }
                fieldelement(Course; "Student Teacher Guardian-CS".Course)
                {
                }
                fieldelement(TypeofCourse; "Student Teacher Guardian-CS"."Type Of Course")
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
        MESSAGE('Uploaded')
    end;

    var


        DocNO: Code[20];

    procedure GetDocNo(NO: Code[20])
    begin
        DocNO := NO;
    end;
}

