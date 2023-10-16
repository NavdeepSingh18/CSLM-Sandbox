table 50381 "Student Buffer"
{
    Caption = 'Student Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(2; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
        }
        field(3; "18 Digit ID"; Text[18])
        {
            Caption = '18 Digit ID';
            DataClassification = CustomerContent;
        }
        field(4; "First Name"; Text[35])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
        }
        field(5; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
        }
        field(6; "Last Name"; Text[35])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(7; "Alternate Email Address"; Code[50])
        {
            Caption = 'Alternate Email Address';
            DataClassification = CustomerContent;
        }
        field(8; "Account Person Type"; Option)
        {
            Caption = 'Account Person Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Applicant, Alumni, Advisor';
            OptionMembers = Applicant,Alumni,Advisor;
        }
        field(9; "School Level"; Text[30])
        {
            Caption = 'School Level';
            DataClassification = CustomerContent;
        }
        field(10; "Country Code (Phone)"; Text[30])
        {
            Caption = 'Country Code (Phone)';
            DataClassification = CustomerContent;
        }
        field(11; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            DataClassification = CustomerContent;
        }
        // field(12; Citizenship; Code[20])
        // {
        //     Caption = 'Citizenship';
        //     DataClassification = CustomerContent;
        // }
        field(12; Citizenship; Option)
        {
            Caption = 'Citizenship';
            OptionCaption = ', Eligible Non Citizen, Non-Citizen, US Citizen, Unknown';
            OptionMembers = "","Eligible Non Citizen","Non-Citizen","US Citizen",Unknown;

        }
        field(13; Ethnicity; Code[20])
        {
            Caption = 'Ethnicity';
            DataClassification = CustomerContent;
            TableRelation = Ethnicity;
        }
        field(14; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Female,Male,Not Specified';
            OptionMembers = " ",Female,Male,"Not Specified";
        }
        field(15; "Graduate GPA"; Decimal)
        {
            Caption = 'Graduate GPA';
            DataClassification = CustomerContent;
        }
        field(16; "High School GPA"; Decimal)
        {
            Caption = 'High School GPA';
            DataClassification = CustomerContent;
        }
        field(17; "Phone No"; Text[30])
        {
            Caption = 'Phone No';
            DataClassification = CustomerContent;
        }
        field(18; "Name on Passport"; Text[107])
        {
            Caption = 'Name on Passport';
            DataClassification = CustomerContent;
        }
        field(19; "Other GPA"; Decimal)
        {
            Caption = 'Other GPA';
            DataClassification = CustomerContent;
        }
        field(20; "Other Lead Source"; Text[250])
        {
            Caption = 'Other Lead Source';
            DataClassification = CustomerContent;
        }
        field(21; "Passport Expiry Date"; Date)
        {
            Caption = 'Passport Expiry Date';
            DataClassification = CustomerContent;
        }
        field(22; "Passport Issued By"; Text[50])
        {
            Caption = 'Passport Issued By';
            DataClassification = CustomerContent;
        }
        field(23; "Passport Issued Date"; Date)
        {
            Caption = 'Passport Issued Date';
            DataClassification = CustomerContent;
        }
        field(24; "Passport No."; Text[20])
        {
            Caption = 'Passport No.';
            DataClassification = CustomerContent;
        }
        field(25; "Permanent U.S. Resident"; Boolean)
        {
            Caption = 'Permanent U.S. Resident';
            DataClassification = CustomerContent;
        }
        field(26; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
        }
        field(27; "E-mail"; Text[50])
        {
            Caption = 'E-mail';
            DataClassification = CustomerContent;
        }
        field(28; "Person Lead Source"; Text[50])
        {
            Caption = 'Person Lead Source';
            DataClassification = CustomerContent;
        }
        field(29; Address1; Text[50])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(30; Address2; Text[50])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(31; Address3; Text[50])
        {
            Caption = 'Address3';
            DataClassification = CustomerContent;
        }
        field(32; Address4; Text[50])
        {
            Caption = 'Address4';
            DataClassification = CustomerContent;
        }
        field(33; "Pre-Req GPA"; Decimal)
        {
            Caption = 'Pre-Req GPA';
            DataClassification = CustomerContent;
        }
        field(34; "Primary Lead Source"; Text[50])
        {
            Caption = 'Primary Lead Source';
            DataClassification = CustomerContent;
        }
        field(35; Skype; Text[250])
        {
            Caption = 'Skype';
            DataClassification = CustomerContent;
        }
        field(36; "Transfer GPA"; Decimal)
        {
            Caption = 'Transfer GPA';
            DataClassification = CustomerContent;
        }
        field(37; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            // TableRelation = "Post Code".City;
        }
        field(38; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(39; "FAFSA Received"; Boolean)
        {
            Caption = 'FAFSA Received';
            DataClassification = CustomerContent;
        }
        field(40; "Residency Hospital 1"; Text[250])
        {
            Caption = 'Residency Hospital 1';
            DataClassification = CustomerContent;
        }
        field(41; "Residency Hospital 2"; Text[250])
        {
            Caption = 'Residency Hospital 2';
            DataClassification = CustomerContent;
        }
        field(42; "Residency Status"; Text[250])
        {
            Caption = 'Residency Status';
            DataClassification = CustomerContent;
        }
        field(43; "Residency City"; Text[30])
        {
            Caption = 'Residency City';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(44; "Residency Specialty 1"; Text[250])
        {
            Caption = 'Residency Specialty 1';
            DataClassification = CustomerContent;
        }
        field(45; "Residency Specialty 2"; Text[250])
        {
            Caption = 'Residency Specialty 2';
            DataClassification = CustomerContent;
        }
        field(46; "Residency State"; Text[250])
        {
            Caption = 'Residency State';
            DataClassification = CustomerContent;
        }
        field(47; "Residency Year"; Text[250])
        {
            Caption = 'Residency Year';
            DataClassification = CustomerContent;
        }
        field(50; Postcode; Code[20])
        {
            Caption = 'Postcode';
            DataClassification = CustomerContent;
        }
        field(51; Nationality; Text[30])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
        }
        field(52; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(53; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
        }
        field(54; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(55; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(56; "Date Of Joining"; Date)
        {
            Caption = 'Date Of Joining';
            DataClassification = CustomerContent;
        }
        field(57; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(58; "Father Name"; Text[40])
        {
            Caption = 'Father Name';
            DataClassification = CustomerContent;
        }
        field(59; "Mother Name"; Text[40])
        {
            Caption = 'Mother Name';
            DataClassification = CustomerContent;
        }
        field(60; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(72; "Transport Required"; Boolean)
        {
            Caption = 'Transport Required';
            DataClassification = CustomerContent;
        }
        field(73; "Scholarship Code 1"; Code[20])
        {
            Caption = 'Scholarship Code';
            DataClassification = CustomerContent;
        }
        field(74; "Grant Code 1"; Code[20])
        {
            Caption = 'Grant Code 1';
            DataClassification = CustomerContent;
        }
        field(76; "Social Security No."; Code[11])
        {
            Caption = 'Social Security No.';
            DataClassification = CustomerContent;
        }
        // field(77; Status; Code[20])
        // {
        //     Caption = 'Status';
        //     DataClassification = CustomerContent;
        // }
        field(77; "Status"; Option)
        {
            Caption = 'Status';
            OptionCaption = ' ,ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,Re-Admitted,Re-Entry,SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD';
            OptionMembers = " ",ROL,Active,Probation,Declined,Deferred,Deposited,Dismissed,Enrolled,Promoted,Compeleted,Graduated,"Re-Admitted","Re-Entry",SLOA,ELOA,CLOA,Suspension,Withdrawn,Deceased,ADWD,TWD;
            DataClassification = CustomerContent;
        }
        field(79; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(80; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(81; "New Semester Type"; Text[6])
        {
            Caption = 'New Semester Type';
            DataClassification = CustomerContent;
        }
        field(82; "New Academic Year"; Code[10])
        {
            Caption = 'New Academic Year';
            DataClassification = CustomerContent;
        }
        field(83; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(84; "Grant Code 2"; Code[20])
        {
            Caption = 'Grant Code 2';
            DataClassification = CustomerContent;
        }
        field(85; "Grant Code 3"; Code[20])
        {
            Caption = 'Grant Code 3';
            DataClassification = CustomerContent;
        }
        field(86; "Parent Student No."; Code[20])
        {
            Caption = 'Parent Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No." where("Parent Student No." = filter(''));
        }
        //SD-SN-15-Dec-2020 +

        field(88; "Application ID"; Code[20])
        {
            Caption = 'Application ID';
            DataClassification = CustomerContent;
        }
        field(89; "Application Sub-type"; Text[50])
        {
            Caption = 'Application Sub-type';
            DataClassification = CustomerContent;
        }
        field(90; "Application Type"; Text[50])
        {
            Caption = 'Application Type';
            DataClassification = CustomerContent;
        }
        field(91; "Deposit Paid Date"; Date)
        {
            Caption = 'Deposit Paid Date';
            DataClassification = CustomerContent;
        }
        field(92; "Deposit Waived"; Boolean)
        {
            Caption = 'Deposit Waived';
            DataClassification = CustomerContent;
        }
        field(93; Housing; Option)
        {
            Caption = 'Housing';
            DataClassification = CustomerContent;
            OptionCaption = ' ,AUA Housing,Independent Housing';
            OptionMembers = " ","AUA Housing","Independent Housing";
        }
        field(94; "Housing/Waiver Application No."; Code[20])
        {
            Caption = 'Housing/Waiver Application No.';
            DataClassification = CustomerContent;
        }
        field(95; "Housing Deposit Waived"; Boolean)
        {
            Caption = 'Housing Deposit Waived';
            DataClassification = CustomerContent;
        }
        field(96; "Housing Deposit Date"; Date)
        {
            Caption = 'Housing Deposit Date';
            DataClassification = CustomerContent;
        }
        field(97; "Seat Deposit Paid"; Boolean)
        {
            Caption = 'Seat Deposit Paid';
            DataClassification = CustomerContent;
        }
        field(98; "Student Accepted Date"; Date)
        {
            Caption = 'Student Accepted Date';
            DataClassification = CustomerContent;
        }
        field(99; "Sub-Stage"; Text[50])
        {
            Caption = 'Sub-Stage';
            DataClassification = CustomerContent;
        }

        field(100; "Present Address 1"; Text[50])
        {
            Caption = 'Present Address 1';
            DataClassification = CustomerContent;
        }
        field(101; "Present Address 2"; Text[50])
        {
            Caption = 'Present Address 2';
            DataClassification = CustomerContent;
        }
        field(102; "Present Address 3"; Text[50])
        {
            Caption = 'Present Address 3';
            DataClassification = CustomerContent;
        }
        field(103; "Present City"; Text[30])
        {
            Caption = 'Present City';
            DataClassification = CustomerContent;
        }
        field(104; "Present Post Code"; Code[20])
        {
            Caption = 'Present Post Code';
            DataClassification = CustomerContent;
        }
        field(105; "Present State"; Code[20])
        {
            Caption = 'Present State';
            DataClassification = CustomerContent;
        }
        field(106; "Present Country"; Code[10])
        {
            Caption = 'Present Country';
            DataClassification = CustomerContent;
        }
        field(107; "Lease Agreement No."; Code[20])
        {
            Caption = 'Lease Agreement No.';
            DataClassification = CustomerContent;
        }
        field(108; "Lease Agreement Group"; Text[50])
        {
            Caption = 'Lease Agreement Group';
            DataClassification = CustomerContent;
        }

        field(110; "Transport Cell No."; code[20])
        {
            Caption = 'Transport Cell No.';
            DataClassification = CustomerContent;
        }
        field(111; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        field(112; "Student Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        //SD-SN-15-Dec-2020 -
        Field(113; "Housing Waiver Enable"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(114; "Flight Arrival Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        Field(115; "Flight Arrival Time"; Time)
        {
            DataClassification = CustomerContent;

        }
        Field(116; "Flight Number"; Text[20])
        {
            DataClassification = CustomerContent;

        }
        Field(117; "Airline/Carrier"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(118; "Departure Date from Antigua"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(119; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(120; "Admission Advisor"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee where(Department = filter(Verity));
        }
        field(121; "Eligible Non Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(122; "US Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(123; "Antigua Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(124; "Indian Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        // key(Key1; "Student No.", "Line No.")
        // {
        //     Clustered = true;
        // }
        key(Key1; "18 Digit ID", "Line No.")
        {
            Clustered = true;
        }
    }

}
