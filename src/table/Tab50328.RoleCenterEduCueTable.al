table 50328 RoleCenterEduCueTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;

        }
        field(2; "Active Student"; Integer)
        {
            CalcFormula = Count ("Student Master-CS" WHERE("Global Dimension 1 Code" = field("Institute Code")));
            Caption = 'Active Student';
            FieldClass = FlowField;
        }
        field(3; "Total Course"; Integer)
        {
            CalcFormula = Count ("Course Master-CS" WHERE("Global Dimension 1 Code" = field("Institute Code"),
                                                                "Code" = FILTER(<> '')));
            Caption = 'Total Course';
            FieldClass = FlowField;
        }
        field(4; "Total Housing"; Integer)
        {
            CalcFormula = Count ("Housing Master");
            Caption = 'Total Housing';
            FieldClass = FlowField;
        }
        field(5; "Total Room"; Integer)
        {
            CalcFormula = Count("Room Master");
            Caption = 'Total Apartment';
            FieldClass = FlowField;
        }
        field(6; "Total Bed"; Integer)
        {
            CalcFormula = Count("Room Wise Bed");
            Caption = 'Total Room';
            FieldClass = FlowField;
        }
        field(7; "Institute Code"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //DataClassification = CustomerContent;
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}