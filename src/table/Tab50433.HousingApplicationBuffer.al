table 50433 "Housing Application Buffer"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Application Buffer';
    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
        }
        field(5; "With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'With Spouse';
        }
        field(6; "Housing Pref. 1"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 1';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
        }
        field(8; "Housing Pref. 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 2';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
        }
        field(10; "Housing Pref. 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 3';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
        }
        field(15; "Preference Remarks"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Preference Remarks';

        }

        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(34; "Room Category Pref.1"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Pref.1';
        }
        field(35; "Room Category Pref.2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Pref.2';
        }
        field(36; "Room Category Pref.3"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Pref.3';
        }
        field(37; "Housing Group Pref.1"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
        }
        field(38; "Housing Group Pref.2"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
        }
        field(39; "Housing Group Pref.3"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
        }

        field(60; "Room Mate Name Pref"; Text[50])
        {
            Caption = 'Apartment Mate Name Pref';
            DataClassification = CustomerContent;
        }
        field(61; "Room Mate Email Pref"; Text[80])
        {
            Caption = 'Apartment Mate Email Pref';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(62; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(63; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        Field(64; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(65; Semester; Code[20])
        {
            DataClassification = CustomerContent;
        }
        Field(66; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        Field(67; "Application Inserted Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(90; "Medical Condition"; Boolean)//GMCS//240523//FALL 2023 OLR Changes
        {
            DataClassification = CustomerContent;
        }
        field(91; Disability; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(92; "Traveling With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(93; "Travel Spouse & Child"; Boolean)
        {
            Caption = 'Traveling with spouse and children';
            DataClassification = CustomerContent;
        }
        field(94; "Travel Ser. Animal"; Boolean)
        {
            Caption = 'Traveling with Service Animal';
            DataClassification = CustomerContent;
        }
        field(95; Other; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(96; "Other Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(97; "Special Roommate Preference"; Text[1024])
        {
            DataClassification = CustomerContent;//GMCS//240523//FALL 2023 OLR Changes
        }
        field(60000; "Delete Application"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; "Student No.", "Application No.", "Line No.")
        {
            Clustered = true;
        }
    }
}