table 50457 "Course Degree"
{
    Caption = 'Course Degree';

    fields
    {
        field(1; "Degree Code"; Code[20])
        {
            Caption = 'Degree Code';
            DataClassification = CustomerContent;
            TableRelation = "Final Degree-CS".Code;

            trigger OnValidate()
            begin
                if FinalDegree.Get("Degree Code") then
                    "Degree Name" := FinalDegree.Description;
            end;
        }
        field(2; "Degree Name"; Text[100])
        {
            Caption = 'Degree Name';
            DataClassification = CustomerContent;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code;

        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Updated By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(12; "With Expiration"; Boolean)
        {
            Caption = 'With Expiration';
            DataClassification = CustomerContent;
        }
        field(13; "Expiration Duration"; DateFormula)
        {
            Caption = 'Expiration Duration';
            DataClassification = CustomerContent;
        }
        field(14; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Course Code", "Degree Code")
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
    end;

    trigger OnModify()
    begin
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());
    end;

    var

        FinalDegree: Record "Final Degree-CS";

}