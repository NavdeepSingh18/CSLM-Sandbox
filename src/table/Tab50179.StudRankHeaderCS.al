table 50179 "Stud. Rank Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   26/05/2019       OnInsert()                                 Get "No Series","User Id" Values
    // 02    CSPL-00114   26/05/2019       OnDelete()                                 Code added for Lines Deleted
    // 03    CSPL-00114   26/05/2019       No. - OnValidate()                         Code added for No Series Related
    // 04    CSPL-00114   26/05/2019       Scholarship Code - OnValidate()            Code added for Scholarship Name & Fee Classification value
    // 05    CSPL-00114   26/05/2019       Source Code - OnValidate()                 Code added for Source name from Scholar Source
    // 06    CSPL-00114   26/05/2019       AssistEdit()- Function                     Code added for No Series generation

    Caption = 'Stud. Rank Header-CS';
    DrillDownPageID = 50304;
    LookupPageID = 50304;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            Editable = true;

            trigger OnValidate()
            begin
                //Code added for No series related::CSPL-00114::26052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    FeeSetupCS.GET();
                    NoSeriesMgt.TestManual(FeeSetupCS."Rank Detail No.");
                    Course := '';
                END;
                //Code added for No series related::CSPL-00114::26052019: End
            end;
        }
        field(2; "Scholarship Code"; Code[10])
        {
            Caption = 'Scholarship Code';
            DataClassification = CustomerContent;
            TableRelation = "Category Master-CS";

            trigger OnValidate()
            begin
                //Code added for Scholarship Name & Fee Classification value::CSPL-00114::26052019: Start
                CategoryMasterCS.Reset();
                CategoryMasterCS.SETRANGE(Code, "Scholarship Code");
                IF CategoryMasterCS.FINDFIRST() THEN BEGIN
                    "Scholarship Name" := CategoryMasterCS.Description;
                    "Fee Classification Code" := CategoryMasterCS."Fee Classification";
                END;
                //Code added for Scholarship Name & Fee Classification value::CSPL-00114::26052019: End
            end;
        }
        field(3; "Scholarship Name"; Text[50])
        {
            Caption = 'Scholarship Name';
            DataClassification = CustomerContent;
        }
        field(4; "Source Code"; Code[10])
        {
            Caption = 'Source Code';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS";

            trigger OnValidate()
            begin
                //Code added for Source name from Scholar Source::CSPL-00114::26052019: Start
                IF SourceScholarshipCS.GET("Source Code") THEN
                    "Source Name" := SourceScholarshipCS.Description;
                //Code added for Source name from Scholar Source::CSPL-00114::26052019: End
            end;
        }
        field(5; "Source Name"; Text[50])
        {
            Caption = 'Source Name';
            DataClassification = CustomerContent;
        }
        field(6; "Fee Classification Code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            DataClassification = CustomerContent;
        }
        field(7; "Admitted Year"; Code[10])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(9; Course; Code[10])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
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

    trigger OnDelete()
    begin
        //Code added for Lines Deleted::CSPL-00114::26052019: Start
        StudRankLineCS.Reset();
        StudRankLineCS.SETRANGE("Document No.", "No.");
        IF StudRankLineCS.FINDSET() THEN
            StudRankLineCS.DELETEALL();
        //Code added for Lines Deleted::CSPL-00114::26052019: End
    end;

    trigger OnInsert()
    begin
        //Code added for Get "No Series","User Id" Values ::CSPL-00114::26052019: Start
        FeeSetupCS.GET();
        IF "No. Series" = '' THEN BEGIN
            FeeSetupCS.TESTFIELD(FeeSetupCS."Rank Detail No.");
            NoSeriesMgt.InitSeries(FeeSetupCS."Rank Detail No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "User ID" := FORMAT(UserId());
        //Code added for Get "No Series","User Id" Values ::CSPL-00114::26052019: End
    end;

    var
        CategoryMasterCS: Record "Category Master-CS";
        FeeSetupCS: Record "Fee Setup-CS";

        StudRankHeaderCS: Record "Stud. Rank Header-CS";
        SourceScholarshipCS: Record "Source Scholarship-CS";
        StudRankLineCS: Record "Stud. Rank Line-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";

    local procedure AssistEdit(OldStudRankHeaderCS: Record "Stud. Rank Header-CS"): Boolean
    begin
        //Code added for No Series generation::CSPL-00114::26052019: Start
        WITH StudRankHeaderCS DO BEGIN
            StudRankHeaderCS := Rec;
            FeeSetupCS.GET();
            FeeSetupCS.TESTFIELD(FeeSetupCS."Rank Detail No.");
            IF NoSeriesMgt.SelectSeries(FeeSetupCS."Rank Detail No.", OldStudRankHeaderCS."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := StudRankHeaderCS;
                EXIT(TRUE);
            END;
        END;
    end;
    //Code added for No Series generation::CSPL-00114::26052019: End
}

