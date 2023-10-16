table 50019 "Discipline Level-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID       Date          Trigger                 Remarks
    // 1         CSPL-00092    03-05-2019    OnInsert                User Id Assign in User Id Field.

    Caption = 'Running Total Calculation Worksheet';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "SLcM No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(6; "First Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Last Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(9; Semester; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(10; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(11; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; "Field01"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(13; "Field02"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(14; "Field03"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(15; "Field04"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Field05"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(17; "Field06"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(18; "Field07"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(19; "Field08"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(20; "Field09"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(21; "Field10"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(22; "Field11"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(23; "Field12"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(24; "Field13"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(25; "Field14"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(26; "Field15"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(27; Total; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(28; "5216M2Q2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(29; "5216M2Q3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(30; "6326ICM3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(31; "6326M3CAS1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(32; "6326M3CAS2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33; "6326M3CAS3"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(34; "6426ICM4"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(35; "6426M4CAS1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(36; "6426M4CAS2"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(37; "6844CAS1"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(38; "6855CAS2"; Decimal)
        {
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
        key(Key1; "Code")
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
}

