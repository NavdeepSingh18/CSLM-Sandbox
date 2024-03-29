table 50434 "Recommendations GradeBook"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }

        field(4; Semester; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
        }
        field(5; "Min Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Min Percentage';
        }
        field(6; "Max Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Max Percentage';
        }
        field(7; "Range Percentage"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Range Percentage';
        }
        field(20; "Recommendation"; text[120])
        {
            DataClassification = CustomerContent;
            Caption = 'Recommendation';
        }
        field(21; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Communications"; text[2048])
        {
            DataClassification = CustomerContent;
        }
        Field(24; "Academic SAP"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(25; Repeating; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(26; CBSE; Integer)// Not in Use
        {
            DataClassification = CustomerContent;
        }
        field(28; "CBSE Max"; Decimal)
        {
            Caption = 'CBSE Max';
            DataClassification = CustomerContent;
        }
        field(29; "CBSE Min"; Decimal)
        {
            Caption = 'CBSE Min';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Global Dimension 1 Code", Semester, "Min Percentage")
        {

        }
    }
}