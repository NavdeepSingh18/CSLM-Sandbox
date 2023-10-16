table 50052 "Sel Process Stage L1-CS"
{
    // version V.001-CS

    Caption = 'Sel Process Stage L1-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
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
        field(4; "Quota Code"; Code[20])
        {
            Caption = 'Quota Code';
            DataClassification = CustomerContent;
            TableRelation = "Quota-CS";
        }
        field(5; Capacity; Integer)
        {
            Caption = 'Capacity';
            DataClassification = CustomerContent;
        }
        field(6; Alloted; Integer)
        {
            Caption = 'Alloted';
            DataClassification = CustomerContent;
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; Selected; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Stage1 Selection Detail2-CS" WHERE("Selection List No." = FIELD("Stage1 Selection List No."),
                                                                     "Course Code" = FIELD("Course Code"),
                                                                     "Application Selection" = FILTER(true),
                                                                     Quota = FIELD("Quota Code")));
            Caption = 'Selected';
            Editable = false;

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
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
        key(Key2; "Course Code", "Stage1 Selection List No.")
        {
        }
    }

    fieldgroups
    {
    }
}

