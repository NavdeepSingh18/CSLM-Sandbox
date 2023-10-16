table 50220 "Initial Fee Setup-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                             Remarks
    // 1         CSPL-00092    09-05-2019    OnInsert                            Assign Value in User ID Field.
    // 2         CSPL-00092    09-05-2019    Fee Type Code - OnValidate          Assign Value in Description Field

    Caption = 'Initial Fee Setup-CS';
    // DrillDownPageID = 33049647;
    //LookupPageID = 33049647;

    fields
    {
        field(1; "Fee Type Code"; Code[20])
        {
            Caption = 'Fee Type Code';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Fee Type Master-CS";

            trigger OnValidate()
            begin
                //Code added for Assign Value in Description Field::CSPL-00092::09-05-2019: Start
                IF FeeType.GET("Fee Type Code") THEN
                    Description := FeeType.Description
                ELSE
                    Description := '';
                //Code added for Assign Value in Description Field::CSPL-00092::09-05-2019: End
            end;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 11-05-2019';
        }
    }

    keys
    {
        key(Key1; "Fee Type Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User ID Field::CSPL-00092::09-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Assign Value in User ID Field::CSPL-00092::09-05-2019: End
    end;

    var
        FeeType: Record "Fee Type Master-CS";
}

