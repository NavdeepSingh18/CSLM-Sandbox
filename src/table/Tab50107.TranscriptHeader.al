table 50107 "Competition H-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/06/2019       OnInsert()                                 Get "No Series","Academic Year",Date & "User Id" Values
    // 02    CSPL-00114   19/06/2019       No. - OnValidate()                         Get "No Series" Values
    // 03    CSPL-00114   19/06/2019       Competition Status - OnValidate()          Code added Competition Status Modified
    // 04    CSPL-00114   19/06/2019       Assistedit- Function                       Code added No series Generation

    Caption = 'Transcript Header';
    //DrillDownPageID = 33049330;
    //LookupPageID = 33049330;
    //CSPL-00307-Transcript
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';//In-Use
            DataClassification = CustomerContent;
            trigger OnValidate()

            var
                myInt: Integer;
                CompetitionHCS: Record "Competition H-CS";
                NoSeriesMgt: Codeunit NoSeriesManagement;

            begin


                if "No." <> xRec."No." then begin//GAURAV//15//02//23
                    //EducationSetupCS.Get('AUA2021');
                    EducationSetupCS.Reset();
                    EducationSetupCS.SetRange("Global Dimension 1 Code", '9000');
                    EducationSetupCS.FindFirst();
                    NoSeriesMgt.TestManual(EducationSetupCS."Trans No.");
                    NoSeriesMgt.SetSeries("No.");

                end;
                // end;

                //Get "No Series" Values::CSPL-00114::19062019: Start
                // IF "No." <> xRec."No." THEN BEGIN
                //     SetupCoCurricularCS.GET();
                //     SetupCoCurricularCS.TESTFIELD("Competition Entry No.");
                //     //NoSeriesMgt.TestManual(SetupCoCurricularCS."Competition Entry No.");
                //     "No.Series" := '';
                // END;
                //Get "No Series" Values::CSPL-00114::19062019: End
            end;
        }
        field(2; "Competition Name"; Text[50])
        {
            Caption = 'User ID';//In-Use
            DataClassification = CustomerContent;
        }
        field(3; "Competition Type"; Code[50])
        {
            Caption = 'Last Print By';//In-Use
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
            // TableRelation = State;
        }

        field(6; "Event Type"; Option)
        {
            Caption = 'Event Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(7; "Competition Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(8; "Competition Status"; Option)
        {
            Caption = 'Competition Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Up Coming,On Going,Completed';
            OptionMembers = " ","Up Coming","On Going",Completed;

            trigger OnValidate()
            begin
                //Code added Competition Status Modified::CSPL-00114::19062019: Start
                IF xRec."Competition Status" = xRec."Competition Status"::Completed THEN
                    ERROR(Text000Lbl);
                CompetitionLCS.Reset();
                CompetitionLCS.SETRANGE("Document No.", "No.");
                IF CompetitionLCS.FINDSET() THEN
                    REPEAT
                        ParticipantHeaderCS.Reset();
                        ParticipantHeaderCS.SETCURRENTKEY("Competition Entry No.", "Student Division");
                        ParticipantHeaderCS.SETRANGE("Competition Entry No.", "No.");
                        ParticipantHeaderCS.SETRANGE("Student Division", CompetitionLCS."Student Division");
                        ParticipantHeaderCS.MODIFYALL("Competition Status", "Competition Status");
                    UNTIL CompetitionLCS.NEXT() = 0;
                //Code added Competition Status Modified::CSPL-00114::19062019: End
            end;
        }
        field(9; "Last Print Date"; Date) //In-Use
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Print Type"; Option)
        {
            OptionCaption = ' ,Official Transcript,UnOfficial Transcript';
            OptionMembers = " ","Official Transcript","UnOfficial Transcript";
        }

        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 19062019';
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
    }

    trigger OnInsert()
    var
        Educationsetup: Record "Education Setup-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        //Get "No Series","Academic Year" & "User Id" Values ::CSPL-00114::19062019: Start
        // SetupCoCurricularCS.GET();
        // IF "No.Series" = '' THEN
        // SetupCoCurricularCS.TESTFIELD("Competition Entry No.");
        //NoSeriesMgt.InitSeries(SetupCoCurricularCS."Competition Entry No.", xRec."No.Series", 0D, "No.", "No.Series");
        if Rec."No." = '' then begin//GAURAV//15//02//23
            Educationsetup.Reset();
            Educationsetup.SetRange("Global Dimension 1 Code", '9000');
            Educationsetup.FindFirst();
            Educationsetup.testfield("Trans No.");
            NoSeriesMgt.InitSeries(Educationsetup."Trans No.", xRec."No.Series", 0D, "No.", "No.Series");

            // "Last Print Date" := today;

        end;
        "Competition Name" := UserId;//GAURAV//16//02//23
        "Competition Date" := today;
    end;

    // "Competition Name" := FORMAT(UserId());
    // EducationSetupCS.GET();
    // EducationSetupCS.TESTFIELD("Academic Year");
    // "Academic Year" := EducationSetupCS."Academic Year";
    //Get "No Series","Academic Year" & "User Id" Values ::CSPL-00114::19062019: End


    var
        EducationSetupCS: Record "Education Setup-CS";
        SetupCoCurricularCS: Record "Setup Co-Curricular -CS";
        //NoSeriesMgt: Codeunit NoSeriesManagement;
        RecCompetitionHCS: Record "Competition H-CS";
        CompetitionLCS: Record "Competition L-CS";
        ParticipantHeaderCS: Record "Participant Header-CS";
        Text000Lbl: Label 'Once Completed it cannot be change';

    trigger OnDelete()
    var
        TranscriptLine: Record "Competition L-CS";
    Begin
        TranscriptLine.Reset();
        TranscriptLine.SetRange("Document No.", Rec."No.");
        TranscriptLine.DeleteAll();
    End;


    procedure Assistedit(OldRecCompetitionHCS: Record "Competition H-CS"): Boolean
    Var
        RecCompetitionHCS: Record "Competition H-CS";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        WITH RecCompetitionHCS DO BEGIN
            RecCompetitionHCS := Rec;
            EducationSetupCS.Reset();
            EducationSetupCS.setfilter("Trans No.", '<>%1', '');
            IF EducationSetupCS.Findfirst then
                IF NoSeriesMgt.SelectSeries(EducationSetupCS."Trans No.", OldRecCompetitionHCS."No.Series", "No.Series")
                THEN BEGIN
                    NoSeriesMgt.SetSeries("No.");
                    Rec := RecCompetitionHCS;
                    EXIT(TRUE);
                END;
        END;

    End;


}

