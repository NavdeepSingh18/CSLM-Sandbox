table 50238 "Time Table Template Head-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   10/07/2019       OnInsert()                                 Get "No Series" Value
    // 02    CSPL-00114   10/07/2019       OnModify()                                 Data Modification Flag
    // 03    CSPL-00114   10/07/2019       No. - OnValidate()                         Code added for Get "No Series" Value
    // 04    CSPL-00114   10/07/2019       Template Name - OnValidate()               Code added for Data Validation
    // 05    CSPL-00114   10/07/2019       Global Dimension 1 Code - OnValidate()     Code added for Data Validation
    // 06    CSPL-00114   10/07/2019       Global Dimension 2 Code - OnValidate()     Code added for Data Validation
    // 06    CSPL-00114   10/07/2019       AssistEdit()                               Code added for No Series Generation

    DrillDownPageID = "Time Templt Name-CS";
    LookupPageID = "Time Templt Name-CS";
    DataClassification = CustomerContent;
    DataCaptionFields = "Template Name";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get "No Series" Value::CSPL-00114::10072019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AdmissionSetupCS.GET();
                    NoSeriesMgt.TestManual(AdmissionSetupCS."Time Slot No.");
                END;
                //Code added for Get "No Series" Value::CSPL-00114::10072019: End
            end;
        }
        field(2; "Template Name"; Text[100])
        {
            TableRelation = "Time Table Tamplate-CS" where("Global Dimension 1 Code" = Field("Global Dimension 1 Code"));
            Caption = 'Template Name';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Data Validation::CSPL-00114::10072019: Start
                If "Template Name" <> '' then begin
                    IF Rec."Template Name" <> xRec."Template Name" THEN begin
                        // IF not CONFIRM(Text_10001Lbl, FALSE) THEN
                        //     exit;
                        TimeTableTemplateLineCS.Reset();
                        TimeTableTemplateLineCS.SETRANGE("Document No.", "No.");
                        IF TimeTableTemplateLineCS.FINDSET() THEN
                            TimeTableTemplateLineCS.MODIFYALL("Template Name", "Template Name");
                    end;
                end Else begin
                    TimeTableTemplateLineCS.Reset();
                    TimeTableTemplateLineCS.SETRANGE("Document No.", "No.");
                    IF TimeTableTemplateLineCS.FINDSET() THEN
                        TimeTableTemplateLineCS.MODIFYALL("Template Name", '');
                end;

                // ELSE
                //     ERROR('You cannot modify the data');

                //Code added for Data Validation::CSPL-00114::10072019: End
            end;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Data Validation::CSPL-00114::10072019: Start
                If "Global Dimension 1 Code" <> '' then begin
                    IF Rec."Global Dimension 1 Code" <> xRec."Global Dimension 1 Code" THEN begin
                        // IF not CONFIRM(Text_10002Lbl, FALSE) THEn
                        //     exit;

                        TimeTableTemplateLineCS.Reset();
                        TimeTableTemplateLineCS.SETRANGE("Document No.", "No.");
                        IF TimeTableTemplateLineCS.FINDSET() THEN
                            TimeTableTemplateLineCS.MODIFYALL("Global Dimension 1 Code", "Global Dimension 1 Code")

                    END;
                end Else begin
                    TimeTableTemplateLineCS.Reset();
                    TimeTableTemplateLineCS.SETRANGE("Document No.", "No.");
                    IF TimeTableTemplateLineCS.FINDSET() THEN
                        TimeTableTemplateLineCS.MODIFYALL("Global Dimension 1 Code", '')
                end;
                //Code added for Data Validation::CSPL-00114::10072019: End
            end;
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Data Validation::CSPL-00114::10072019: Start
                If "Global Dimension 2 Code" <> '' then begin
                    IF Rec."Global Dimension 2 Code" <> xRec."Global Dimension 2 Code" THEN BEGIN
                        // IF not CONFIRM(Text_10003Lbl, FALSE) THEN
                        //     exit;

                        TimeTableTemplateLineCS.Reset();
                        TimeTableTemplateLineCS.SETRANGE("Document No.", "No.");
                        IF TimeTableTemplateLineCS.FINDSET() THEN
                            TimeTableTemplateLineCS.MODIFYALL("Global Dimension 2 Code", "Global Dimension 2 Code");

                    END;
                end Else Begin
                    TimeTableTemplateLineCS.Reset();
                    TimeTableTemplateLineCS.SETRANGE("Document No.", "No.");
                    IF TimeTableTemplateLineCS.FINDSET() THEN
                        TimeTableTemplateLineCS.MODIFYALL("Global Dimension 2 Code", '')
                End;
                //Code added for Data Validation::CSPL-00114::10072019: End
            end;
        }
        field(5; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(6; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50001; "Created By"; Code[30])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(50002; "Created On"; Date)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(50003; "Modified By"; Code[30])
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Modified By';
            DataClassification = CustomerContent;
        }
        field(50004; "Modified On"; Date)
        {
            Description = 'CS Field Added 10072019';
            Caption = 'Modified On';
            DataClassification = CustomerContent;
        }
        Field(50005; "With Topic Code"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Template Name", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for Get "No Series" Value::CSPL-00114::10072019: Start
        AdmissionSetupCS.GET();
        IF "No. Series" = '' THEN BEGIN
            AdmissionSetupCS.TESTFIELD(AdmissionSetupCS."Time Slot No.");
            NoSeriesMgt.InitSeries(AdmissionSetupCS."Time Slot No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        //Code added for Get "No Series" Value::CSPL-00114::10072019: End
    end;

    trigger OnModify()
    begin
        //Code added for Data Modification Flag::CSPL-00114::10072019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Data Modification Flag::CSPL-00114::10072019: End
    end;

    var
        AdmissionSetupCS: Record "Admission Setup-CS";
        TimeTableTemplateHeadCS: Record "Time Table Template Head-CS";
        TimeTableTemplateLineCS: Record "Time Table Template Line-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text_10001Lbl: Label 'Are you Sure Do You Want to Change Template Name ?';
        Text_10002Lbl: Label 'Are you Sure Do You Want to Change Institute Code ?';
        Text_10003Lbl: Label 'Are you Sure Do You Want to Change Department Code ?';

    procedure AssistEdit(OldFee: Record "Time Table Template Head-CS"): Boolean
    begin
        //Code added for No Series Generation::CSPL-00114::10072019: Start
        WITH TimeTableTemplateHeadCS DO BEGIN
            TimeTableTemplateHeadCS := Rec;
            AdmissionSetupCS.GET();
            AdmissionSetupCS.TESTFIELD(AdmissionSetupCS."Time Slot No.");
            IF NoSeriesMgt.SelectSeries(AdmissionSetupCS."Time Slot No.", OldFee."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := TimeTableTemplateHeadCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No Series Generation::CSPL-00114::10072019: End
    end;
}