table 50151 "Fee Classification Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    07-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Fee Classification Master-CS';
    DrillDownPageID = 50060;
    LookupPageID = 50060;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
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
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Credit Card Bank Account No."; Code[20])
        {
            Caption = 'Credit Card Bank Account No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Bank Account";
        }
        field(50004; "SIS Code"; Code[10])
        {
            Caption = 'SIS Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
        }
        field(50005; "Wire Trans. Bank Account No."; Code[20])
        {
            Caption = 'Wire Transfer Bank Account No.';
            DataClassification = CustomerContent;
            TableRelation = "Bank Account";
        }
        field(50006; "EFT Bank Account No."; Code[20])
        {
            Caption = 'EFT Bank Account No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
            TableRelation = "Bank Account";
        }

        field(50007; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50008; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

        field(33048920; "User ID"; Code[50])
        {

            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 09-05-2019';
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

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::07-05-2019: Start
        "User ID" := FORMAT(UserId());

        Inserted := true;
        //Code added for User Id Assign in User Id Field::CSPL-00092::07-05-2019: End
    end;

    trigger OnModify()
    begin
        IF xRec.Updated = Updated then
            Updated := true;

    end;
}

