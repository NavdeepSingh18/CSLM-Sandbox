xmlport 50078 "Upload Time Table Line"
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ',';
    FieldDelimiter = '"';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Class Time Table Line-CS"; "Class Time Table Line-CS")
            {
                XmlName = 'TimeTableLine';
                textelement(TimeSlot)
                {
                }
                textelement(Day)
                {
                }
                textelement(Interval)
                {
                }
                textelement(IntervalType)
                {
                }
                textelement(SubjectGroup)
                {
                }
                textelement(SubjectClass)
                {
                }
                textelement(SubjectCode)
                {
                }
                textelement(Batch)
                {
                }
                textelement(FacultyCode1)
                {
                }
                textelement(FacultyCode2)
                {
                }
                textelement(FacultyCode3)
                {
                }
                textelement(FacultyCode4)
                {
                }
                trigger OnBeforeInsertRecord()
                begin
                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end Else begin
                        ClassTimeTableLineRec1.Reset();
                        ClassTimeTableLineRec1.SetRange(ClassTimeTableLineRec1."Document No.", DocNo);
                        if ClassTimeTableLineRec1.FindLast() then
                            LineNo := ClassTimeTableLineRec1."Line No." + 10000
                        else
                            LineNo := 10000;

                        if LineNo <> 0 then begin
                            ClassTimeTableLineRec.Reset();
                            ClassTimeTableLineRec.Init();
                            ClassTimeTableLineRec."Document No." := DocNo;
                            ClassTimeTableLineRec."Line No." := LineNo;
                            ClassTimeTableLineRec.Section := Section;
                            ClassTimeTableLineRec.Validate(ClassTimeTableLineRec."Time Slot", TimeSlot);
                            if Day <> '' then
                                Evaluate(ClassTimeTableLineRec.Day, Day);
                            if Interval <> '' then
                                Evaluate(ClassTimeTableLineRec.Interval, Interval);
                            ClassTimeTableLineRec."Interval Type" := IntervalType;
                            ClassTimeTableLineRec."Subject Group" := SubjectGroup;
                            ClassTimeTableLineRec.Validate(ClassTimeTableLineRec."Subject Class", SubjectClass);
                            ClassTimeTableLineRec."Subject Code" := SubjectCode;
                            ClassTimeTableLineRec.Batch := Batch;
                            ClassTimeTableLineRec.validate(ClassTimeTableLineRec."Faculty 1 Code", FacultyCode1);
                            ClassTimeTableLineRec.validate(ClassTimeTableLineRec."Faculty 2 Code", FacultyCode2);
                            ClassTimeTableLineRec.validate(ClassTimeTableLineRec."Faculty 3 Code", FacultyCode3);
                            ClassTimeTableLineRec.validate(ClassTimeTableLineRec."Faculty 4 Code", FacultyCode4);
                            ClassTimeTableLineRec.Insert();
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


    }
    trigger OnInitXmlPort()
    begin
        LineNo := 0;

    end;

    trigger OnPreXmlPort()
    begin
        SkipFirstLine := True;

    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Uploaded Sucessfully !');
    end;

    var
        ClassTimeTableLineRec: Record "Class Time Table Line-CS";
        ClassTimeTableLineRec1: Record "Class Time Table Line-CS";
        LineNo: Integer;
        DocNo: Code[20];
        Section: Code[10];
        CourseCode: Code[20];
        SkipFirstLine: Boolean;


    procedure GetTimeTableNo(var _DocNo: Code[20]; var _Section: Code[10]; var _CourseCode: Code[20])
    Begin
        DocNo := _DocNo;
        Section := _Section;
        CourseCode := _CourseCode;
    End;
}

