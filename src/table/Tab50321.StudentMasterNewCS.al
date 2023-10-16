table 50321 "Student Master New-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   15/05/2019       OnInsert()                                 Get "No Series" & "User Id" Values
    // 03    CSPL-00114   15/05/2019       No. - OnValidate()                         Get "No Series" Generation
    // 04    CSPL-00114   15/05/2019       Date Of Birth - OnValidate()               Code added for Date of Birth Value Calculate
    // 05    CSPL-00114   15/05/2019       Enquiry No. - OnValidate()                 Code For Validation
    // 06    CSPL-00114   15/05/2019       Distance Covered in KM - OnValidate()      Code added for Transport Fee
    // 07    CSPL-00114   15/05/2019       Assistedit - Function                      Get "No Series" Generation

    Caption = 'Student';


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Get "No Series" Generation::CSPL-00114::15052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    UserSetupRec.Get(UserId());
                    EducationSetupRec.Reset();
                    EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    EducationSetupRec.FindFirst();
                    NoSeriesMgt.TestManual(EducationSetupRec."Student No.");
                    "No. Series" := '';
                END;
                //Get "No Series" Generation::CSPL-00114::15052019: End
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var

            begin
            end;
        }
        field(3; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
        }
        field(9; "Date Of Birth"; Date)
        {
            Caption = 'Date Of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Date of Birth Value Calculate::CSPL-00114::15052019: Start
                IF "Date Of Birth" <> 0D THEN BEGIN
                    Age := TODAY() - "Date Of Birth";
                    TempAgeNew := ROUND(Age / 365, 1, '=');
                    AgeNew := Age MOD 365;
                    Months := ROUND(AgeNew / 30, 1, '=');
                    Age := TempAgeNew - 1;
                END ELSE BEGIN
                    CLEAR(Age);
                    CLEAR(Months);
                END;
                //Date of Birth Value Calculate::CSPL-00114::15052019: End
            end;
        }
        field(10; "Father's Name"; Text[100])
        {
            Caption = 'Father''s Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mother's Name"; Text[100])
        {
            Caption = 'Mother''s Name';
            DataClassification = CustomerContent;
        }
        field(12; Citizenship; Code[20])
        {
            Caption = 'Citizenship';
            DataClassification = CustomerContent;
            TableRelation = "Citizenship Master-CS";
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Student Master-CS";
        }
        field(15; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Hostel Acommodation"; Boolean)
        {
            Caption = 'Hostel Acommodation';
            DataClassification = CustomerContent;
        }
        field(17; "Previous School"; Text[100])
        {
            Caption = 'Previous School';
            DataClassification = CustomerContent;
        }
        field(18; "Medium of Instruction"; Code[10])
        {
            Caption = 'Medium of Instruction';
            DataClassification = CustomerContent;
            TableRelation = "Medium of Instruction-CS";
        }
        field(19; "Presently Residing with"; Code[10])
        {
            Caption = 'Presently Residing with';
            DataClassification = CustomerContent;
            TableRelation = Relative;
        }
        field(20; Curriculum; Code[10])
        {
            Caption = 'Curriculum';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(21; "Previous Class"; Code[10])
        {
            Caption = 'Previous Class';
            DataClassification = CustomerContent;
            TableRelation = "Class Master - CS";
        }
        field(22; "Previous Curriculum"; Code[10])
        {
            Caption = 'Previous Curriculum';
            DataClassification = CustomerContent;
        }
        field(23; "Address To"; Code[20])
        {
            Caption = 'Address To';
            DataClassification = CustomerContent;
            TableRelation = Relative;
        }
        field(24; Addressee; Text[100])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(25; Address1; Text[100])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(26; Address2; Text[100])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(27; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(28; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
          //  TableRelation = "Post Code";
        }
        field(29; Country; Code[20])
        {
            Caption = 'Country';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(30; "E-Mail Address"; Text[100])
        {
            Caption = 'E-Mail Address';
            DataClassification = CustomerContent;
        }
        field(31; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
            DataClassification = CustomerContent;
        }
        field(32; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
        }
        field(33; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
        }
        field(37; "Visa Exp Date"; Date)
        {
            Caption = 'Visa Exp Date';
            DataClassification = CustomerContent;
        }
        field(38; "Passport No."; Text[20])
        {
            Caption = 'Passport No.';
            DataClassification = CustomerContent;
        }
        field(39; "Passport Exp Date"; Date)
        {
            Caption = 'Passport Exp Date';
            DataClassification = CustomerContent;
        }
        field(40; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            DataClassification = CustomerContent;
        }
        field(49; "Food Habits"; Option)
        {
            Caption = 'Food Habits';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Veg,Non Veg';
            OptionMembers = " ",Veg,"Non Veg";
        }
        field(50; "Applicant Image"; BLOB)
        {
            Caption = 'Applicant Image';
            DataClassification = CustomerContent;
        }
        field(51; "Father Image"; BLOB)
        {
            Caption = 'Father Image';
            DataClassification = CustomerContent;
        }
        field(52; "Mother Image"; BLOB)
        {
            Caption = 'Mother Image';
            DataClassification = CustomerContent;
        }
        field(53; "Guardian Image"; BLOB)
        {
            Caption = 'Guardian Image';
            DataClassification = CustomerContent;
        }
        field(54; "Mother's Qualification"; Text[30])
        {
            Caption = 'Mother''s Qualification';
            DataClassification = CustomerContent;
        }
        field(55; "Mother's Occupation"; Text[30])
        {
            Caption = 'Mother''s Occupation';
            DataClassification = CustomerContent;
        }
        field(56; "Guardian Name"; Text[100])
        {
            Caption = 'Guardian Name';
            DataClassification = CustomerContent;
        }
        field(60; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
            DataClassification = CustomerContent;
        }
        field(70; "Father's Occupation"; Text[30])
        {
            Caption = 'Father''s Occupation';
            DataClassification = CustomerContent;
        }
        field(71; "Mother's Annual Income"; Decimal)
        {
            Caption = 'Mother''s Annual Income';
            DataClassification = CustomerContent;
        }
        field(72; "Guardian Qualification"; Text[30])
        {
            Caption = 'Guardian Qualification';
            DataClassification = CustomerContent;
        }
        field(73; "Guardian Occupation"; Text[30])
        {
            Caption = 'Guardian Occupation';
            DataClassification = CustomerContent;
        }
        field(74; "Guardian Annual Income"; Decimal)
        {
            Caption = 'Guardian Annual Income';
            DataClassification = CustomerContent;
        }
        field(76; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry-CS";

            trigger OnValidate()
            begin
                //Code added for validation::CSPL-00114::15052019: Start
                IF EnquiryCS.GET("Enquiry No.") THEN BEGIN
                    TRANSFERFIELDS(EnquiryCS);
                    VALIDATE("Date Of Birth");
                    VALIDATE(Class);
                    "No." := xRec."No.";
                END;
                //Code added for validation::CSPL-00114::15052019: End
            end;
        }
        field(77; Religion; Code[20])
        {
            Caption = 'Religion';
            DataClassification = CustomerContent;
            TableRelation = "Religion Master-CS";
        }
        field(78; "Father's Qualification"; Text[30])
        {
            Caption = 'Father''s Qualification';
            DataClassification = CustomerContent;
        }
        field(79; Caste; Code[20])
        {
            Caption = 'Caste';
            DataClassification = CustomerContent;
            TableRelation = "Caste Master-CS";
        }
        field(81; Age; Integer)
        {

            BlankZero = true;
            Caption = 'Age';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(82; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(96; "Father's Annual Income"; Decimal)
        {
            Caption = 'Father''s Annual Income';
            DataClassification = CustomerContent;
        }
        field(97; "Exam Code"; Code[10])
        {
            Caption = 'Exam Code';
            DataClassification = CustomerContent;
            TableRelation = "Exam Group Code-CS";
        }
        field(98; Community; Code[10])
        {
            Caption = 'Community';
            DataClassification = CustomerContent;
            TableRelation = "Community-CS";
        }
        field(99; "Mother Tongue"; Code[10])
        {
            Caption = 'Mother Tongue';
            DataClassification = CustomerContent;
            TableRelation = "Mother Tongue-CS";
        }
        field(100; "New Student"; Boolean)
        {
            Caption = 'New Student';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(1000; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Section Master-CS";
        }
        field(1001; "Student Status"; Option)
        {
            Caption = 'Student Status';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Student,Inactive,Alumni';
            OptionMembers = " ",Student,Inactive,Alumni;
        }
        field(1002; "Class Code"; Code[20])
        {
            Caption = 'Class Code';
            DataClassification = CustomerContent;
            TableRelation = "Class Section Master-CS";
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(2001; House; Code[20])
        {
            Caption = 'House';
            DataClassification = CustomerContent;
        }
        field(2002; Points; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Participant Line-CS".Points WHERE("Student No." = FIELD("No."),
                                                                  "Academic Year" = FIELD("Academic Year"),
                                                                  "Update Results" = FILTER(TRUE)));
            Caption = 'Points';
            Editable = false;

        }
        field(10001; "Fee Classification"; Code[10])
        {
            Caption = 'Fee Classification';
            DataClassification = CustomerContent;
            TableRelation = "Fee Classification Master-CS";
        }
        field(10002; Quota; Code[10])
        {
            Caption = 'Quota';
            DataClassification = CustomerContent;
            TableRelation = "Quota-CS";
        }
        field(10003; "Physically Challanged"; Boolean)
        {
            Caption = 'Physically Challanged';
            DataClassification = CustomerContent;
        }
        field(10004; "Staff Child"; Boolean)
        {
            Caption = 'Staff Child';
            DataClassification = CustomerContent;
        }
        field(10005; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(20000; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            TableRelation = "Application-CS";
        }
        field(20001; "Date Joined"; Date)
        {
            Caption = 'Date Joined';
            DataClassification = CustomerContent;
        }
        field(20002; "Room No."; Code[20])
        {
            Caption = 'Room No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20003; "Hostel Code"; Code[20])
        {
            Caption = 'Hostel Code';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20004; "Hostel Alloted"; Boolean)
        {
            Caption = 'Hostel Alloted';
            DataClassification = CustomerContent;
        }
        field(20005; "Hostel Vacated"; Boolean)
        {
            Caption = 'Hostel Vacated';
            DataClassification = CustomerContent;
        }
        field(20006; "Room Type"; Code[20])
        {
            Caption = 'Room Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20007; Mess; Code[20])
        {
            Caption = 'Mess';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20009; CGPA; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Average ("Main Student Subject-CS".Points WHERE("Student No." = FIELD("No."),
                                                                          Course = FIELD("Class Code")));
            Caption = 'CGPA';
            Editable = false;

        }
        field(20010; "CGPA Grade"; Code[10])
        {
            Caption = 'CGPA Grade';
            DataClassification = CustomerContent;
        }
        field(20011; "Latest Rank"; Integer)
        {
            Caption = 'Latest Rank';
            DataClassification = CustomerContent;
        }
        field(20012; "Latest GPA"; Decimal)
        {
            Caption = 'Latest GPA';
            DataClassification = CustomerContent;
        }
        field(20013; "Latest Grade"; Code[20])
        {
            Caption = 'Latest Grade';
            DataClassification = CustomerContent;
        }
        field(20014; "Student Image"; Text[100])
        {
            Caption = 'Student Image';
            DataClassification = CustomerContent;
        }
        field(30000; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(50011; Pickup; Text[30])
        {
            Caption = 'Pickup';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';

        }
        field(50012; Drop; Text[30])
        {
            Caption = 'Drop';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';

        }
        field(50013; "Distance Covered in KM"; Decimal)
        {
            Caption = 'Distance Covered in KM';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';

            trigger OnValidate()
            begin
                //Code added for Transport Fee::CSPL-00114::15052019: Start
                SlabTransportCS.Reset();
                SlabTransportCS.SETFILTER("Slab Start Distance in KM", '<=%1', "Distance Covered in KM");
                SlabTransportCS.SETFILTER("Slab End Distance in KM", '>=%1', "Distance Covered in KM");
                IF SlabTransportCS.FINDFIRST() THEN
                    "Transport Fee" := SlabTransportCS.Amount
                ELSE
                    "Transport Fee" := 0;
                //Code added for Transport Fee::CSPL-00114::15052019: End
            end;
        }
        field(50014; "Transport Fee"; Decimal)
        {
            Caption = 'Transport Fee';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(50015; "Approval Status"; Option)
        {
            Caption = 'Approval Status';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
            OptionCaption = 'Open, Approved, Pending Approval';
            OptionMembers = Open,Approved,"Pending Approval";
        }
        field(60000; Height; Decimal)
        {
            BlankZero = true;
            Caption = 'Height';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(60001; Weight; Decimal)
        {
            BlankZero = true;
            Caption = 'Weight';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(60002; Division; Code[20])
        {
            FieldClass = FlowField;
            Caption = 'Division';
            Description = 'CS Field Added 15052019';
            Editable = false;

        }
        field(60003; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(33048920; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
        }
        field(33048922; "Family Code"; Code[20])
        {
            Caption = 'Family Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 15052019';
            TableRelation = "Family ID-CS";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; Class, Curriculum, "Academic Year")
        {
        }
        key(Key3; Class, Section, Curriculum, "Academic Year")
        {
        }
        key(Key4; "Academic Year", "Student Status")
        {
        }
        key(Key5; House)
        {
        }
        key(Key6; "Class Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series" & "User Id" Values::CSPL-00114::15052019: Start
        UserSetupRec.Get(UserId());
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        IF "No. Series" = '' THEN BEGIN
            EducationSetupRec.TESTFIELD("Student No.");
            NoSeriesMgt.InitSeries(EducationSetupRec."Student No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "User ID" := FORMAT(UserId());
        //Get "No Series" & "User Id" Values::CSPL-00114::15052019: End
    end;

    var
        // Postcode: Record "Post code";
        EducationSetupRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        EnquiryCS: Record "Enquiry-CS";
        SlabTransportCS: Record "Slab Transport-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";

        AgeNew: Decimal;
        TempAgeNew: Decimal;


    procedure Assistedit(OldStudentMasterNewCS: Record "Student Master New-CS"): Boolean
    begin
        //Code added for No Series Generation::CSPL-00114::15052019: Start
        WITH OldStudentMasterNewCS DO BEGIN
            OldStudentMasterNewCS := Rec;
            UserSetupRec.Get(UserId());
            EducationSetupRec.Reset();
            EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            EducationSetupRec.FindFirst();
            EducationSetupRec.TESTFIELD("Student No.");
            IF NoSeriesMgt.SelectSeries(EducationSetupRec."Student No.", OldStudentMasterNewCS."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := OldStudentMasterNewCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for No Series Generation::CSPL-00114::15052019: End
    end;
}

