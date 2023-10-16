table 50401 "In Person Registration"
{
    Caption = 'In Person Registration';

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Academic Year Master-CS";

        }
        field(2; Semester; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Semester Master-CS";
        }
        field(3; "Last Name First Letter Range"; Text[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name First Letter Range';
        }
        field(4; "Date of In-Person"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of In-Person Registration';
        }
        field(5; "Time Slot of In-Person"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Time Slot of In-Person Registration';
            TableRelation = "Time Period-CS";
        }
        field(6; Session; Option)
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING';
            OptionMembers = FALL,SPRING;
        }
        field(7; "Place of In-Person"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Place of In-person Registration';
        }

        field(8; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(15; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Last Name First Letter Range", "Global Dimension 1 Code")
        {
            Clustered = true;
        }

    }

    var

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
        Updated := true;
    end;
}