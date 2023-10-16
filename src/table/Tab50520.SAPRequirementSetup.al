table 50520 "SAP Requirement Setup"
{
    DataClassification = CustomerContent;
    Caption = 'SAP Requirement Setup';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";


        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3; Semester; code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
            trigger OnValidate()
            begin
                TestField(Year, '');
            end;
        }
        field(4; Year; code[10])
        {
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestField(Semester, '');
            end;
        }
        field(5; GPA; Decimal)
        {
            Caption = 'GPA';
            DataClassification = CustomerContent;
        }
        field(6; "Pace of Progression"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Pace of Progression (Minimum %)';
        }
        field(7; "Maximum Timeframe"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Timeframe';
        }
    }

    keys
    {
        key(PK; "Course Code", "Global Dimension 1 Code", Year, Semester)
        {
            Clustered = true;
        }
    }


}