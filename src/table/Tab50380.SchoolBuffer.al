table 50380 "School Buffer"
{
    Caption = 'School Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SLcM School ID"; Code[20])
        {
            Caption = 'SLcM School ID';
            DataClassification = CustomerContent;
        }
        field(2; "18 Digit ID"; Text[18])
        {
            Caption = '18 Digit ID';
            DataClassification = CustomerContent;
        }
        field(4; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Alternate Email Address"; Text[50])
        {
            Caption = 'Alternate Email Address';
            DataClassification = CustomerContent;
        }

        field(5; "Account Person Type"; Option)
        {
            Caption = 'Account Person Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Applicant, Alumni, Advisor';
            OptionMembers = "",Applicant,Alumni,Advisor;
        }
        field(6; Advisor; Boolean)
        {
            Caption = 'Advisor';
            DataClassification = CustomerContent;
        }
        field(7; "Billing Address"; Text[300])
        {
            Caption = 'Billing Address';
            DataClassification = CustomerContent;
        }
        field(8; "Shipping Address"; Text[300])
        {
            Caption = 'Shipping Address';
            DataClassification = CustomerContent;
        }
        field(9; "Current GPA Scale"; Text[250])
        {
            Caption = 'Current GPA Scale';
            DataClassification = CustomerContent;
        }
        field(10; Phone; Text[30])
        {
            Caption = 'Phone';
            DataClassification = CustomerContent;
        }
        field(11; Website; Text[80])
        {
            Caption = 'Website';
            DataClassification = CustomerContent;
        }
        field(12; "City"; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(13; State; Code[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(14; Country; Code[10])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
        }
        field(15; "Zip Code"; Code[20])
        {
            Caption = 'Zip Code';
            DataClassification = CustomerContent;
        }
        field(17; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(20; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "SLcM School ID", "Line No.")
        {
            Clustered = true;
        }
    }

}
