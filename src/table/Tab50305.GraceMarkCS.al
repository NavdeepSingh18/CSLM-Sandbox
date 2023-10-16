table 50305 "Grace Mark-CS"
{
    // version V.001-CS

    Caption = 'Grace Mark-CS';

    fields
    {
        field(1; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Course Master-CS";
        }
        field(2; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Semester Master-CS";
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Student No"; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Student Master-CS";
        }
        field(16; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Subject Master-CS";
        }
        field(18; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(20; "Grace Marks"; Integer)
        {
            Caption = 'Grace Marks';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Regular,Re-Registration,Makeup';
            OptionMembers = " ",Regular,"Re-Registration",Makeup;
        }
        field(54; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Year Master-CS";
        }
        field(55; "Type of Course"; Option)
        {
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(56; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
        field(57; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2));
        }
        field(58; "Maximum Marks"; Decimal)
        {
            Caption = 'Maximum Marks';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(59; "Student External Document No"; Code[20])
        {
            Caption = 'Student External Document No';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Course Code", Semester, "Academic Year", "Line No")
        {
        }
        key(Key2; "Subject Code", "Marks Obtained")
        {
        }
        key(Key3; "Student No", "Marks Obtained")
        {
        }
    }

    fieldgroups
    {
    }
}

