table 50121 "Source Scholarship-CS"
{
    // version V.001-CS

    DrillDownPageID = "Scholar. Source L-CS";
    LookupPageID = "Scholar. Source L-CS";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Category Code"; Code[10])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Grade Master-CS";
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; "Discount Type"; option)
        {
            DataClassification = CustomerContent;
            Caption = 'Discount Type';
            OptionCaption = ' ,Grant,Scholarship,Waiver';
            OptionMembers = " ",Grant,Scholarship,Waiver;
        }
        field(50000; "SAP Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'SAP Code';
            TableRelation = "SAP Fee Code";
        }

        field(50001; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(50002; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    Var
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.Reset();
        CLE.SETRANGE("Waiver/Scholar/Grant Code", Code);
        CLE.SETRANGE(CLE.Reversed, FALSE);
        if CLE.FindFirst() then
            Error('You can not delete the record, Customer Ledger Entry already exist');
    end;

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;
}

