table 50105 "Participant Line-CS"
{
    // version V.001-CS

    // 
    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   28/08/2019       Student No. - OnValidate()                  Code added for Page look up the students based on age validate Check
    // 02    CSPL-00114   28/08/2019       Student No. - OnLookup()                    Code added for Page look up the students based on age validate Check
    // 03    CSPL-00114   28/08/2019       Participant Type - OnValidate()             Code added for validating Particioant type

    Caption = 'Participant Line-CS';
    //DrillDownPageID = 33049339;
    //LookupPageID = 33049339;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";

            trigger OnLookup()
            begin
                //Code added for Page look up the students based on age validate Check::CSPL-00114::29082019: Start
                EducationSetupCS.GET();
                EducationSetupCS.TESTFIELD("Academic Year");
                StudentMasterNewCS.CLEARMARKS();
                IF ParticipantHeaderCS.GET("Document No.") THEN BEGIN
                    CompetitionLCS.Reset();
                    CompetitionLCS.SETRANGE("Document No.", ParticipantHeaderCS."Competition Entry No.");
                    CompetitionLCS.SETRANGE("Student Division", ParticipantHeaderCS."Student Division");
                    IF CompetitionLCS.FINDFIRST() THEN BEGIN
                        CompetitionLCS.TESTFIELD("Min Age");
                        CompetitionLCS.TESTFIELD("Max Age");
                        CompetitionLCS.TESTFIELD("Cut Off Date");
                        StudentMasterNewCS.CLEARMARKS();
                        StudentMasterNewCS.Reset();
                        StudentMasterNewCS.SETRANGE("Student Status", StudentMasterNewCS."Student Status"::Student);
                        IF ParticipantHeaderCS.House <> '' THEN
                            StudentMasterNewCS.SETRANGE(House, ParticipantHeaderCS.House);
                        StudentMasterNewCS.SETRANGE("Academic Year", EducationSetupCS."Academic Year");
                        IF StudentMasterNewCS.FINDSET() THEN
                            REPEAT
                                VarLocalAge := 0;
                                VarTempAge := 0;
                                VarMonths1 := 0;
                                IF StudentMasterNewCS."Date Of Birth" <> 0D THEN BEGIN
                                    VarLocalAge := CompetitionLCS."Cut Off Date" - StudentMasterNewCS."Date Of Birth";
                                    VarTempAge := ROUND(VarLocalAge / 365, 1, '<');
                                    VarAge2 := VarLocalAge MOD 365;
                                    VarMonths1 := ROUND(VarAge2 / 30, 1, '=');
                                    VarLocalAge := VarTempAge;
                                END;
                                IF (VarLocalAge >= CompetitionLCS."Min Age") AND (VarLocalAge <= CompetitionLCS."Max Age") THEN
                                    IF (VarLocalAge = CompetitionLCS."Max Age") AND (VarMonths1 < 0) THEN
                                        StudentMasterNewCS.MARK(TRUE)
                                    ELSE
                                        IF VarLocalAge < CompetitionLCS."Max Age" THEN
                                            StudentMasterNewCS.MARK(TRUE);

                            UNTIL StudentMasterNewCS.NEXT() = 0;

                        StudentMasterNewCS.MARKEDONLY(TRUE);
                        IF PAGE.RUNMODAL(0, StudentMasterNewCS) = ACTION::LookupOK THEN BEGIN
                            "Student No." := StudentMasterNewCS."No.";
                            "Student Name" := StudentMasterNewCS.Name;
                            StudentMasterNewCS.TESTFIELD(House);
                            House := StudentMasterNewCS.House;
                            VALIDATE("Student No.");
                        END;
                    END;
                END;
                //Code added for Page look up the students based on age validate Check::CSPL-00114::29082019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Page look up the students based on age validate Check::CSPL-00114::29082019: Start
                IF ParticipantHeaderCS.GET("Document No.") THEN BEGIN
                    IF ParticipantHeaderCS."Update Entry" THEN
                        ERROR(Text001Lbl);
                    ParticipantHeaderCS.TESTFIELD("Competition Entry No.");
                    ParticipantHeaderCS.TESTFIELD("Student Division");
                    IF ParticipantHeaderCS."Event Type" <> ParticipantHeaderCS."Event Type"::Team THEN BEGIN
                        ParticipantLineCS.Reset();
                        ParticipantLineCS.SETRANGE("Document No.", "Document No.");
                        IF ParticipantLineCS.FINDFIRST() THEN
                            ERROR(Text000Lbl);
                    END;

                    CompetitionLCS.Reset();
                    CompetitionLCS.SETRANGE("Document No.", ParticipantHeaderCS."Competition Entry No.");
                    CompetitionLCS.SETRANGE("Student Division", ParticipantHeaderCS."Student Division");
                    IF CompetitionLCS.FINDFIRST() THEN BEGIN
                        CompetitionLCS.TESTFIELD("Min Age");
                        CompetitionLCS.TESTFIELD("Max Age");
                        CompetitionLCS.TESTFIELD("Cut Off Date");
                        StudentMasterNewCS.Reset();
                        IF StudentMasterNewCS.GET("Student No.") THEN
                            IF StudentMasterNewCS."Date Of Birth" <> 0D THEN BEGIN
                                VarLocalAge1 := CompetitionLCS."Cut Off Date" - StudentMasterNewCS."Date Of Birth";
                                VarTempAge1 := ROUND(VarLocalAge1 / 365, 1, '<');
                                VarAge3 := VarLocalAge1 MOD 365;
                                VarMonths2 := ROUND(VarAge3 / 30, 1, '=');
                                Age := VarTempAge1;
                                Months := VarMonths2;
                                StudentMasterNewCS.TESTFIELD(House);
                            END ELSE BEGIN
                                Age := 0;
                                Months := 0;
                            END;

                    END;
                END;
                //Code added for Page look up the students based on age validate Check::CSPL-00114::29082019: End
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(5; Age; Decimal)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 0;
        }
        field(6; House; Code[20])
        {
            Caption = 'House';
            DataClassification = CustomerContent;
        }
        field(7; "Participant Type"; Option)
        {
            Caption = 'Participant Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Main,Substitute';
            OptionMembers = " ",Main,Substitute;

            trigger OnValidate()
            begin
                //Code added for validating Particioant type::CSPL-00114::29082019: Start
                ParticipantHeaderCS.GET("Document No.");
                IF ParticipantHeaderCS."Update Entry" THEN
                    ERROR(Text001Lbl);

                IF ParticipantHeaderCS."Event Type" <> ParticipantHeaderCS."Event Type"::Team THEN
                    ERROR(Text002Lbl);
                IF ParticipantHeaderCS."Event Type" = ParticipantHeaderCS."Event Type"::Team THEN
                    IF CompetitionLCS.GET(ParticipantHeaderCS."Competition Entry No.", ParticipantHeaderCS."Student Division") THEN BEGIN
                        CompetitionLCS.TESTFIELD("Team Size");
                        ParticipantLineCS.Reset();
                        ParticipantLineCS.SETRANGE("Document No.", "Document No.");
                        IF "Participant Type" = "Participant Type"::Main THEN BEGIN
                            ParticipantLineCS.SETRANGE("Participant Type", ParticipantLineCS."Participant Type"::Main);
                            IF CompetitionLCS."Team Size" <= ParticipantLineCS.COUNT() THEN
                                ERROR(Text003Lbl, CompetitionLCS."Team Size")
                        END ELSE
                            IF "Participant Type" = "Participant Type"::Substitute THEN
                                ParticipantLineCS.SETRANGE("Participant Type", ParticipantLineCS."Participant Type"::Substitute);
                        IF CompetitionLCS.Substitute <= ParticipantLineCS.COUNT() THEN
                            ERROR(Text004Lbl, CompetitionLCS.Substitute);

                    END;

                //Code added for validating Particioant type::CSPL-00114::29082019: End
            end;
        }
        field(8; "Competition Type"; Code[20])
        {
            Caption = 'Competition Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Competition Name"; Text[50])
        {
            Caption = 'Competition Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Student Division"; Code[20])
        {
            Caption = 'Student Division';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Position; Option)
        {
            Caption = 'Position';
            DataClassification = CustomerContent;
            OptionCaption = ' ,1st Place,2nd Place,3rd Place,4th place,Participation';
            OptionMembers = ,"1st Place","2nd Place","3rd Place","4th place",Participation;
        }
        field(12; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(14; "Competition Entry No."; Code[20])
        {
            Caption = 'Competition Entry No.';
            DataClassification = CustomerContent;
        }
        field(15; Months; Decimal)
        {
            Caption = 'Months';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 0;
        }
        field(17; "Event Type"; Option)
        {
            Caption = 'Event Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Individual,Team';
            OptionMembers = " ",Individual,Team;
        }
        field(18; "Team No."; Code[20])
        {
            Caption = 'Team No.';
            DataClassification = CustomerContent;
        }

        field(19; "Update Results"; Boolean)
        {
            Caption = 'Update Results';
            DataClassification = CustomerContent;
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
        key(Key1; "Document No.", "Student No.")
        {
        }
        key(Key2; House, "Academic Year", "Update Results")
        {
            SumIndexFields = Points;
        }
        key(Key3; "Competition Entry No.", "Student Division", "Student No.")
        {
        }
        key(Key4; "Competition Entry No.", "Student Division", "Team No.")
        {
        }
        key(Key5; "Student No.", Points)
        {
        }
        key(Key6; "Team No.")
        {
            SumIndexFields = Points;
        }
    }

    fieldgroups
    {
    }

    var
        EducationSetupCS: Record "Education Setup-CS";
        ParticipantHeaderCS: Record "Participant Header-CS";
        StudentMasterNewCS: Record "Student Master New-CS";
        ParticipantLineCS: Record "Participant Line-CS";
        CompetitionLCS: Record "Competition L-CS";
        VarLocalAge: Decimal;
        VarTempAge: Decimal;
        VarLocalAge1: Decimal;
        VarTempAge1: Decimal;
        VarAge2: Decimal;
        VarMonths1: Decimal;
        VarAge3: Decimal;
        VarMonths2: Decimal;
        Text000Lbl: Label 'You can enter only one student for an individual.';
        Text001Lbl: Label 'You cannot modify the enttry, entry is updated.';
        Text002Lbl: Label 'Only for the Team Event, participant type is  required.';
        Text003Lbl: Label 'Only %1 students can be added in main list';
        Text004Lbl: Label 'Only %1 students can be added in substitute list.';
}

