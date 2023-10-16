table 50197 "Student Registration-CS"
{
    // version V.001-CS

    Caption = 'Student Registration-CS';

    fields
    {
        field(1; "Student No"; Code[20])
        {
            Caption = 'Student No';
            DataClassification = CustomerContent;
        }
        field(2; Course; Text[100])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
        }
        field(3; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(4; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(5; "Last Name"; Text[35])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
        }
        field(9; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
        }
        field(12; Year; Code[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(13; "Enrollment No"; Code[20])
        {
            Caption = 'Enrollment No';
            DataClassification = CustomerContent;
        }
        field(15; "Created By"; Text[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(16; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(17; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(18; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(19; "Student Status"; Option)
        {
            Caption = 'Student Status';
            OptionCaption = 'Active,Incative';
            OptionMembers = Active,Incative;
        }
        field(20; Title; Option)
        {
            Caption = 'Title';
            OptionCaption = ' ,Mr., Mrs., Miss, Ms.';
            OptionMembers = " ","Mr.","Mrs.","Miss","Ms.";
        }
        field(21; "First Name"; Text[35])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;

        }
        field(22; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;

        }
        field(23; "Maiden Name"; Text[80])
        {
            Caption = 'Maiden Name';
            DataClassification = CustomerContent;

        }
        field(24; "Alternate E-Mail Address"; Text[50])
        {
            Caption = 'Alternate E-Mail Address';
            DataClassification = CustomerContent;

        }
        field(25; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

        }
        field(26; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Female,Male,Not Specified';
            OptionMembers = " ",Female,Male,"Not Specified";
        }
        field(27; "Marital Status"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Single, Married, Separated, Divorced, Widowed';
            OptionMembers = " ",Single,Married,Separated,Divorced,Widowed;
            Caption = 'Marital Status';
            DataClassification = CustomerContent;
        }
        field(28; "Street Address"; Text[50])
        {
            Caption = 'Street Address';
            DataClassification = CustomerContent;

        }
        field(29; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(30; "Postal Code"; Code[20])
        {
            Caption = 'Postal Code';
            DataClassification = CustomerContent;
            // TableRelation = if ("Country Code" = const()) "Post Code"
            // else
            // if ("Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Country Code"));
        }
        field(31; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(32; State; Code[10])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(33; "Emergency Contact First Name"; Text[35])
        {
            Caption = 'Emergency Contact First Name';
            DataClassification = CustomerContent;
        }
        field(34; "Emergency Contact Last Name"; Text[30])
        {
            Caption = 'Emergency Contact First Name';
            DataClassification = CustomerContent;
        }
        field(35; "Emergency Contact E-Mail"; Text[50])
        {
            Caption = 'Emergency Contact E-Mail';
            DataClassification = CustomerContent;
        }
        field(36; "Emergency Contact Phone No."; Text[30])
        {
            Caption = 'Emergency Contact Phone No.';
            DataClassification = CustomerContent;
        }
        field(37; "Emergency Contact Address"; Text[100])
        {
            Caption = 'Emergency Contact Address';
            DataClassification = CustomerContent;
        }
        field(38; "Emergency Contact RelationShip"; Text[30])
        {
            Caption = 'Emergency Contact RelationShip';
            DataClassification = CustomerContent;
        }
        field(39; "Emergency Contact Phone No. 2"; Text[30])
        {
            Caption = 'Emergency Contact Alternate Phone No.';
            DataClassification = CustomerContent;
        }

        field(40; "Emergency Contact City"; Text[30])
        {
            Caption = 'Emergency Contact City"';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(41; "Emergency Contact Postal Code"; Code[20])
        {
            Caption = 'Emergency Contact Postal Code';
            DataClassification = CustomerContent;
            //SD-SN-03-Dec-2020 +
            // TableRelation = if ("Emergency Contact Country Code" = const()) "Post Code"
            // else
            // if ("Emergency Contact Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Emergency Contact Country Code"));
            //SD-SN-03-Dec-2020 -
        }
        field(42; "Emergency Contact Country Code"; Code[10])
        {
            Caption = 'Emergency Contact Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(43; "Emergency Contact State"; Code[10])
        {
            Caption = 'Emergency Contact State';
            DataClassification = CustomerContent;
        }
        field(44; "Local Emergency First Name"; Text[35])
        {
            Caption = 'Local Emergency First Name';
            DataClassification = CustomerContent;
        }
        field(45; "Local Emergency Last Name"; Text[35])
        {
            Caption = 'Local Emergency Last Name';
            DataClassification = CustomerContent;
        }
        field(46; "Local Emergency Street Address"; Text[50])
        {
            Caption = 'Local Emergency Street Address';
            DataClassification = CustomerContent;
        }
        field(47; "Local Emergency City"; Text[30])
        {
            Caption = 'Local Emergency City/Parish';
            DataClassification = CustomerContent;
        }
        field(48; "Local Emergency Phone No."; Text[30])
        {
            Caption = 'Local Emergency Phone No.';
            DataClassification = CustomerContent;
        }
        field(49; Remarks; Text[80])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50; Nationality; Text[80])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
        }
        // field(51; Citizen; Code[20])
        // {
        //     Caption = 'Citizen Visa Status';
        //     DataClassification = CustomerContent;
        // }
        field(51; Citizenship; Option)
        {
            Caption = 'Citizenship';
            OptionMembers = " ","Eligible Non Citizen","Non-Citizen","US Citizen",Unknown;

        }
        field(52; Ethnicity; Code[20])
        {
            Caption = 'Ethnicity';
            DataClassification = CustomerContent;
            TableRelation = Ethnicity;
        }
        field(53; "Bursar Agreement"; Boolean)
        {
            Caption = 'Bursar Agreement';
            DataClassification = CustomerContent;
        }
        field(54; "Registrar Agreement"; Boolean)
        {
            Caption = 'Registrar Agreement';
            DataClassification = CustomerContent;
        }
        field(55; "Title_IV Agreement"; Boolean)
        {
            Caption = 'Financial Aid (Title_IV) Agreement';
            DataClassification = CustomerContent;
        }
        field(56; "Residential Network Agreement"; Boolean)
        {
            Caption = 'Residential Networking Agreement';
            DataClassification = CustomerContent;
        }
        field(57; "Emergency Contact Check Agmt"; Boolean)
        {
            Caption = 'Emergency Contact Correct Agreement';
            DataClassification = CustomerContent;
        }
        field(65; "Pass Port No. 1"; Text[20])
        {
            Caption = 'Pass Port No. 1';
            DataClassification = CustomerContent;
        }
        field(66; "Pass Port Issued Date 1"; Date)
        {
            Caption = 'Pass Port Issued Date 1';
            DataClassification = CustomerContent;
        }
        field(67; "Pass Port Issued By 1"; Text[50])
        {
            Caption = 'Pass Port Issued By 1';
            DataClassification = CustomerContent;
        }

        field(68; "Pass Port Expiry Date 1"; Date)
        {
            Caption = 'Pass Port Exp Date 1';
            DataClassification = CustomerContent;
        }
        field(69; "Visa Issued Date"; Date)
        {
            Caption = 'VISA Issued Date';
            DataClassification = CustomerContent;
        }
        field(71; "Visa Expiry Date"; Date)
        {
            Caption = 'Visa Exp Date';
            DataClassification = CustomerContent;
        }
        field(72; "Visa Extension Date"; Date)
        {
            Caption = 'Visa Extension Date';
            DataClassification = CustomerContent;
        }
        field(70; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            DataClassification = CustomerContent;
        }
        field(73; "Immigration Application Date"; Date)
        {
            Caption = 'Immigration Application Date';
            DataClassification = CustomerContent;
        }
        field(64; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Registration,Immigration';
            OptionMembers = Registration,Immigration;
        }
        field(74; "Pass Port No. 2"; Text[20])
        {
            Caption = 'Pass Port No. 2';
            DataClassification = CustomerContent;
        }
        field(75; "Pass Port Issued Date 2"; Date)
        {
            Caption = 'Pass Port Issued Date 2';
            DataClassification = CustomerContent;
        }
        field(76; "Pass Port Issued By 2"; Text[50])
        {
            Caption = 'Pass Port Issued By 2';
            DataClassification = CustomerContent;
        }

        field(77; "Pass Port Expiry Date 2"; Date)
        {
            Caption = 'Pass Port Exp Date 2';
            DataClassification = CustomerContent;
        }
        field(78; "Pass Port No. 3"; Text[20])
        {
            Caption = 'Pass Port No. 3';
            DataClassification = CustomerContent;
        }
        field(79; "Pass Port Issued Date 3"; Date)
        {
            Caption = 'Pass Port Issued Date 3';
            DataClassification = CustomerContent;
        }
        field(80; "Pass Port Issued By 3"; Text[50])
        {
            Caption = 'Pass Port Issued By 3';
            DataClassification = CustomerContent;
        }

        field(81; "Pass Port Expiry Date 3"; Date)
        {
            Caption = 'Pass Port Exp Date';
            DataClassification = CustomerContent;
        }
        field(82; "Release Agreement"; Boolean)
        {
            Caption = 'Release Agreement';
            DataClassification = CustomerContent;
        }
        field(83; "Insurance Agreement"; Boolean)
        {
            Caption = 'Insurance Agreement';
            DataClassification = CustomerContent;
        }
        field(85; "Apply for Insurance"; Boolean)
        {
            Caption = 'Apply for Insurance';
            DataClassification = CustomerContent;
        }
        field(86; "Fathers Name"; Text[40])
        {
            Caption = 'Fathers Name';
            DataClassification = CustomerContent;
        }
        field(87; "Mothers Name"; Text[40])
        {
            Caption = 'Mothers Name';
            DataClassification = CustomerContent;
        }
        field(88; "Father Contact Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Father Contact No.';
            DataClassification = CustomerContent;
        }
        field(89; "Father Email ID"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            ExtendedDatatype = EMail;
            Caption = 'Father E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(90; "Mother Contact Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Mother Contact No.';
            DataClassification = CustomerContent;
        }
        field(91; "Mother Email ID"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            ExtendedDatatype = EMail;
            Caption = 'Mother E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(92; "Guardian Contact Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Guardian Contact Number';
            DataClassification = CustomerContent;
        }
        field(93; "Guardian Email ID"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            ExtendedDatatype = EMail;
            Caption = 'Guardian E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(94; "Guardian Name"; Text[40])
        {
            Caption = 'Guardian Name';
            DataClassification = CustomerContent;
        }

        field(101; "Stage Basic Information"; Boolean)
        {
            Caption = 'Basic Information';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(102; "Stage Housing"; Boolean)
        {
            Caption = 'Housing';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(103; "Stage FERPA"; Boolean)
        {
            Caption = 'FERPA';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(104; "Stage Media Release"; Boolean)
        {
            Caption = 'Media Release';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(105; "Stage Agreements"; Boolean)
        {
            Caption = 'Agreements';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(106; "Stage Financial Aid"; Boolean)
        {
            Caption = 'Financial Aid';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(107; "Stage Insurance"; Boolean)
        {
            Caption = 'Insurance';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(108; "Stage Bursar"; Boolean)
        {
            Caption = 'Bursar';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(109; "Stage Confirmation"; Boolean)
        {
            Caption = 'Confirmation';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(110; Term; Option)
        {
            Caption = 'Term';
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(111; "Stage Basic Info Date"; Date)
        {
            Caption = 'Basic Update Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(112; "Stage Basic Info Time"; Time)
        {
            Caption = 'Basic Update Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(113; "Stage Housing Date"; Date)
        {
            Caption = 'Housing Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(114; "Stage Housing Time"; Time)
        {
            Caption = 'Housing Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(115; "Stage FERPA Date"; Date)
        {
            Caption = 'FERPA Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(116; "Stage FERPA Time"; Time)
        {
            Caption = 'FERPA Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(117; "Stage Media Date"; Date)
        {
            Caption = 'Media Update Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(118; "Stage Media Time"; Time)
        {
            Caption = 'Media Update Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(119; "Stage Agreements Date"; Date)
        {
            Caption = 'Agreements Update Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(120; "Stage Agreements Time"; Time)
        {
            Caption = 'Agreements Update Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(121; "Stage Financial Aid Date"; Date)
        {
            Caption = 'Financial Aid Update Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(122; "Stage Financial Aid Time"; Time)
        {
            Caption = 'Financial Aid Update Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(123; "Stage Bursar Date"; Date)
        {
            Caption = 'Bursar Update Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(124; "Stage Bursar Time"; Time)
        {
            Caption = 'Bursar Update Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(125; "Stage Confirmation Date"; Date)
        {
            Caption = 'Confirmation Update Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(126; "Stage Confirmation Time"; Time)
        {
            Caption = 'Confirmation Update Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(127; "OLR Completed Date"; Date)
        {
            Caption = 'OLR Completed Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(128; "OLR Completed Time"; Time)
        {
            Caption = 'OLR Completed Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(129; "OLR Completed"; Boolean)
        {
            Caption = 'OLR Completed';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(130; "Stage Insurance Date"; Date)
        {
            Caption = 'Insurance Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(131; "Stage Insurance Time"; Time)
        {
            Caption = 'Insurance Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50121; "Social Security No."; Code[11])
        {
            Caption = 'Social Security No.';
            DataClassification = CustomerContent;
        }
        field(50122; "Student Passport Full Name"; Text[107])
        {
            Caption = 'Passport Full Name';
            DataClassification = CustomerContent;
        }
        //SD-SN-03-Dec-2020+
        field(50123; "Resident Address"; Text[250])
        {
            Caption = 'Resident Address';
            DataClassification = CustomerContent;
        }
        field(50124; "Resident Country"; Code[10])
        {
            Caption = 'Resident Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50125; "Resident State"; Code[10])
        {
            Caption = 'Resident State';
            DataClassification = CustomerContent;
        }
        field(50126; "Resident City"; Text[30])
        {
            Caption = 'Resident City';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(50127; "Resident Zip Code"; Code[20])
        {
            Caption = 'Resident Zip Code';
            DataClassification = CustomerContent;
            // TableRelation = if ("Resident Country" = const()) "Post Code"
            // else
            // if ("Resident Country" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Resident Country"));
        }
        field(50128; "Resident Plan"; Option)
        {
            OptionMembers = " ","From Antigua","From my home";
            Caption = 'Resident Plan';
            DataClassification = CustomerContent;

        }
        field(50129; "Media Release Sign-off"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50130; "Transport Cell"; Code[20])
        {
            Caption = 'Transport Cell';
            DataClassification = CustomerContent;
        }
        field(50131; "Transport Allot"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50132; "Immigration Expiration Date"; Date)
        {
            DataClassification = Customercontent;
            Editable = false;

        }
        field(50133; "Immigration Issuance Date"; Date)
        {
            DataClassification = Customercontent;
            Editable = false;

        }
        field(50134; "MOU Agreement"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        Field(50135; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50136; Updated; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50137; "Updated By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50138; "Updated On"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50139; "Address 2"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50140; "Address 3"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50141; "Lease Agreement"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50142; CitizenAntiguaBarbuda; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50143; "Title 4 Agreement Dummy"; Boolean)
        {
            Caption = 'Title_IV Agreement Dummy';
            DataClassification = CustomerContent;
        }
        field(50144; "Eligible Non Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50145; "US Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50146; "Antigua Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50147; "Indian Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(72010; "FERPA Release"; Option)
        {
            OptionMembers = " ",Accept,Decline;
        }



        //SD-SN-03-Dec-2020 - Feilds Added 
    }

    keys
    {
        // key(Key1; "Student No", "Line No.")
        // {
        // }
        key(Key1; "Student No", "Course Code", "Academic Year", Semester, Term)
        {
        }
    }

    fieldgroups
    {
    }
    Var

    Trigger OnInsert()
    begin
        Inserted := true;
        "Created By" := UserId();
        "Created On" := Today();
    end;

    trigger OnModify()
    begin
        Updated := true;
        "Updated By" := UserId();
        "Updated On" := Today();
    end;

    trigger OnRename()
    begin
        Updated := true;
        "Updated By" := UserId();
        "Updated On" := Today();
    end;

}

