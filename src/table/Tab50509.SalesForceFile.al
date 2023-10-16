table 50509 "SalesForce File"
{
    Caption = 'SalesForce File';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "18 Digit ID"; Code[18])
        {
            Caption = '18 Digit ID';
            DataClassification = CustomerContent;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(3; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(4; "Account Name"; Text[100])
        {
            Caption = 'Account Name';
            DataClassification = CustomerContent;
        }
        field(5; "First Name"; Text[35])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                StudentName();
            end;
        }
        field(6; "Last Name"; Text[35])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                StudentName();
            end;
        }
        field(7; "Email Address"; Text[100])
        {
            Caption = 'Email Address';
            DataClassification = CustomerContent;
            ExtendedDataType = Email;
        }
        field(8; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
        }
        field(9; Citizenship; Text[100])
        {
            Caption = 'Citizenship';
            DataClassification = CustomerContent;
        }
        field(10; "Undergraduate GPA"; Decimal)
        {
            Caption = 'Undergraduate GPA';
            DataClassification = CustomerContent;
        }
        field(11; "Pre-Req GPA"; Decimal)
        {
            Caption = 'Pre-Req GPA';
            DataClassification = CustomerContent;
        }
        field(12; "Graduate GPA"; Decimal)
        {
            Caption = 'Graduate GPA';
            DataClassification = CustomerContent;
        }
        field(13; "High School GPA"; Decimal)
        {
            Caption = 'High School GPA';
            DataClassification = CustomerContent;
        }
        field(14; "Phone No"; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = CustomerContent;
        }
        field(15; "Global Dimension 1 Code"; Text[100])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(16; "Semester Type"; Text[30])
        {
            Caption = 'Semester Type';
        }
        field(17; Street; Text[250])
        {
            Caption = 'Street';
            DataClassification = CustomerContent;
        }
        field(18; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(19; State; Text[100])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(20; Postcode; Text[30])
        {
            Caption = 'Postcode';
            DataClassification = CustomerContent;
        }
        field(21; "Country Code"; Text[30])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
        }
        field(22; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(23; "Course Code"; Text[100])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(24; Semester; Text[30])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(25; "Decision Date"; Text[30])
        {
            Caption = 'Decision Date';
            DataClassification = CustomerContent;
        }
        field(26; Stage; Text[70])
        {
            Caption = 'Stage';
            DataClassification = CustomerContent;
        }
        field(27; "Enrollment Status"; Text[30])
        {
            Caption = 'Enrollment Status';
            DataClassification = CustomerContent;
        }
        field(28; "Last ADA Call By"; Code[70])
        {
            Caption = 'Last ADA Call By';
            DataClassification = CustomerContent;
        }
        field(29; "Last ADA Call Date"; Text[30])
        {
            Caption = 'Last ADA Call Date';
            DataClassification = CustomerContent;
        }
        field(30; "VP Appreciation Letter"; Text[100])
        {
            Caption = 'VP Appreciation Letter';
            DataClassification = CustomerContent;
        }
        field(31; "New Semester Type"; Text[30])
        {
            Caption = 'New Semester Type';
            DataClassification = CustomerContent;
        }
        field(32; "New Academic Year"; Text[30])
        {
            Caption = 'New Academic Year';
            DataClassification = CustomerContent;
        }
        field(33; "Anticipated Term"; Text[30])
        {
            Caption = 'Anticipated Term';
            DataClassification = CustomerContent;
        }
        field(34; "Admission Co-ordinator"; Text[100])
        {
            Caption = 'Admission Co-ordinator';
            DataClassification = CustomerContent;
        }
        field(35; "Special Program"; Text[100])
        {
            Caption = 'Special Program';
            DataClassification = CustomerContent;
        }

        field(36; "Application ID"; Code[20])
        {
            Caption = 'Application ID';
            DataClassification = CustomerContent;
        }
        field(37; "Application Sub-type"; Text[100])
        {
            Caption = 'Application Sub-type';
            DataClassification = CustomerContent;
        }
        field(38; "Application Type"; Text[100])
        {
            Caption = 'Application Type';
            DataClassification = CustomerContent;
        }
        field(39; "Deposit Paid Date"; Text[30])
        {
            Caption = 'Deposit Paid Date';
            DataClassification = CustomerContent;
        }
        field(40; "Housing Waiver"; text[100])
        {
            Caption = 'Housing Waiver';
            DataClassification = CustomerContent;
        }
        field(41; Housing; Text[100])
        {
            Caption = 'Housing';
            DataClassification = CustomerContent;
        }
        field(42; "Housing Deposit Date"; Text[30])
        {
            Caption = 'Housing Deposit Date';
            DataClassification = CustomerContent;
        }
        field(43; "Sub-Stage"; Text[100])
        {
            Caption = 'Sub-Stage';
            DataClassification = CustomerContent;
        }
        field(44; "Student Name"; Text[100])
        {
            Caption = 'Sub-Stage';
            DataClassification = CustomerContent;
        }
        field(45; "Uploaded On"; Date)
        {
            Caption = 'Uploaded On';
            DataClassification = CustomerContent;
        }
        Field(46; "18 Digit IDs"; Text[18])
        {
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(Key1; "18 Digit ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Uploaded On" := Today();
    end;

    local procedure StudentName()
    begin
        TESTFIELD("First Name");
        CLEAR("Student Name");

        "Student Name" := "First Name";

        IF ("Last Name" <> '') THEN
            "Student Name" := "First Name" + ' ' + "Last Name"
    end;

}
