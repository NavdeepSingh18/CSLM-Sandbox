xmlport 50076 "Export Grades"
{
    Direction = Export;
    Format = VariableText;
    // FieldSeparator = ',';
    // FieldDelimiter = '"';


    schema
    {
        textelement(RootNodeName)
        {
            tableelement(MainStudentSubjectCS; "Main Student Subject-CS")

            {
                RequestFilterFields = "Enrollment No", Course, Semester, "Academic Year", "Subject Code", "Start Date";
                // UseTemporary = true;
                Fieldelement(OriginalStudentNo; MainStudentSubjectCS."Original Student No.")
                { }
                fieldelement(StudentNo; MainStudentSubjectCS."Student No.")
                {

                }
                FieldElement(StudentName; MainStudentSubjectCS."Student Name")
                { }
                fieldelement(Course; MainStudentSubjectCS.Course)
                {

                }
                fieldelement(Semester; MainStudentSubjectCS.Semester)
                {

                }
                fieldelement(AcademicYear; MainStudentSubjectCS."Academic Year")
                {

                }
                fieldelement(SubjectCode; MainStudentSubjectCS."Subject Code")
                {

                }

                fieldelement(StartDate; MainStudentSubjectCS."Start Date")
                {

                }
                fieldelement(Grade; MainStudentSubjectCS.Grade)
                {

                }

                fieldelement(ExternalMarks; MainStudentSubjectCS."External Mark")
                { }
                fieldelement(ExternalMax; MainStudentSubjectCS."External Maximum")
                { }
                fieldelement(ExternalPer; MainStudentSubjectCS."Percentage Obtained")
                { }
                /*
                trigger OnAfterInitRecord()
                begin

                    SkipRecord += 1;
                    IF SkipRecord = 1 then begin
                        currXMLport.skip();
                    end;
                end;

                trigger OnBeforeInsertRecord()
                var
                    MainStudentSubject: Record "Main Student Subject-CS";
                begin
                    MainStudentSubject.reset();
                    MainStudentSubject.SetCurrentKey("Student No.", Course, Semester, "Academic Year", "Subject Code", Section, "Start Date");
                    MainStudentSubject.setrange("Student No.", MainStudentSubjectCS."Student No.");
                    MainStudentSubject.setrange(Course, MainStudentSubjectCS.Course);
                    MainStudentSubject.setrange(Semester, MainStudentSubjectCS.Semester);
                    MainStudentSubject.setrange("Academic Year", MainStudentSubjectCS."Academic Year");
                    MainStudentSubject.setrange("Subject Code", MainStudentSubjectCS."Subject Code");
                    //MainStudentSubject.setrange(Section, MainStudentSubjectCS.Section);
                    MainStudentSubject.setrange("Start Date", MainStudentSubjectCS."Start date");
                    if MainStudentSubject.FindFirst() then begin
                        MainStudentSubject.Grade := MainStudentSubjectCS.Grade;
                        //code
                        MainStudentSubject.Modify();
                    end;
                end;
                */
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    trigger OnInitXmlPort()
    begin

    end;

    trigger OnPreXmlPort()
    begin
        SkipRecord := 0;
    end;

    trigger OnPostXmlPort()
    begin
        Message(Text001);
    end;

    Var
        SkipRecord: Integer;
        Text001: Label 'Successfully Completed.';
        StartDateN: text;
}
