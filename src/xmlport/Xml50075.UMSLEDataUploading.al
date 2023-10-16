xmlport 50075 "USMLE Performance Data"
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
            tableelement("USMLE Performance Data"; "USMLE Performance Data")
            {
                XmlName = 'USMLEUpload';

                fieldElement(LastNAme; "USMLE Performance Data"."Last Name")
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignField()
                    begin
                        "USMLE Performance Data"."Published Document No." := DocNo;
                    end;
                }
                Fieldelement(RestofName; "USMLE Performance Data"."Rest of Name")
                {
                    MinOccurs = Zero;
                }
                fieldelement(SG; "USMLE Performance Data"."S/G")
                {
                    MinOccurs = Zero;
                }
                textelement(USMLEID)
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignVariable()
                    Begin
                        //USMLEID := DelStr(USMLEID, 1, 2);
                        "USMLE Performance Data"."USMLE ID" := Delchr(USMLEID, '=', '-');
                    End;
                }
                Fieldelement(UniqueMedSchoolID; "USMLE Performance Data"."Unique Medical School ID")
                {
                    MinOccurs = Zero;
                }
                Fieldelement(StepExam; "USMLE Performance Data"."Step Exam")
                {
                    MinOccurs = Zero;
                }
                TextElement(DateofExam)
                {
                    MinOccurs = Zero;

                    trigger OnAfterAssignVariable()
                    Begin
                        IF DateofExam <> '' then
                            "USMLE Performance Data"."Date of Exam" := GetDate(DateofExam);
                    End;
                }
                fieldelement(PF; "USMLE Performance Data"."P/F")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DigitScore; "USMLE Performance Data"."3 Digit Score")
                {
                    MinOccurs = Zero;
                }
                TextElement(ScoreAvailable)
                {
                    MinOccurs = Zero;
                    trigger OnAfterAssignVariable()
                    Begin
                        IF ScoreAvailable <> '' then
                            "USMLE Performance Data"."Score Available Until" := GetDate(ScoreAvailable);
                    End;
                }
                fieldelement(Remarks; "USMLE Performance Data".Remarks)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInitRecord()
                begin
                    If SkipFirstLine then begin
                        SkipFirstLine := false;
                        currXMLport.skip();
                    end;

                    "USMLE Performance Data"."Published Document No." := DocNo;

                    //"USMLE Performance Data"."Date of Exam" := GetDate(DateofExam);
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
        EntryNo := 0;

    end;

    trigger OnPreXmlPort()
    begin
        SkipFirstLine := True;

    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('USMLE Performance Upload Sucessfully !');
    end;

    var
        USMLEPerformanceData: Record "USMLE Performance Data";
        USMLEPerformanceData1: Record "USMLE Performance Data";
        EntryNo: Integer;
        DocNo: Code[20];
        SkipFirstLine: Boolean;

    procedure GetPublishingDocNo(var _DocNo: Code[20])
    Begin
        DocNo := _DocNo;
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

        IF Strlen(_Date) = 7 then begin
            Day1 := CopyStr(_Date, 1, 2);
            _date := Delstr(_Date, 1, 2);
        end;
        IF Strlen(_Date) = 6 then begin
            Day1 := CopyStr(_Date, 1, 1);
            _date := Delstr(_Date, 1, 1);
        end;

        Month1 := CopyStr(_Date, 1, 3);
        IF Month1 = 'Jan' then
            Month := 1;
        If Month1 = 'Feb' then
            Month := 2;
        If Month1 = 'Mar' then
            Month := 3;
        If Month1 = 'Apr' then
            Month := 4;
        If Month1 = 'May' then
            Month := 5;
        If Month1 = 'Jun' then
            Month := 6;
        If Month1 = 'Jul' then
            Month := 7;
        IF Month1 = 'Aug' then
            Month := 8;
        If Month1 = 'Sep' then
            Month := 9;
        If Month1 = 'Oct' then
            Month := 10;
        If Month1 = 'Nov' then
            Month := 11;
        If Month1 = 'Dec' then
            Month := 12;

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
}

