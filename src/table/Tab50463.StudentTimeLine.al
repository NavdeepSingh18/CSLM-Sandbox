table 50463 "Student Time Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Student Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Activity performed"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Created on"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Hidden Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure InsertRecordFun(StudNOPara: Code[20]; StudNamePara: Text[80]; ActivityPerformedPara: Text;
    CreatedByPara: Code[50]; CreatedOnPara: Date)
    var
        StudTimeLine: Record "Student Time Line";
        StudTimeLine2: Record "Student Time Line";
    begin
        // Rec.Init();
        // Rec.Validate("Student No.", StudNOPara);
        // Rec.Validate("Student Name", StudNamePara);
        // Rec.Validate("Activity performed", ActivityPerformedPara);
        // Rec.Validate("Created By", CreatedByPara);
        // Rec.Validate("Created on", CreatedOnPara);
        // Rec.Insert();
        StudTimeLine2.Reset();
        if StudTimeLine2.FindLast() then;

        StudTimeLine.Init();
        StudTimeLine."Entry No." := StudTimeLine2."Entry No." + 1;
        StudTimeLine.Validate("Student No.", StudNOPara);
        StudTimeLine.Validate("Student Name", StudNamePara);
        StudTimeLine.Validate("Activity performed", ActivityPerformedPara);
        StudTimeLine.Validate("Created By", CreatedByPara);
        StudTimeLine.Validate("Created on", CreatedOnPara);
        StudTimeLine.Insert();
    end;

    procedure InsertRecordFunFromOut(StudNOPara: Code[20]; StudNamePara: Text[80]; ActivityPerformedPara: Text[100];
    CreatedByPara: Code[50]; CreatedOnPara: Date)
    var
        StudTimeLine: Record "Student Time Line";
        StudTimeLine2: Record "Student Time Line";
    begin
        StudTimeLine2.Reset();
        if StudTimeLine2.FindLast() then;

        StudTimeLine.Init();
        StudTimeLine."Entry No." := StudTimeLine2."Entry No." + 1;
        StudTimeLine.Validate("Student No.", StudNOPara);
        StudTimeLine.Validate("Student Name", StudNamePara);
        StudTimeLine.Validate("Activity performed", ActivityPerformedPara);
        StudTimeLine.Validate("Created By", CreatedByPara);
        StudTimeLine.Validate("Created on", CreatedOnPara);
        StudTimeLine.Insert();
    end;

    procedure InsertHiddenRecordFun(StudNOPara: Code[20]; StudNamePara: Text[80]; ActivityPerformedPara: Text[100];
    CreatedByPara: Code[50]; CreatedOnPara: Date)
    var
        StudTimeLine: Record "Student Time Line";
        StudTimeLine2: Record "Student Time Line";
    begin
        StudTimeLine2.Reset();
        if StudTimeLine2.FindLast() then;

        StudTimeLine.Init();
        StudTimeLine."Entry No." := StudTimeLine2."Entry No." + 1;
        StudTimeLine.Validate("Student No.", StudNOPara);
        StudTimeLine.Validate("Student Name", StudNamePara);
        StudTimeLine.Validate("Activity performed", ActivityPerformedPara);
        StudTimeLine.Validate("Created By", CreatedByPara);
        StudTimeLine.Validate("Created on", CreatedOnPara);
        StudTimeLine."Hidden Entry" := true;
        StudTimeLine.Insert();
    end;

}