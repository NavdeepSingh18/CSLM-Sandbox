table 50481 "Student Group Ledger"
{
    DataClassification = CustomerContent;
    Caption = 'Student Group Ledger';


    fields
    {
        field(1; "Entry No."; BigInteger)
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
            TableRelation = "Student Master-CS"."No.";

            trigger OnValidate();
            begin
                if StudentMasterRec.Get("Student No.") then begin
                    "Student Name" := StudentMasterRec."Student Name";
                    Semester := StudentMasterRec.Semester;
                    "Academic Year" := StudentMasterRec."Academic Year";
                    "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                    "Enrollment No." := StudentMasterRec."Enrollment No.";
                end else begin
                    Semester := '';
                    "Academic Year" := '';
                    "Student Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Enrollment No." := '';
                end;
            end;

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
        field(8; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
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
        field(16; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(17; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(18; "Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Group.Code;
        }
        field(19; "Group Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Clinical;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
    end;

    var

        StudentMasterRec: Record "Student Master-CS";

}