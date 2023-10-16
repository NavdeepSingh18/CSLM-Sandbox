table 50020 "Discipline Line Faculty-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                       Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                      User Id Assign in User Id Field.
    // 2         CSPL-00092    03-05-2019    OnInsert                      User Id Assign in User Id Field
    // 3         CSPL-00092    03-05-2019    Date Commited - OnValidate    Assign Value in Academic Year Field
    // 4         CSPL-00092    03-05-2019    Staff Code - OnValidate       Assign Value in Staff Name Field

    Caption = 'Discipline Line Faculty-CS';

    fields
    {
        field(1; "Staff No."; Code[20])
        {
            Caption = 'Staff No.';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(4; Severity; Code[20])
        {
            Caption = 'Severity';
            DataClassification = CustomerContent;
            TableRelation = "Discipline Level-CS";
        }
        field(5; "Action Taken"; Code[20])
        {
            Caption = 'Action Taken';
            DataClassification = CustomerContent;
            TableRelation = "College Taken Action-CS";
        }
        field(6; "Remedial Measures"; Text[250])
        {
            Caption = 'Remedial Measures';
            DataClassification = CustomerContent;
        }
        field(7; "Date Commited"; Date)
        {
            Caption = 'Date Commited';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Academic Year Field::CSPL-00092::03-05-2019: Start
                EduSetup.Reset();
                EduSetup.GET();
                EduSetup.TESTFIELD("Academic Year");
                "Academic Year" := EduSetup."Academic Year";
                //Code added for Assign Value in Academic Year Field::CSPL-00092::03-05-2019: End
            end;
        }
        field(8; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(9; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Staff Name Field::CSPL-00092::03-05-2019: Start
                IF Employee.GET("Staff Code") THEN
                    "Staff Name" := Employee."First Name";
                //Code added for Assign Value in Staff Name Field::CSPL-00092::03-05-2019: End
            end;
        }
        field(10; "Staff Name"; Text[30])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 07-05-2019';
        }
    }

    keys
    {
        key(Key1; "Staff No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::03-05-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::03-05-2019: End
    end;

    var
        EduSetup: Record "Education Setup-CS";

        Employee: Record "Employee";
}

