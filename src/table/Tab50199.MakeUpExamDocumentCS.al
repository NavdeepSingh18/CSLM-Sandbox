table 50199 "MakeUp Exam Document-CS"
{
    // version V.001-CS

    Caption = 'MakeUp Exam Document-CS';

    fields
    {
        field(1; "Student No"; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
        }
        field(2; "Application No"; Code[20])
        {
            Caption = 'Application No';
            DataClassification = CustomerContent;
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(5; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(6; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(7; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(8; "Subject Code"; Code[10])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
        }
        field(9; "Document Path"; Text[100])
        {
            Caption = 'Document Path';
            DataClassification = CustomerContent;
        }
        field(10; "Document Name"; Text[30])
        {
            Caption = 'Document Name';
            DataClassification = CustomerContent;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
        }
        field(13; "Created By"; Text[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(14; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
        }
        field(15; "Updated By"; Text[30])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(16; "Updated Date"; Date)
        {
            Caption = 'Updated Date';
            DataClassification = CustomerContent;
        }
        field(17; "Document Description"; Text[50])
        {
            Caption = 'Document Description';
            DataClassification = CustomerContent;
        }
        field(18; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
        }
        field(19; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
        }
        field(21; Remark; Text[150])
        {
            Caption = 'Remark';
            DataClassification = CustomerContent;
        }
        field(22; "Approved By"; Text[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(23; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Student No", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

