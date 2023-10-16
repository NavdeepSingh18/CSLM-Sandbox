table 50428 "Grade Master Grade Book"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    04-052019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Grade Master - Grade Book';
    // DrillDownPageID = "Grade List GradeBook";
    // LookupPageID = "Grade List GradeBook";
    DataCaptionFields = "Code", Description;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;


        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Max Percentage"; Decimal)
        {
            Caption = 'Max Percentage';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            begin
                if "Min Percentage" > "Max Percentage" then
                    Error('Minimum Percentage must be less than Maximum Percentage');
            end;
        }
        field(4; "Min Percentage"; Decimal)
        {
            Caption = 'Min Percentage';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            begin
                if "Min Percentage" > "Max Percentage" then
                    Error('Minimum Percentage must be less than Maximum Percentage');
            end;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; Points; Decimal)
        {
            Caption = 'Points';
            DataClassification = CustomerContent;
        }
        field(7; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Grade Book No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Standard Formula"; Decimal)
        {
            Caption = 'Standard Formula';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50004; "Grade Points"; Decimal)
        {
            Caption = 'Grade Points"';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(50005; Graduation; Code[20])
        {
            Caption = 'Graduation';
            Description = 'CS Field Added 08-05-2019';
            TableRelation = "Graduation Master-CS";
        }

        field(50006; "Consider for GPA"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'CS Field Added 27-03-2021';
        }
        Field(50007; "Show Grade Description"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50008; "Blocked for Grading"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60000; Failed; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(70000; "Total Students"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08-05-2019';
        }
        field(33048922; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2020';
        }
        field(33048923; "Grade Level ID"; code[20])
        {
            Caption = 'Grade Level ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2020';
        }
        field(33048924; "Grade Scale ID"; code[20])
        {
            Caption = 'Grade Scale ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 13-01-2020';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign Value in User Id and Academic Year Field::CSPL-00092::04-05-2019: Start
        "User ID" := FORMAT(UserId());
        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        //Code added for Assign Value in User Id and Academic Year Field::CSPL-00092::04-05-2019: End
    end;

    var
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";


}

