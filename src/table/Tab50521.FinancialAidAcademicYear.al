table 50521 "Financial Aid Academic Year"
{
    DataClassification = CustomerContent;
    Caption = 'Financial Aid Academic Year Setup';

    fields
    {
        field(1; "FA Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Academic Year';

        }
        field(2; "FA Academic Year Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Academic Year Description';
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(4; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; Term; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
    }

    keys
    {
        key(PK; "FA Academic Year")
        {
            Clustered = true;
        }
    }

}