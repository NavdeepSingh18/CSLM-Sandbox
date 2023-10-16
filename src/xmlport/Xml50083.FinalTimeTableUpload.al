xmlport 50083 "Final Time Table Upload"
{
    FieldSeparator = ',';
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement("Time Table Buffer"; "Time Table Buffer")
            {
                XmlName = 'TimeTable';
                TextElement(DateofExam)
                {
                    MinOccurs = Zero;


                }
                textelement(TimeSlot)
                {
                    MinOccurs = Zero;
                }

                textelement(RoomNum)
                {
                    MinOccurs = Zero;
                }
                textelement(Batch)
                {
                    MinOccurs = Zero;
                }
                textelement(SectionTxt)
                {
                    MinOccurs = Zero;
                }
                textelement(SubjectGroup)
                {
                    MinOccurs = Zero;
                }
                textelement(SubjectClass)
                {
                    MinOccurs = Zero;
                }
                textelement(SubjectCode)
                {
                    MinOccurs = Zero;
                }

                textelement(FacultyCategory)
                {
                    MinOccurs = Zero;
                }
                textelement(FacultyCode1)
                {
                    MinOccurs = Zero;
                }
                textelement(FacultyCode2)
                {
                    MinOccurs = Zero;
                }
                textelement(FacultyCode3)
                {
                    MinOccurs = Zero;
                }
                TextElement(FacultyCode4)
                {
                    MinOccurs = Zero;
                }



                trigger OnBeforeInsertRecord()
                var
                    TimeTableBufferRec: Record "Time Table Buffer";
                    EntryNo: Integer;
                    ExamDate: Date;
                begin
                    If FirstLine then begin
                        FirstLine := false;
                    end Else Begin
                        TimeTableBufferRec.Reset();
                        IF TimeTableBufferRec.FindLast() then
                            EntryNo := TimeTableBufferRec."S.No." + 1
                        Else
                            EntryNo := 1;
                        ExamDate := 0D;
                        Evaluate(ExamDate, DateofExam);

                        TimeTableBufferRec.Reset();
                        TimeTableBufferRec.Init();
                        TimeTableBufferRec."S.No." := EntryNo;
                        TimeTableBufferRec."Time Table Document No." := DocNo;
                        TimeTableBufferRec.Validate("Course code", CourseCode);
                        TimeTableBufferRec."Academic Code" := AcaYr;
                        TimeTableBufferRec.Semester := Semester;
                        TimeTableBufferRec."Global Dimension 1 Code" := GD1;
                        TimeTableBufferRec.Term := VTerm;
                        TimeTableBufferRec.Year := VYear;
                        TimeTableBufferRec.Validate("Time Slot Code", TimeSlot);
                        TimeTableBufferRec.Date := ExamDate;
                        TimeTableBufferRec."Room No" := RoomNum;
                        TimeTableBufferRec.Batch := Batch;
                        TimeTableBufferRec.Section := SectionTxt;
                        TimeTableBufferRec."Subject Class" := SubjectClass;
                        TimeTableBufferRec."Subject Group" := SubjectGroup;
                        TimeTableBufferRec.Validate("Subject Code", SubjectCode);
                        TimeTableBufferRec."Faculty Category" := FacultyCategory;
                        TimeTableBufferRec.Validate("Faculty 1Code", FacultyCode1);
                        TimeTableBufferRec.Validate("Faculty 2 Code", FacultyCode2);
                        TimeTableBufferRec.Validate("Faculty 3 Code", FacultyCode3);
                        TimeTableBufferRec.Validate("Faculty 4 Code", FacultyCode4);
                        TimeTableBufferRec.Insert(true);
                    End;
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
    trigger OnPreXmlPort()
    begin
        FirstLine := TRUE;
        // TimeTableBufferRec.Reset();
        // IF TimeTableBufferRec.FINDSET() THEN
        //     TimeTableBufferRec.DELETEALL();
    end;

    trigger OnPostXmlPort()
    var
    begin
        MESSAGE('Uploaded Successfully !');
    end;

    procedure GetTimeTableNo(var _DocNo: Code[20]; var _Section: Code[10]; var _CourseCode: Code[20]; _AcaYea: Code[20]; _Semester: Code[10]; _GD1: Code[20]; pTerm: Option "FALL","SRPING","SUMMER"; pYear: Code[10])
    Begin
        DocNo := _DocNo;
        Section := _Section;
        CourseCode := _CourseCode;
        Semester := _Semester;
        AcaYr := _AcaYea;
        GD1 := _GD1;
        VTerm := PTerm;
        VYear := pYear;

    End;

    Procedure GetDate(_Date: Text): Date
    Var
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Day1: Text;
        Month1: Text;
        Year1: Text;
        CreateDate: Date;
    begin
        _Date := Delchr(_Date, '=', '-');


        IF Strlen(_Date) = 6 then begin
            Day1 := CopyStr(_Date, 1, 1);
            _date := Delstr(_Date, 1, 1);
        end;

        IF Strlen(_Date) = 7 then begin
            Day1 := CopyStr(_Date, 1, 1);
            _date := Delstr(_Date, 1, 1);
        end;

        IF Strlen(_Date) = 8 then begin
            Day1 := CopyStr(_Date, 1, 2);
            _date := Delstr(_Date, 1, 2);
        end;

        Month1 := CopyStr(_Date, 1, 2);
        // IF Month1 = 'Jan' then
        //     Month := 1;
        // If Month1 = 'Feb' then
        //     Month := 2;
        // If Month1 = 'Mar' then
        //     Month := 3;
        // If Month1 = 'Apr' then
        //     Month := 4;
        // If Month1 = 'May' then
        //     Month := 5;
        // If Month1 = 'Jun' then
        //     Month := 6;
        // If Month1 = 'Jul' then
        //     Month := 7;
        // IF Month1 = 'Aug' then
        //     Month := 8;
        // If Month1 = 'Sep' then
        //     Month := 9;
        // If Month1 = 'Oct' then
        //     Month := 10;
        // If Month1 = 'Nov' then
        //     Month := 11;
        // If Month1 = 'Dec' then
        //     Month := 12;

        _Date := DelStr(_date, 1, 3);

        IF StrLen(_Date) = 2 then
            Year1 := '20' + _Date;
        If StrLen(_Date) = 4 then
            Year1 := _date;

        Evaluate(Day, Day1);
        //Evaluate(Month, Month1);
        Evaluate(Year, Year1);

        CreateDate := DMY2Date(Day, Month, Year);
        Exit(CreateDate)

    end;

    var
        TimeTableBufferRec: Record "Time Table Buffer";
        DocNo: Code[20];
        Section: Code[10];
        CourseCode: Code[20];
        Semester: Code[10];
        AcaYr: Code[20];
        GD1: Code[20];
        Counter: Integer;
        Window: Dialog;
        CounterTotal: Integer;
        CounterOK: Integer;
        FirstLine: Boolean;
        Text0001Lbl: Label 'Uploading Students  #1########## @2@@@@@@@@@@@@@';
        VTerm: Option "FALL","SPRING","SUMMER";
        VYear: Code[10];

}