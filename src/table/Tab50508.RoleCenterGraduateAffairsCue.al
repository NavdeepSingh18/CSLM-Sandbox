table 50508 RoleCenterGraduateAffairsCue
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(2; "Total Matched Students"; Integer)
        {
            Caption = 'Total Matched Students';
            Editable = false;
        }
        field(3; "MSPE Applications"; Integer)
        {
            Editable = false;
            Caption = 'MSPE Applications';
        }
        field(4; "Licensing Request Form"; Integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count();
            Editable = false;
            Caption = 'Post-Graduate Request Form';
        }
        field(5; "Transcript Request List"; Integer)
        {
            FieldClass = FlowField;
            // CalcFormula = count();
            Editable = false;
            Caption = 'Transcript Request List';
        }
        field(6; "Completed MSPE Apps"; Integer)
        {
            caption = 'MSPE Applications';
            Editable = false;
        }
        field(7; "In-Review MSPE Apps"; Integer)
        {
            caption = 'In-Review MSPE Applications';
            Editable = false;
        }
        field(8; "Institute Code"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            FieldClass = FlowFilter;
        }
        field(9; "Review Req MSPE Apps"; Integer)
        {
            caption = 'Review Required MSPE Applications';
            Editable = false;
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