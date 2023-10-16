table 50104 "Participant Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/08/2019       OnInsert()                                 Get "No Series","Academic Year",Date & "User Id" Values
    // 03    CSPL-00114   29/08/2019       No. - OnValidate()                         Generation No. Series
    // 04    CSPL-00114   29/08/2019       Competition Entry No. - OnValidate()       Code added for Competition Header Related Value
    // 05    CSPL-00114   29/08/2019       Student Division - OnValidate()            Code added for Competition line Related Value:
    // 06    CSPL-00114   29/08/2019       House - OnValidate()                       Code added for Participant Header Related Value
    // 05    CSPL-00114   29/08/2019       Team No. - OnValidate()                    Code added for Participant Header Related Validation
    // 06    CSPL-00114   29/08/2019       Assistedit() Function                      Function called for generating No. Series

    Caption = 'Participant Header-CS';
    // DrillDownPageID = 33049334;
    // LookupPageID = 33049334;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Generation No. Series::CSPL-00114::29082019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    SetupCoCurricularCS.GET();
                    SetupCoCurricularCS.TESTFIELD("Participant Entry No.");
                    //NoSeriesMgt.TestManual(SetupCoCurricularCS."Participant Entry No.");
                    "No.Series" := '';
                END;
                //Code added for Generation No. Series::CSPL-00114::29082019: End
            end;
        }
        field(2; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "Competition H-CS" WHERE("Academic Year" = FIELD("Academic Year"),
                                                      "Competition Status" = FILTER(<> Completed));

            trigger OnValidate()
            begin
                //Code added for Competition Header Related Value::CSPL-00114::29082019: Start
                IF "Update Entry" THEN
                    ERROR(Text000Lbl);

                IF CompetitionHCS.GET("Competition Entry No.") THEN BEGIN
                    "Competition Name" := CompetitionHCS."Competition Name";
                    "Competition Type" := CompetitionHCS."Competition Type";
                    "Event Type" := CompetitionHCS."Event Type";
                    "Team No." := '';
                    "Student Division" := '';
                    "Competition Date" := CompetitionHCS."Competition Date";
                    "Competition Status" := CompetitionHCS."Competition Status";
                END ELSE BEGIN
                    "Competition Name" := '';
                    "Competition Type" := '';
                    "Event Type" := 0;
                    "Team No." := '';
                    "Student Division" := '';
                END;
                //Code added for Competition Header Related Value::CSPL-00114::29082019: End
            end;
        }
        field(3; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            DataClassification = CustomerContent;
            TableRelation = "Competition L-CS"."Student Division" WHERE("Document No." = FIELD("Competition Entry No."));

            trigger OnValidate()
            begin
                //Code added for Competition line Related Value::CSPL-00114::29082019: Start
                IF "Update Entry" THEN
                    ERROR(Text000Lbl);

                TESTFIELD("Competition Entry No.");
                IF CompetitionLCS.GET("Competition Entry No.", "Student Division") THEN BEGIN
                    "Team Size" := CompetitionLCS."Team Size";
                    Substitute := CompetitionLCS.Substitute;
                END ELSE BEGIN
                    "Team Size" := 0;
                    Substitute := 0;
                END;
                //Code added for Competition line Related Value::CSPL-00114::29082019: End
            end;
        }
        field(5; House; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'House';

            trigger OnValidate()
            begin
                //Code added for Participant Header Related Value::CSPL-00114::29082019: Start
                IF "Update Entry" THEN
                    ERROR(Text000Lbl);
                ParticipantHeaderCS.Reset();
                ParticipantHeaderCS.SETRANGE("Competition Entry No.", "Competition Entry No.");
                ParticipantHeaderCS.SETRANGE("Student Division", "Student Division");
                ParticipantHeaderCS.SETRANGE(House, House);
                IF ParticipantHeaderCS.FINDFIRST() THEN
                    ERROR(Text001Lbl);
                //Code added for Participant Header Related Value::CSPL-00114::29082019: End
            end;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Update Entry"; Boolean)
        {
            Caption = 'Update Entry';
            DataClassification = CustomerContent;
        }
        field(10; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
            DataClassification = CustomerContent;
        }
        field(11; "Event Type"; Option)
        {
            Caption = 'Event Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(12; "Team No."; Code[20])
        {
            Caption = 'Team No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Participant Header Related Validation::CSPL-00114::29082019: Start
                IF "Event Type" <> "Event Type"::Team THEN
                    ERROR(Text002Lbl);
                ParticipantHeaderCS1.Reset();
                ParticipantHeaderCS1.SETRANGE("Team No.", "Team No.");
                IF ParticipantHeaderCS1.FINDFIRST() THEN
                    ERROR(Text003Lbl);
                //Code added for Participant Header Related Validation::CSPL-00114::29082019: End
            end;
        }
        field(13; "Team Size"; Integer)
        {
            Caption = 'Team Size';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; Substitute; Integer)
        {
            Caption = 'Substitute';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Competition Date"; Date)
        {
            Caption = 'Competition Date';
            DataClassification = CustomerContent;
        }
        field(16; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29082019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 29082019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Competition Entry No.", "Student Division")
        {
        }
        key(Key3; "Competition Entry No.", "Student Division", House)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series","Academic Year","User Id" Values::CSPL-00114::29082019: Start
        SetupCoCurricularCS.GET();
        IF "No.Series" = '' THEN
            SetupCoCurricularCS.TESTFIELD("Participant Entry No.");
        //NoSeriesMgt.InitSeries(SetupCoCurricularCS."Participant Entry No.", xRec."No.Series", 0D, "No.", "No.Series");

        "User ID" := FORMAT(UserId());
        EducationSetupCS.GET();
        EducationSetupCS.TESTFIELD("Academic Year");
        "Academic Year" := EducationSetupCS."Academic Year";
        //Get "No Series","Academic Year","User Id" Values::CSPL-00114::29082019: End
    end;

    var
        EducationSetupCS: Record "Education Setup-CS";
        SetupCoCurricularCS: Record "Setup Co-Curricular -CS";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        ParticipantHeaderCS: Record "Participant Header-CS";
        CompetitionHCS: Record "Competition H-CS";
        CompetitionLCS: Record "Competition L-CS";
        ParticipantHeaderCS1: Record "Participant Header-CS";
        Text000Lbl: Label 'You cannot modify the entry, entry is updated.';
        Text001Lbl: Label 'House has already been selected before.';
        Text002Lbl: Label 'Only for the team event type, team no. is required.';
        Text003Lbl: Label 'Team no. should be unique.';

    procedure Assistedit(OldParticipant: Record "Participant Header-CS"): Boolean
    begin
        //Function called for generating No. Series::CSPL-00114::29082019: Start
        WITH ParticipantHeaderCS DO BEGIN
            ParticipantHeaderCS := Rec;
            SetupCoCurricularCS.GET();
            SetupCoCurricularCS.TESTFIELD(SetupCoCurricularCS."Participant Entry No.");
            //IF NoSeriesMgt.SelectSeries(SetupCoCurricularCS."Participant Entry No.", OldParticipant."No.Series", "No.Series") THEN BEGIN
            //NoSeriesMgt.SetSeries("No.");
            Rec := ParticipantHeaderCS;
            EXIT(TRUE);
            //END;
        END;
        //Function called for generating No. Series::CSPL-00114::29082019: End
    end;
}

