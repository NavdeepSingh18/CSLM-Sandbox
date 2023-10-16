table 50459 "Student Honors"
{
    Caption = 'Student Honors';

    fields
    {
        field(1; "Honors Code"; Code[20])
        {
            Caption = 'Honors Code';
            DataClassification = CustomerContent;
            TableRelation = Honors.Code;

            trigger OnValidate()
            begin
                if HonorsRec.Get("Honors Code") then begin
                    "Honors Name" := HonorsRec.Description;
                    "Min. Range" := HonorsRec."Min. Range";
                    "Max. Range" := HonorsRec."Max. Range";
                end;
            end;
        }
        field(2; "Honors Name"; Text[100])
        {
            Caption = 'Honors Name';
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";

            trigger OnValidate()
            begin
                if StudentMaster.Get("Student No.") then
                    "Enrollment No." := StudentMaster."Enrollment No.";
            end;
        }
        field(4; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
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
        field(12; "DateAwarded"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(13; "DateCleared"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(14; "Min. Range"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Min. Range';
        }

        Field(15; "Max. Range"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Max. Range';
        }
    }

    keys
    {
        key(Key1; "Student No.", "Honors Code")
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

        HonorsRec: Record Honors;
        StudentMaster: Record "Student Master-CS";
}