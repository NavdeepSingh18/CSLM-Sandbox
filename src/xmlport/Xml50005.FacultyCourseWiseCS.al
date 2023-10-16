xmlport 50005 "Faculty Course Wise-CS"
{
    // version V.001-CS

    Direction = Both;
    FieldSeparator = ',';
    Format = VariableText;
    FormatEvaluate = Legacy;
    //TextEncoding = MS-DOS;
    Caption='Faculty Course Wise';

    schema
    {
        textelement(Root)
        {
            tableelement("Faculty Course Wise-CS"; "Faculty Course Wise-CS")
            {
                AutoUpdate = true;
                RequestFilterFields = "Semester Code", "Academic Year", "Course Code";
                XmlName = 'CourseWiseFaculty';
                fieldelement(CourseCode; "Faculty Course Wise-CS"."Course Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        /*
                        IF "Faculty Course Wise-CS"."Course Code" <> '' THEN
                          "Faculty Course Wise-CS"."Course Code"   := '0' + "Faculty Course Wise-CS"."Course Code";
                        */

                    end;
                }
                fieldelement(FacultyCode; "Faculty Course Wise-CS"."Faculty Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        /*
                        Employee.Reset();
                        Employee.SETRANGE("No.","Faculty Course Wise-CS"."Faculty Code");
                        IF Employee.FINDFIRST()THEN
                        */

                    end;
                }
                fieldelement(SemesterCode; "Faculty Course Wise-CS"."Semester Code")
                {
                }
                fieldelement(SactionCode; "Faculty Course Wise-CS"."Section Code")
                {
                }
                fieldelement(LineNo; "Faculty Course Wise-CS"."Line No")
                {
                }
                fieldelement(SubjectCode; "Faculty Course Wise-CS"."Subject Code")
                {
                }
                fieldelement(Academic; "Faculty Course Wise-CS"."Academic Year")
                {
                }
                fieldelement(SubjectType; "Faculty Course Wise-CS"."Subject Type")
                {
                }
                fieldelement(FacultyName; "Faculty Course Wise-CS"."Faculty Name")
                {

                    trigger OnAfterAssignField()
                    begin
                        "Faculty Course Wise-CS"."Faculty Name" := Employee."First Name";
                    end;
                }
                fieldelement(SubjectDescription; "Faculty Course Wise-CS"."Subject Description")
                {
                }
                fieldelement(Role; "Faculty Course Wise-CS".Role)
                {
                }
                fieldelement(GlobalDimension1Code; "Faculty Course Wise-CS"."Global Dimension 1 Code")
                {

                    trigger OnAfterAssignField()
                    begin
                        /*
                        IF "Faculty Course Wise-CS"."Global Dimension 1 Code" <>  '' THEN
                          "Faculty Course Wise-CS"."Global Dimension 1 Code"   := '0' + "Faculty Course Wise-CS"."Global Dimension 1 Code";
                        */

                    end;
                }
                fieldelement(GlobalDimension2Code; "Faculty Course Wise-CS"."Global Dimension 2 Code")
                {
                }
                fieldelement(TypeOfCourse; "Faculty Course Wise-CS"."Type Of Course")
                {
                }
                fieldelement(YearCode; "Faculty Course Wise-CS"."Year Code")
                {
                }
                fieldelement(Graduation; "Faculty Course Wise-CS".Graduation)
                {
                }
                fieldelement(SubjectClass; "Faculty Course Wise-CS"."Subject Class")
                {
                }
                fieldelement(Batch; "Faculty Course Wise-CS".Batch)
                {
                }
                fieldelement(Updated; "Faculty Course Wise-CS".Updated)
                {
                }

                trigger OnAfterInsertRecord()
                begin
                    "Faculty Course Wise-CS".VALIDATE("Faculty Course Wise-CS"."Faculty Code");
                    "Faculty Course Wise-CS".Modify();
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
        Employee: Record "Employee";
}

