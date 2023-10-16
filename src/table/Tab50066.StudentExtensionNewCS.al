table 50066 "Student Extension New-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date            Trigger                 Remarks
    // 1         CSPL-00092    20-01-2019    OnInsert                  Assign TRUE in "Mobile Insert" Field.
    // 2         CSPL-00092    20-01-2019    OnModify                  Assign TRUE in "Mobile Insert" Field.

    Caption = 'Student Extension New-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

        }
        field(2; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(3; "Application No"; Code[20])
        {
            Caption = 'Application No';
            DataClassification = CustomerContent;
        }
        field(4; "Semester I Rank"; Text[30])
        {
            Caption = 'Semester I Rank';
            DataClassification = CustomerContent;
        }
        field(5; "Semester II Rank"; Text[30])
        {
            Caption = 'Semester II Rank';
            DataClassification = CustomerContent;
        }
        field(6; "Semester III Rank"; Text[30])
        {
            Caption = 'Semester III Rank';
            DataClassification = CustomerContent;
        }
        field(7; "Semester IV Rank"; Text[30])
        {
            Caption = 'Semester IV Rank';
            DataClassification = CustomerContent;
        }
        field(8; "Semester V Rank"; Text[30])
        {
            Caption = 'Semester V Rank';
            DataClassification = CustomerContent;
        }
        field(9; "Semester VI Rank"; Text[30])
        {
            Caption = 'Semester VI Rank';
            DataClassification = CustomerContent;
        }
        field(10; "Semester VII Rank"; Text[30])
        {
            Caption = 'Semester VII Rank';
            DataClassification = CustomerContent;
        }
        field(11; "Semester VIII Rank"; Text[30])
        {
            Caption = 'Semester VIII Rank';
            DataClassification = CustomerContent;
        }
        field(12; "Final Rank"; Text[30])
        {
            Caption = 'Final Rank';
            DataClassification = CustomerContent;
        }
        field(13; "Mobile Insert"; Boolean)
        {
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(14; "Mobile Update"; Boolean)
        {
            Caption = 'Mobile Update';
            DataClassification = CustomerContent;
        }
        field(15; "Mobile Result"; Boolean)
        {
            Caption = 'Mobile Result';
            DataClassification = CustomerContent;
        }
        field(16; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(17; "Year 1 Rank"; Text[30])
        {
            Caption = 'Year 1 Rank';
            DataClassification = CustomerContent;
        }
        field(18; "Year 2 Rank"; Text[30])
        {
            Caption = 'Year 2 Rank';
            DataClassification = CustomerContent;
        }
        field(19; "Year 3 Rank"; Text[30])
        {
            Caption = 'Year 3 Rank';
            DataClassification = CustomerContent;
        }
        field(20; "Year 4 Rank"; Text[30])
        {
            Caption = 'Year 4 Rank';
            DataClassification = CustomerContent;
        }
        field(21; "Final Year Rank"; Text[30])
        {
            Caption = 'Final Year Rank';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for Assign TRUE in "Mobile Insert" Field::CSPL-00092::20-01-2019: Start
        "Mobile Insert" := TRUE;
        //Code added for Assign TRUE in "Mobile Insert" Field::CSPL-00092::20-01-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Assign TRUE in "Mobile Insert" Field::CSPL-00092::20-01-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF NOT "Mobile Insert" THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;

        //Code added for Assign TRUE in "Mobile Insert" Field::CSPL-00092::20-01-2019: End
    end;
}

