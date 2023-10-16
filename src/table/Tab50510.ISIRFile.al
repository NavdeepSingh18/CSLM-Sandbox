table 50510 "ISIR File"
{
    Caption = 'ISIR File';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(2; StudentFirstName; Text[35])
        {
            Caption = 'Student First Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AccountName();
            end;
        }
        field(3; StudentLastName; Text[35])
        {
            Caption = 'Student Last Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AccountName();
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(5; StudentPersonalEmail; Text[50])
        {
            Caption = 'Personal Email Address';
            DataClassification = CustomerContent;
            ExtendedDataType = Email;
        }
        field(6; StudentDateOfBirth; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
        }
        field(7; StudentPermPhoneNbr; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = CustomerContent;
        }
        field(8; StudentPermMailAddress; Text[500])
        {
            Caption = 'Permanent Mail Address';
            DataClassification = CustomerContent;
        }
        field(9; StudentPermCity; Text[30])
        {
            Caption = 'Student Permanent City';
            DataClassification = CustomerContent;
            //  TableRelation = "Post Code".City;
        }
        field(10; StudentPermState; Code[20])
        {
            Caption = 'Student Permanent State';
            DataClassification = CustomerContent;
        }
        field(11; StudentPermZipCode; Code[20])
        {
            Caption = 'Student Permanent Zipcode';
            DataClassification = CustomerContent;
        }
        field(12; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
        }
        field(13; "Social Security No."; Code[9])
        {
            Caption = 'Social Security No.';
            DataClassification = CustomerContent;
        }
        field(14; "FAFSA Type"; Text[36])
        {
            Caption = 'FAFSA Type';
            DataClassification = CustomerContent;
        }
        field(15; "FAFSA ID"; Code[11])
        {
            Caption = 'FAFSA ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Duplicate Removed"; Boolean)
        {
            Caption = 'Duplicate Removed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Result Matched"; Boolean)
        {
            Caption = 'Result Matched';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; "Updated In SLcM"; Boolean)
        {
            Caption = 'Updated In SLcM';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; OrigNameId; Text[250])
        {
            Caption = 'Orignial Name ID';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; TransNbr; Text[250])
        {
            Caption = 'Transcation Number';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; StudentMiddleInitial; Text[35])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                AccountName();
            end;
        }
        field(24; StudentDriversLicNbr; Text[250])
        {
            Caption = 'Drivers License Number';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(25; StudentDriversLicState; Text[250])
        {
            Caption = 'Drivers License State';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; StudentCitizenshipStatus; Text[250])
        {
            Caption = 'Citizenship Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(27; StudentAlienRegNbr; Text[250])
        {
            Caption = 'Student Alien Reg Nbr';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(28; StudentMaritalStatus; Text[250])
        {
            Caption = 'Student Marital Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(29; StudentMaritalStatusDate; Text[20])
        {
            Caption = 'Student Marital Status Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; StudentStateLegalResidence; Text[250])
        {
            Caption = 'Student State Legal Residence';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; "Student LegalResident Before"; Text[250])
        {
            Caption = 'Student Legal Resident Before_1-1-2014';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; StudentLegalResidenceDate; Text[20])
        {
            Caption = 'Student Legal Residence Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; StudentGender; Text[250])
        {
            Caption = 'Student Gender';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; SelectiveServiceReg; Text[250])
        {
            Caption = 'Selective Service Reg';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(35; "Drug Con Affect Eligibility"; Text[250])
        {
            Caption = 'Drug Conviction Affect Eligibility';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(36; Parent1HighestGradeLvl; Text[250])
        {
            Caption = 'Parent1 Highest Grade Lvl';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(37; Parent2HighestGradeLvl; Text[250])
        {
            Caption = 'Parent2 Highest Grade Lvl';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(38; HSDiplomaOrEquivalent; Text[250])
        {
            Caption = 'HS Diploma Or Equivalent';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(39; HighSchoolName; Text[250])
        {
            Caption = 'High School Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(40; HighSchoolCity; Text[250])
        {
            Caption = 'High School City';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(41; HighSchoolState; Text[250])
        {
            Caption = 'High School State';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; HighSchoolCode; Text[250])
        {
            Caption = 'High School Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(43; Filler1; Text[1000])
        {
            Caption = 'Filler1';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(44; ISIRCode; Text[250])
        {
            Caption = 'ISIR Code';
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
    local procedure AccountName()
    begin
        TESTFIELD(StudentFirstName);
        CLEAR("Student Name");

        "Student Name" := StudentFirstName;
        IF (StudentLastName <> '') THEN
            "Student Name" := StudentFirstName + ' ' + StudentLastName;
    end;

}
