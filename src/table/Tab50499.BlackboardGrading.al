table 50499 BlackboardGrading
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Grade Column ID"; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Grade Column Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Grade Value"; text[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Status"; text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Update Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Course Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Academic year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; Term; Text[100])
        {
            DataClassification = CustomerContent;
            // OptionCaption = 'FALL,SPRING,SUMMER';
            // OptionMembers = FALL,SPRING,SUMMER;
            ObsoleteState = Pending;
            Description = 'Marked for Removal';
        }
        field(13; "Blackboard course id"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Term 1"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}