table 50275 "Sel Proces Stage Headr1-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   29/07/2019       OnInsert()                             Auto assign User ID & Insert Current Academic year & USER ID.
    // 02    CSPL-00114   29/07/2019       No. - OnValidate()                     Code added for Get No Series.

    Caption = 'Sel Proces Stage Headr1-CS';


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Get No Series::CSPL-00114::29072019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AdmissionSetupCS.GET();
                    NoSeriesMgt.TestManual(AdmissionSetupCS."Sel Process Stage1 No.");
                    "No.Series" := '';
                END;
                //Code added for Get No Series::CSPL-00114::29072019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; "Stage1 Selection List No."; Integer)
        {
            Caption = 'Stage1 Selection List No.';
            DataClassification = CustomerContent;
        }
        field(4; "Number of Students"; Integer)
        {
            Caption = 'Number of Students';
            DataClassification = CustomerContent;
        }
        field(5; "Application Receive Till Date"; Date)
        {
            Caption = 'Application Receive Till Date';
            DataClassification = CustomerContent;
        }
        field(6; "Excempt Rules - Reserve Quota"; Boolean)
        {
            Caption = 'Excempt Rules - Reserve Quota';
            DataClassification = CustomerContent;
        }
        field(7; "Excempt Rules - Staff Child"; Boolean)
        {
            Caption = 'Excempt Rules - Staff Child';
            DataClassification = CustomerContent;
        }
        field(8; "Consider Break Students"; Boolean)
        {
            Caption = 'Consider Break Students';
            DataClassification = CustomerContent;
        }
        field(9; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(10; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(11; "Processed Date"; Date)
        {
            Caption = 'Processed Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27062019';
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
    begin
        //Auto assign User ID & Insert Current Academic year & USER ID::CSPL-00114::29072019: Start
        AdmissionSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AdmissionSetupCS.TESTFIELD("Sel Process Stage1 No.");
            NoSeriesMgt.InitSeries(AdmissionSetupCS."Sel Process Stage1 No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Auto assign User ID & Insert Current Academic year & USER ID::CSPL-00114::29072019: End
    end;

    var
        AdmissionSetupCS: Record "Admission Setup-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
}