table 50546 "Residency Placement Result New"
{
    DataClassification = CustomerContent;
    // DrillDownPageId = "Residency Plac. Result List";
    // LookupPageId = "Residency Plac. Result List";

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            Editable = false;

            trigger OnValidate()
            Var
                StudentMasterCS: Record "Student Master-CS";
            begin
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name";
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; "Preferred Email Address"; Text[100])
        {
            Editable = false;
            Caption = 'Preferred Email Address';
            DataClassification = CustomerContent;
        }
        field(6; "Preferred Phone Number"; Text[30])
        {
            Editable = false;
            Caption = 'Preferred Phone Number';
            DataClassification = CustomerContent;
        }
        field(7; "NRMP_ERAS"; Boolean)
        {
            // Caption = 'NRMP_ERAS';
            Caption = 'The NRMP/ERAS Match';
            DataClassification = CustomerContent;
        }
        field(8; CaRMS; Boolean)
        {
            Caption = 'CaRMS';
            DataClassification = CustomerContent;
        }
        field(9; Other; Boolean)
        {
            Caption = 'Other';
            DataClassification = CustomerContent;
        }
        field(10; "Other Description"; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; Neither; Boolean)
        {
            Caption = 'Neither';
            DataClassification = CustomerContent;
        }
        field(12; "Secure Position"; Boolean)
        {
            Caption = 'Secure Position';
            DataClassification = CustomerContent;
        }
        field(13; "Secure Position Term"; Boolean)
        {
            Caption = 'Secure Position Term';
            DataClassification = CustomerContent;
        }
        field(14; "Secure Position Academic Year"; Code[20])
        {
            Caption = 'Secure Position Academic Year';
            DataClassification = CustomerContent;
        }
        field(15; "Placement Type_vacant position"; Boolean)
        {
            Caption = 'Placement Type_vacant position';
            DataClassification = CustomerContent;
        }
        field(16; "Plac. Type_ERAS_NRMP_Match_Day"; Boolean)
        {
            Caption = 'Placement Type_ERAS_NRMP_Match_Day';
            DataClassification = CustomerContent;
        }
        field(17; "Placement Type_NRMP_SOAP"; Boolean)
        {
            Caption = 'Placement Type_NRMP_SOAP';
            DataClassification = CustomerContent;
        }
        field(18; "Placement Type_After_SOAP"; Boolean)
        {
            Caption = 'Placement Type_After_SOAP';
            DataClassification = CustomerContent;
        }
        field(19; "Placement Type_Outside_Match"; Boolean)
        {
            Caption = 'Placement Type_Outside_Match';
            DataClassification = CustomerContent;
        }
        field(20; "Plac. Type_CarMS_1_Iteration"; Boolean)
        {
            Caption = 'Placement Type_CarMS_1_Iteration';
            DataClassification = CustomerContent;
        }
        field(21; "Plac. Type_CarMS_2_Iteration"; Boolean)
        {
            Caption = 'Placement Type_CarMS_2_Iteration';
            DataClassification = CustomerContent;
        }
        field(22; "Placement Type_Other"; Boolean)
        {
            Caption = 'Placement Type_Other';
            DataClassification = CustomerContent;
        }
        field(23; "Secured Position"; Option)
        {
            Caption = 'Secured Position';
            DataClassification = CustomerContent;
            OptionMembers = " ","First Choice","Second Choice","Third Choice",Other;
        }
        field(24; "Section Postion Other Desc"; Text[100])
        {
            Caption = 'Section Postion Other Description';
            DataClassification = CustomerContent;
        }
        field(25; "Preliminary Program"; Boolean)
        {
            Caption = 'Preliminary Program';
            DataClassification = CustomerContent;
        }
        field(26; "Categorical Program"; Boolean)
        {
            Caption = 'Categorical Program';
            DataClassification = CustomerContent;
        }
        field(27; "Advanced Program"; Boolean)
        {
            Caption = 'Advanced Program';
            DataClassification = CustomerContent;
        }
        field(28; "Program Name"; Text[100])
        {
            Caption = 'Program Name';
            DataClassification = CustomerContent;
        }
        field(29; "Hospital Name"; Text[100])
        {
            Caption = 'Hospital Name';
            DataClassification = CustomerContent;
        }
        field(30; "ACGME Program ID"; Text[50])
        {
            Caption = 'ACGME Program ID';
            DataClassification = CustomerContent;
        }
        field(31; Specialty; Text[100])
        {
            Caption = 'Specialty';
            DataClassification = CustomerContent;
        }
        field(32; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(33; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            TableRelation = "State SLcM CS";
        }
        field(34; "Start Date"; date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(35; "End Date"; date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(36; "Participate NRMP SOAP"; Option)
        {
            Caption = 'Participate NRMP SOAP';
            DataClassification = CustomerContent;
            OptionMembers = Yes,No,"N/A";
        }
        field(37; "Withdraw NRMP Match"; Option)
        {
            Caption = 'Withdraw NRMP Match';
            DataClassification = CustomerContent;
            OptionMembers = Yes,No,"N/A";
        }
        field(38; "Withdraw from CaRMS"; Option)
        {
            Caption = 'Withdraw from CaRMS';
            DataClassification = CustomerContent;
            OptionMembers = Yes,No,"N/A";
        }
        field(39; "With_Due To Graduation Delayed"; Boolean)
        {
            Caption = 'Withdrew Due To Graduation Delayed';
            DataClassification = CustomerContent;
        }
        field(40; "Withd_Due To Personal Reason"; Boolean)
        {
            Caption = 'Withdrew Due To Personal Reason';
            DataClassification = CustomerContent;
        }
        field(41; "With_Due To NRMP Not Eligible"; Boolean)
        {
            Caption = 'Withdrew Due To NRMP Not Eligible';
            DataClassification = CustomerContent;
        }

        field(42; "Withdrew Due To NE_Step2 CS"; Boolean)
        {
            Caption = 'Step2 CS';
            DataClassification = CustomerContent;
        }
        field(43; "Withdrew Due To NE_Step2 CK"; Boolean)
        {
            Caption = 'Step2 CK';
            DataClassification = CustomerContent;
        }

        field(44; "With_Due To NE_Not Rec. Result"; Boolean)
        {
            Caption = 'I did not receive exam result in time';
            DataClassification = CustomerContent;
        }

        field(45; "With_Due To CaRMS Not Eligible"; Boolean)
        {
            Caption = 'Withdrew Due To CaRMS Not Eligible';
            DataClassification = CustomerContent;
        }
        field(46; "Withdrew Due To Other"; Boolean)
        {
            Caption = 'Withdrew Due To Other';
            DataClassification = CustomerContent;
        }
        field(47; "Healthcare Position"; Text[50])
        {
            Caption = 'Healthcare Position';
            DataClassification = CustomerContent;
        }
        field(48; "Position Institution"; Text[100])
        {
            Caption = 'Position Institution';
            DataClassification = CustomerContent;
        }
        field(49; "Position Department"; Text[50])
        {
            Caption = 'Position Department';
            DataClassification = CustomerContent;
        }
        field(50; "Position City"; Text[30])
        {
            Caption = 'Position City';
            DataClassification = CustomerContent;
        }
        field(51; "Position State"; Code[20])
        {
            Caption = 'Position State';
            DataClassification = CustomerContent;
        }
        field(52; "Position Start Date"; Date)
        {
            Caption = 'Position Start Date';
            DataClassification = CustomerContent;
        }
        field(53; "Position Projective End Date"; Date)
        {
            Caption = 'Position Projective End Date';
            DataClassification = CustomerContent;
        }
        field(54; "Did Not Submit Rank Order List"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(55; "1st Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(56; "1st Program Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(57; "2nd Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(58; "2nd Program Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(59; "3rd Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60; "3rd Program Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(61; "4th Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(62; "4th Program Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(63; "5th Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(64; "5th Program Specialty"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(65; "No. of Programs Ranked"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(66; "Resources Used While Applying"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(67; "Utilize the advisory services"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(68; "Lessons Learned"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(69; "Can contact to share info"; Boolean)
        {
            caption = 'Can contact to share information';
            DataClassification = CustomerContent;
        }
        field(70; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(71; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(73; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(74; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Entry From Portal"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Place Choice"; Option)
        {
            OptionCaption = 'First Choice,Second Choice,Third Choice,Other';
            OptionMembers = "First Choice","Second Choice","Third Choice","Other";
            DataClassification = ToBeClassified;
        }

        Field(78; "Fam. Medi. ERAS Prgm Applied"; Boolean)
        {
            Caption = 'Family Medicine ERAS Program Applied';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(79; "Fam. Medi. CaRMS Prgm. Applied"; Boolean)
        {
            Caption = 'Family Medicine CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(80; "Fam. Medi. ERAS intws Offered"; Boolean)
        {
            Caption = 'Family Medicine ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(81; "Fam. Med. CaRMS Intws. Offered"; Boolean)
        {
            Caption = 'Family Medicine CaRMS Interviews Offered';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(82; "Fam. Medi. ERAS intws. Atnded."; Boolean)
        {
            Caption = 'Family Medicine ERAS Interviews Attended';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(83; "Fam. Med. CaRMS Intws. Atnded."; Boolean)
        {
            Caption = 'Family Medicine CaRMS Interviews Attended';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(84; "Fam. Med. ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Family Medicine ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(85; "Fam. Med. CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Family Medicine CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(86; "Int. Med. ERAS Prgm. Appld."; Boolean)
        {
            Caption = 'Internal Medicine ERAS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(87; "Int. Med. CaRMS Prgm. Appld."; Boolean)
        {
            Caption = 'Internal Medicine CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(88; "Int. Med. ERAS Inws. Offrd."; Boolean)
        {
            Caption = 'Internal Medicine ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(89; "Int. Med. CaRMS Inws. Offrd."; Boolean)
        {
            Caption = 'Internal Medicine CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(90; "Int. Med. ERAS Int. Attended"; Boolean)
        {
            Caption = 'Internal Medicine ERAS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(91; "Int. Med. CaRMS Int. Attended"; Boolean)
        {
            Caption = 'Internal Medicine CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(92; "Int. Med. ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Internal Medicine ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(93; "Int. Med. CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Internal Medicine CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(94; "OB GYN ERAS Prgm. Appld."; Boolean)
        {
            Caption = 'OB/GYN ERAS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(95; "OB GYN CaRMS Prgm. Appld."; Boolean)
        {
            Caption = 'OB/GYN CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(96; "OB GYN ERAS Inws. Offrd."; Boolean)
        {
            Caption = 'OB/GYN ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(97; "OB GYN CaRMS Inws. Offrd."; Boolean)
        {
            Caption = 'OB/GYN CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(98; "OB GYN ERAS Int. Attended"; Boolean)
        {
            Caption = 'OB/GYN ERAS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(99; "OB GYN CaRMS Int. Attended"; Boolean)
        {
            Caption = 'OB/GYN CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(100; "OB GYN ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'OB/GYN ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(101; "OB GYN CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'OB/GYN CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(102; "Pediatrics ERAS Prgm. Appld."; Boolean)
        {
            Caption = 'Pediatrics ERAS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(103; "Pediatrics CaRMS Prgm. Appld."; Boolean)
        {
            Caption = 'Pediatrics CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(104; "Pediatrics ERAS Inws. Offrd."; Boolean)
        {
            Caption = 'Pediatrics ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(105; "Pediatrics CaRMS Inws. Offrd."; Boolean)
        {
            Caption = 'Pediatrics CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(106; "Pediatrics ERAS Int. Attended"; Boolean)
        {
            Caption = 'Pediatrics ERAS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(107; "Pediatrics CaRMS Int. Attended"; Boolean)
        {
            Caption = 'Pediatrics CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(108; "Pediatrics ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Pediatrics ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(109; "Pediatrics CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Pediatrics CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(110; "Psychiatry ERAS Prgm. Appld."; Boolean)
        {
            Caption = 'Psychiatry ERAS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(111; "Psychiatry CaRMS Prgm. Appld."; Boolean)
        {
            Caption = 'Psychiatry CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(112; "Psychiatry ERAS Inws. Offrd."; Boolean)
        {
            Caption = 'Psychiatry ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(113; "Psychiatry CaRMS Inws. Offrd."; Boolean)
        {
            Caption = 'Psychiatry CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(114; "Psychiatry ERAS Int. Attended"; Boolean)
        {
            Caption = 'Psychiatry ERAS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(115; "Psychiatry CaRMS Int. Attended"; Boolean)
        {
            Caption = 'Psychiatry CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(116; "Psychiatry ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Psychiatry ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(117; "Psychiatry CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Psychiatry CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(118; "Surgery ERAS Prgm. Appld."; Boolean)
        {
            Caption = 'Surgery ERAS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(119; "Surgery CaRMS Prgm. Appld."; Boolean)
        {
            Caption = 'Surgery CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(120; "Surgery ERAS Inws. Offrd."; Boolean)
        {
            Caption = 'Surgery ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(121; "Surgery CaRMS Inws. Offrd."; Boolean)
        {
            Caption = 'Surgery CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(122; "Surgery ERAS Int. Attended"; Boolean)
        {
            Caption = 'Surgery ERAS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(123; "Surgery CaRMS Int. Attended"; Boolean)
        {
            Caption = 'Surgery CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(124; "Surgery ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Surgery ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(125; "Surgery CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Surgery CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(126; "Other ERAS Prgm. Appld."; Boolean)
        {
            Caption = 'Other ERAS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(127; "Other CaRMS Prgm. Appld."; Boolean)
        {
            Caption = 'Other CaRMS Program Applied';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(128; "Other ERAS Inws. Offrd."; Boolean)
        {
            Caption = 'Other ERAS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(129; "Other CaRMS Inws. Offrd."; Boolean)
        {
            Caption = 'Other CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(130; "Other ERAS Int. Attended"; Boolean)
        {
            Caption = 'Other ERAS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(131; "Other CaRMS Int. Attended"; Boolean)
        {
            Caption = 'Other CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(132; "Other ERAS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Other ERAS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        Field(133; "Other CaRMS Prgm. Rnkd."; Boolean)
        {
            Caption = 'Other CaRMS Program Ranked';
            DataClassification = CustomerContent;
            Description = 'Not in used';
            ObsoleteState = Pending;
        }
        field(134; "Other Choice Desci."; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        Field(135; "Fam. Medic. ERAS Prgm Applied"; Integer)
        {
            Caption = 'Family Medicine ERAS Program Applied';
            DataClassification = CustomerContent;
        }
        field(136; "Fam. Medi. CaRMS Prg. Applied"; Integer)
        {
            Caption = 'Family Medicine CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(137; "Fam. Medi. ERAS intw Offered"; Integer)
        {
            Caption = 'Family Medicine ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        Field(138; "Fam. Med. CaRMS Intw. Offered"; Integer)
        {
            Caption = 'Family Medicine CaRMS Interviews Offered';
            DataClassification = CustomerContent;
        }
        Field(139; "Fam. Medi. ERAS intw. Atnded."; Integer)
        {
            Caption = 'Family Medicine ERAS Interviews Attended';
            DataClassification = CustomerContent;
        }
        Field(140; "Fam. Med. CaRMS Intw. Atnded."; Integer)
        {
            Caption = 'Family Medicine CaRMS Interviews Attended';
            DataClassification = CustomerContent;
        }
        Field(141; "Fam. Med. ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'Family Medicine ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(142; "Fam. Med. CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'Family Medicine CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
        field(143; "Int. Med. ERAS Prg. Appld."; Integer)
        {
            Caption = 'Internal Medicine ERAS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(144; "Int. Med. CaRMS Prg. Appld."; Integer)
        {
            Caption = 'Internal Medicine CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(145; "Int. Med. ERAS Int. Offrd."; Integer)
        {
            Caption = 'Internal Medicine ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(146; "Int. Med. CaRMS Int. Offrd."; Integer)
        {
            Caption = 'Internal Medicine CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(147; "Int. Medi. ERAS Int. Attended"; Integer)
        {
            Caption = 'Internal Medicine ERAS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        field(148; "Int. Medi. CaRMS Int. Attended"; Integer)
        {
            Caption = 'Internal Medicine CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        Field(149; "Int. Med. ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'Internal Medicine ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(150; "Int. Med. CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'Internal Medicine CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
        field(151; "OB GYN ERAS Prg. Appld."; Integer)
        {
            Caption = 'OB/GYN ERAS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(152; "OB GYN CaRMS Prg. Appld."; integer)
        {
            Caption = 'OB/GYN CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(153; "OB GYN ERAS Int. Offrd."; Integer)
        {
            Caption = 'OB/GYN ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(154; "OB GYN CaRMS Int. Offrd."; integer
        )
        {
            Caption = 'OB/GYN CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(155; "OB GYN ERAS Inte. Attended"; Integer)
        {
            Caption = 'OB/GYN ERAS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        field(156; "OB GYN CaRMS Inte. Attended"; Integer)
        {
            Caption = 'OB/GYN CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        Field(157; "OB GYN ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'OB/GYN ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(158; "OB GYN CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'OB/GYN CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
        field(159; "Pediatrics ERAS Prg. Appld."; Integer)
        {
            Caption = 'Pediatrics ERAS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(160; "Pediatrics CaRMS Prg. Appld."; Integer)
        {
            Caption = 'Pediatrics CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(161; "Pediatrics ERAS Int. Offrd."; integer)
        {
            Caption = 'Pediatrics ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(162; "Pediatrics CaRMS Int. Offrd."; Integer)
        {
            Caption = 'Pediatrics CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(163; "Pediatrics ERAS Inte. Attended"; Integer)
        {
            Caption = 'Pediatrics ERAS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        field(164; "Pediatris CaRMS Inte. Attended"; Integer)
        {
            Caption = 'Pediatrics CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        Field(165; "Pediatrics ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'Pediatrics ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(166; "Pediatrics CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'Pediatrics CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
        field(167; "Psychiatry ERAS Prg. Appld."; Integer)
        {
            Caption = 'Psychiatry ERAS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(168; "Psychiatry CaRMS Prg. Appld."; Integer)
        {
            Caption = 'Psychiatry CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(169; "Psychiatry ERAS Int. Offrd."; Integer)
        {
            Caption = 'Psychiatry ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(170; "Psychiatry CaRMS Int. Offrd."; Integer)
        {
            Caption = 'Psychiatry CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(171; "Psychiatry ERAS Inte. Attended"; Integer)
        {
            Caption = 'Psychiatry ERAS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        field(172; "Psychitry CaRMS Int. Attended"; Integer)
        {
            Caption = 'Psychiatry CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        Field(173; "Psychitry ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'Psychiatry ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(174; "Psychitry CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'Psychiatry CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
        field(175; "Surgery ERAS Prg. Appld."; Integer)
        {
            Caption = 'Surgery ERAS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(176; "Surgery CaRMS Prg. Appld."; Integer)
        {
            Caption = 'Surgery CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(177; "Surgery ERAS Int. Offrd."; Integer)
        {
            Caption = 'Surgery ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(178; "Surgery CaRMS Int. Offrd."; Integer)
        {
            Caption = 'Surgery CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(179; "Surgery ERAS Inte. Attended"; integer)
        {
            Caption = 'Surgery ERAS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        field(180; "Surgery CaRMS Inte. Attended"; Integer)
        {
            Caption = 'Surgery CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        Field(181; "Surgery ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'Surgery ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(182; "Surgery CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'Surgery CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
        field(183; "Other ERAS Prg. Appld."; Integer)
        {
            Caption = 'Other ERAS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(184; "Other CaRMS Prg. Appld."; Integer)
        {
            Caption = 'Other CaRMS Program Applied';
            DataClassification = ToBeClassified;
        }
        field(185; "Other ERAS Int. Offrd."; Integer)
        {
            Caption = 'Other ERAS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(186; "Other CaRMS Int. Offrd."; Integer)
        {
            Caption = 'Other CaRMS Interviews Offered';
            DataClassification = ToBeClassified;
        }
        field(187; "Other ERAS Inte. Attended"; Integer)
        {
            Caption = 'Other ERAS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        field(188; "Other CaRMS Inte. Attended"; Integer)
        {
            Caption = 'Other CaRMS Interviews Attended';
            DataClassification = ToBeClassified;
        }
        Field(189; "Other ERAS Prg. Rnkd."; Integer)
        {
            Caption = 'Other ERAS Program Ranked';
            DataClassification = CustomerContent;
        }
        Field(190; "Other CaRMS Prg. Rnkd."; Integer)
        {
            Caption = 'Other CaRMS Program Ranked';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Application No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();

        usersetup.get(UserId());
        EduSetup.Reset();
        EduSetup.SetRange("Global Dimension 1 Code", '9000');
        if EduSetup.FindFirst() then begin
            EduSetup.TESTFIELD("Application No For Residency.");
            NoSeriesMngt.InitSeries(EduSetup."Application No For Residency.", xRec."No. Series", 0D, "Application No", Rec."No. Series");
        end;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
    end;

    var
        SelectNoSeriesAllow: Boolean;
        EduSetup: Record "Education Setup-CS";
        usersetup: Record "User Setup";
        NoSeriesRec: Record "No. Series";
        NoSeriesMngt: Codeunit NoSeriesManagement;

    //code for request no - No series +
    procedure AssistEdit("Residency Placement Result": Record "Residency Placement Result New"): Boolean
    var
        Rec_DocumentationReq: Record "Residency Placement Result New";
        NoSerMgnt: Codeunit NoSeriesManagement;
    begin
        with Rec_DocumentationReq do begin
            Copy(Rec);
            usersetup.Get(UserId());
            EduSetup.Reset();
            EduSetup.SetRange("Global Dimension 1 Code", '9000');
            if EduSetup.FindFirst() then begin
                EduSetup.TestField("Application No For Residency.");
                if NoSerMgnt.SelectSeries(EduSetup."Application No For Residency.", "Residency Placement Result"."No. Series", "No. Series") then begin
                    NoSerMgnt.SetSeries("Application No");
                    Rec := Rec_DocumentationReq;
                    exit(true);
                end;
            end;
        end;
    end;

    procedure TestNumSer()
    var
        Check: Boolean;
    begin
        EduSetup.Get();
        Check := false;
        if not Check then
            EduSetup.TestField("Application No For Residency.");
    end;

    procedure GetNoSeriesCode(): Code[20]
    var
        Check: Boolean;
        NoSeriesCode: Code[20];
    begin
        EduSetup.Get();
        Check := false;
        if Check then
            exit;
        NoSeriesCode := EduSetup."Application No For Residency.";
        exit(NoSeriesMngt.GetNoSeriesWithCheck(NoSeriesCode, selectNoSeriesAllow, "No. Series"))
    end;

    procedure InitInsert()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if not IsHandled then
            if "Application No" = '' then begin
                TestNumSer();
                NoSeriesMngt.InitSeries(GetNoSeriesCode(), xRec."No. Series", Today, "Application No", "No. Series");
            end;
        initRecord();
    end;

    procedure InitRecord()
    var
        IsHandled: Boolean;
    begin
        EduSetup.Get();
        IsHandled := false;
        if not IsHandled then
            NoSeriesMngt.SetDefaultSeries("No. Series", EduSetup."Application No For Residency.");
    end;
    //code for request no - No series -
}