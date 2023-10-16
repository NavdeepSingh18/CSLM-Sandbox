table 50060 "Admission Setup-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                 Remarks
    // 1         CSPL-00092    10-01-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Admission Setup-CS';

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }

        field(3; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(4; "Appl Cost Method"; Option)
        {
            Caption = 'Appl Cost Method';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Common,Coursewise';
            OptionMembers = " ",Common,Coursewise;
        }
        field(5; "Application Cost For Reserve"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost For Reserve';
            DataClassification = CustomerContent;
        }
        field(6; "Application Cost For Others"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost For Others';
            DataClassification = CustomerContent;
        }
        field(7; "Registration Cost For Reserve"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost For Reserve';
            DataClassification = CustomerContent;
        }
        field(8; "Registration Cost For Others"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost For Others';
            DataClassification = CustomerContent;
        }
        field(9; "Application Cost Account No."; Code[20])
        {
            Caption = 'Application Cost Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(10; "Registration Cost Account No."; Code[20])
        {
            Caption = 'Registration Cost Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(11; "Template Name"; Code[10])
        {
            Caption = 'Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(12; "Application Sales Batch Name"; Code[10])
        {
            Caption = 'Application Sales Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"));
        }
        field(13; "Sales of Application From"; Date)
        {
            Caption = 'Sales of Application From';
            DataClassification = CustomerContent;
        }
        field(14; "Sales of Application To"; Date)
        {
            Caption = 'Sales of Application To';
            DataClassification = CustomerContent;
        }
        field(15; "Application Cost"; Boolean)
        {
            Caption = 'Application Cost';
            DataClassification = CustomerContent;
            InitValue = true;
        }
        field(16; "Registration Cost"; Boolean)
        {
            Caption = 'Registration Cost';
            DataClassification = CustomerContent;
        }
        field(17; "Admission Year"; Code[10])
        {
            Caption = 'Admission Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(18; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";
        }
        field(19; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Customer Posting Group";
        }

        field(21; "Registration Batch Name"; Code[20])
        {
            Caption = 'Registration Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Template Name"));
        }
        field(22; "Application Sales Posting No."; Code[20])
        {
            Caption = 'Application Sales Posting No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(23; "Registration Posting No."; Code[20])
        {
            Caption = 'Registration Posting No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(24; "Total Marks Category Code"; Code[20])
        {
            Caption = 'Total Marks Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Room Alloted Line-CS";
        }
        field(25; "Sel Process Stage2 No."; Code[20])
        {
            Caption = 'Sel Process Stage2 No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(26; "Evaluation Category Code"; Code[20])
        {
            Caption = 'Evaluation Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Room Alloted Line-CS";
        }
        field(27; "Sel Process Stage1 No."; Code[20])
        {
            Caption = 'Sel Process Stage1 No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(28; "Stage1 Category Code"; Code[20])
        {
            Caption = 'Stage1 Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Room Alloted Line-CS";
        }
        field(50000; "Prospectus No."; Code[20])
        {
            Caption = 'Prospectus No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-01-2019';
            TableRelation = "No. Series";
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 22-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 22-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; "Time Slot No."; Code[20])
        {
            Caption = 'Time Slot No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-01-2019';
            TableRelation = "No. Series";
        }
        field(50004; "Time Table No."; Code[20])
        {
            Caption = 'Time Table No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 25-01-2019';
            TableRelation = "No. Series";
        }
        field(50005; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50006; "Housing Issue No."; Code[20])
        {
            Caption = 'Housing Issue No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(33048920; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            Description = 'CS Field Added 25-01-2019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
        }
        field(33048922; "Mess Attendance"; Code[20])
        {
            Caption = 'Mess Attendance';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "No. Series";
        }
        field(33048923; "Bus pass USIN No."; Code[20])
        {
            Caption = 'Bus pass USIN No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "No. Series";
        }
        field(33048924; "Bus Pass No."; Code[20])
        {
            Caption = 'Bus Pass No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "No. Series";
        }
        field(33048925; "Fee Receipt Usin No"; Code[20])
        {
            Caption = 'Fee Receipt Usin No';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 28-01-2019';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for User Id Assign in User Id Field::CSPL-00092::10-01-2019: Start
        "User ID" := FORMAT(UserId());
        //Code added for User Id Assign in User Id Field::CSPL-00092::10-01-2019: End
    end;
}