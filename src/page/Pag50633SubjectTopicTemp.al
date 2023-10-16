page 50633 "Subject Topics List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Class Time Table Line-CS";
    SourceTableTemporary = true;
    Caption = 'Subject Topics List';
    SourceTableView = sorting("Subject code") ORDER(Ascending);
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Topics Selected"; Rec."Topics Selected")
                {
                    ApplicationArea = All;
                    Caption = 'Topic Selected';
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Caption = 'Topic Code';
                }
                field("Subject Name"; Rec."Subject Name")
                {
                    ApplicationArea = All;
                    Caption = 'Topic Description';
                }

            }
        }
    }
    procedure SubjectTopicsInsert(DocumentNo: Code[20]; LineNo: Integer)

    var
        SubjectMasterRec: Record "Subject Master-CS";
        TimeTableLineRec: Record "Class Time Table Line-CS";
        SubjectTopicsListTemp: Record "Class Time Table Line-CS" temporary;
        TimeTableLineRec1: Record "Class Time Table Line-CS";
        TimeTableLineRec2: Record "Class Time Table Line-CS";
        TempLineNo: Integer;

    begin
        if TimeTableLineRec.Get(DocumentNo, LineNo) then;

        TimeTableLineRec1.Reset();
        TimeTableLineRec1.SetRange("Document No.", TimeTableLineRec."Document No.");
        TimeTableLineRec1.Setrange("Parent Line No.", TimeTableLineRec."Line No.");
        if TimeTableLineRec1.findset() then
            repeat
                TempLineNo := 0;
                SubjectTopicsListTemp.RESET();
                SubjectTopicsListTemp.SETRANGE("Document No.", DocumentNo);
                IF SubjectTopicsListTemp.FINDLAST() THEN
                    TempLineNo := SubjectTopicsListTemp."Line No." + 10
                ELSE
                    TempLineNo := 10;

                SubjectTopicsListTemp.Reset();
                SubjectTopicsListTemp.INIT();
                SubjectTopicsListTemp."Document No." := DocumentNo;
                SubjectTopicsListTemp."Line No." := TempLineNo;
                SubjectTopicsListTemp."Subject Code" := TimeTableLineRec1."Subject Code";
                SubjectTopicsListTemp."Subject Name" := TimeTableLineRec1."Subject Name";
                SubjectTopicsListTemp.Insert();

                Rec.INIT();
                Rec."Document No." := SubjectTopicsListTemp."Document No.";
                Rec."Line No." := SubjectTopicsListTemp."Line No.";
                Rec."Subject Code" := TimeTableLineRec1."Subject Code";
                Rec."Subject Name" := TimeTableLineRec1."Subject Name";
                Rec.Validate("Topics Selected", true);
                Rec.Insert();
            until TimeTableLineRec1.Next() = 0;

        SubjectMasterRec.Reset();
        SubjectMasterRec.Setrange("Subject Group", TimeTableLineRec."Subject Code");
        if SubjectMasterRec.findset() then
            repeat
                TimeTableLineRec2.Reset();
                TimeTableLineRec2.SetRange("Document No.", DocumentNo);
                TimeTableLineRec2.SetRange("Parent Line No.", LineNo);
                TimeTableLineRec2.SetRange("Subject Code", SubjectMasterRec.Code);
                if not TimeTableLineRec2.FindFirst() then begin
                    TempLineNo := 0;
                    SubjectTopicsListTemp.RESET();
                    SubjectTopicsListTemp.SETRANGE("Document No.", DocumentNo);
                    IF SubjectTopicsListTemp.FINDLAST() THEN
                        TempLineNo := SubjectTopicsListTemp."Line No." + 10
                    ELSE
                        TempLineNo := 10;

                    SubjectTopicsListTemp.Reset();
                    SubjectTopicsListTemp.INIT();
                    SubjectTopicsListTemp."Document No." := DocumentNo;
                    SubjectTopicsListTemp."Line No." := TempLineNo;
                    SubjectTopicsListTemp."Subject Code" := SubjectMasterRec.Code;
                    SubjectTopicsListTemp."Subject Name" := SubjectMasterRec.Description;
                    SubjectTopicsListTemp."Subject Topics" := SubjectTopicsListTemp."Subject Topics"::Topics;
                    SubjectTopicsListTemp.Insert();


                    Rec.INIT();
                    Rec."Document No." := SubjectTopicsListTemp."Document No.";
                    Rec."Line No." := SubjectTopicsListTemp."Line No.";
                    Rec."Subject Code" := SubjectMasterRec.Code;
                    Rec."Subject Name" := SubjectMasterRec.Description;
                    Rec."Subject Topics" := Rec."Subject Topics"::Topics;
                    Rec."Parent Line No." := LineNo;
                    Rec.Insert();
                end;
            until SubjectMasterRec.Next() = 0;
    end;

    procedure VariablePassing(DocumentNo: Code[20]; LineNo: Integer);
    begin
        DocumentNoGbl := DocumentNo;
        LineNoGbl := LineNo;
    end;

    trigger OnOpenPage()
    begin
        SubjectTopicsInsert(DocumentNoGbl, LineNoGbl);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        TimeTableInsert(DocumentNoGbl, LineNoGbl);
    end;

    procedure TimeTableInsert(DocumentNo: Code[20]; LineNo: Integer)
    var
        //TimeTableLineRec: Record "Class Time Table Line-CS";
        TimeTableLineRec1: Record "Class Time Table Line-CS";
        TimeTableLineRec2: Record "Class Time Table Line-CS";
        TempLineNo: Integer;
    begin
        TimeTableLineRec1.Reset();
        TimeTableLineRec1.SetRange("Document No.", DocumentNo);
        TimeTableLineRec1.Setrange("Parent Line No.", LineNo);
        if TimeTableLineRec1.findset() then
            TimeTableLineRec1.DeleteAll();

        Rec.Setrange("Topics Selected", True);
        if Rec.FindSet() then
            repeat
                TempLineNo := 0;
                TimeTableLineRec2.RESET();
                TimeTableLineRec2.SETRANGE("Document No.", Rec."Document No.");
                IF TimeTableLineRec2.FINDLAST() THEN
                    TempLineNo := TimeTableLineRec2."Line No." + 10
                ELSE
                    TempLineNo := 10;

                TimeTableLineRec2.RESET();
                TimeTableLineRec2.SETRANGE("Document No.", Rec."Document No.");
                TimeTableLineRec2.SetRange("Line No.", LineNo);
                IF TimeTableLineRec2.FindFirst() THEN;

                TimeTableLineRec1.Reset();
                TimeTableLineRec1.Init();
                TimeTableLineRec1."Document No." := DocumentNo;
                TimeTableLineRec1.Validate(TimeTableLineRec1."Time Slot", TimeTableLineRec2."Time Slot");
                TimeTableLineRec1.Day := TimeTableLineRec2.Day;
                TimeTableLineRec1.Section := TimeTableLineRec2.Section;
                TimeTableLineRec1.Day := TimeTableLineRec2.Day;
                TimeTableLineRec1."Line No." := TempLineNo;
                TimeTableLineRec1."Subject Group" := TimeTableLineRec2."Subject Group";
                TimeTableLineRec1."Subject Class" := TimeTableLineRec2."Subject Class";
                TimeTableLineRec1."Subject Topics" := TimeTableLineRec1."Subject Topics"::Topics;
                TimeTableLineRec1."Subject Code" := Rec."Subject Code";
                TimeTableLineRec1."Subject Name" := Rec."Subject Name";
                TimeTableLineRec1."Parent Line No." := LineNo;
                TimeTableLineRec1.Insert();
            Until Rec.Next() = 0;
    end;

    var
        DocumentNoGbl: Code[20];
        LineNoGbl: Integer;
}