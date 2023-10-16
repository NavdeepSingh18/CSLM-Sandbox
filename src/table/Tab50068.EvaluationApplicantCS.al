table 50068 "Evaluation Applicant-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    21-01-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Evaluation Applicant-CS';

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            TableRelation = "Application-CS";
            DataClassification = CustomerContent;
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            TableRelation = "Student Extension New-CS";
            DataClassification = CustomerContent;
        }
        field(3; Desription; Text[30])
        {
            Caption = 'Desription';
            DataClassification = CustomerContent;
        }
        field(4; "Mark Obtained"; Decimal)
        {
            Caption = 'Mark Obtained';
            DataClassification = CustomerContent;
        }
        field(5; "Attendance Status"; Option)
        {
            Caption = 'Attendance Status';
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 28-01-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 28-01-2019';
        }
    }

    keys
    {
        key(Key1; "Application No.", "Evaluation Method Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::21-01-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::21-01-2019: End
    end;
}