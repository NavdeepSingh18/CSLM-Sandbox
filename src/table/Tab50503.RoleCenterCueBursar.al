table 50503 RoleCenterCueBursar
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Pndg Payment Plan Apps"; integer)
        {
            Caption = 'Pending Payment Plan Application';
            FieldClass = FlowField;
            CalcFormula = Count("Financial AID" Where(Status = filter("Pending for Approval"), "Type" = filter("Self Payment" | "Payment Plan"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(3; "Pendg Fin. Accountability List"; integer)
        {
            Caption = 'Pending Financial Accountability List';
            FieldClass = FlowField;
            CalcFormula = Count("Financial Accountability" where(Status = filter("Pending for Approval"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(4; "Pending Financial Aid Roster"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Financial Aid Roster" where(Status = filter("Pending for Approval"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(5; "Pending Withwal Approval List"; integer)
        {
            Caption = 'Pending Withdrawal Approval List';
            FieldClass = FlowField;
            CalcFormula = count("Withdrawal Approvals" WHERE(Status = FILTER("Pending for Approval"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter"), "Approved for Department" = filter(8010)));
        }
        field(6; "Pending Wire Transfer List"; Integer)
        {
            FieldClass = Flowfield;
            CalcFormula = count("RTGS Payment Summary-CS" Where(Status = filter("Pending for Approval"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(7; "Pending Financial Aid App"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Financial AID" where(Status = filter("Pending for Approval"), Type = filter("Financial Aid"), "Global Dimension 1 Code" = field("Global Dimension 1 Filter")));
        }
        field(8; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
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

    var
        myInt: Integer;

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