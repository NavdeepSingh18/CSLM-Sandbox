table 50496 "Residency Placement Result"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

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
            Caption = 'Preferred Email Address';
            DataClassification = CustomerContent;
        }
        field(6; "Preferred Phone Number"; Text[30])
        {
            Caption = 'Preferred Phone Number';
            DataClassification = CustomerContent;
        }
        field(7; "NRMP_ERAS "; Boolean)
        {
            Caption = 'NRMP_ERAS ';
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
            Caption = 'Other Description';
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
            OptionMembers = " ",Yes,No,"N/A";
        }
        field(37; "Withdraw NRMP Match"; Option)
        {
            Caption = 'Withdraw NRMP Match';
            DataClassification = CustomerContent;
            OptionMembers = " ",Yes,No,"N/A";
        }
        field(38; "Withdraw from CaRMS"; Option)
        {
            Caption = 'Withdraw from CaRMS';
            DataClassification = CustomerContent;
            OptionMembers = " ",Yes,No,"N/A";
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
            Caption = 'Withdrew Due To NE_Step2 CS';
            DataClassification = CustomerContent;
        }
        field(43; "Withdrew Due To NE_Step2 CK"; Boolean)
        {
            Caption = 'Withdrew Due To NE_Step2 CK';
            DataClassification = CustomerContent;
        }

        field(44; "With_Due To NE_Not Rec. Result"; Boolean)
        {
            Caption = 'Withdrew Due To NE_Not Received Result';
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
        field(56; "1st Program Speciality"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(57; "2nd Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(58; "2nd Program Speciality"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(59; "3rd Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(60; "3rd Program Speciality"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(61; "4th Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(62; "4th Program Speciality"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(63; "5th Program Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(64; "5th Program Speciality"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(65; "No. of Programs Ranked"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(66; "Resources Used While Applying"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(67; "Utilize the advisory services"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(68; "Lessons Learned"; Text[500])
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

        field(74; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(75; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
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

        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();

        If xRec.Updated = Updated then
            Updated := true;
    end;



}