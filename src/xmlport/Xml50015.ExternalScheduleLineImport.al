xmlport 50015 ExternalSchedLineImport
{
    FieldSeparator = ',';
    Format = VariableText;
    Direction = Import;
    UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement("Exam Time Table Line-CS"; "Exam Time Table Line-CS")
            {
                //AutoUpdate = true;
                XmlName = 'Student';

                Textelement(DocumentNo) { }
                textelement(LineNo) { }
                textelement(SubjectCode) { }
                textelement(StudentGroup) { }
                textelement(ExamDate) { }
                textelement(ExamSlot) { }

                trigger OnBeforeInsertRecord()
                var
                    ExamSchdLn: Record "Exam Time Table Line-CS";
                    LineNoInt: Integer;
                begin
                    if FirstRecSkip then
                        FirstRecSkip := false
                    else begin
                        Evaluate(LineNoInt, LineNo);
                        ExamSchdLn.Reset();
                        ExamSchdLn.SetRange("Document No.", DocumentNo);
                        ExamSchdLn.SetRange("Line No.", LineNoInt);
                        IF ExamSchdLn.FindFirst() then begin
                            if ExamSchdLn."Exam No." <> '' then
                                Error('Schedule No. %1 Line No. %2 cannot be imported as Exam Line has already been created.', ExamSchdLn."Document No.", ExamSchdLn."Line No.");
                            ExamSchdLn.validate("Student Group", StudentGroup);
                            Evaluate(ExamSchdLn."Exam Date", ExamDate);
                            ExamSchdLn.Validate("Exam Date");
                            Evaluate(ExamSchdLn."Exam Slot New", ExamSlot);
                            ExamSchdLn.Validate("Exam Slot New");
                            ExamSchdLn.Modify();
                        end;
                    end;
                    currXMLport.Skip();
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
        MESSAGE('Done !');
    end;

    trigger OnPreXmlPort()
    begin
        FirstRecSkip := true;
    end;

    var
        FirstRecSkip: Boolean;
}

