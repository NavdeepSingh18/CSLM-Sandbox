table 50126 "Rooms-CS"
{
    // version V.001-CS

    Caption = 'Rooms-CS';
    DrillDownPageID = "Room Detail-CS";
    LookupPageID = "Room Detail-CS";

    fields
    {
        field(1; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
        }
        field(2; "Room Type"; Option)
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Lecture Room,Lab Room,WorkShop,Seminar Hall,Home Room,Flex Room,Harvey Roooms,ICM Room';
            OptionMembers = " ","Lecture Room","Lab Room",WorkShop,"Seminar Hall","Home Room","Flex Room","Harvey Room","ICM Room";
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
        field(10; "Building Number"; Code[20])
        {
            Caption = 'Building Number';
            DataClassification = CustomerContent;
        }
        field(11; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
        }
        field(12; Course; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(13; "Academic Block"; Code[20])
        {
            Caption = 'Academic Block';
            DataClassification = CustomerContent;
        }
        field(14; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(15; "Display Room No."; Code[20])
        {
            Caption = 'Display Room No.';
            DataClassification = CustomerContent;
        }
        field(16; "Examination Department Code"; Code[20])
        {
            Caption = 'Examination Department Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(17; "Room Description"; Text[100])
        {
            Caption = 'Room Description';
            DataClassification = CustomerContent;
        }
        field(18; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
        }
        field(19; "Exam Slot"; Code[10])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
        }
        field(20; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(21; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
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
        fieldgroup("DisplayRoomNo."; "Display Room No.", "Room No.")
        {
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

