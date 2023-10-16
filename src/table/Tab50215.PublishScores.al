table 50215 "Publish Scores"
{
    Caption = 'Publish Scores';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Document No." <> xRec."Document No." THEN BEGIN
                    AcademicSetupRec.Get();
                    NoSeriesMgt.TestManual(AcademicSetupRec."Publish Score Document No.");
                    "No.Series" := '';
                END;
            end;
        }
        field(2; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(3; "Score Type"; Option)
        {
            Caption = 'Score Type';
            OptionMembers = " ",CBSE,CCSE,CCSSE,USMLE;
            OptionCaption = ' ,CBSE,CCSE,CCSSE,USMLE';
        }
        field(4; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code where(Code = field("Core Subject Groups"));
            trigger OnValidate()
            begin
                SubjectMasterRec.Reset();
                SubjectMasterRec.SetRange(Code, "Subject Code");
                if SubjectMasterRec.FindFirst() then
                    "Subject Description" := SubjectMasterRec.Description
                else
                    "Subject Description" := '';
            end;
        }
        field(5; "Subject Description"; Text[100])
        {
            Caption = 'Subject Description';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(6; Status; Option)
        {
            Caption = 'Status';
            Editable = false;
            OptionCaption = 'Pending,Published';
            OptionMembers = Pending,Published;
        }
        field(7; Updated; Boolean)
        {
            Caption = 'Updated';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(8; Inserted; Boolean)
        {
            Caption = 'Inserted';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Created By"; Code[50])
        {
            Caption = 'Created By';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(10; "Created On"; Date)
        {
            Caption = 'Created On';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(11; "No.Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(60000; "Core Subject Groups"; Code[1024])
        {
            Editable = false;
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(PK; "Document No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        AcademicSetupRec.Get();
        IF "Document No." = '' THEN BEGIN
            AcademicSetupRec.TESTFIELD("Publish Score Document No.");
            NoSeriesMgt.InitSeries(AcademicSetupRec."Publish Score Document No.", xRec."No.Series", 0D, "Document No.", "No.Series");
        end;

        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
        "Document Date" := WORKDATE();
    end;

    trigger OnModify()
    begin

    end;

    // Trigger OnDelete()
    // var
    //     USMLEPerformanceRec: Record "USMLE Performance Data";
    //     CBSECCSERec: Record "CBSE CCSE Scores";
    // Begin
    //     IF "Score Type" <> "Score Type"::" " then begin
    //         IF "Score Type" <> "Score Type"::" " then begin
    //             USMLEPerformanceRec.Reset();
    //             USMLEPerformanceRec.SetRange("Published Document No.", Rec."Document No.");
    //             if USMLEPerformanceRec.FindFirst() then
    //                 if Not (USMLEPerformanceRec."Result Matched") or (USMLEPerformanceRec.Duplicate) then
    //                     USMLEPerformanceRec.DeleteAll()
    //                 else
    //                     Error('You can not delete the record as the record are already Matched.');

    //             CBSECCSERec.Reset();
    //             CBSECCSERec.SetRange("Published Document No.", Rec."Document No.");
    //             if CBSECCSERec.FindFirst() then
    //                 if Not (CBSECCSERec."Result Matched") or (CBSECCSERec.Duplicate) then
    //                     CBSECCSERec.DeleteAll()
    //                 else
    //                     Error('You can not delete the record as the record are already Matched.');
    //         end;
    //     end;
    // End;

    procedure Assistedit(OldPublishScores: Record "Publish Scores"): Boolean
    begin
        WITH PublishScoresRec DO BEGIN
            PublishScoresRec := Rec;
            AcademicSetupRec.Get();
            AcademicSetupRec.TESTFIELD("Publish Score Document No.");
            IF NoSeriesMgt.SelectSeries(AcademicSetupRec."Publish Score Document No.", OldPublishScores."No.Series", "No.Series")
            THEN BEGIN
                NoSeriesMgt.SetSeries("Document No.");
                Rec := PublishScoresRec;
                EXIT(TRUE);
            END;
        END;

    End;

    var
        PublishScoresRec: Record "Publish Scores";
        AcademicSetupRec: Record "Academics Setup-CS";
        SubjectMasterRec: Record "Subject Master-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
