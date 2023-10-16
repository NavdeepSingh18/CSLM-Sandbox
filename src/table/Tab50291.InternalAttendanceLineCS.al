table 50291 "Internal Attendance Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                   Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   23/05/2019       OnInsert()                                Code added for Record Change then Upadted True
    // 02    CSPL-00114   23/05/2019       Student No. - OnValidate()                Code Added to flow the Roll No

    Caption = 'Internal Attendance Line-CS';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(4; "Subject Type"; Code[20])
        {
            Caption = 'Subject Type';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Subject Type-CS";
        }
        field(5; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS".Code WHERE(Course = FIELD(Course));
        }
        field(7; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(8; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Main Student Subject-CS"."Student No.";

            trigger OnValidate()
            begin
                //Code Added to flow the Roll No.::CSPL-00114::23052019: Start
                IF StudentMasterCS.GET("Student No.") THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    "Roll No." := StudentMasterCS."Roll No.";
                END ELSE
                    "Student Name" := '';
                "Roll No." := '';
                //Code Added to flow the Roll No.::CSPL-00114::23052019: End
            end;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(11; "Attendance Type"; Option)
        {
            Caption = 'Attendance Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50016; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            TableRelation = "Year Master-CS";
        }
        field(50017; "Attendance %"; Decimal)
        {
            Caption = 'Attendance %';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            Editable = true;
        }
        field(50018; "Applicable for Re-Sessional"; Boolean)
        {
            Caption = 'Applicable for Re-Sessional';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(50019; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(50020; "Room Alloted No."; Code[20])
        {
            Caption = 'Room Alloted No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            Editable = false;
        }
        field(50021; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            Editable = false;
            OptionCaption = ' ,Internal,External';
            OptionMembers = " ",Internal,External;
        }
        field(50022; "Exam Type"; Option)
        {
            Caption = 'Exam Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            OptionCaption = ' ,Regular,Re-Sessional';
            OptionMembers = " ",Regular,"Re-Sessional";
        }
        field(50023; "Roll No."; Code[10])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(50024; "Answer Sheet"; Code[20])
        {
            Caption = 'Answer Sheet';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(50025; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
            Editable = false;
        }
        field(50032; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(33048922; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(33048923; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(33048924; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(33048925; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(33048926; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
        field(33048928; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 23052019';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for Record Change then Upadted True::CSPL-00114::23052019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;
        //Code added for Record Change then Upadted True::CSPL-00114::23052019: End
    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        DimMgt: Codeunit "DimensionManagement";


    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

