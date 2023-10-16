table 50504 RoleCenterCueFinancialAid
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Pending Financial Aid Apps"; integer)
        {
            Caption = 'Financial Aid Application';
        }
        field(3; "Pending Semester Warning Apps"; integer)
        {
            Caption = 'Semester Warning Application';
            FieldClass = FlowField;
            //CalcFormula = Count();
        }
        field(4; "Pending Appeal Applications"; integer)
        {
            Caption = 'Appeal Applications';
            FieldClass = FlowField;
            //CalcFormula = count();
        }
        field(5; "Pending ELOA Application"; Integer)
        {
            Caption = 'ELOA Application';
            }
        field(6; "Pending Withdrawal Application"; integer)
        {
            Caption = 'Withdrawal Application';
             }
        field(7; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(8; "Financial Aid Sign-Off"; Integer)
        {
            Caption = 'Financial Aid Sign-Off';
        }
        field(9; "Pending CLOA Application"; Integer)
        {
            Caption = 'CLOA Application';
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