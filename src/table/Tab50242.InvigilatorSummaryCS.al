table 50242 "Invigilator Summary-CS"
{
    // version V.001-CS
    Caption = 'Invigilator Summary-CS';


    fields
    {
        field(1; "Doc No."; Code[20])
        {
            Caption = 'Doc No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(50001; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50002; "Room Alloted No."; Code[20])
        {
            Caption = 'Room Alloted No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
        }
        field(50003; "Exam Slot"; Code[20])
        {
            Caption = 'Exam Slot';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
        }
        field(50004; "Invigilator 1"; Code[20])
        {
            Caption = 'Invigilator 1';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Employee"."No.";
        }
        field(50005; "Invigilator 2"; Code[20])
        {
            Caption = 'Invigilator 2';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Employee"."No.";
        }
        field(50006; "Invigilator 3"; Code[20])
        {
            Caption = 'Invigilator 3';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Employee"."No.";
        }
        field(50007; "Invigilator 4"; Code[20])
        {
            Caption = 'Invigilator 4';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Employee"."No.";
        }
        field(50008; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50009; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50010; "Exam Date"; Date)
        {
            Caption = 'Exam Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
        }
        field(50011; "Exam Schedule No."; Code[20])
        {
            Caption = 'Exam Schedule No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 16082019';
            TableRelation = "Exam Time Table Head-CS"."No.";
        }
    }

    keys
    {
        key(Key1; "Doc No.", "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var

}

