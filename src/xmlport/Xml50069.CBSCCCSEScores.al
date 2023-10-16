xmlport 50069 "CBSC CCSE Scores"
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
            tableelement("CBSE CCSE Scores"; "CBSE CCSE Scores")
            {
                XmlName = 'CBSEUpload';
                textelement(InstitutionID)
                {
                }
                textelement(TestDate)
                {
                }
                textelement(OrderNumber)
                {
                }
                textelement(Exam)
                {
                }
                textelement(ID)
                {
                }
                textelement(Examinee)
                {
                }
                textelement(TotalTest)
                {
                }

                trigger OnBeforeInsertRecord()
                begin

                    If SkipFirstLine then begin
                        SkipFirstLine := False;
                    end Else begin

                        CBSEScoresRec1.Reset();
                        if CBSEScoresRec1.FindLast() then
                            EntryNo := CBSEScoresRec1."Entry No." + 1
                        else
                            EntryNo := 1;

                        if EntryNo <> 0 then begin
                            CBSEScoresRec.Reset();
                            CBSEScoresRec.Init();
                            CBSEScoresRec."Entry No." := EntryNo;
                            if TypeOption = 1 then
                                CBSEScoresRec.Type := CBSEScoresRec.Type::CBSE;
                            if TypeOption = 2 then
                                CBSEScoresRec.Type := CBSEScoresRec.Type::CCSE;


                            If TypeOption = 3 then begin
                                CBSEScoresRec.Type := CBSEScoresRec.Type::CCSSE;
                                SubjectMAster.Reset();
                                SubjectMAster.SetRange("CCSSE Exam Description", Exam);
                                IF SubjectMAster.FindFirst() then begin
                                    CBSEScoresRec."Subject Code" := SubjectMAster.Code;
                                    CBSEScoresRec.Exam := SubjectMAster.Description;
                                end;
                            end;


                            CBSEScoresRec."Institution ID" := InstitutionID;
                            CBSEScoresRec."Order Number" := OrderNumber;
                            //Evaluate(Date1, TestDate);
                            Evaluate(Day, CopyStr(TestDate, 4, 2));
                            Evaluate(Month, CopyStr(TestDate, 1, 2));
                            Evaluate(Year, CopyStr(TestDate, 7, 4));
                            Date3 := DMY2Date(Day, Month, Year);
                            Evaluate(TotalNo, TotalTest);
                            CBSEScoresRec."Test Date" := Date3;
                            
                            CBSEScoresRec.ID := ID;
                            CBSEScoresRec.Examinee := Examinee;
                            CBSEScoresRec."Total Test" := TotalNo;
                            CBSEScoresRec."Published Document No." := DocNo;
                            CBSEScoresRec.Insert();
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
        EntryNo := 0;

    end;

    trigger OnPreXmlPort()
    begin
        SkipFirstLine := True;

    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Scores Upload Sucessfully !');
    end;

    var
        CBSEScoresRec: Record "CBSE CCSE Scores";
        CBSEScoresRec1: Record "CBSE CCSE Scores";
        SubjectMAster: Record "Subject Master-CS";
        EntryNo: Integer;

        Date1: Date;
        Day: Integer;
        Month: Integer;
        Year: Integer;
        Date3: Date;
        TotalNo: Integer;

        TypeOption: Integer;

        DocNo: Code[20];
        SkipFirstLine: Boolean;


    procedure GetType(var CBSECCSEType: Integer)
    begin
        TypeOption := CBSECCSEType;
    end;

    procedure GetPublishingDocNo(var _DocNo: Code[20])
    Begin
        DocNo := _DocNo;
    End;
}

