table 50389 "Approval Details"
{
    Caption = 'Approval Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(6; "Approval Type"; Code[50])
        {
            Caption = 'Approval Type';
            DataClassification = CustomerContent;
        }
        field(7; "Student Remark"; Text[100])
        {
            Caption = 'Student Remark';
            DataClassification = CustomerContent;
        }
        field(8; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(9; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            OptionCaption = ' ,Approved,Rejected';
            OptionMembers = " ",Approved,Rejected;
            DataClassification = CustomerContent;
        }
        field(10; "Approved By"; Text[100])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        field(11; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
        }
        field(12; "Reject Remark"; Text[100])
        {
            Caption = 'Reject Remark';
            DataClassification = CustomerContent;
        }
        field(13; "Course"; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
        }
        field(14; "Registration No."; Code[20])
        {
            Caption = 'Registration No.';
            DataClassification = CustomerContent;
        }
        field(15; "Withdrawal No."; Code[20])
        {
            Caption = 'Withdrawal No.';
            DataClassification = CustomerContent;
        }
        field(16; "Roll No"; Integer)
        {
            Caption = 'Roll No';
            DataClassification = CustomerContent;
        }
        field(17; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
        }
        field(18; "Rank"; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
        }
        field(19; "Category"; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }
        field(20; "Parent Name"; Text[100])
        {
            Caption = 'Parent Name';
            DataClassification = CustomerContent;
        }
        field(21; "Contact Address"; Text[250])
        {
            Caption = 'Contact Adddress';
            DataClassification = CustomerContent;
        }
        field(22; "STD Code"; Code[10])
        {
            Caption = 'STD Code';
            DataClassification = CustomerContent;
        }
        field(23; "Telephone Number"; Text[30])
        {
            Caption = 'Telephone Number';
            DataClassification = CustomerContent;
        }
        field(24; "Mobile Number"; text[30])
        {
            Caption = 'Mobile Number';
            DataClassification = CustomerContent;
        }
        field(25; "Email Address"; Text[50])
        {
            Caption = 'Email Address';
            DataClassification = CustomerContent;
        }
        field(26; "Bank Account Holder Name"; Text[100])
        {
            Caption = 'Bank Account Holder Name';
            DataClassification = CustomerContent;
        }
        field(27; "Bank Account No."; Text[50])
        {
            Caption = 'Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(28; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(29; "IFSC Code Number"; Text[50])
        {
            Caption = 'IFSC Code Number';
            DataClassification = CustomerContent;
        }
        field(30; "Bank Address"; Text[200])
        {
            Caption = 'Bank Address';
            DataClassification = CustomerContent;
        }
        field(31; "Relationship to the Candidate"; Text[50])
        {
            Caption = 'Relationship to the Candidate';
            DataClassification = CustomerContent;
        }
        field(32; "Other Detail"; Text[50])
        {
            Caption = 'Other Detail';
            DataClassification = CustomerContent;
        }
        field(33; "Name of Remitter"; Text[50])
        {
            Caption = 'Name of Remitter';
            DataClassification = CustomerContent;
        }
        field(34; "Address of the Remitter"; Text[200])
        {
            Caption = 'Address of the Remitter';
            DataClassification = CustomerContent;
        }
        field(35; "Remitter Bank Account Number"; Code[50])
        {
            Caption = 'Remitter Bank Account Number';
            DataClassification = CustomerContent;
        }
        field(36; "Bank Swift Code"; Code[50])
        {
            Caption = 'Bank Swift Code';
            DataClassification = CustomerContent;
        }
        field(37; "Remitter Bank Address"; Text[200])
        {
            Caption = 'Remitter Bank Address';
            DataClassification = CustomerContent;
        }

        field(38; "Intermediary Bank Name"; Code[50])
        {
            Caption = 'Intermediary Bank Name';
            DataClassification = CustomerContent;
        }
        field(39; "Intermediary Bank Account No."; Code[50])
        {
            Caption = 'Intermediary Bank Account No.';
            DataClassification = CustomerContent;
        }
        field(40; "Intermediary Bank Swift Code"; Code[50])
        {
            Caption = 'Intermediary Bank Swift Code';
            DataClassification = CustomerContent;
        }
        field(41; "Intermediary Other Detail"; Code[50])
        {
            Caption = 'Intermediary Other Detail';
            DataClassification = CustomerContent;
        }
        field(42; "Remitter Bank Name"; text[100])
        {
            Caption = 'Remitter Bank Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Student No.")
        {
            Clustered = true;
        }
    }

}
