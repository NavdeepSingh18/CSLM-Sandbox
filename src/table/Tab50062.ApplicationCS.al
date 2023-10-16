
table 50062 "Application-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                           Remarks
    // 1         CSPL-00092    05-01-2019    OnInsert                                          No. Series and Assign Value in Fields
    // 2         CSPL-00092    05-01-2019    OnModify                                        Validate Data
    // 3         CSPL-00092    05-01-2019    No. - OnValidate                                No. Series and Assign Value in Fields
    // 4         CSPL-00092    05-01-2019    Date of Birth - OnValidate                      Find Age and Validate data
    // 5         CSPL-00092    05-01-2019    Course Code - OnValidate                        Validate data and Assign Value in Fields
    // 6         CSPL-00092    05-01-2019    Quota - OnValidate                            Validate data and Assign Value in Fields
    // 7         CSPL-00092    05-01-2019    Enquiry No. - OnValidate                        Validate data and Assign Value in Fields
    // 8         CSPL-00092    05-01-2019    Religion - OnValidate                          Validate data and Assign Value in Fields
    // 9         CSPL-00092    05-01-2019    Prospectus No. - OnValidate                      Prospectus No. Series
    // 10        CSPL-00092    05-01-2019    Cor City - OnValidate                          Assign Value in Fields
    // 11        CSPL-00092    05-01-2019    Same As Permanent Address - OnValidate          Copy Address from Parmanent Address
    // 12        CSPL-00092    05-01-2019    Assistedit                                      Select No Series
    // 13        CSPL-00092    05-01-2019    GenerateCreditMemo                              Create Credit Memo Voucher
    // 14        CSPL-00092    05-01-2019    CalculatePercent                                Find Pre Qualification Percent
    // 15        CSPL-00092    05-01-2019    CheckPreQulification                            Check Pre Qulification
    // 16        CSPL-00092    05-01-2019    TestCollege                                    Validate data
    // 17        CSPL-00092    05-01-2019    ApplyDiscount                                  Apply Discount
    // 18        CSPL-00092    05-01-2019    DiscApplyJain                                  Jain Discount
    // 19        CSPL-00092    05-01-2019    OnSpotReceiptFee                                Create Procpectus Fee
    // 20        CSPL-00092    05-01-2019    FeeHostal                                      Create Hostel Fee
    // 21        CSPL-00092    05-01-2019    Transpotfee                                    Create Transpot Fee

    Caption = 'Application-CS';
    DrillDownPageID = 50254;
    LookupPageID = 50254;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = true;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for No. Series and Assign Value in Fields::CSPL-00092::05-01-2019: Start
                IF "No." <> xRec."No." THEN BEGIN
                    recAdmissionSetupCS.GET();
                    NoSeriesManagement.TestManual(recAdmissionSetupCS."Application No.");
                    "No.Series" := '';
                END;

                recEduSetupCS.GET();
                "Academic Year" := recEduSetupCS."Academic Year";
                //Code added for No. Series and Assign Value in Fields::CSPL-00092::05-01-2019: End
            end;
        }
        field(8; "Applicant Name"; Text[50])
        {
            Caption = 'Applicant Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Assign Value in Admitted Year Field::CSPL-00092::05-01-2019: Start
                recEduSetupCS.GET();
                "Admitted Year" := recEduSetupCS."Academic Year";
                //Code added for Assign Value in Admitted Year Field::CSPL-00092::05-01-2019: End
            end;
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                TempAge: Decimal;
                Age2: Decimal;
            begin
                //Code added for find Age and Validate data::CSPL-00092::05-01-2019: Start
                TestCollege();

                IF "Date of Birth" <> 0D THEN BEGIN
                    Age := TODAY() - "Date of Birth";
                    TempAge := ROUND(Age / 365, 1, '<');
                    Age2 := Age MOD 365;
                    Months := ROUND(Age2 / 30, 1, '=');
                    Age := TempAge;
                END ELSE BEGIN
                    CLEAR(Age);
                    CLEAR(Months);
                END;

                IF recCourseMasterCS1.GET("Course Code") THEN
                    IF (recCourseMasterCS1."Miniimum Age Limit" > Age) OR (recCourseMasterCS1."Maximum Age Limit" < Age) THEN
                        ERROR(Text002Lbl, recCourseMasterCS1."Miniimum Age Limit", recCourseMasterCS1."Maximum Age Limit");

                //Code added for find Age and Validate data::CSPL-00092::05-01-2019: End
            end;
        }
        field(10; "Father Name"; Text[30])
        {
            Caption = 'Father''s Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mother Name"; Text[30])
        {
            Caption = 'Mother''s Name';
            DataClassification = CustomerContent;
        }
        field(12; Citizenship; Code[20])
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
        field(14; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            TableRelation = "Course Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: Start
                recCourseMasterCS.GET("Course Code");
                IF (recCourseMasterCS."Application Sale From" <> 0D) AND (recCourseMasterCS."Application Sale Till" <> 0D) THEN
                    IF (recCourseMasterCS."Application Sale From" > "Date of Sale") OR (recCourseMasterCS."Application Sale Till" < "Date of Sale") THEN
                        ERROR(Text000Lbl);

                recCourseMasterCS2.Reset();
                recCourseMasterCS2.SETRANGE(recCourseMasterCS2.Code, "Course Code");
                IF recCourseMasterCS2.FindFirst() THEN BEGIN
                    Year := recCourseMasterCS2.Year;
                    "Course Name" := recCourseMasterCS2.Description;
                    "Type Of Course" := recCourseMasterCS2."Type Of Course";
                    "Global Dimension 1 Code" := recCourseMasterCS2."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := recCourseMasterCS2."Global Dimension 2 Code";
                END;

                IF "Type Of Course" = "Type Of Course"::Semester THEN BEGIN
                    SemesterFlagCS := TRUE;
                    YearFlagCS := FALSE
                END ELSE BEGIN
                    SemesterFlagCS := FALSE;
                    YearFlagCS := TRUE;
                END;
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: End
            end;
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
            TableRelation = "Not Sync Document-CS";
            DataClassification = CustomerContent;
        }
        field(18; "Name of Previous Inst"; Text[50])
        {
            Caption = 'Name of Previous Inst';
            DataClassification = CustomerContent;
        }
        field(19; "Certification Authority"; Code[20])
        {
            Caption = 'Certification Authority';
            DataClassification = CustomerContent;
        }
        field(20; "Medium of Instruction"; Code[20])
        {
            Caption = 'Medium of Instruction';
            DataClassification = CustomerContent;
            TableRelation = "Medium of Instruction-CS";
        }
        field(21; "Address To"; Code[20])
        {
            Caption = 'Address To';
            TableRelation = Relative;
            DataClassification = CustomerContent;
        }
        field(22; Addressee; Text[50])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(23; Address1; Text[50])
        {
            Caption = 'Address1';
            DataClassification = CustomerContent;
        }
        field(24; Address2; Text[50])
        {
            Caption = 'Address2';
            DataClassification = CustomerContent;
        }
        field(25; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            // TableRelation = "Post Code".City WHERE("State Code" = FIELD(State),
            //                                         "District 3" = FIELD(District));
        }
        field(26; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            //  TableRelation = "Post Code".Code;
            DataClassification = CustomerContent;
        }
        field(27; "Country Code"; Code[20])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(28; "E-Mail Address"; Text[30])
        {
            Caption = 'E-Mail Address';
            DataClassification = CustomerContent;
        }
        field(29; "Mobile Number"; Text[10])
        {
            Caption = 'Mobile Number';
            DataClassification = CustomerContent;
        }
        field(30; "Phone Number"; Text[10])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;
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
            //TableRelation = State;
            DataClassification = CustomerContent;
        }
        field(34; Address3; Text[100])
        {
            Caption = 'Address3';
            DataClassification = CustomerContent;
        }
        field(36; "Visa Exp Date"; Date)
        {
            Caption = 'Visa Exp Date';
            DataClassification = CustomerContent;
        }
        field(37; "Co-Curricular Activities"; Text[30])
        {
            Caption = 'Co-Curricular Activities';
            DataClassification = CustomerContent;
        }
        field(38; "Food Habits"; Option)
        {
            Caption = 'Food Habits';
            OptionCaption = ' ,Veg,Non Veg';
            OptionMembers = " ",Veg,"Non Veg";
            DataClassification = CustomerContent;
        }
        field(39; "Applicant Relationship"; Code[20])
        {
            Caption = 'Applicant Relationship';
            TableRelation = Relative;
            DataClassification = CustomerContent;
        }
        field(40; "Passport No."; Text[20])
        {
            Caption = 'Passport No.';
            DataClassification = CustomerContent;
        }
        field(41; "Passport Exp Date"; Date)
        {
            Caption = 'Passport Exp Date';
            DataClassification = CustomerContent;
        }
        field(42; Caste; Code[20])
        {
            Caption = 'Caste';
            TableRelation = "Caste Master-CS";
            DataClassification = CustomerContent;
        }
        field(43; "Cheque / DD Date"; Date)
        {
            Caption = 'Cheque / DD Date';
            DataClassification = CustomerContent;
        }
        field(44; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(45; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
            DataClassification = CustomerContent;
        }
        field(46; "Date of Sale"; Date)
        {
            Caption = 'Date of Sale';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(47; "Application Status"; Option)
        {
            Caption = 'Application Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Sold,Received';
            OptionMembers = " ",Sold,Received;
        }
        field(48; "Date of Receive"; Date)
        {
            Caption = 'Date of Receive';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(49; "Applicant Image"; BLOB)
        {
            Caption = 'Applicant Image';
            Compressed = false;
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50; "Father Image"; BLOB)
        {
            Caption = 'Father Image';
            DataClassification = CustomerContent;
        }
        field(51; "Mother Image"; BLOB)
        {
            Caption = 'Mother Image';
            DataClassification = CustomerContent;
        }
        field(52; "Guardian Image"; BLOB)
        {
            Caption = 'Guardian Image';
            DataClassification = CustomerContent;
        }
        field(53; "Presently Residing with"; Code[20])
        {
            Caption = 'Presently Residing with';
            TableRelation = Relative;
            DataClassification = CustomerContent;
        }
        field(54; Quota; Code[20])
        {
            Caption = 'Quota';
            TableRelation = "Quota-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: Start
                recAdmissionSetupCS.Reset();
                recAdmissionSetupCS.GET();
                recCourseMasterCS.GET("Course Code");
                IF recQuotaCS.Reserve AND (recAdmissionSetupCS."Appl Cost Method" = recAdmissionSetupCS."Appl Cost Method"::Common) THEN BEGIN
                    "Application Cost" := recAdmissionSetupCS."Application Cost For Reserve";
                    "Registration Cost" := recAdmissionSetupCS."Registration Cost For Reserve";
                END ELSE
                    IF recQuotaCS.Reserve AND (recAdmissionSetupCS."Appl Cost Method" = recAdmissionSetupCS."Appl Cost Method"::Coursewise) THEN BEGIN
                        "Application Cost" := recCourseMasterCS."Application Cost For Reserve";
                        "Registration Cost" := recCourseMasterCS."Registration Cost For Reserve";
                    END ELSE
                        IF (NOT (recQuotaCS.Reserve)) AND (recAdmissionSetupCS."Appl Cost Method" = recAdmissionSetupCS."Appl Cost Method"::Common) THEN BEGIN
                            "Application Cost" := recAdmissionSetupCS."Application Cost For Others";
                            "Registration Cost" := recAdmissionSetupCS."Registration Cost For Others";
                        END ELSE
                            IF (NOT (recQuotaCS.Reserve)) AND (recAdmissionSetupCS."Appl Cost Method" = recAdmissionSetupCS."Appl Cost Method"::Coursewise) THEN BEGIN
                                "Application Cost" := recCourseMasterCS."Application Cost For Others";
                                "Registration Cost" := recCourseMasterCS."Registration Cost For Others";
                            END;
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: End
            end;
        }
        field(55; "No.Series"; Code[20])
        {
            Caption = 'No.Series';
            DataClassification = CustomerContent;
        }
        field(56; "Father's Qualification"; Text[30])
        {
            Caption = 'Father''s Qualification';
            DataClassification = CustomerContent;
        }
        field(57; "Father's Occupation"; Text[30])
        {
            Caption = 'Father''s Occupation';
            DataClassification = CustomerContent;

        }
        field(58; "Father's Annual Income"; Decimal)
        {
            Caption = 'Father''s Annual Income';
            DataClassification = CustomerContent;
        }
        field(59; "Mother's Qualification"; Text[30])
        {
            Caption = 'Mother''s Qualification';
            DataClassification = CustomerContent;
        }
        field(60; "Mother's Occupation"; Text[30])
        {
            Caption = 'Mother''s Occupation';
            DataClassification = CustomerContent;
        }
        field(61; "Mother's Annual Income"; Decimal)
        {
            Caption = 'Mother''s Annual Income';
            DataClassification = CustomerContent;
        }
        field(62; "Guardian Name"; Text[30])
        {
            Caption = 'Guardian Name';
            DataClassification = CustomerContent;
        }
        field(63; "Guardian Qualification"; Text[30])
        {
            Caption = 'Guardian Qualification';
            DataClassification = CustomerContent;
        }
        field(64; "Guardian Occupation"; Text[30])
        {
            Caption = 'Guardian Occupation';
            DataClassification = CustomerContent;
        }
        field(65; "Guardian Annual Income"; Decimal)
        {
            Caption = 'Guardian Annual Income';
            DataClassification = CustomerContent;
        }
        field(66; Nationality; Text[30])
        {
            Caption = 'Nationality';
            TableRelation = "Citizenship Master-CS";
            DataClassification = CustomerContent;
        }
        field(67; "Physically Challanged"; Boolean)
        {
            Caption = 'Physically Challanged';
            DataClassification = CustomerContent;
        }
        field(68; "Visually Challanged"; Boolean)
        {
            Caption = 'Visually Challanged';
            DataClassification = CustomerContent;
        }
        field(69; "First Generation Leaner"; Boolean)
        {
            Caption = 'First Generation Leaner';
            DataClassification = CustomerContent;
        }
        field(70; Recommended; Boolean)
        {
            Caption = 'Recommended';
            DataClassification = CustomerContent;
        }
        field(71; "Recommend By"; Text[30])
        {
            Caption = 'Recommend By';
            DataClassification = CustomerContent;
        }
        field(72; "Staff Child"; Boolean)
        {
            Caption = 'Staff Child';
            DataClassification = CustomerContent;
        }
        field(73; "Staff Code"; Code[20])
        {
            Caption = 'Staff Code';
            TableRelation = Employee;
            DataClassification = CustomerContent;
        }
        field(74; "Break In Study"; Boolean)
        {
            Caption = 'Break In Study';
            DataClassification = CustomerContent;
        }
        field(75; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
        }
        field(76; "Rejected Reason"; Text[100])
        {
            Caption = 'Rejected Reason';
            DataClassification = CustomerContent;
        }
        field(77; "Sports Person"; Boolean)
        {
            Caption = 'Sports Person';
            DataClassification = CustomerContent;
        }
        field(78; Specialization; Text[30])
        {
            Caption = 'Specialization';
            DataClassification = CustomerContent;
        }
        field(81; "Application Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Application Cost';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(82; "Registration Cost"; Decimal)
        {
            BlankZero = true;
            Caption = 'Registration Cost';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(83; "Sale Mode"; Code[20])
        {
            Caption = 'Sale Mode';
            DataClassification = CustomerContent;
            TableRelation = "Enquiry Type-CS";
        }
        field(84; "Enquiry No."; Code[20])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: Start
                recApplicationCS2.Reset();
                recApplicationCS2.SETRANGE(recApplicationCS2."Enquiry No.", "Enquiry No.");
                IF recApplicationCS2.FindFirst() THEN
                    ERROR(Text003Lbl, "Enquiry No.");

                IF (xRec."Application Status" = xRec."Application Status"::Sold) AND (xRec."Enquiry No." <> '') THEN
                    ERROR(Text001Lbl);

                Address4 := '';
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: End
            end;
        }
        field(85; "Mode of Payment"; Code[20])
        {
            Caption = 'Mode of Payment';
            TableRelation = "Payment Method";
            DataClassification = CustomerContent;
        }
        field(86; "Cheque / DD No."; Text[30])
        {
            Caption = 'Cheque / DD No.';
            DataClassification = CustomerContent;
        }
        field(87; Religion; Code[20])
        {
            Caption = 'Religion';
            TableRelation = "Religion Master-CS";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: Start
                IF (Religion = 'JAIN') OR (Religion = 'SIKH') OR (Religion = 'MUSLIM') OR (Religion = 'CHRISTIAN') OR (Religion = 'BUDDHIST') OR (Religion = 'PARSI') THEN
                    Quota := 'MINORITY '
                //Code added for Validate data and Assign Value in Fields::CSPL-00092::05-01-2019: End
            end;
        }
        field(88; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            DataClassification = CustomerContent;
        }
        field(89; Age; Integer)
        {
            Caption = 'Age';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(90; Months; Integer)
        {
            Caption = 'Months';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(91; "Application Selection"; Boolean)
        {
            Caption = 'Application Selection';
            DataClassification = CustomerContent;
        }
        field(92; Alloted; Boolean)
        {
            Caption = 'Alloted';
            DataClassification = CustomerContent;
        }
        field(93; "Call Letter Sent"; Boolean)
        {
            Caption = 'Call Letter Sent';
            DataClassification = CustomerContent;
        }
        field(94; "Interview Attended"; Boolean)
        {
            Caption = 'Interview Attended';
            DataClassification = CustomerContent;
        }
        field(95; Admitted; Boolean)
        {
            Caption = 'Admitted';
            DataClassification = CustomerContent;
        }
        field(96; "Stage2 Selection List No."; Integer)
        {
            Caption = 'Stage2 Selection List No.';
            DataClassification = CustomerContent;
        }
        field(97; "Selection Rank"; Integer)
        {
            Caption = 'Selection Rank';
            DataClassification = CustomerContent;
        }
        field(98; "Selected Quota Rank"; Integer)
        {
            Caption = 'Selected Quota Rank';
            DataClassification = CustomerContent;
        }
        field(99; "Selected Quota"; Code[20])
        {
            Caption = 'Selected Quota';
            TableRelation = "Quota-CS";
            DataClassification = CustomerContent;
        }
        field(100; "Selection Percentage"; Decimal)
        {
            Caption = 'Selection Percentage';
            DataClassification = CustomerContent;
        }
        field(101; "Interview Selected"; Boolean)
        {
            Caption = 'Interview Selected';
            DataClassification = CustomerContent;
        }
        field(500; Spot; Boolean)
        {
            Caption = 'Spot';
            DataClassification = CustomerContent;
        }
        field(501; "Check Age Limt"; Boolean)
        {
            Caption = 'Check Age Limt';
            DataClassification = CustomerContent;
        }
        field(502; "Is Recommended"; Boolean)
        {
            Caption = 'Is Recommended';
            DataClassification = CustomerContent;
        }
        field(503; "Recommended List No."; Text[30])
        {
            Caption = 'Recommended List No.';
            DataClassification = CustomerContent;
        }
        field(504; "Recommended By"; Text[30])
        {
            Caption = 'Recommended By';
            DataClassification = CustomerContent;
        }
        field(505; "Recommended Designation"; Text[50])
        {
            Caption = 'Recommended Designation';
            DataClassification = CustomerContent;
        }
        field(1000; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS" WHERE(Order = FILTER(1 | 3));
        }
        field(1001; "Fee Classification Code"; Code[20])
        {
            Caption = 'Fee Classification Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(1002; Section; Code[10])
        {
            Caption = 'Section';
            TableRelation = "Section Master-CS";
            DataClassification = CustomerContent;
        }
        field(1004; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(1006; "Is Demoted"; Boolean)
        {
            Caption = 'Is Demoted';
            DataClassification = CustomerContent;
        }
        field(1007; "Reason For Promotion"; Text[50])
        {
            Caption = 'Reason For Promotion';
            DataClassification = CustomerContent;
        }
        field(1008; "Reason For Demotion"; Text[50])
        {
            Caption = 'Reason For Demotion';
            DataClassification = CustomerContent;
        }
        field(1009; "Is Promoted"; Boolean)
        {
            Caption = 'Is Promoted';
            DataClassification = CustomerContent;
        }
        field(1010; "Rank Selection"; Boolean)
        {
            Caption = 'Rank Selection';
            DataClassification = CustomerContent;
        }
        field(1011; "Eligibility Rank"; Integer)
        {
            Caption = 'Eligibility Rank';
            DataClassification = CustomerContent;
        }
        field(1012; "Eligibility Percertage"; Decimal)
        {
            Caption = 'Eligibility Percertage';
            DataClassification = CustomerContent;
        }
        field(1013; "Stage1 Selection List No."; Integer)
        {
            Caption = 'Stage1 Selection List No.';
            DataClassification = CustomerContent;
        }
        field(1014; "Eligibilty Quota"; Code[20])
        {
            Caption = 'Eligibilty Quota';
            TableRelation = "Quota-CS";
            DataClassification = CustomerContent;
        }
        field(1015; "Eligibility Quota Rank"; Integer)
        {
            Caption = 'Eligibility Quota Rank';
            DataClassification = CustomerContent;
        }
        field(1016; "Admission Letter Sent"; Boolean)
        {
            Caption = 'Admission Letter Sent';
            DataClassification = CustomerContent;
        }
        field(1017; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            TableRelation = "Student Master-CS";
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 06-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 06-01-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(50003; "Aadhar No."; Code[20])
        {
            Description = 'CS Field Added 06-01-2019';
            Caption = 'Aadhar No.';
            DataClassification = CustomerContent;
        }
        field(50004; "Facebook ID"; Text[50])
        {
            Description = 'CS Field Added 06-01-2019';
            Caption = 'Facebook ID';
            DataClassification = CustomerContent;
        }
        field(50005; "Prospectus No."; Code[20])
        {
            Description = 'CS Field Added 06-01-2019';
            Caption = 'Prospectus No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Prospectus No. Series::CSPL-00092::05-01-2019: Start
                IF "Prospectus No." <> xRec."Prospectus No." THEN BEGIN
                    recAdmissionSetupCS.GET();
                    NoSeriesManagement.TestManual(recAdmissionSetupCS."Prospectus No.");
                    "No.Series" := '';
                END;
                //Code added for Prospectus No. Series::CSPL-00092::05-01-2019: End
            end;
        }
        field(50015; "Pay Type"; Option)
        {
            Description = 'CS Field Added 08-01-2019';
            OptionCaption = ' ,Paid,Unpaid';
            OptionMembers = " ",Paid,Unpaid;
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
        }
        field(50016; Year; Code[20])
        {
            Description = 'CS Field Added 08-01-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(50017; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 08-01-2019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50018; Address4; Text[100])
        {
            Description = 'CS Field Added 10-01-2019';
            Caption = 'Address 4';
            DataClassification = CustomerContent;
        }
        field(50019; "Cor City"; Text[30])
        {
            Description = 'CS Field Added 10-01-2019';
            // TableRelation = "Post Code".City;
            Caption = 'Cor City';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Fields::CSPL-00092::05-01-2019: Start
                //recPostCode2CS.Reset();
                //recPostCode2CS.SETRANGE(recPostCode2CS.City, "Cor City");
                //IF recPostCode2CS.FindFirst() THEN BEGIN
                //    "Cor State" := recPostCode2CS.State;
                //    "Cor District" := recPostCode2CS.District;
                //    "Cor Country Code" := recPostCode2CS."Country/Region Code";

                //Code added for Assign Value in Fields::CSPL-00092::05-01-2019: End
            end;
        }
        field(50020; "Cor State"; Code[20])
        {
            Description = 'CS Field Added 10-01-2019';
            //TableRelation = State;
            Caption = 'Cor State';
            DataClassification = CustomerContent;
        }
        field(50021; "Cor Country Code"; Code[20])
        {
            Description = 'CS Field Added 10-01-2019';
            TableRelation = "Country/Region".Code;
            Caption = 'Cor Country Code';
            DataClassification = CustomerContent;
        }
        field(50022; "Cor Post Code"; Code[20])
        {
            Description = 'CS Field Added 10-01-2019';
            //  TableRelation = "Post Code".Code;
            Caption = 'Cor Post Code';
            DataClassification = CustomerContent;
        }
        field(50023; "Same As Permanent Address"; Boolean)
        {
            Description = 'CS Field Added 10-01-2019';
            Caption = 'Same as pPermanent Address';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Copy Address from Parmanent Address::CSPL-00092::05-01-2019: Start
                IF "Same As Permanent Address" = TRUE THEN BEGIN
                    Address4 := Address2;
                    Address3 := Address1;
                    "Cor City" := City;
                    "Cor State" := State;
                    "Cor Country Code" := "Country Code";
                    "Cor Post Code" := "Post Code";
                END ELSE BEGIN
                    Address4 := '';
                    Address3 := '';
                    "Cor City" := '';
                    "Cor State" := '';
                    "Cor Country Code" := '';
                    "Cor Post Code" := '';
                END;
                //Code added for Copy Address from Parmanent Address::CSPL-00092::05-01-2019: End
            end;
        }
        field(50024; Disability; Boolean)
        {
            Description = 'CS Field Added 10-01-2019';
            Caption = 'Disability';
            DataClassification = CustomerContent;
        }
        field(50025; "Record of Criminal Case"; Boolean)
        {
            Description = 'CS Field Added 10-01-2019';
            Caption = 'Record of Criminal Case';
            DataClassification = CustomerContent;
        }
        field(50026; "Marital Status"; Option)
        {
            Description = 'CS Field Added 22-05-2019';
            OptionCaption = ' ,Married,Unmarried';
            OptionMembers = " ",Married,Unmarried;
            Caption = 'Marital Status';
            DataClassification = CustomerContent;
        }
        field(50027; "Mother Tongue"; Code[20])
        {
            Description = 'CS Field Added 22-05-2019';
            TableRelation = "Mother Tongue-CS".Code;
            Caption = 'Mother Tongue';
            DataClassification = CustomerContent;
        }
        field(50028; "Parents Phone Number"; Text[10])
        {
            Description = 'CS Field Added 22-05-2019';
            Caption = 'Parents Phone No.';
            DataClassification = CustomerContent;
        }
        field(50029; "Parents Mobile Number"; Text[10])
        {
            Description = 'CS Field Added 22-05-2019';
            Caption = 'Parents Mobile No.';
            DataClassification = CustomerContent;
        }
        field(50030; "Parents Email Id"; Text[30])
        {
            Description = 'CS Field Added 22-05-2019';
            Caption = 'Parents Email No.';
            DataClassification = CustomerContent;
        }
        field(50031; "Resident Status"; Option)
        {
            Description = 'CS Field Added 22-05-2019';
            OptionCaption = ' ,Village,Town,City';
            OptionMembers = "  ",Village,Town,City;
            Caption = 'Resident Status';
            DataClassification = CustomerContent;
        }
        field(50032; "Pre qualification percentage"; Decimal)
        {
            Description = 'CS Field Added 22-05-2019';
            Caption = 'Pre Qualification Percentage';
            DataClassification = CustomerContent;
        }
        field(50033; "Discount Applicable"; Boolean)
        {
            Description = 'CS Field Added 02-06-2019';
            Caption = 'Discount Applicable';
            DataClassification = CustomerContent;
        }
        field(50034; "Discount Status"; Option)
        {
            Description = 'CS Field Added 02-06-2019';
            OptionCaption = 'Discount Pending,Discount Done';
            OptionMembers = "Discount Pending","Discount Done";
            Caption = 'Discount Status';
            DataClassification = CustomerContent;
        }
        field(50035; "Sub Religion"; Option)
        {
            Description = 'CS Field Added 02-06-2019';
            OptionCaption = ' ,SHWETAMBAR,DIGAMBAR';
            OptionMembers = " ",SHWETAMBAR,DIGAMBAR;
            Caption = 'Sub Religion';
            DataClassification = CustomerContent;
        }
        field(50036; "Cor District"; Text[30])
        {
            Description = 'CS Field Added 02-06-2019';
            Caption = 'Cor District';
            DataClassification = CustomerContent;
        }
        field(50037; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 02-06-2019';
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(50038; "Admission Date"; Date)
        {
            Description = 'CS Field Added 02-06-2019';
            Caption = 'Admission Date';
            DataClassification = CustomerContent;
        }
        field(50039; "Program Level"; Code[20])
        {
            Description = 'CS Field Added 03-06-2019';
            Caption = 'Program Level';
            DataClassification = CustomerContent;
        }
        field(50040; "Program Stream"; Code[20])
        {
            Description = 'CS Field Added 03-06-2019';
            Caption = 'Program Stream';
            DataClassification = CustomerContent;
        }
        field(50041; "Last Modification On"; Date)
        {
            Description = 'CS Field Added 15-08-2019';
            Caption = 'Last Modification On';
            DataClassification = CustomerContent;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 12-09-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 12-09-2019';
            DataClassification = CustomerContent;
        }
        field(33048925; District; Text[50])
        {
            Description = 'CS Field Added 12-09-2019';
            //    TableRelation = "Post Code"."District 3" WHERE("State Code" = FIELD(State));
            Caption = 'District';
            DataClassification = CustomerContent;
        }
        field(33048929; "Discount Code"; Code[20])
        {
            Description = 'CS Field Added 12-09-2019';
            TableRelation = "Fee Discount Head-CS";
            Caption = 'Discount Code';
            DataClassification = CustomerContent;
        }
        field(33048930; "Alloted Date"; Date)
        {
            Description = 'CS Field Added 12-09-2019';
            Editable = false;
            Caption = 'Alloted Code';
            DataClassification = CustomerContent;
        }
        field(33048931; "Transport Accommodation"; Boolean)
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Transport Accommodation';
            DataClassification = CustomerContent;
        }
        field(33048932; "Hostel Allow"; Boolean)
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Hostel Allow';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Transport Allow" := FALSE;
            end;
        }
        field(33048933; "Transport Allow"; Boolean)
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Transport Allow';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                "Hostel Allow" := FALSE;
            end;
        }
        field(33048934; Password; Text[30])
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Password';
            DataClassification = CustomerContent;
        }
        field(33048935; "Step Completed"; Integer)
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Step Completed';
            DataClassification = CustomerContent;
        }
        field(33048936; "Registration No."; Code[20])
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Registration No.';
            DataClassification = CustomerContent;
        }
        field(33048937; "Applicant Signature"; BLOB)
        {
            Caption = 'Applicant Image';
            Compressed = false;
            Description = 'CS Field Added 12-09-2019';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(33048938; Submited; Boolean)
        {
            Description = 'CS Field Added 12-09-2019';
            Caption = 'Submited';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Application Status", "Course Code", "Stage2 Selection List No.", "Call Letter Sent")
        {
        }
        key(Key3; "Application Status", "Course Code", "Stage2 Selection List No.")
        {
        }
        key(Key4; "Course Code", "Application Selection", "Rank Selection", Alloted, "Stage2 Selection List No.", "Selection Percentage")
        {
        }
        key(Key5; "Course Code", "Selected Quota", "Selection Percentage")
        {
        }
        key(Key6; "Course Code", "Application Selection", "Rank Selection", "Stage2 Selection List No.", "Selection Percentage")
        {
        }
        key(Key7; "Course Code", "Application Status", Alloted, Rejected, "Date of Receive")
        {
        }
        key(Key8; "Course Code", "Application Selection", "Stage1 Selection List No.", "Eligibility Percertage")
        {
        }
        key(Key9; "Course Code", "Stage2 Selection List No.", Alloted, Quota)
        {
        }
        key(Key10; "Application Status", "Course Code", "Stage1 Selection List No.", "Application Selection")
        {
        }
        key(Key11; "Course Code", "Stage1 Selection List No.", "Application Selection", "Rank Selection", Alloted, "Eligibility Percertage")
        {
        }
        key(Key12; "Application Status", "Course Code", "Date of Sale")
        {
        }
        key(Key13; "Application Status", "Course Code", "Date of Receive", Admitted)
        {
        }
        key(Key14; "Application Status", "Course Code", "Date of Receive", Alloted)
        {
        }
        key(Key15; "Course Code", "Stage2 Selection List No.", "Selection Percentage", "Rank Selection")
        {
        }
        key(Key16; "Course Code", "Application Status", Alloted, "Application Selection", "Date of Receive", "Stage1 Selection List No.")
        {
        }
        key(Key17; "Course Code", "Stage1 Selection List No.", "Eligibility Percertage", Quota)
        {
        }
        key(Key18; "Course Code", "Application Status", "Application Selection", "Date of Receive")
        {
        }
        key(Key19; "Course Code", "Stage1 Selection List No.", "Application Selection", Quota)
        {
        }
        key(Key20; "Course Code", "Stage2 Selection List No.", Alloted, "Admission Letter Sent")
        {
        }
        key(Key21; "Course Code", "Stage1 Selection List No.", "Application Selection", "Call Letter Sent")
        {
        }
        key(Key22; "Recommended List No.")
        {
        }
        key(Key23; "Course Code", "Academic Year", "Application Status", Admitted)
        {
        }
    }

    trigger OnInsert()
    begin
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::05-01-2019: Start
        "Academic Year" := recVerticalEducationCS.CreateAdmission_Yr();
        recAdmissionSetupCS.GET();
        IF "No.Series" = '' THEN BEGIN
            recAdmissionSetupCS.TESTFIELD("Application No.");
            recAdmissionSetupCS.TESTFIELD("Prospectus No.");
            NoSeriesManagement.InitSeries(recAdmissionSetupCS."Application No.", xRec."No.Series", 0D, "No.", "No.Series");
            NoSeriesManagement.InitSeries(recAdmissionSetupCS."Prospectus No.", xRec."No.Series", 0D, "Prospectus No.", "No.Series");
        END;
        "Date of Sale" := TODAY();
        "User ID" := FORMAT(UserId());
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::05-01-2019: End
    end;

    trigger OnModify()
    begin
        //Code added for Validate Data::CSPL-00092::05-01-2019: Start
        TESTFIELD("Applicant Name");
        //Code added for Validate Data::CSPL-00092::05-01-2019: End
    end;

    var

        //recPostCode1CS: Record "225";
        recAdmissionSetupCS: Record "Admission Setup-CS";

        recApplicationCS: Record "Application-CS";
        recQuotaCS: Record "Quota-CS";
        recCourseMasterCS: Record "Course Master-CS";
        recEduSetupCS: Record "Education Setup-CS";
        recApplicationCS1: Record "Application-CS";
        recCourseMasterCS1: Record "Course Master-CS";
        recCourseMasterCS2: Record "Course Master-CS";
        recApplicationCS2: Record "Application-CS";
        recVerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        Text000Lbl: Label 'Sale of Applications closed.';
        Text001Lbl: Label 'You cannot modify once the applications are sold.';

        Text002Lbl: Label 'Age limet for this course..%1..To..%2';

        //recPostCode2CS: Record "225";
        YearFlagCS: Boolean;
        SemesterFlagCS: Boolean;

        Text003Lbl: Label 'Enquiry No. %1 Allready In Use ';

    procedure Assistedit(OldApplication: Record "Application-CS"): Boolean
    BEGIN
        ;
        //Code added for Select No Series::CSPL-00092::05-01-2019: Start
        WITH recApplicationCS DO BEGIN
            recApplicationCS := Rec;
            recAdmissionSetupCS.GET();
            recAdmissionSetupCS.TESTFIELD("Application No.");
            IF NoSeriesManagement.SelectSeries(recAdmissionSetupCS."Application No.", OldApplication."No.Series", "No.Series") THEN BEGIN
                NoSeriesManagement.SetSeries("No.");
                Rec := recApplicationCS;
                EXIT(TRUE);
            END;


            recApplicationCS1 := Rec;
            recAdmissionSetupCS.GET();
            recAdmissionSetupCS.TESTFIELD("Prospectus No.");
            IF NoSeriesManagement.SelectSeries(recAdmissionSetupCS."Prospectus No.", OldApplication."No.Series", "No.Series") THEN BEGIN
                NoSeriesManagement.SetSeries("Prospectus No.");
                Rec := recApplicationCS1;
                EXIT(TRUE);
            END;

            //Code added for Select No Series::CSPL-00092::05-01-2019: End
        END;
    end;

    procedure GenerateCreditMemo()
    var
        FeeDiscountHeadCS: Record "Fee Discount Head-CS";
        FeeDiscountLineCS: Record "Fee Discount Line-CS";

        FeeCourseHeadCS: Record "Fee Course Head-CS";
        FeeCourseLineCS: Record "Fee Course Line-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        GenJournalLine: Record "Gen. Journal Line";
        StudentMasterCS: Record "Student Master-CS";
        FeeDiscountLineCS1: Record "Fee Discount Line-CS";
        DiscountPercent: Decimal;
        DiscountAmount: Decimal;
        CourseFeeAmtount: Decimal;
        TempDocumentNo: Code[20];
        Discriptiontext: Text[50];
        GLAccount: Code[20];
        LineNo: Integer;

        StudentNo: Code[20];

    begin
        //Code added for Create Credit Memo Voucher::CSPL-00092::05-01-2019: Start
        FeeDiscountHeadCS.Reset();
        FeeDiscountHeadCS.SETRANGE(FeeDiscountHeadCS."No.", "Discount Code");
        IF FeeDiscountHeadCS.FindFirst() THEN
            FeeDiscountLineCS1.Reset();
        FeeDiscountLineCS1.SETRANGE(FeeDiscountLineCS1."Document No.", FeeDiscountHeadCS."No.");
        IF FeeDiscountLineCS1.FINDSET() THEN
            FeeCourseHeadCS.Reset();
        FeeCourseHeadCS.SETRANGE("Course Code", "Course Code");
        IF FeeCourseHeadCS.FINDFIRST() THEN
            FeeCourseLineCS.Reset();
        FeeCourseLineCS.SETRANGE("Document No.", FeeCourseHeadCS."No.");
        FeeCourseLineCS.SETFILTER("Fee Code", FeeDiscountLineCS1."Fee Code");
        IF FeeCourseLineCS.FINDSET() THEN
            REPEAT
                CourseFeeAmtount := FeeCourseLineCS.Amount;
            UNTIL FeeCourseLineCS.NEXT() = 0;

        FeeDiscountLineCS.Reset();
        FeeDiscountLineCS.SETRANGE(FeeDiscountLineCS."Document No.", "Discount Code");
        IF FeeDiscountLineCS.FindSet() THEN
            REPEAT
                DiscountPercent := FeeDiscountLineCS."Discount%";
            UNTIL FeeDiscountLineCS.NEXT() = 0;

        Discriptiontext := FeeDiscountLineCS.Description;
        GLAccount := FeeDiscountLineCS."G/L Account";

        DiscountAmount := (CourseFeeAmtount * DiscountPercent) / 100;

        CLEAR(NoSeriesManagement);
        FeeSetupCS.GET();
        TempDocumentNo := NoSeriesManagement.GetNextNo(FeeSetupCS."Fee Discount No.", 0D, TRUE);


        GenJournalLine.Reset();
        GenJournalLine.SETFILTER("Journal Template Name", '%1', 'GENERAL');
        GenJournalLine.SETFILTER("Journal Batch Name", '%1', 'FEEINV');
        IF GenJournalLine.FINDLAST() THEN
            LineNo := GenJournalLine."Line No." + 10000
        ELSE
            LineNo := 10000;

        StudentMasterCS.Reset();
        StudentMasterCS.SETRANGE(StudentMasterCS."Enquiry No.", "Enquiry No.");
        IF StudentMasterCS.FindFirst() THEN
            StudentNo := StudentMasterCS."No.";


        IF DiscountAmount <> 0 THEN BEGIN
            GenJournalLine.INIT();
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine."Journal Batch Name" := 'FEEINV';
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::Customer;
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::"Credit Memo";
            GenJournalLine."Line No." := LineNo;
            GenJournalLine."Account No." := StudentNo;
            GenJournalLine.VALIDATE("Account No.");
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::"G/L Account";
            GenJournalLine."Bal. Account No." := GLAccount;
            GenJournalLine.Description := Discriptiontext + ' Against ' + FeeDiscountLineCS."Fee Code";
            GenJournalLine."Posting Date" := TODAY();
            GenJournalLine."Document Date" := TODAY();
            GenJournalLine.Amount := -DiscountAmount;
            GenJournalLine.VALIDATE(Amount);
            GenJournalLine.Course := "Course Code";
            GenJournalLine.Semester := Semester;
            GenJournalLine."Document No." := TempDocumentNo;
            GenJournalLine."Academic Year" := "Academic Year";
            GenJournalLine."Fee Code" := FeeDiscountLineCS."Fee Code";
            GenJournalLine.INSERT();
        END;
        //Code added for Create Credit Memo Voucher::CSPL-00092::05-01-2019: End
    end;

    procedure CalculatePercent()
    var
        MarksTotal: Decimal;
        SubjectTotal: Integer;
    begin
        //Code added for Find Pre Qualification Percent::CSPL-00092::05-01-2019: Start
        "Pre qualification percentage" := MarksTotal / SubjectTotal;
        Modify();
        //Code added for Find Pre Qualification Percent::CSPL-00092::05-01-2019: End
    end;

    procedure CheckPreQulification()
    var
        ApplPrequalificationCS: Record "Appl Prequalification-CS";
        CourseEligibleSummaryCS: Record "Course Eligible Summary-CS";
    begin
        //Code added for Check Pre Qulification::CSPL-00092::05-01-2019: Start
        recCourseMasterCS1.Reset();
        recCourseMasterCS1.SETRANGE(recCourseMasterCS1.Code, "Course Code");
        IF recCourseMasterCS1.FINDFIRST() AND recCourseMasterCS1."Optional Pre Qualification" = TRUE AND "Call Letter Sent" <> TRUE THEN BEGIN
            ApplPrequalificationCS.Reset();
            ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS."No.", "No.");
            IF ApplPrequalificationCS.FindFirst() THEN BEGIN
                CourseEligibleSummaryCS.Reset();
                CourseEligibleSummaryCS.SETRANGE(CourseEligibleSummaryCS."Course Code", ApplPrequalificationCS."Course Code");
                CourseEligibleSummaryCS.SETRANGE(CourseEligibleSummaryCS.Prequalification, ApplPrequalificationCS.Qualification);
                IF NOT CourseEligibleSummaryCS.FindFirst() THEN
                    ERROR('Not Eligible');
            END
        END ELSE
            IF "Call Letter Sent" <> TRUE THEN BEGIN
                CourseEligibleSummaryCS.Reset();
                CourseEligibleSummaryCS.SETRANGE(CourseEligibleSummaryCS."Course Code", "Course Code");
                IF CourseEligibleSummaryCS.FINDSET() THEN
                    REPEAT
                        ApplPrequalificationCS.Reset();
                        ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS."No.", "No.");
                        ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS.Qualification, CourseEligibleSummaryCS.Prequalification);
                        IF NOT ApplPrequalificationCS.FINDSET() THEN
                            ERROR('Not Eligible');
                    UNTIL CourseEligibleSummaryCS.NEXT() = 0;

            END;
        //Code added for Check Pre Qulification::CSPL-00092::05-01-2019: End
    end;

    procedure TestCollege()
    var
        UserSetup: Record "User Setup";
    begin
        //Code added for Validate data::CSPL-00092::05-01-2019: Start
        UserSetup.Reset();
        IF UserSetup."Global Dimension 1 Code" <> '' THEN BEGIN
            UserSetup.SETRANGE(UserSetup."User ID", "User ID");
            UserSetup.SETRANGE(UserSetup."Global Dimension 1 Code", "Global Dimension 1 Code");
            IF NOT UserSetup.FindFirst() THEN
                ERROR('You Have Not Permission For This College');

        END;
        //Code added for Validate data::CSPL-00092::05-01-2019: End
    end;

    procedure ApplyDiscount()
    var
        ApplPrequalificationCS: Record "Appl Prequalification-CS";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine1: Record "Gen. Journal Line";
        Customer: Record "Customer";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        AmountDiscount: Decimal;

        CustomerCode: Code[20];
        AmountFee: Decimal;

        DiscountFlag: Boolean;
    begin
        //Code added for Apply Discount::CSPL-00092::05-01-2019: Start
        CLEAR(CustomerCode);
        Customer.Reset();
        Customer.SETRANGE(Customer."Application No.", "No.");
        IF Customer.FindFirst() THEN BEGIN
            CustomerCode := Customer."No.";
            CustLedgerEntry.Reset();
            CustLedgerEntry.SETRANGE(CustLedgerEntry."Customer No.", Customer."No.");
            CustLedgerEntry.SETFILTER(CustLedgerEntry."Fee Code", 'TF');
            IF CustLedgerEntry.FindFirst() THEN BEGIN
                CustLedgerEntry.CALCFIELDS(CustLedgerEntry.Amount);
                AmountFee := CustLedgerEntry.Amount;
            END
        END;

        ApplPrequalificationCS.Reset();
        ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS."No.", "No.");
        ApplPrequalificationCS.SETFILTER(ApplPrequalificationCS."Percentage of Mark", '>=%1', 85);
        IF ApplPrequalificationCS.FIND('+') THEN
            AmountDiscount := ROUND((AmountFee * 25) / 100, 1, '=');


        ApplPrequalificationCS.Reset();
        ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS."No.", "No.");
        ApplPrequalificationCS.SETFILTER(ApplPrequalificationCS."Percentage of Mark", '%1..%2', 60, 69.9);
        IF ApplPrequalificationCS.FIND('+') THEN
            AmountDiscount := ROUND((AmountFee * 10) / 100, 1, '=');


        ApplPrequalificationCS.Reset();
        ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS."No.", "No.");
        ApplPrequalificationCS.SETFILTER(ApplPrequalificationCS."Percentage of Mark", '%1..%2', 70, 79.9);
        IF ApplPrequalificationCS.FIND('+') THEN
            AmountDiscount := ROUND((AmountFee * 15) / 100, 1, '=');


        ApplPrequalificationCS.Reset();
        ApplPrequalificationCS.SETRANGE(ApplPrequalificationCS."No.", "No.");
        ApplPrequalificationCS.SETFILTER(ApplPrequalificationCS."Percentage of Mark", '%1..%2', 80, 84.9);
        IF ApplPrequalificationCS.FIND('+') THEN
            AmountDiscount := ROUND((AmountFee * 20) / 100, 1, '=');


        IF recCourseMasterCS1.GET("Course Code") THEN
            DiscountFlag := recCourseMasterCS1."Discount Granted";



        IF ((AmountDiscount <> 0) AND ("Call Letter Sent" <> TRUE) AND (DiscountFlag <> FALSE)) THEN BEGIN
            GenJournalLine.INIT();
            GenJournalLine."Posting Date" := TODAY();
            GenJournalLine."Journal Template Name" := 'GENERAL';
            GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name");
            GenJournalLine."Journal Batch Name" := 'SPCDIS';
            GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name");
            GenJournalLine.VALIDATE(GenJournalLine."Posting Date");
            GenJournalLine."Document Type" := GenJournalLine."Document Type"::"Credit Memo";
            GenJournalLine."Document No." := CustomerCode;
            GenJournalLine.Description := 'Special Discount';
            GenJournalLine."Line No." += 1000;
            GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
            GenJournalLine.VALIDATE(GenJournalLine."Account Type");
            GenJournalLine."Account No." := '401700090';
            GenJournalLine.VALIDATE(GenJournalLine."Account No.");
            GenJournalLine.Amount := AmountDiscount;
            GenJournalLine.VALIDATE(GenJournalLine.Amount);
            GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Customer;
            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type");
            GenJournalLine."Bal. Account No." := CustomerCode;
            GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
            GenJournalLine."Posting No. Series" := 'FEEDIS';
            GenJournalLine.INSERT();
            GenJournalLine1.Reset();
            GenJournalLine1.SETRANGE(GenJournalLine1."Document No.", CustomerCode);
            IF GenJournalLine1.FindFirst() THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine1);

        END;
        //Code added for Apply Discount::CSPL-00092::05-01-2019: End
    end;

    procedure DiscApplyJain()
    var

        GenJournalLine1_L: Record "Gen. Journal Line";

        GenJournalLine_L: Record "Gen. Journal Line";
        Customer_L: Record "Customer";
        CustLedgerEntry_L: Record "Cust. Ledger Entry";

        DiscountAmount: Decimal;

        CustomerNo_L: Code[20];
        feeAmount_L: Decimal;

        DiscountFlag_L: Boolean;
        FeeCodeOnDisc_L: Code[10];
    begin
        //Code added for Jain  Discount::CSPL-00092::05-01-2019: Start
        CLEAR(CustomerNo_L);
        FeeCodeOnDisc_L := 'TF' + '|' + 'HOST';
        Customer_L.Reset();
        Customer_L.SETRANGE(Customer_L."Application No.", "No.");
        IF Customer_L.FindFirst() THEN Begin
            CustomerNo_L := Customer_L."No.";
            CustLedgerEntry_L.Reset();
            CustLedgerEntry_L.SETRANGE(CustLedgerEntry_L."Customer No.", Customer_L."No.");
            CustLedgerEntry_L.SETFILTER(CustLedgerEntry_L."Fee Code", FeeCodeOnDisc_L);
            IF CustLedgerEntry_L.FindSet() THEN
                REPEAT
                    CustLedgerEntry_L.CALCFIELDS(CustLedgerEntry_L.Amount);
                    feeAmount_L += CustLedgerEntry_L.Amount;
                UNTIL CustLedgerEntry_L.NEXT() = 0;

        END;

        DiscountAmount := ROUND((feeAmount_L * 50) / 100, 1, '=');

        IF recCourseMasterCS1.GET("Course Code") THEN
            DiscountFlag_L := recCourseMasterCS1."Discount Granted";


        IF DiscountFlag_L <> FALSE THEN BEGIN
            GenJournalLine_L.INIT();
            GenJournalLine_L."Posting Date" := TODAY();
            GenJournalLine_L."Journal Template Name" := 'GENERAL';
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Journal Template Name");
            GenJournalLine_L."Journal Batch Name" := 'SPCDIS';
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Journal Batch Name");
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Posting Date");
            GenJournalLine_L."Document Type" := GenJournalLine_L."Document Type"::"Credit Memo";
            GenJournalLine_L."Document No." := CustomerNo_L;
            GenJournalLine_L.Description := 'Jain Scholarship';
            GenJournalLine_L."Line No." += 1000;
            GenJournalLine_L."Account Type" := GenJournalLine_L."Account Type"::"G/L Account";
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Account Type");
            GenJournalLine_L."Account No." := '401700090';
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Account No.");
            GenJournalLine_L.Amount := DiscountAmount;
            GenJournalLine_L.VALIDATE(GenJournalLine_L.Amount);
            GenJournalLine_L."Bal. Account Type" := GenJournalLine_L."Bal. Account Type"::Customer;
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Bal. Account Type");
            GenJournalLine_L."Bal. Account No." := CustomerNo_L;
            GenJournalLine_L.VALIDATE(GenJournalLine_L."Bal. Account No.");
            GenJournalLine_L."Posting No. Series" := 'FEEDIS';
            GenJournalLine_L.INSERT();
            GenJournalLine1_L.Reset();
            GenJournalLine1_L.SETRANGE(GenJournalLine1_L."Document No.", CustomerNo_L);
            IF GenJournalLine1_L.FindFirst() THEN
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine1_L);
        END;
        //Code added for Jain  Discount::CSPL-00092::05-01-2019: End
    end;

    procedure OnSpotReceiptFee(ApplicationNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine1: Record "Gen. Journal Line";
        AdmissionSetupCS: Record "Admission Setup-CS";
        Customer: Record "Customer";
        CustomerNo: Code[20];
    begin
        //Code added for Create Procpectus Fee::CSPL-00092::05-01-2019: Start
        AdmissionSetupCS.GET();
        Customer.Reset();
        Customer.SETRANGE(Customer."Application No.", "No.");
        IF Customer.FindFirst() THEN
            CustomerNo := Customer."No.";

        GenJournalLine.INIT();
        GenJournalLine."Posting Date" := TODAY();
        GenJournalLine."Journal Template Name" := AdmissionSetupCS."Template Name";
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name");
        GenJournalLine."Journal Batch Name" := AdmissionSetupCS."Application Sales Batch Name";
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name");
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date");
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;
        GenJournalLine."Document No." := ApplicationNo;
        GenJournalLine."Line No." += 1000;
        GenJournalLine."Fee Code" := 'PROS';
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine.VALIDATE(GenJournalLine."Account Type");
        GenJournalLine."Account No." := AdmissionSetupCS."Application Cost Account No.";
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Credit Amount" := AdmissionSetupCS."Application Cost For Reserve";
        GenJournalLine.VALIDATE(GenJournalLine."Credit Amount");
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Customer;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type");
        GenJournalLine."Bal. Account No." := CustomerNo;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine.INSERT();
        GenJournalLine1.Reset();
        GenJournalLine1.SETRANGE(GenJournalLine1."Document No.", ApplicationNo);
        IF GenJournalLine1.FindFirst() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine1);

        //Code added for Create Procpectus Fee::CSPL-00092::05-01-2019: End
    end;

    procedure FeeHostal(ApplicationNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalLine1: Record "Gen. Journal Line";
        AdmissionSetupCS: Record "Admission Setup-CS";
        FeeSetupCS: Record "Fee Setup-CS";
        Customer: Record "Customer";
        CustomerNo: Code[20];
        HostelAmount: Decimal;
        TempDocNo: Code[20];
    begin
        //Code added for Create Hostel Fee::CSPL-00092::05-01-2019: Start
        AdmissionSetupCS.GET();
        FeeSetupCS.GET();
        Customer.Reset();
        Customer.SETRANGE(Customer."Application No.", "No.");
        IF Customer.FindFirst() THEN
            CustomerNo := Customer."No.";

        CLEAR(NoSeriesManagement);
        TempDocNo := NoSeriesManagement.GetNextNo(FeeSetupCS."Hostal No", 0D, TRUE);
        HostelAmount := 0;
        GenJournalLine.INIT();
        GenJournalLine."Posting Date" := TODAY();
        GenJournalLine."Journal Template Name" := FeeSetupCS."Journal Template Name";
        GenJournalLine.VALIDATE(GenJournalLine."Journal Template Name");
        GenJournalLine."Journal Batch Name" := FeeSetupCS."Journal Batch Name";
        GenJournalLine.VALIDATE(GenJournalLine."Journal Batch Name");
        GenJournalLine.VALIDATE(GenJournalLine."Posting Date");
        GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;
        GenJournalLine."Document No." := TempDocNo;
        GenJournalLine."Line No." += 1000;
        GenJournalLine."Account Type" := GenJournalLine."Account Type"::"G/L Account";
        GenJournalLine.VALIDATE(GenJournalLine."Account Type");
        GenJournalLine."Account No." := '372000010';
        GenJournalLine."Source Code" := 'FEE';
        GenJournalLine."Fee Code" := 'HOST';
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Credit Amount" := HostelAmount;//?
        GenJournalLine.VALIDATE(GenJournalLine."Credit Amount");
        GenJournalLine."Bal. Account Type" := GenJournalLine."Bal. Account Type"::Customer;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account Type");
        GenJournalLine."Bal. Account No." := CustomerNo;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine.INSERT();



        GenJournalLine1.Reset();
        GenJournalLine1.SETRANGE(GenJournalLine1."Document No.", TempDocNo);
        IF GenJournalLine1.FindFirst() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine1);

        //Code added for Create Hostel Fee::CSPL-00092::05-01-2019: End
    end;

    procedure Transpotfee(ApplicationNo: Code[20])
    var
        recGenJournalLine: Record "Gen. Journal Line";
        recGenJournalLine1: Record "Gen. Journal Line";
        ApplicationSetup: Record "Admission Setup-CS";
        recCustomer: Record "Customer";
        FeeSetup: Record "Fee Setup-CS";
        NoSeries: Codeunit "NoSeriesManagement";
        CustomerNo: Code[20];
        TransAmount: Decimal;

        TempDocNo: Code[20];

    begin
        //Code added for Create Transpot Fee::CSPL-00092::05-01-2019: Start
        ApplicationSetup.GET();
        FeeSetup.GET();
        recCustomer.Reset();
        recCustomer.SETRANGE(recCustomer."Application No.", "No.");
        IF recCustomer.FindFirst() THEN
            CustomerNo := recCustomer."No.";

        CLEAR(NoSeries);
        TempDocNo := NoSeries.GetNextNo(FeeSetup."Transport No", 0D, TRUE);
        TransAmount := 0;
        recGenJournalLine.INIT();
        recGenJournalLine."Posting Date" := TODAY();
        recGenJournalLine."Journal Template Name" := ApplicationSetup."Template Name";
        recGenJournalLine.VALIDATE(recGenJournalLine."Journal Template Name");
        recGenJournalLine."Journal Batch Name" := ApplicationSetup."Application Sales Batch Name";
        recGenJournalLine.VALIDATE(recGenJournalLine."Journal Batch Name");
        recGenJournalLine.VALIDATE(recGenJournalLine."Posting Date");
        recGenJournalLine."Document Type" := recGenJournalLine."Document Type"::Invoice;
        recGenJournalLine."Document No." := TempDocNo;
        recGenJournalLine."Line No." += 1000;
        recGenJournalLine."Account Type" := recGenJournalLine."Account Type"::"G/L Account";
        recGenJournalLine.VALIDATE(recGenJournalLine."Account Type");
        recGenJournalLine."Account No." := '373000010';
        recGenJournalLine."Source Code" := 'FEE';
        recGenJournalLine."Fee Code" := 'TRAN';
        recGenJournalLine.VALIDATE(recGenJournalLine."Account No.");
        recGenJournalLine."Credit Amount" := TransAmount;
        recGenJournalLine.VALIDATE(recGenJournalLine."Credit Amount");
        recGenJournalLine."Bal. Account Type" := recGenJournalLine."Bal. Account Type"::Customer;
        recGenJournalLine.VALIDATE(recGenJournalLine."Bal. Account Type");
        recGenJournalLine."Bal. Account No." := CustomerNo;
        recGenJournalLine.VALIDATE(recGenJournalLine."Bal. Account No.");
        recGenJournalLine.INSERT();


        recGenJournalLine1.Reset();
        recGenJournalLine1.SETRANGE(recGenJournalLine1."Document No.", TempDocNo);
        IF recGenJournalLine1.FindFirst() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", recGenJournalLine1);

        //Code added for Create Transpot Fee::CSPL-00092::05-01-2019: End
    end;

    procedure HostalFeeMic(ApplicationNo: Code[20])
    var
        recGenJournalLine: Record "Gen. Journal Line";
        recGenJournalLine1: Record "Gen. Journal Line";
        ApplicationSetup: Record "Admission Setup-CS";
        FeeSetup: Record "Fee Setup-CS";
        recCustomer: Record "Customer";
        NoSeries: Codeunit "NoSeriesManagement";
        CustomerNo: Code[20];
        TempDocNo: Code[20];


    begin
        ApplicationSetup.GET();
        FeeSetup.GET();
        recCustomer.Reset();
        recCustomer.SETRANGE(recCustomer."Application No.", ApplicationNo);
        IF recCustomer.FindFirst() THEN
            CustomerNo := recCustomer."No.";

        CLEAR(NoSeries);
        TempDocNo := NoSeries.GetNextNo(FeeSetup."Hostal No", 0D, TRUE);

        recGenJournalLine.INIT();
        recGenJournalLine."Posting Date" := TODAY();
        recGenJournalLine."Journal Template Name" := FeeSetup."Journal Template Name";
        recGenJournalLine.VALIDATE(recGenJournalLine."Journal Template Name");
        recGenJournalLine."Journal Batch Name" := FeeSetup."Journal Batch Name";
        recGenJournalLine.VALIDATE(recGenJournalLine."Journal Batch Name");
        recGenJournalLine.VALIDATE(recGenJournalLine."Posting Date");
        recGenJournalLine."Document Type" := recGenJournalLine."Document Type"::Invoice;
        recGenJournalLine."Document No." := TempDocNo;
        recGenJournalLine."Line No." += 1000;
        recGenJournalLine."Account Type" := recGenJournalLine."Account Type"::"G/L Account";
        recGenJournalLine.VALIDATE(recGenJournalLine."Account Type");
        recGenJournalLine."Account No." := '372000010';
        recGenJournalLine."Source Code" := 'FEE';
        recGenJournalLine."Fee Code" := 'HOST';
        recGenJournalLine.VALIDATE(recGenJournalLine."Account No.");
        recGenJournalLine."Credit Amount" := 1000;
        recGenJournalLine.VALIDATE(recGenJournalLine."Credit Amount");
        recGenJournalLine."Bal. Account Type" := recGenJournalLine."Bal. Account Type"::Customer;
        recGenJournalLine.VALIDATE(recGenJournalLine."Bal. Account Type");
        recGenJournalLine."Bal. Account No." := CustomerNo;
        recGenJournalLine.VALIDATE(recGenJournalLine."Bal. Account No.");
        recGenJournalLine.INSERT();


        recGenJournalLine1.Reset();
        recGenJournalLine1.SETRANGE(recGenJournalLine1."Document No.", TempDocNo);
        IF recGenJournalLine1.FindFirst() THEN
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", recGenJournalLine1);

    end;
}