xmlport 50018 ImportMakeUpStudent

{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    UseRequestPage = false;
    schema
    {
        textelement(NodeName1)
        {
            tableelement(Integer; Integer)
            {
                XmlName = 'ImportMakeUpStudentList';
                textelement(StudentID)
                {

                }

                trigger OnBeforeInsertRecord()
                var
                    StudentMaster_lRec: Record "Student Master-CS";
                    ExternalExamLine: Record "External Exam Line-CS";
                    ExternalExamHdr: Record "External Exam Header-CS";
                    LineNo: Integer;
                    CourseFilter: Text;
                Begin
                    IF SkipFirstLine then begin
                        SkipFirstLine := false;
                    end Else begin
                        CourseFilter := 'AUACOM | AUA-GHT|FIU - AUA CLINICAL|FIUGLOBAL|SEMCOM|SEMCOM2|STDPROG|TRICOM';
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetCurrentKey("Enrollment Order");
                        StudentMaster_lRec.SetRange("Original Student No.", StudentID);
                        StudentMaster_lRec.Setfilter("Course Code", CourseFilter);
                        If StudentMaster_lRec.Findlast() then begin
                            ExternalExamLine.Reset();
                            ExternalExamLine.SetRange("Document No.", DocNo);
                            IF ExternalExamLine.FindLast() then
                                LineNo := ExternalExamLine."Line No." + 10000
                            Else
                                LineNo := 10000;

                            ExternalExamHdr.Reset();
                            ExternalExamHdr.SetRange("No.", DocNo);
                            ExternalExamHdr.FindFirst();

                            ExternalExamLine.Reset();
                            ExternalExamLine.Init();
                            ExternalExamLine."Document No." := DocNo;
                            ExternalExamLine."Line No." := LineNo;
                            ExternalExamLine.Validate("Student No.", StudentMaster_lRec."No.");
                            ExternalExamLine.Term := ExternalExamHdr.Term;
                            ExternalExamLine.Course := ExternalExamHdr."Course Code";
                            ExternalExamLine.Semester := ExternalExamHdr.Semester;
                            ExternalExamLine."Academic year" := ExternalExamHdr."Academic Year";
                            ExternalExamLine.Year := ExternalExamHdr.Year;
                            ExternalExamLine."Global Dimension 1 Code" := ExternalExamHdr."Global Dimension 1 Code";
                            ExternalExamLine."Student Group" := ExternalExamHdr."Student Group";
                            ExternalExamLine."Exam Classification" := ExternalExamHdr."Exam Classification";
                            ExternalExamLine."Exam Date" := ExternalExamHdr."Exam Date";
                            ExternalExamLine."Exam Slot" := ExternalExamHdr."Exam Slot";
                            ExternalExamLine."Exam Schedule No." := ExternalExamHdr."Exam Schedule Code";
                            ExternalExamLine."Exam Type" := ExternalExamHdr."Exam Type";
                            ExternalExamLine."External Maximum" := ExternalExamHdr."External Maximum";
                            ExternalExamLine.Insert(true);
                        end;
                    end;
                    currXMLport.Skip();
                End;
            }
        }
    }

    Var
        SkipFirstLine: Boolean;
        DocNo: Code[20];

    procedure GetHdrDoc(_Doc: Code[20])
    begin
        DocNo := _Doc;
    end;
}