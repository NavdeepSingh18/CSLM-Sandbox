table 50013 "Period Header-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    28-04-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Period Header-CS';
    //DrillDownPageID = 33049496;
    //LookupPageID = 33049496;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Starting time"; Time)
        {
            Caption = 'Starting time';
            DataClassification = CustomerContent;
        }
        field(3; "No.Of Periods/Day"; Integer)
        {
            Caption = 'No.Of Periods/Day';
            DataClassification = CustomerContent;
        }
        field(4; "Minutes/Period"; Integer)
        {
            Caption = 'Minutes/Period';
            DataClassification = CustomerContent;
        }
        field(5; "Interval Start Time"; Time)
        {
            Caption = 'Interval Start Time';
            DataClassification = CustomerContent;
        }
        field(6; "Interval End Time"; Time)
        {
            Caption = 'Interval End Time';
            DataClassification = CustomerContent;
        }
        field(7; "Lunch Start Time"; Time)
        {
            Caption = 'Lunch Start Time';
            DataClassification = CustomerContent;
        }
        field(8; "Lunch End Time"; Time)
        {
            Caption = 'Lunch End Time';
            DataClassification = CustomerContent;
        }
        field(9; "Working Days Per Week"; Integer)
        {

            Caption = 'Working Days Per Week';
            DataClassification = CustomerContent;
        }
        field(10; "No.Of Periods/Half Day"; Integer)
        {
            Caption = 'No.Of Periods/Half Day';
            DataClassification = CustomerContent;
        }
        field(11; "Max Lab Hours/Day"; Integer)
        {
            Caption = 'Max Lab Hours/Day';
            DataClassification = CustomerContent;
        }

        field(12; "End time"; Time)
        {
            Caption = 'End time';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        Field(50003; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50004; "Student Last Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50005; "Student First Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50006; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50007; Program; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50008; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50009; "Doc. Type"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(50010; "Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50011; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50012; "Bill Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50013; "Bill Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        Field(50014; "Transaction Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        Field(50015; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
        Field(50016; "Running Balance"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        Field(50017; "Fee Group"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50018; "Institute Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50019; "Department Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(50020; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 30-04-2019';
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::28-04-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::28-04-2019: End
    end;
}

