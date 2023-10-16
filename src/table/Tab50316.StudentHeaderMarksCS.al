table 50316 "Student Header Marks-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   02/10/2019       OnInsert()                Auto assign "User Id" Value

    Caption = 'Student Header Marks-CS';


    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Student Master-CS";
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Course Master-CS";
        }
        field(4; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Semester Master-CS";
        }
        field(5; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Section Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Total Marks Scored"; Decimal)
        {
            Caption = 'Total Marks Scored';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Total Marks Conducted"; Decimal)
        {
            Caption = 'Total Marks Conducted';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(9; "Average"; Decimal)
        {
            Caption = 'Average';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; "Percentage Scored"; Decimal)
        {
            Caption = 'Percentage Scored';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Rank; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; "GPA Grade"; Code[20])
        {
            Caption = 'GPA Grade';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(13; "Total No of Subject Failed"; Integer)
        {
            Caption = 'Total No of Subject Failed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; Result; Option)
        {
            Caption = 'Result';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Pass,Fail';
            OptionMembers = " ",Pass,Fail;
        }
        field(15; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(16; "Average Attendance %"; Decimal)
        {
            Caption = 'Average Attendance %';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "GPA Points"; Decimal)
        {
            Caption = 'GPA Points';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
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
        key(Key1; "Student No.", Course, Semester, "Academic Year")
        {
            SumIndexFields = "GPA Points";
        }
        key(Key2; Rank)
        {
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

