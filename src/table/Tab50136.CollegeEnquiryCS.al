table 50136 "College Enquiry-CS"
{
    // version V.001-CS

    Caption = 'College Enquiry-CS';
    DrillDownPageID = 50252;
    LookupPageID = 50252;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

        }
        field(2; "Enquiry Date"; Date)
        {
            Caption = 'Enquiry Date';
            DataClassification = CustomerContent;
        }
        field(3; "Enquiry Type"; Code[20])
        {
            Caption = 'Enquiry Type';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry Type-CS";
        }
        field(4; "Enquiry Source"; Code[20])
        {
            Caption = 'Enquiry Source';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry Source-CS";
        }
        field(5; "Name of the Media"; Code[20])
        {
            Caption = 'Name of the Media';
            DataClassification = CustomerContent;
            TableRelation = "Vehicle - CS";
        }
        field(6; "Enquirer Name"; Text[50])
        {
            Caption = 'Enquirer Name';
            DataClassification = CustomerContent;
        }
        field(7; "Applicant Relationship"; Text[50])
        {
            Caption = 'Applicant Relationship';
            DataClassification = CustomerContent;
        }
        field(8; "Applicant Name"; Text[50])
        {
            Caption = 'Applicant Name';
            DataClassification = CustomerContent;
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var

            begin
            end;
        }
        field(10; "Father's Name"; Text[50])
        {
            Caption = 'Father''s Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mother's Name"; Text[50])
        {
            Caption = 'Mother''s Name';
            DataClassification = CustomerContent;
        }
        field(12; "Applicant Status"; Code[20])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(14; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
        }
        field(15; "University Interested"; Code[20])
        {
            Caption = 'University Interested';
            DataClassification = CustomerContent;
        }
        field(16; "Hostel Acommodation"; Boolean)
        {
            Caption = 'Hostel Acommodation';
            DataClassification = CustomerContent;
        }
        field(17; Prequalification; Code[20])
        {
            Caption = 'Prequalification';
            DataClassification = CustomerContent;
            TableRelation = "Not Sync Document-CS";
        }
        field(18; "Name of the Previous Institute"; Text[50])
        {
            Caption = 'Name of the Previous Institute';
            DataClassification = CustomerContent;
        }
        field(19; "Certification Authoriry"; Code[20])
        {
            Caption = 'Certification Authoriry';
            DataClassification = CustomerContent;
        }
        field(20; "Medium of Instruction"; Code[20])
        {
            Caption = 'Medium of Instruction';
            DataClassification = CustomerContent;
            TableRelation = "Medium of Instruction-CS";
        }
        field(21; "Address to"; Code[20])
        {
            Caption = 'Address to';
            DataClassification = CustomerContent;
            TableRelation = Relative;
        }
        field(22; Addressee; Text[50])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(23; "Address 1"; Text[50])
        {
            Caption = 'Address 1';
            DataClassification = CustomerContent;
        }
        field(24; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(25; City; Code[10])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(26; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            //   TableRelation = "Post Code".Code;
        }
        field(27; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(28; "E-Mail Address"; Text[80])
        {
            Caption = 'E-Mail  Address';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(29; "Mobile Number"; Text[13])
        {
            Caption = 'Mobile Number';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(30; "Phone Number"; Text[13])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(31; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(32; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            //TableRelation = State.Code; chandrabhan
        }
        field(33; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(34; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(35; "Converted to Application"; Boolean)
        {
            Caption = 'Converted to Application';
            DataClassification = CustomerContent;
        }
        field(89; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(90; Months; Integer)
        {
            Caption = 'Months';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(102; "College Interested"; Code[20])
        {
            Caption = 'College Interested';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(103; Category; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Category Master-CS";
        }
        field(104; Religion; Code[20])
        {
            Caption = 'Religion';
            DataClassification = CustomerContent;
            TableRelation = "Religion Master-CS";
        }
        field(105; "Sub Religion"; Option)
        {
            Caption = 'Sub Religion';
            DataClassification = CustomerContent;
            OptionCaption = ' ,SHWETAMBAR,DIGAMBAR';
            OptionMembers = " ",SHWETAMBAR,DIGAMBAR;
        }
        field(106; "Remarks/Feedback"; Text[80])
        {
            Caption = 'Remarks/Feedback';
            DataClassification = CustomerContent;
        }
        field(107; "Fee Type"; Option)
        {
            Caption = 'Fee Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Paid,Unpaid';
            OptionMembers = " ",Paid,Unpaid;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50015; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            OptionCaption = ' ,Paid,Unpaid';
            OptionMembers = " ",Paid,Unpaid;
        }
        field(50016; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            TableRelation = "Year Master-CS";
        }
        field(50017; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50018; "Course Name"; Text[100])
        {
            Caption = 'Course Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048922; OTP; Code[10])
        {
            Caption = 'OTP';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048923; "Phone Enquiry"; Boolean)
        {
            Caption = 'Phone Enquiry';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048924; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048925; District; Text[50])
        {
            Caption = 'District';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
        }
        field(33048926; Graduation; Code[20])
        {
            Caption = 'Graduation';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            TableRelation = "Graduation Master-CS";
        }
        field(33048927; Department; Code[20])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(33048928; Nationality; Code[10])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18072019';
            TableRelation = "Citizenship Master-CS";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", "Academic Year")
        {
        }
        key(Key3; "Father's Name")
        {
        }
        key(Key4; "Applicant Name")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Applicant Name", "Father's Name")
        {
        }
    }

    var

}

