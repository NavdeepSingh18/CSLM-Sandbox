table 50024 "Enquiry Type-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    04-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Running Total Calc Mapping';
    //LookupPageID = 50192;

    fields
    {
        field(1; "Code"; Code[10])
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
        field(3; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(4; "Semester Code"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Subject Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Data Mapping Field"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Field ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Total Maximum"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
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
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::04-05-2019: End
    end;
}

