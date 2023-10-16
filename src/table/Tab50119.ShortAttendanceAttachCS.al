table 50119 "Short Attendance Attach-CS"
{
    // version V.001-CS

    Caption = 'Short Attendance Attach-CS';

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(2; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(6; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(7; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
        }
        field(8; "Document Path"; Text[250])
        {
            Caption = 'Document Path';
            DataClassification = CustomerContent;
        }
        field(9; "Document Name"; Text[50])
        {
            Caption = 'Document Name';
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(12; "Created By"; Text[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(13; "Created Date"; Date)
        {
            Caption = 'Craeted Date';
            DataClassification = CustomerContent;
        }
        field(14; "Updated By"; Text[30])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(15; "Updated Date"; Date)
        {
            Caption = 'Updated Date';
            DataClassification = CustomerContent;
        }
        field(16; "Document Description"; Text[50])
        {
            Caption = 'Document Description';
            DataClassification = CustomerContent;
        }
        field(17; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
        }
        field(18; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
        }
        field(19; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(20; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(21; Status; Text[30])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(22; Remark; Text[150])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(23; "Approved By"; Text[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(24; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
        }
        field(25; Attachment; BLOB)
        {
            Caption = 'Attachment';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No.", "Application No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

