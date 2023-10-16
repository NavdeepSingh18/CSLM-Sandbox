table 50355 "Subject Category Master"
{
    DataClassification = CustomerContent;
    Caption = 'Subject Category Master';

    fields
    {
        field(1; "Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Code';
        }

        field(2; "Category Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';
        }
        field(3; "Course Range Min"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Range Min';
        }
        field(4; "Course Range Max"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Range Max';
        }
        field(5; "Course Description"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(6; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(9; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(10; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(11; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(12; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(13; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = False;

        }
        Field(14; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = False;

        }
    }

    keys
    {
        key(PK; "Category Code")
        {
            Clustered = true;
        }
    }

    var


    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        Updated := true;
    end;

}