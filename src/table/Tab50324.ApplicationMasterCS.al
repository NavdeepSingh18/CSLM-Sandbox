table 50324 "Application Master-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   17/05/2019       OnInsert()                                 Get "No Series",Academic Year,Date & "User Id" Values
    // 02    CSPL-00114   17/05/2019       No. - OnValidate()                         Get No series value
    // 02    CSPL-00114   17/05/2019       Date Of Birth - OnValidate()               Code added for Date of Birth Value Calculate
    // 03    CSPL-00114   17/05/2019       Class - OnValidate()                       Code For Validation
    // 04    CSPL-00114   17/05/2019       Class - Lookup()                           Code For Validation
    // 05    CSPL-00114   17/05/2019       Curriculum Intrested - OnValidate()        Code For Validation
    // 06    CSPL-00114   17/05/2019       Curriculum Intrested - Lookup()            Code For Validation
    // 07    CSPL-00114   17/05/2019       Assistedit - Function                      Get "No Series" Generation

    Caption = 'Application Master-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Get No series value::CSPL-00114::17052019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    AdmissionSetupMasterCS.GET();
                    NoSeriesMgt.TestManual(AdmissionSetupMasterCS."Application No.");
                    "No.Series" := '';
                END;
                //Get No series value::CSPL-00114::17052019: End
            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';

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
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Date of Birth Value Calculate::CSPL-00114::17052019: Start
                TESTFIELD(Class);
                TESTFIELD("Curriculum Intrested");
                ClassDetailsCS.Reset();
                ClassDetailsCS.SETRANGE("Class Code", Class);
                ClassDetailsCS.SETRANGE(Curriculum, "Curriculum Intrested");
                ClassDetailsCS.SETRANGE("Academic Year", "Academic Year");
                IF ClassDetailsCS.FINDFIRST() THEN
                    IF ClassDetailsCS."Cut Off Age as on" <> 0D THEN
                        IF "Date of Birth" <> 0D THEN BEGIN
                            Age := ClassDetailsCS."Cut Off Age as on" - "Date of Birth";
                            TempAgeNew := ROUND(Age / 365, 1, '=');
                            AgeNew := Age MOD 365;
                            Months := ROUND(AgeNew / 30, 1, '=');
                            Age := TempAgeNew - 1;
                        END ELSE BEGIN
                            CLEAR(Age);
                            CLEAR(Months);
                        END;
                //Code added for Date of Birth Value Calculate::CSPL-00114::17052019: End
            END;
        }
        field(10; "Father's Name"; Text[30])
        {
            Caption = 'Father''s Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mother's Name"; Text[30])
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
            TableRelation = "Academic Year Master-CS";
        }
        field(15; Class; Code[10])
        {
            Caption = 'Class';
            DataClassification = CustomerContent;
            TableRelation = "Class Details -CS"."Class Code";

            trigger OnLookup()
            begin
                //Code added for Validation::CSPL-00114::17052019: Start
                ClassDetailsCS1.LookUpClassCS(Class, "Curriculum Intrested");
                VALIDATE("Enquiry No.");
                //Code added for Validation::CSPL-00114::17052019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::17052019: Start
                ClassDetailsCS1.ValidateClassCS(Class, "Curriculum Intrested");
                VALIDATE("Enquiry No.");
                //Code added for Validation::CSPL-00114::17052019: End
            end;
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
        field(20; "Curriculum Intrested"; Code[10])
        {
            Caption = 'Curriculum Intrested';
            DataClassification = CustomerContent;
            TableRelation = "Class Details -CS".Curriculum;

            trigger OnLookup()
            begin
                //Code added for Validation::CSPL-00114::17052019: Start
                ClassDetailsCS1.LookUpCurriculumCS(Class, "Curriculum Intrested");
                //Code added for Validation::CSPL-00114::17052019: End
            end;

            trigger OnValidate()
            begin
                //Code added for Validation::CSPL-00114::17052019: Start
                ClassDetailsCS1.ValidateCurriculumCS(Class, "Curriculum Intrested");
                //Code added for Validation::CSPL-00114::17052019: End
            end;
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
        field(24; Addressee; Text[30])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(25; Address1; Text[50])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(26; Address2; Text[50])
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
        field(30; "E-Mail Address"; Text[30])
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
        field(56; "Guardian Name"; Text[30])
        {
            Caption = 'Guardian Name';
            DataClassification = CustomerContent;
        }
        field(58; "Application Status"; Option)
        {
            Caption = 'Application Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Sold,Received,Selected,Admitted';
            OptionMembers = " ",Sold,Received,Selected,Admitted;
        }
        field(59; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(60; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
            DataClassification = CustomerContent;
        }
        field(61; "Cheque / DD Date"; Date)
        {
            Caption = 'Cheque / DD Date';
            DataClassification = CustomerContent;
        }
        field(62; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(63; "Date of Sale"; Date)
        {
            Caption = 'Date of Sale';
            DataClassification = CustomerContent;
        }
        field(64; "Date of Receive"; Date)
        {
            Caption = 'Date of Receive';
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
        field(75; "Applicant Relationship"; Code[20])
        {
            Caption = 'Applicant Relationship';
            DataClassification = CustomerContent;
            TableRelation = Relative;
        }
        field(76; "Enquiry No."; Code[10])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry-CS" WHERE("Enquiry Closed" = CONST(FALSE));

            trigger OnValidate()
            begin
                //Code added for Validation & Application Cost Value ::CSPL-00114::17052019: Start
                AdmissionSetupMasterCS1.GET();
                IF EnquiryCS.GET("Enquiry No.") THEN BEGIN
                    TRANSFERFIELDS(EnquiryCS);
                    VALIDATE("Date of Birth");
                    "No." := xRec."No.";
                END;

                AdmissionSetupMasterCS1.GET();
                IF AdmissionSetupMasterCS1."Application Sale Method" = AdmissionSetupMasterCS1."Application Sale Method"::Common THEN BEGIN
                    IF (AdmissionSetupMasterCS1."Application Sales From" <> 0D) AND (AdmissionSetupMasterCS1."Application Sales To" <> 0D) THEN
                        IF (AdmissionSetupMasterCS1."Application Sales From" > TODAY()) OR (AdmissionSetupMasterCS1."Application Sales To" < TODAY()) THEN
                            ERROR(Text001Lbl);
                END ELSE
                    IF AdmissionSetupMasterCS1."Application Sale Method" = AdmissionSetupMasterCS1."Application Sale Method"::Classwise THEN BEGIN
                        ClassDetailsCS.GET(Class, "Curriculum Intrested");
                        IF (ClassDetailsCS."Application Sale From" <> 0D) AND (ClassDetailsCS."Application Sale Till" <> 0D) THEN
                            IF (ClassDetailsCS."Application Sale From" > TODAY()) AND (ClassDetailsCS."Application Sale Till" < TODAY()) THEN
                                MESSAGE(Text002Lbl);
                    END;

                IF AdmissionSetupMasterCS1."Appl Cost Method" = AdmissionSetupMasterCS1."Appl Cost Method"::Common THEN BEGIN
                    "Application Cost" := AdmissionSetupMasterCS1."Application Cost";
                    "Registration Cost" := AdmissionSetupMasterCS1."Registration Cost";
                END ELSE
                    IF AdmissionSetupMasterCS1."Appl Cost Method" = AdmissionSetupMasterCS1."Appl Cost Method"::Classwise THEN BEGIN
                        "Application Cost" := ClassDetailsCS."Application Cost";
                        "Registration Cost" := ClassDetailsCS."Registration Cost";
                    END;
                //Code added for Validation & Application Cost Value ::CSPL-00114::17052019: End
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
        field(83; "Registration Cost"; Decimal)
        {
            Caption = 'Registration Cost';
            DataClassification = CustomerContent;
        }
        field(90; "Mode of Sale"; Code[10])
        {
            Caption = 'Mode of Sale';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry Type-CS";
        }
        field(91; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(92; "Mode of Payment"; Code[10])
        {
            Caption = 'Mode of Payment';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(93; "Cheque / DD No."; Text[30])
        {
            Caption = 'Cheque / DD No.';
            DataClassification = CustomerContent;
        }
        field(94; Prospectus; Boolean)
        {
            Caption = 'Prospectus';
            DataClassification = CustomerContent;
        }
        field(95; "Prospectus No."; Text[30])
        {
            Caption = 'Prospectus No.';
            DataClassification = CustomerContent;
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
        field(500; Spot; Boolean)
        {
            Caption = 'Spot';
            DataClassification = CustomerContent;
        }
        field(501; "Recommender Designation"; Text[50])
        {
            Caption = 'Recommender Designation';
            DataClassification = CustomerContent;
        }
        field(502; "Recommended By"; Text[50])
        {
            Caption = 'Recommended By';
            DataClassification = CustomerContent;
        }
        field(503; "Recommended List No"; Text[50])
        {
            Caption = 'Recommended List No';
            DataClassification = CustomerContent;
        }
        field(504; "Check Age Limit"; Boolean)
        {
            Caption = 'Check Age Limit';
            DataClassification = CustomerContent;
        }
        field(505; Recommendation; Boolean)
        {
            Caption = 'Recommendation';
            DataClassification = CustomerContent;
        }
        field(1000; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(1017; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(10001; "Fee Classification"; Code[20])
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
        field(50174; "User ID"; Code[20])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
        field(50175; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
        field(51000; Rank; Integer)
        {
            Caption = 'Rank';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
        field(51001; "Evaluation Total"; Decimal)
        {
            Caption = 'Evaluation Total';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
        field(51002; "Selection Number"; Code[10])
        {
            Caption = 'Selection Number';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
        field(60000; Height; Decimal)
        {
            BlankZero = true;
            Caption = 'Height';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
        field(60001; Weight; Decimal)
        {
            BlankZero = true;
            Caption = 'Weight';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 17052019';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; Class, "Curriculum Intrested", "Academic Year")
        {
        }
        key(Key3; Rank)
        {
        }
        key(Key4; "Selection Number", "Application Status")
        {
        }
        key(Key5; Class, "Curriculum Intrested", "Academic Year", "Application Status")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series",Academic Year,Date & "User Id" Values::CSPL-00114::17052019: Start
        "Academic Year" := VerticalEducationCS.CreateAdmissionYr();
        AdmissionSetupMasterCS.GET();
        IF "No.Series" = '' THEN BEGIN
            AdmissionSetupMasterCS.TESTFIELD("Application No.");
            NoSeriesMgt.InitSeries(AdmissionSetupMasterCS."Application No.", xRec."No.Series", 0D, "No.", "No.Series");
        END;
        "Date of Sale" := TODAY();
        "User ID" := FORMAT(UserId());
        //Get "No Series",Academic Year,Date & "User Id" Values::CSPL-00114::17052019: End
    end;

    var


        AdmissionSetupMasterCS: Record "Admission Setup Master-CS";
        EnquiryCS: Record "Enquiry-CS";
        ApplicationMasterCS: Record "Application Master-CS";
        AdmissionSetupMasterCS1: Record "Admission Setup Master-CS";
        ClassDetailsCS: Record "Class Details -CS";
        ClassDetailsCS1: Record "Class Details -CS";

        NoSeriesMgt: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        AgeNew: Decimal;
        TempAgeNew: Decimal;
        Text001Lbl: Label 'Sale of Application Closed';
        Text002Lbl: Label 'Sale of Application Closed';

    procedure Assistedit(OldApplicationMasterCS: Record "Application Master-CS"): Boolean
    begin
        //Code added for no Series generation::CSPL-00114::17052019: Start
        WITH ApplicationMasterCS DO BEGIN
            ApplicationMasterCS := Rec;
            AdmissionSetupMasterCS.GET();
            AdmissionSetupMasterCS.TESTFIELD("Application No.");
            IF NoSeriesMgt.SelectSeries(AdmissionSetupMasterCS."Application No.", OldApplicationMasterCS."No.Series", "No.Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := ApplicationMasterCS;
                EXIT(TRUE);
            END;
        END;
        //Code added for no Series generation::CSPL-00114::17052019: End
    end;
}

