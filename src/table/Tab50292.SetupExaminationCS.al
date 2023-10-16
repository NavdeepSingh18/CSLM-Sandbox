table 50292 "Setup Examination -CS"
{
    // version V.001-CS


    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(10; "Internal Exam Attd. Nos."; Code[20])
        {
            Caption = 'Internal Exam Attd. Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(11; "External Exam Attd. Nos."; Code[20])
        {
            Caption = 'External Exam Attd. Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(12; "Min. External Exam Attd. Per."; Decimal)
        {
            Caption = 'Min. External Exam Attd. Per.';
            DataClassification = CustomerContent;
        }
        field(13; "Room Allocation Nos."; Code[20])
        {
            Caption = 'Room Allocation Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(14; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(15; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(16; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Academic Year Master-CS";
        }
        field(17; "Min. Lab Attd. Per."; Decimal)
        {
            Caption = 'Min. Lab Attd. Per.';
            DataClassification = CustomerContent;
        }
        field(18; "Semester I"; Code[10])
        {
            Caption = 'Semester I';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(19; "Semester II"; Code[10])
        {
            Caption = 'Semester II';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(20; "Semester III"; Code[10])
        {
            Caption = 'Semester III';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(21; "Semester IV"; Code[10])
        {
            Caption = 'Semester IV';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(22; "Semester V"; Code[10])
        {
            Caption = 'Semester V';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(23; "Semester VI"; Code[10])
        {
            Caption = 'Semester VI';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(24; "Semester VII"; Code[10])
        {
            Caption = 'Semester VII';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(25; "Semester VIII"; Code[10])
        {
            Caption = 'Semester VIII';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Semester Master-CS";
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

