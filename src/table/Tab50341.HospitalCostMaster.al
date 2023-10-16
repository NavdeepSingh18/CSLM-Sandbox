table 50341 "Hospital Cost Master"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
            TableRelation = Vendor."No." where("Vendor Sub Type" = const("Hospital"));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                "Hospital Name" := '';
                Vendor.Reset();
                if Vendor.Get("Hospital ID") then
                    "Hospital Name" := Vendor.Name;
            end;
        }
        field(2; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
        }
        field(3; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';
            trigger OnValidate()
            begin
                "Weekly Cost" := 0;
            end;
        }
        field(4; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
            trigger OnValidate()
            begin
                TestField("Effective Date");
                "Weekly Cost" := 0;
            end;
        }
        field(5; "Weekly Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Weekly Cost';
            trigger OnValidate()
            begin
                TestField("Clerkship Type");
                TestField("Effective Date");
            end;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
    }

    keys
    {
        key(PK; "Hospital ID", "Effective Date", "Clerkship Type")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        Vendor: Record Vendor;
    begin
        Vendor.Reset();
        if Vendor.Get("Hospital ID") then
            "Hospital Name" := Vendor.Name;
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