table 50166 "Room Department Wise-CS"
{
    // version V.001-CS

    Caption = 'Room Department Wise-CS';
    DrillDownPageID = 50139;
    LookupPageID = 50139;

    fields
    {
        field(1; "Room No."; Code[10])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
        }
        field(2; "Room Type"; Option)
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Lecture Room,Lab Room,WorkShop,Seminar Hall';
            OptionMembers = " ","Lecture Room","Lab Room",WorkShop,"Seminar Hall";
        }
        field(3; "Floor No."; Code[10])
        {
            Caption = 'Floor No.';
            DataClassification = CustomerContent;
        }
        field(4; "Building Name"; Text[50])
        {
            Caption = 'Building Name';
            DataClassification = CustomerContent;
        }
        field(5; "Class Capacity"; Integer)
        {
            Caption = 'Class Capacity';
            DataClassification = CustomerContent;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(8; "Allot For Examination"; Boolean)
        {
            Caption = 'Allot For Examination';
            DataClassification = CustomerContent;
            TableRelation = "Rooms-CS"."Room No." WHERE("Allot For Examination" = CONST(false));
        }
        field(9; "Exam Capacity"; Integer)
        {
            Caption = 'Exam Capacity';
            DataClassification = CustomerContent;
        }
        field(10; "Building Number"; Integer)
        {
            Caption = 'Building Number';
            DataClassification = CustomerContent;
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
        }
        field(12; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(13; "Exam Type"; Option)
        {
            Caption = '"Exam Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Internal,External,Assignment,Internal Lab,External Lab,Project';
            OptionMembers = " ",Internal,External,Assignment,"Internal Lab","External Lab",Project;
        }
        field(14; "Subject Class"; Code[10])
        {
            Caption = 'Subject Class';
            DataClassification = CustomerContent;
            TableRelation = "Subject Classification-CS";
        }
    }

    keys
    {
        key(Key1; "Room No.")
        {
        }
    }

    fieldgroups
    {
    }
}

