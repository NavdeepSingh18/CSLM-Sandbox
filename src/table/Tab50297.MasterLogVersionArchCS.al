table 50297 "Master Log Version Arch-CS"
{
    // version V.001-CS

    Caption = 'Master Log Version Arch-CS';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table));
        }
        field(4; "Version No"; Integer)
        {
            Caption = 'Version No.';
            DataClassification = CustomerContent;
        }
        field(6; "Table Caption"; Text[250])
        {
            FieldClass = FlowField;
            Caption = 'Table Caption';
            CalcFormula = Lookup (AllObjWithCaption."Object Caption" WHERE("Object Type" = CONST(Table),
                                                                           "Object ID" = FIELD("Table No.")));

        }
        field(7; "Field No."; Integer)
        {
            Caption = 'Field No.';
            DataClassification = CustomerContent;
            TableRelation = Field."No." WHERE(TableNo = FIELD("Table No."));
        }
        field(8; "Field Caption"; Text[80])
        {
            FieldClass = FlowField;
            Caption = 'Field Caption';
            CalcFormula = Lookup (Field."Field Caption" WHERE(TableNo = FIELD("Table No."),
                                                              "No." = FIELD("Field No.")));

        }
        field(50; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; "Archived On"; Date)
        {
            Caption = 'Archived On';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Old Value"; Text[250])
        {
            Caption = 'Old Value';
            DataClassification = CustomerContent;
        }
        field(53; "New Value"; Text[250])
        {
            Caption = 'New Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

