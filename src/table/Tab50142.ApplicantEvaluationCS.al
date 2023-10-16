table 50142 "Applicant Evaluation-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   30/05/2019       OnInsert()                             Auto assign User ID

    Caption = 'Applicant Evaluation-CS';

    fields
    {
        field(1; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "Application-CS";
        }
        field(2; "Evaluation Method Code"; Code[20])
        {
            Caption = 'Evaluation Method Code';
            DataClassification = CustomerContent;
            TableRelation = "Student Extension New-CS";
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
            DataClassification = CustomerContent;
            OptionCaption = ' ,Present,Absent';
            OptionMembers = " ",Present,Absent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30052019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
            end;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30052019';
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
        //Code added for Auto assign User ID::CSPL-00114::30052019: Start
        "User ID" := FORMAT(UserId());
        //Code added for Auto assign User ID::CSPL-00114::30052019: End
    end;
}

