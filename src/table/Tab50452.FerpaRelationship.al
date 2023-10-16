table 50452 "Ferpa Relationship"
{
    Caption = 'Ferpa Relationship';

    fields
    {
        field(1; "Relationship Code"; Code[20])
        {
            Caption = 'Relationship Code';
            DataClassification = CustomerContent;
        }
        field(2; "Relationship Name"; Text[50])
        {
            Caption = 'Relationship Name';
            DataClassification = CustomerContent;
        }
        field(3; "Blocked"; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(6; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(9; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Updated By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(12; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; "Relationship Code")
        {

        }
    }

    trigger OnInsert()
    begin

        "Creation Date" := Today();
        "Created By" := Userid();
        "User ID" := FORMAT(UserId());
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());

        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());

        If xRec.Updated = Updated then
            Updated := true;
    end;

}