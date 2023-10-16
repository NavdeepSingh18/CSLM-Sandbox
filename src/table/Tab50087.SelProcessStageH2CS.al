table 50087 "Sel Process Stage H2-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    18-01-2019    OnInsert                Init No., Assign User ID and AcadmicYear
    // 2         CSPL-00092    18-01-2019    No. - OnValidate        Test No Series
    // 3         CSPL-00092    18-01-2019    Assistedit              Select manual no series.

    Caption = 'Sel Process Stage H2-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Test No Series::CSPL-00092::18-01-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AdmissionSetupCS.GET();
                    //NoSeriesManagement.TestManual(AdmissionSetupCS."Sel Process Stage2 No.");
                    "No.Series" := '';
                END;
                //Code added for Test No Series::CSPL-00092::18-01-2019: End
            end;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; "Stage2 Selection List No."; Integer)
        {
            Caption = 'Stage2 Selection List No.';
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
            Description = 'CS Field Added 26-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-01-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 26-01-2019';
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
        //Code added for Init No., Assign User ID and AcadmicYear::CSPL-00092::18-01-2019: Start
        AdmissionSetupCS.GET();
        IF "No.Series" = '' THEN
            AdmissionSetupCS.TESTFIELD("Sel Process Stage2 No.");
        //NoSeriesManagement.InitSeries(AdmissionSetupCS."Sel Process Stage2 No.", xRec."No.Series", 0D, "No.", "No.Series");

        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Init No., Assign User ID and AcadmicYear::CSPL-00092::18-01-2019: End
    end;

    var
        AdmissionSetupCS: Record "Admission Setup-CS";
        //NoSeriesManagement: Codeunit "NoSeriesManagement";

        SelProcessStageH2CS: Record "Sel Process Stage H2-CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";

    procedure Assistedit(OldSelectionProcessHeader: Record "Sel Process Stage H2-CS"): Boolean
    begin
        //Code added for Select manual no series::CSPL-00092::18-01-2019: Start
        WITH SelProcessStageH2CS DO BEGIN
            SelProcessStageH2CS := Rec;
            AdmissionSetupCS.GET();
            AdmissionSetupCS.TESTFIELD("Sel Process Stage2 No.");
            //IF NoSeriesManagement.SelectSeries(AdmissionSetupCS."Sel Process Stage2 No.", OldSelectionProcessHeader."No.Series","No.Series") THEN BEGIN
            //NoSeriesManagement.SetSeries("No.");
            Rec := SelProcessStageH2CS;
            EXIT(TRUE);
            //END;
        END;
        //Code added for Select manual no series::CSPL-00092::18-01-2019: End
    end;
}

