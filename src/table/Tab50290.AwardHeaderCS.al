table 50290 "Award Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/05/2019       OnInsert()                                 Get "No Series","Academic Year" Values
    // 02    CSPL-00114   07/05/2019       OnDelete()                                 Code added for Lines Deleted
    // 03    CSPL-00114   07/05/2019       No. - OnValidate()                         Code added for Status Related
    // 04    CSPL-00114   07/05/2019       Assistedit -Function                       Code added for Assist edit Field for No Series

    Caption = 'Award Header-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for "No Series" Blank::CSPL-00114::07052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AcademicsSetupCS.GET();
                    NoSeriesMgt.TestManual(AcademicsSetupCS."Award List No.");
                    "No.Series" := '';
                END;
                //Code added for "No Series" Blank::CSPL-00114::07052019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Get "No Series","Academic Year" Values ::CSPL-00114::07052019: Start
        AcademicsSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Award List No.");
            NoSeriesMgt.InitSeries(AcademicsSetupCS."Award List No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Get "No Series","Academic Year" Values ::CSPL-00114::07052019: End
    end;

    var
        AcademicsSetupCS: Record "Academics Setup-CS";
        AwardHeaderCS: Record "Award Header-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";


    procedure Assistedit(OldAwardHeaderCS: Record "Award Header-CS"): Boolean
    begin
        //Code added for Assist edit Field for No Series::CSPL-00114::07052019: Start
        WITH AwardHeaderCS DO BEGIN
            AwardHeaderCS := Rec;
            AcademicsSetupCS.GET();
            AcademicsSetupCS.TESTFIELD(AcademicsSetupCS."Award List No.");
            IF NoSeriesMgt.SelectSeries(AcademicsSetupCS."Award List No.", OldAwardHeaderCS."No.Series", "No.Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := AwardHeaderCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Assist edit Field for No Series::CSPL-00114::07052019: End
    end;
}

