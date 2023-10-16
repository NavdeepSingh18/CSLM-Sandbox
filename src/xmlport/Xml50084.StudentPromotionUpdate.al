xmlport 50084 "Student Promotion Update"
{
    Direction = Import;
    FieldSeparator = ',';
    Format = VariableText;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'StudentPromotionUpdate';
                textelement(EnrollmentNo)
                {

                }
                textelement(Semester_)
                { }

                trigger OnBeforeInsertRecord()
                var
                    StudentMaster_lRec: Record "Student Master-CS";
                Begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end ELSE begin
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("Enrollment No.", EnrollmentNo);
                        If StudentMaster_lRec.FindFirst() then begin
                            IF Semester_ <> StudentMaster_lRec.Semester then
                                Error('Semester does not match for the Student : %1.', StudentMaster_lRec."Enrollment No.");
                            If Semester_ = StudentMaster_lRec.Semester then begin
                                StudentMaster_lRec."Promotion Suggested" := true;
                                StudentMaster_lRec.Modify();
                            end;


                        end;

                    end;



                    currXMLport.Skip();
                End;
            }
        }
    }
    Var
        SkipFirstLine: Boolean;


}