table 50392 "Hold Status Ledger"
{
    DataClassification = CustomerContent;
    Caption = 'Hold Status Ledger';


    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';

        }
        field(2; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Date';

        }
        field(3; "Entry Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Time';

        }

        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

        }
        field(5; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;

        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;

        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;

        }
        field(8; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;

        }
        field(9; "Hold Code"; Code[20])
        {
            Caption = 'Hold Code';
            DataClassification = CustomerContent;
            //


        }
        field(10; "Hold Description"; Text[250])
        {
            Caption = 'Hold Message';
            DataClassification = CustomerContent;

        }
        field(11; "Hold Type"; Option)
        {
            Caption = 'Hold Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Housing,Financial Aid,Bursar,Registrar,Registrar Sign-off,Immigration,Clinical,OLR Finance';
            OptionMembers = " ",Housing,"Financial Aid",Bursar,Registrar,"Registrar Sign-off",Immigration,Clinical,"OLR Finance";
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

        }
        field(14; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';

            OptionCaption = 'Enable,Disable';
            OptionMembers = Enable,Disable;
        }
        field(15; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(16; "Table ID"; integer)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Table Caption"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Group.Code;
            Editable = false;
        }
        field(19; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(20; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        IF xRec.Updated = Updated then
            Updated := true;
    end;


}