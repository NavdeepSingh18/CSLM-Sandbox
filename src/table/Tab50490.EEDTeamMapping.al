table 50490 "EED Team Mapping"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Topic Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Advising Topics";

        }
        field(3; "Reason Program Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Program";

        }
        field(4; "Advisor ID"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employee";

        }
        field(5; "Start Alpha Range"; Code[1])
        {
            DataClassification = CustomerContent;

        }
        field(6; "End Alpha Range"; Code[1])
        {
            DataClassification = CustomerContent;

        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(8; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(9; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(10; "Global Dimension 1 Code"; code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

        }
        field(11; Blocked; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(16; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(17; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        Inserted := True;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();

        If xRec.Updated = Updated then
            Updated := true;
    end;



}