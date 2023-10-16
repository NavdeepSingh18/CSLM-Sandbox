table 50322 "Admission Setup Master-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   15/05/2019       OnInsert()                                 Auto assign "User Id" Values

    Caption = 'Admission Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Application No."; Code[10])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(5; "Appl Cost Method"; Option)
        {
            Caption = 'Appl Cost Method';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Common,Classwise';
            OptionMembers = " ",Common,Classwise;
        }
        field(6; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
            DataClassification = CustomerContent;
        }
        field(7; "Registration Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost';
            DataClassification = CustomerContent;
        }
        field(8; "Journal Template Name"; Code[20])
        {
            Caption = 'Journal Template Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Template";
        }
        field(9; "Application Sales Batch Name"; Code[20])
        {
            Caption = 'Application Sales Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(10; "Application Cost Account No."; Code[20])
        {
            Caption = 'Application Cost Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(11; "Registration Cost Account No."; Code[20])
        {
            Caption = 'Registration Cost Account No.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(12; "Application Cost Needed"; Boolean)
        {
            Caption = 'Application Cost Needed';
            DataClassification = CustomerContent;
        }
        field(13; "Registration Cost Needed"; Boolean)
        {
            Caption = 'Registration Cost Needed';
            DataClassification = CustomerContent;
        }
        field(14; "Admission Year"; Code[10])
        {
            Caption = 'Admission Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(15; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Business Posting Group";
        }
        field(16; "Customer Posting Group"; Code[10])
        {
            Caption = 'Customer Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Customer Posting Group";
        }
        field(17; "Student No."; Code[10])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(21; "Registration Batch Name"; Code[20])
        {
            Caption = 'Registration Batch Name';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
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
        field(24; "Evaluation No."; Code[20])
        {
            Caption = 'Evaluation No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(25; "Selection No."; Code[20])
        {
            Caption = 'Selection No.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(26; "Application Sale Method"; Option)
        {
            Caption = 'Application Sale Method';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Common,Classwise';
            OptionMembers = " ",Common,Classwise;
        }
        field(27; "Application Sales From"; Date)
        {
            Caption = 'Application Sales From';
            DataClassification = CustomerContent;
        }
        field(28; "Application Sales To"; Date)
        {
            Caption = 'Application Sales To';
            DataClassification = CustomerContent;
        }
        field(50174; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(50175; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
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
        //Get Auto assign "User Id" Values ::CSPL-00114::15052019: Start
        "User ID" := FORMAT(UserId());
        //Get Auto assign "User Id" Values ::CSPL-00114::15052019: End
    end;
}

