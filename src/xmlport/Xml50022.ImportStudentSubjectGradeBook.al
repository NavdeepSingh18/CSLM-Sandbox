xmlport 50022 ImportStudentSubjectGB
{
    Caption = 'Import StudentSubject GradeBook';
    Direction = Import;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(SSGradeBook; "Student Subject GradeBook")
            {
                xmlName = 'StudentSubjectGradeBook';
                textelement(GradeBookNo)
                {
                    MinOccurs = Zero;
                }
                textelement(StudentNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Communicate)
                {
                    MinOccurs = Zero;
                }

                Trigger OnBeforeInsertRecord()
                var
                    SSGradeBook: Record "Student Subject GradeBook";
                Begin
                    IF SkipFirstLine then begin
                        SkipFirstLine := false;
                    end Else begin
                        If (GradeBookNo = '') or (StudentNo = '') then
                            Error('Grade Book No & Student No must not be blank');

                        Communicate := Delchr(Communicate, '=', ',');
                        SSGradeBook.Reset();
                        SSGradeBook.SetRange("Grade Book No.", GradeBookNo);
                        SSGradeBook.SetRange("Student No.", StudentNo);
                        IF SSGradeBook.FindFirst() then begin
                            SSGradeBook.Communications := Communicate;
                            SSGradeBook.Modify();
                        end;
                    end;
                    currXMLport.Skip();
                End;
            }
        }
    }
    Var
        SkipFirstLine: Boolean;

    trigger OnInitXmlPort()
    begin
        SkipFirstLine := true;
    end;

    trigger OnPostXmlPort()
    begin
        Message('Uploaded Successfully');
    end;
}