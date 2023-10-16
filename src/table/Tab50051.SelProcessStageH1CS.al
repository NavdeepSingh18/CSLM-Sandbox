table 50051 "Sel Process Stage H1-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    16-01-2019    OnInsert                Init No series
    // 2         CSPL-00092    16-01-2019    No. - OnValidate        Test No series
    // 3         CSPL-00092    16-01-2019    Assistedit              Select manual no series

    Caption = 'Sel Process Stage H1-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Test No series::CSPL-00092::16-01-2019: End
                IF "No." <> xRec."No." THEN BEGIN
                    AdmissionSetupCS.GET();
                    NoSeriesManagement.TestManual(AdmissionSetupCS."Sel Process Stage1 No.");
                    "No.Series" := '';
                END;
                //Code added for Test No series::CSPL-00092::16-01-2019: End
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
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
        }
        field(12; "Student ID"; code[20])
        {

        }
        field(13; "Student Last Name"; text[100])
        {

        }
        field(14; "Doc. Type"; text[50])
        {

        }
        field(15; Program; code[20])
        {

        }
        field(16; "Posting Date"; date)
        {

        }
        field(17; "Doc. No."; code[20])
        {

        }
        field(18; "Bill Code"; code[20])
        {

        }
        field(19; "Bill Discription"; text[250])
        {

        }

        field(20; "Transaction Description"; text[250])
        {

        }
        field(21; "Fee Group"; code[20])
        {

        }
        field(22; "Running Balance"; Decimal)
        {

        }
        field(23; "Institute Code"; code[20])
        {

        }
        field(24; "Department Code"; code[20])
        {

        }
        field(25; Amount; Decimal)
        {

        }
        field(26; Semester; Code[20])
        {

        }
        field(27; "Student First Name"; text[100])
        {

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
        //Code added for Init No series::CSPL-00092::16-01-2019: Start
        AdmissionSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AdmissionSetupCS.TESTFIELD("Sel Process Stage1 No.");
            NoSeriesManagement.InitSeries(AdmissionSetupCS."Sel Process Stage1 No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "User ID" := FORMAT(UserId());
        //Code added for Init No series::CSPL-00092::16-01-2019: End
    end;

    var
        AdmissionSetupCS: Record "Admission Setup-CS";
        SelProcessStageH1CS: Record "Sel Process Stage H1-CS";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";


    procedure Assistedit(OldSelectionProcessHeader: Record "Sel Process Stage H1-CS"): Boolean
    begin
        //Code added for Select manual no series::CSPL-00092::16-01-2019: Start
        WITH SelProcessStageH1CS DO BEGIN
            SelProcessStageH1CS := Rec;
            AdmissionSetupCS.GET();
            AdmissionSetupCS.TESTFIELD("Sel Process Stage1 No.");
            IF NoSeriesManagement.SelectSeries(AdmissionSetupCS."Sel Process Stage1 No.", OldSelectionProcessHeader."No.Series",
               "No.Series")
            THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := SelProcessStageH1CS;
                EXIT(TRUE);
            END;
        END;
        //Code added for Select manual no series::CSPL-00092::16-01-2019: Start
    end;
}

