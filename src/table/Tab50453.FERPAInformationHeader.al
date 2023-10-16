table 50453 "FERPA Information Header"
{
    Caption = 'FERPA Information Header';

    fields
    {
        field(1; "Info Header No"; Code[20])
        {
            Caption = 'Info Header No';
            DataClassification = CustomerContent;
        }
        field(2; "Student No"; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; "Semester"; Code[10])
        {
            Caption = 'Semester';
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(5; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(6; "Share Start Date"; Date)
        {
            Caption = 'Share Start Date';
            DataClassification = CustomerContent;
        }
        field(7; "Share End Date"; Date)
        {
            Caption = 'Share End Date';
            DataClassification = CustomerContent;
        }
        field(8; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(11; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Updated By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(13; Reason; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(14; Block; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Can Amend"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Can Review"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(18; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(19; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; "Info Header No")
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

        Inserted := True;

    end;

    trigger OnModify()
    begin
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());

        If xRec.Updated = Updated then
            Updated := True;

    end;

}