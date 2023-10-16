report 50202 "AICASA AS Nursing Degree"
{
    Caption = 'AICASA Associate of Science in Nursing Degree';
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportrdlc/AICASA_ASNDegree.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Student Degree"; "Student Degree")
        {
            DataItemTableView = sorting("Student No.");
            column(Student_No_; "Student No.")
            { }
            column(Student_Name; StudentMasterCS."Student Name")
            { }
            column(DateInWord; DateInWord)
            { }
            column(Degree_Name; "Degree Name")
            { }

            trigger OnPreDataItem()
            begin
                //SetRange("Global Dimension 1 Code", InstituteCode);

                IF StudentNo1 <> '' then
                    SetFilter("Student No.", StudentNo1);
                IF DegreeCode1 <> '' then
                    SetFilter("Degree Code", DegreeCode1);

            end;

            trigger OnAfterGetRecord()
            begin
                StudentMasterCS.GET("Student No.");
                StudentDegree.Reset();
                StudentDegree.SetRange("Student No.", StudentNo1);
                StudentDegree.SetRange("Degree Code", DegreeCode1);
                IF StudentDegree.FindFirst() then begin
                    IF StudentDegree."Degree Code" <> 'NUR' then
                        Error('Degree not found for Student No.:%1', StudentNo1);

                    IF InstituteCode <> StudentDegree."Global Dimension 1 Code" then
                        Error('Institute Code must be %1 for Student No. %2', InstituteCode, StudentNo1);
                end;
                if DateAwarded = 0D then
                    Error('Date Awarded not found')
                else
                    DateAwarded1 := DateAwarded;

                Day1 := DATE2DMY(DateAwarded1, 1);
                Year1 := DATE2DMY(DateAwarded1, 3);

                Days();
                Years();

                IF Year1 > 2030 then
                    Year1 := 2030;

                DateInWord := 'this' + ' ' + OnesText[Day1] + ' ' + 'day of' + ' ' + FORMAT(DateAwarded1, 0, '<Month Text>') + ' ' + YearText[Year1];

                IF "Printed Date" = 0D then begin
                    "Printed Date" := Today();
                    "Printed By" := UserID();
                    Modify();
                end else begin
                    "Last Printed Date" := Today();
                    "Last Printed By" := UserID();
                    Modify();
                end;
            end;


        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field("Institute Code"; InstituteCode)
                    {
                        ApplicationArea = All;
                        Editable = False;
                        Caption = 'Institude Code';
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                    }
                    field("Student No."; StudentNo1)
                    {
                        ApplicationArea = All;
                        Caption = 'Student No.';
                        TableRelation = "Student Master-CS"."No.";

                    }
                    field("Degree Code"; DegreeCode1)
                    {
                        ApplicationArea = All;
                        Caption = 'Degree Code';
                        TableRelation = "Final Degree-CS".Code;

                    }
                }

            }
        }

    }

    trigger OnInitReport()
    Begin
        InstituteCode := '9100';
    End;

    trigger OnPreReport()
    begin
        IF StudentNo1 = '' then
            Error('Student No. must have a value');
        IF DegreeCode1 = '' then
            Error('Degree Code must have a value');
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        StudentDegree: Record "Student Degree";
        StudentNo1: Code[20];
        DegreeCode1: Code[20];
        InstituteCode: Code[20];
        OnesText: array[50] of Text[90];
        YearText: array[2500] of Text[90];
        DateAwarded1: Date;
        Day1: Integer;
        Year1: integer;

        DateInWord: Text;

    procedure Days()
    begin
        OnesText[1] := 'first';
        OnesText[2] := 'second';
        OnesText[3] := 'third';
        OnesText[4] := 'fourth';
        OnesText[5] := 'fifth';
        OnesText[6] := 'sixth';
        OnesText[7] := 'seventh';
        OnesText[8] := 'eighth';
        OnesText[9] := 'ninth';
        OnesText[10] := 'tenth';
        OnesText[11] := 'eleventh';
        OnesText[12] := 'twelfth';
        OnesText[13] := 'thirteenth';
        OnesText[14] := 'fourteenth';
        OnesText[15] := 'fifteenth';
        OnesText[16] := 'sixteenth';
        OnesText[17] := 'seventeenth';
        OnesText[18] := 'eighteenth';
        OnesText[19] := 'nineteenth';
        OnesText[20] := 'twentieth';
        OnesText[21] := 'twenty-first';
        OnesText[22] := 'twenty-second';
        OnesText[23] := 'twenty-third';
        OnesText[24] := 'twenty-fourth';
        OnesText[25] := 'twenty-fifth';
        OnesText[26] := 'twenty-sixth';
        OnesText[27] := 'twenty-seventh';
        OnesText[28] := 'twenty-eighth';
        OnesText[29] := 'twenty-ninth';
        OnesText[30] := 'thirtieth';
        OnesText[31] := 'thirty-first';
    end;

    procedure Years()
    begin
        YearText[2001] := 'two thousand and one';
        YearText[2002] := 'two thousand and two';
        YearText[2003] := 'two thousand and three';
        YearText[2004] := 'two thousand and four';
        YearText[2005] := 'two thousand and five';
        YearText[2006] := 'two thousand and six';
        YearText[2007] := 'two thousand and seven';
        YearText[2008] := 'two thousand and eight';
        YearText[2009] := 'two thousand and nine';
        YearText[2010] := 'two thousand and ten';
        YearText[2011] := 'two thousand and eleven';
        YearText[2012] := 'two thousand and twelve';
        YearText[2013] := 'two thousand and thirteen';
        YearText[2014] := 'two thousand and fourteen';
        YearText[2015] := 'two thousand and fifteen';
        YearText[2016] := 'two thousand and sixteen';
        YearText[2017] := 'two thousand and seventeen';
        YearText[2018] := 'two thousand and eighteen';
        YearText[2019] := 'two thousand and nineteen';
        YearText[2020] := 'two thousand and twenty';
        YearText[2021] := 'two thousand and twenty one';
        YearText[2022] := 'two thousand and twenty two';
        YearText[2023] := 'two thousand and twenty three';
        YearText[2024] := 'two thousand and twenty four';
        YearText[2025] := 'two thousand and twenty five';
        YearText[2026] := 'two thousand and twenty six';
        YearText[2027] := 'two thousand and twenty seven';
        YearText[2028] := 'two thousand and twenty eight';
        YearText[2029] := 'two thousand and twenty nine';
        YearText[2030] := 'two thousand and thirty';
    end;

    procedure StudentDegreevariable(StudNo: Code[20]; DegCode: Code[20])
    begin
        StudentNo1 := StudNo;
        DegreeCode1 := DegCode;
    end;
}