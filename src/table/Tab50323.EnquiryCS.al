table 50323 "Enquiry-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   15/05/2019       OnInsert()                                 Get "No Series",Academic Year,Date & "User Id" Values
    // 02    CSPL-00114   15/05/2019       Date Of Birth - OnValidate()               Code added for Date of Birth Value Calculate
    // 03    CSPL-00114   15/05/2019       Class Applied - OnValidate()               Code For Validation
    // 04    CSPL-00114   15/05/2019       Class Applied - Lookup                     Code For Validation
    // 05    CSPL-00114   15/05/2019       Curriculum Intrested - OnValidate()        Code For Validation
    // 06    CSPL-00114   15/05/2019       Curriculum Intrested - Lookup()            Code For Validation
    // 07    CSPL-00114   15/05/2019       Assistedit - Function                      Get "No Series" Generation

    Caption = 'Enquiry-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
        }
        field(4; "Type Of Enquiry"; Code[10])
        {
            Caption = 'Type Of Enquiry';
            TableRelation = "Enquiry Type-CS";
            DataClassification = CustomerContent;
        }
        field(5; "Enquiry Source"; Code[10])
        {
            Caption = 'Enquiry Source';
            TableRelation = "Enquiry Source-CS";
            DataClassification = CustomerContent;
        }
        field(6; "Enquirer Name"; Text[50])
        {
            Caption = 'Enquirer Name';
            DataClassification = CustomerContent;
        }
        field(7; "Relationship with Applicant"; Text[30])
        {
            Caption = 'Relationship with Applicant';
            DataClassification = CustomerContent;
        }
        field(8; "Media Vehicle"; Code[20])
        {
            Caption = 'Media Vehicle';
            TableRelation = "Vehicle - CS";
            DataClassification = CustomerContent;
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Date of Birth Value Calculate::CSPL-00114::15052019: Start
                IF "Date of Birth" <> 0D THEN BEGIN
                    Age := TODAY() - "Date of Birth";
                    TempAgeNew := ROUND(Age / 365, 1, '<');
                    AgeNew := Age MOD 365;
                    Months := ROUND(AgeNew / 30, 1, '<');
                    Age := TempAgeNew;
                END
                ELSE BEGIN
                    CLEAR(Age);
                    CLEAR(Months);
                END;
                //Date of Birth Value Calculate::CSPL-00114::15052019: End
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
        field(12; Citizenship; Code[10])
        {
            Caption = 'Citizenship';
            TableRelation = "Citizenship Master-CS";
            DataClassification = CustomerContent;
        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(14; "Enquiry Date"; Date)
        {
            Caption = 'Enquiry Date';
            DataClassification = CustomerContent;
        }
        field(15; "Class Applied"; Code[10])
        {
            Caption = 'Class Applied';
            TableRelation = "Class Details -CS";
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code Added for validated::CSPL-00114::15052019: Start
                ClassDetailsCS.LookUpClassCS("Class Applied", "Curriculum Intrested");
                //Code Added for validated::CSPL-00114::15052019: End
            end;

            trigger OnValidate()
            begin
                //Code Added for validated::CSPL-00114::15052019: Start
                ClassDetailsCS.ValidateClassCS("Class Applied", "Curriculum Intrested");
                //Code Added for validated::CSPL-00114::15052019: End
            end;
        }
        field(16; "Hostel Accomodation"; Boolean)
        {
            Caption = 'Hostel Accomodation';
            DataClassification = CustomerContent;
        }
        field(17; "Name Of The Previous Institute"; Text[80])
        {
            Caption = 'Name Of The Previous Institute';
            DataClassification = CustomerContent;
        }
        field(18; "Medium Of Instruction"; Code[10])
        {
            Caption = 'Medium Of Instruction';
            TableRelation = "Medium of Instruction-CS";
            DataClassification = CustomerContent;
        }
        field(20; "Curriculum Intrested"; Code[10])
        {
            Caption = 'Curriculum Intrested';
            TableRelation = "Class Details -CS".Curriculum;
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                //Code Added for validated::CSPL-00114::15052019: Start
                ClassDetailsCS.LookUpCurriculumCS("Class Applied", "Curriculum Intrested");
                //Code Added for validated::CSPL-00114::15052019: End
            end;

            trigger OnValidate()
            begin
                //Code Added for validated::CSPL-00114::15052019: Start
                ClassDetailsCS.ValidateCurriculumCS("Class Applied", "Curriculum Intrested");
                //Code Added for validated::CSPL-00114::15052019: End
            end;
        }
        field(21; "Class Last Attended"; Code[10])
        {
            Caption = 'Class Last Attended';
            DataClassification = CustomerContent;
            TableRelation = "Course Pre-Qualification-CS";
        }
        field(22; "Curriculum Followed"; Code[10])
        {
            Caption = 'Curriculum Followed';
            DataClassification = CustomerContent;
        }
        field(23; "Address To"; Code[10])
        {
            Caption = 'Address To';
            TableRelation = Relative;
            DataClassification = CustomerContent;
        }
        field(24; Addressee; Text[50])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(25; "Address 1"; Text[50])
        {
            Caption = 'Address 1';
            DataClassification = CustomerContent;
        }
        field(26; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
            DataClassification = CustomerContent;
        }
        field(27; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
        }
        field(28; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            //TableRelation = "Post Code";
            DataClassification = CustomerContent;
        }
        field(29; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(30; "E-Mail Address"; Text[50])
        {
            Caption = 'E-Mail Address';
            ExtendedDatatype = EMail;
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
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(33; State; Code[10])
        {
            Caption = 'State';
            //TableRelation = State;
            DataClassification = CustomerContent;
        }
        field(34; "No Series"; Code[20])
        {
            Caption = 'No Series';
            DataClassification = CustomerContent;
        }
        field(35; Age; Integer)
        {
            BlankZero = true;
            Caption = 'Age';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(36; Months; Integer)
        {
            BlankZero = true;
            Caption = 'Months';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(38; Campaign; Code[20])
        {
            Caption = 'Campaign';
            TableRelation = Campaign;
            DataClassification = CustomerContent;
        }
        field(2000; "Address 3"; Text[100])
        {
            Caption = 'Address 3';
            DataClassification = CustomerContent;
        }
        field(2001; "Enquiry Closed"; Boolean)
        {
            Caption = 'Enquiry Closed';
            DataClassification = CustomerContent;
        }
        field(50174; "User ID"; Code[20])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 09092019';
            DataClassification = CustomerContent;
        }
        field(50175; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 09092019';
            DataClassification = CustomerContent;
        }
        field(50000; "Application ID"; Code[20])
        {
            Caption = 'Application ID';
            DataClassification = CustomerContent;
        }
        field(50001; "Application Sub-type"; Text[20])
        {
            Caption = 'Application Sub-type';
            DataClassification = CustomerContent;
        }
        field(50002; "Application Type"; Text[20])
        {
            Caption = 'Application Type';
            DataClassification = CustomerContent;
        }
        field(50003; "Clinical Semester"; Text[250])
        {
            Caption = 'Clinical Semester';
            DataClassification = CustomerContent;
        }
        field(50004; "Country of Citizenship"; Code[20])
        {
            Caption = 'Country of Citizenship';
            DataClassification = CustomerContent;
        }
        field(50005; "Deposit Paid Date"; Date)
        {
            Caption = 'Deposit Paid Date';
            DataClassification = CustomerContent;
        }
        field(50006; "Deposit Waived"; Boolean)
        {
            Caption = 'Deposit Waived';
            DataClassification = CustomerContent;
        }
        field(50007; "Deposit Waiver Status"; Text[30])
        {
            Caption = 'Deposit Waiver Status';
            DataClassification = CustomerContent;
        }
        field(50008; "Expected Start Date"; Date)
        {
            Caption = 'Expected Start Date';
            DataClassification = CustomerContent;
        }
        field(50009; "FAFSA Applied"; Boolean)
        {
            Caption = 'FAFSA Applied';
            DataClassification = CustomerContent;
        }
        field(50010; "Graduate GPA"; Decimal)
        {
            Caption = 'Graduate GPA';
            DataClassification = CustomerContent;
        }
        field(50011; "Graduation Date"; Date)
        {
            Caption = 'Graduation Date';
            DataClassification = CustomerContent;
        }
        field(50012; "High School GPA"; Decimal)
        {
            Caption = 'High School GPA';
            DataClassification = CustomerContent;
        }
        field(50013; "Housing Deposit Paid"; Boolean)
        {
            Caption = 'Housing Deposit Paid';
            DataClassification = CustomerContent;
        }

        field(50015; "Lead Source"; Text[30])
        {
            Caption = 'Lead Source';
            DataClassification = CustomerContent;
        }
        field(50016; "Original Anticipated Term"; Text[20])
        {
            Caption = 'Original Anticipated Term';
            DataClassification = CustomerContent;
        }
        field(50017; "Pre-Req GPA"; Decimal)
        {
            Caption = 'Pre-Req GPA';
            DataClassification = CustomerContent;
        }
        field(50018; "Housing Deposit Date"; Date)
        {
            Caption = 'Housing Deposit Date';
            DataClassification = CustomerContent;
        }
        field(50019; "Program Start"; Text[30])
        {
            Caption = 'Program Start';
            DataClassification = CustomerContent;
        }
        field(50020; Program; Code[20])
        {
            Caption = 'Program';
            DataClassification = CustomerContent;
        }
        field(50021; "Scholarship Amount Awarded"; Decimal)
        {
            Caption = 'Scholarship Amount Awarded';
            DataClassification = CustomerContent;
        }
        field(50022; "Scholarship Awarded"; Boolean)
        {
            Caption = 'Scholarship Awarded';
            DataClassification = CustomerContent;
        }
        field(50023; "Scholarship Type"; Text[30])
        {
            Caption = 'Scholarship Type';
            DataClassification = CustomerContent;
        }
        field(50024; Scholarship; Boolean)
        {
            Caption = 'Scholarship';
            DataClassification = CustomerContent;
        }
        field(50025; "Seat Deposit Paid"; Boolean)
        {
            Caption = 'Seat Deposit Paid';
            DataClassification = CustomerContent;
        }
        field(50026; "Special Program Start Date"; Date)
        {
            Caption = 'Special Program Start Date';
            DataClassification = CustomerContent;
        }
        field(50027; "Special Program"; Text[250])
        {
            Caption = 'Special Program';
            DataClassification = CustomerContent;
        }
        field(50028; "Student Accepted Date"; Date)
        {
            Caption = 'Student Accepted Date';
            DataClassification = CustomerContent;
        }
        field(50029; "Sub-Stage"; Text[20])
        {
            Caption = 'Sub-Stage';
            DataClassification = CustomerContent;
        }
        field(50030; "Transfer GPA"; Decimal)
        {
            Caption = 'Transfer GPA';
            DataClassification = CustomerContent;
        }
        field(50031; "Transport Required"; Boolean)
        {
            Caption = 'Transport Required';
            DataClassification = CustomerContent;
        }
        field(50034; "Undergraduate GPA"; Decimal)
        {
            Caption = 'Undergraduate GPA';
            DataClassification = CustomerContent;
        }
        field(50035; "18 Digit ID"; Text[18])
        {
            Caption = '18 Digit ID';
            DataClassification = CustomerContent;
        }
        field(50036; "18 digit School/Student ID"; Code[18])
        {
            Caption = '18 digit School/Student ID';
            DataClassification = CustomerContent;
        }
        field(50037; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50038; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50040; Housing; Option)
        {
            Caption = 'Housing';
            DataClassification = CustomerContent;
            OptionCaption = ' ,AUA Housing,Independent Housing';
            OptionMembers = " ","AUA Housing","Independent Housing";
        }
        field(50041; "Housing/Waiver Application No."; Code[20])
        {
            Caption = 'Housing/Waiver Application No.';
            DataClassification = CustomerContent;
        }
        field(50042; "Housing Deposit Waived"; Boolean)
        {
            Caption = 'Housing Deposit Waived';
            DataClassification = CustomerContent;
        }

        field(50043; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(50044; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(43; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
        }
        field(44; "Present Address 1"; Text[50])
        {
            Caption = 'Present Address 1';
            DataClassification = CustomerContent;
        }
        field(45; "Present Address 2"; Text[50])
        {
            Caption = 'Present Address 2';
            DataClassification = CustomerContent;
        }
        field(46; "Present Address 3"; Text[50])
        {
            Caption = 'Present Address 3';
            DataClassification = CustomerContent;
        }
        field(47; "Present City"; Text[30])
        {
            Caption = 'Present City';
            DataClassification = CustomerContent;
        }
        field(48; "Present Post Code"; Code[20])
        {
            Caption = 'Present Post Code';
            DataClassification = CustomerContent;
        }
        field(49; "Present State"; Code[20])
        {
            Caption = 'Present State';
            DataClassification = CustomerContent;
        }
        field(50; "Present Country"; Code[10])
        {
            Caption = 'Present Country';
            DataClassification = CustomerContent;
        }
        field(51; "Lease Agreement No."; Code[20])
        {
            Caption = 'Lease Agreement No.';
            DataClassification = CustomerContent;
        }
        field(52; "Lease Agreement Group"; Text[50])
        {
            Caption = 'Lease Agreement Group';
            DataClassification = CustomerContent;
        }
        field(53; "Transport Allotment"; Boolean)
        {
            Caption = 'Transport Allotment';
            DataClassification = CustomerContent;
        }
        field(54; "Transport Cell No."; Boolean)
        {
            Caption = 'Transport Cell No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Class Applied", "Curriculum Intrested", "Academic Year")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Get "No Series",Academic Year,Date & "User Id" Values::CSPL-00114::15052019: Start
        UserSetupRec.Get(UserId());
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        IF "No Series" = '' THEN BEGIN
            EducationSetupRec.TESTFIELD("Enquiry No.");
            NoSeriesMgt.InitSeries(EducationSetupRec."Enquiry No.", xRec."No Series", 0D, "No.", "No Series");
        END;
        "Academic Year" := VerticalEducationCS.CreateAdmissionYr();
        "Enquiry Date" := WORKDATE();
        "User ID" := FORMAT(UserId());

        Inserted := true;
        //Get "No Series",Academic Year,Date & "User Id" Values::CSPL-00114::15052019: End
    end;

    trigger OnModify()
    Begin
        if xRec.Updated = Updated then
            Updated := true;
    End;

    var
        EducationSetupRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        EnquiryCS: Record "Enquiry-CS";
        ClassDetailsCS: Record "Class Details -CS";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        AgeNew: Decimal;
        TempAgeNew: Decimal;

    procedure Assistedit(OldEnquiryCS: Record "Enquiry-CS"): Boolean
    begin
        //Get "No Series" Generation::CSPL-00114::15052019: Start
        WITH EnquiryCS DO BEGIN
            EnquiryCS := Rec;
            UserSetupRec.Get(UserId());
            EducationSetupRec.Reset();
            EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            EducationSetupRec.FindFirst();
            EducationSetupRec.TESTFIELD("Enquiry No.");
            IF NoSeriesMgt.SelectSeries(EducationSetupRec."Enquiry No.", OldEnquiryCS."No Series", "No Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := EnquiryCS;
                EXIT(TRUE);
            END;
        END;
        //Get "No Series" Generation::CSPL-00114::15052019: End
    end;
}