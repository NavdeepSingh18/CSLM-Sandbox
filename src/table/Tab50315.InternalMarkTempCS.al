table 50315 "Internal Mark Temp-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   02/10/2019       OnInsert()                Auto assign "User Id" Value

    Caption = 'Internal Mark Temp-CS';

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(2; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            DataClassification = CustomerContent;
        }
        field(3; "Marks Obtained"; Decimal)
        {
            Caption = 'Marks Obtained';
            DataClassification = CustomerContent;
        }
        field(4; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(6; "Subject Code"; Code[20])
        {
            Caption = 'Subject Code';
            DataClassification = CustomerContent;
            TableRelation = "Subject Master-CS";
        }
        field(7; "Order"; Integer)
        {
            Caption = 'Order';
            DataClassification = CustomerContent;
        }
        field(8; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(9; Weightage; Decimal)
        {
            Caption = 'Weightage';
            DataClassification = CustomerContent;
        }
        field(10; "Internal Evaluation Method"; Option)
        {
            Caption = 'Internal Evaluation Method';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Best of Two,Average of Two,Best of Three,Average of Three,Average of Best Two';
            OptionMembers = " ","Best of Two","Average of Two","Best of Three","Average of Three","Average of Best Two";
        }
        field(11; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            TableRelation = "Year Master-CS";
        }
        field(12; "Internal Maximum"; Decimal)
        {
            Caption = 'Internal Maximum';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 02102019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 02102019';
        }
    }

    keys
    {
        key(Key1; "Student No.", "Course Code", Semester, Year, Section, "Subject Code", "Group Code", "Order")
        {
        }
        key(Key2; "Student No.", "Order")
        {
            SumIndexFields = "Marks Obtained";
        }
        key(Key3; "Student No.", "Marks Obtained")
        {
        }
        key(Key4; "Course Code", Semester, Section, "Subject Code", "Student No.")
        {
            SumIndexFields = "Marks Obtained";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Auto assign "User Id" Value ::CSPL-00114::02102019: Start
        "User ID" := FORMAT(UserId());
        //Auto assign "User Id" Value ::CSPL-00114::02102019: End
    end;
}

