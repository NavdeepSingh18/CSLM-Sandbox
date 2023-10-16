table 50173 "Different Attachment-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   09/09/2019       OnInsert()                                 Code Added for Full Faculty name.
    Caption = 'Different Attachment-CS';
    //LookupPageID = 50028;

    fields
    {
        field(1; "S.No."; Integer)
        {
            Caption = 'S.No.';
            DataClassification = CustomerContent;
        }
        field(2; "Faculty Code"; Code[20])
        {
            Caption = 'Faculty Code"';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code Added for Full Faculty Name::CSPL-00114::09092019: Start
                IF "Faculty Code" <> '' THEN
                    IF Employee.GET("Faculty Code") THEN
                        "Faculty Name" := Format(Employee."First Name" + ' ' + Employee."Last Name" + ' ' + Employee."Middle Name");
                //Code Added for Full Faculty Name::CSPL-00114::09092019: End
            end;
        }
        field(3; "Faculty Name"; Text[50])
        {
            Caption = 'Faculty Name';
            DataClassification = CustomerContent;
        }
        field(4; "File Name"; Text[200])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(5; "File Extension"; Text[30])
        {
            Caption = 'File Extension';
            DataClassification = CustomerContent;
        }
        field(6; "File Path"; Text[250])
        {
            Caption = 'File Path';
            DataClassification = CustomerContent;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(8; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(9; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(10; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
            Width = 1;
        }
        field(11; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(12; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(13; "Document Type"; Code[20])
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
        }
        field(14; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(15; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(16; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(17; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(18; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(19; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(20; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
        }
        field(21; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(24; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(25; IsActive; Boolean)
        {
            Caption = 'IsActive';
            DataClassification = CustomerContent;
        }
        field(26; Attachment; BLOB)
        {
            Caption = 'Attachment';
            DataClassification = CustomerContent;
        }
        field(27; "Program"; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
        }
        field(28; Important; Boolean)
        {
            Caption = 'Important';
            DataClassification = CustomerContent;
        }
        field(29; "Transaction No."; Code[30])
        {
            Caption = 'Transaction No.';
            DataClassification = CustomerContent;
        }
        field(30; "Document Category"; Text[50])
        {
            Caption = 'Important';
            DataClassification = CustomerContent;
        }
        field(31; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }

        field(32; "Document Type New"; Option)
        {
            Caption = 'Document Type';
            OptionMembers = " ",Form,Document;
            // DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "S.No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee";

    trigger OnInsert()
    var
        RecAttachmentothers: Record "Different Attachment-CS";
    begin
        If "S.No." = 0 then begin
            RecAttachmentothers.Reset();
            IF RecAttachmentothers.FindLast() then
                "S.No." := RecAttachmentothers."S.No." + 1
            else
                "S.No." := 1;
        end;
        "Created By" := UserId;
        "Created On" := Today;
        "Created By Name" := UserId;
    end;

    trigger OnModify()
    var
    begin
        "Updated By" := UserId;
        "Updated On" := Today;
        "Updated By Name" := UserId;
    end;
}

