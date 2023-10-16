table 50537 "Student Semester Log Entry"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(4; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Semester Decision"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Repeat ,Restart';
            OptionMembers = " ","Repeat ","Restart";
        }
        field(7; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(11; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(12; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Academic Year", Term)
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        Inserted := true;
        "Created By" := UserId();
        "Created On" := Today();
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