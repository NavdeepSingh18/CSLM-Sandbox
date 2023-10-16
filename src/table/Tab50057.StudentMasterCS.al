// dotnet
// {
//     assembly("System.Net.Http, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a")
//     {
//         type("System.Net.Http.HttpResponseMessage"; HttpResponseMessage1) { }
//     }
// }
// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type(System.Object; null1) { }
//     }
// }
// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type(System.IO.MemoryStream; ImageStream1) { }
//     }
// }

table 50057 "Student Master-CS"
{
    // version V.001-CS

    // Sr.No.    Emp. ID     Date          Trigger                                           Remarks
    // 1         CSPL-00092    06-05-2019    OnInsert                                          No. Series and Assign Value in Fields
    // 2         CSPL-00092    06-05-2019    OnModify                                          Assign Value in Fields
    // 3         CSPL-00092    06-05-2019    First Name - OnValidate                           Call function for Find Student Full Name
    // 4         CSPL-00092    06-05-2019    Middle Name - OnValidate                          Call function for Find Student Full Name
    // 5         CSPL-00092    06-05-2019    Last Name - OnValidate                            Call function for Find Student Full Name
    // 6         CSPL-00092    06-05-2019    Roll No. - OnValidate                             Call function for Update Customer
    // 7         CSPL-00092    06-05-2019    Student Name - OnValidate                         Call function for Update Customer
    // 8         CSPL-00092    06-05-2019    Date of Birth - OnValidate                        Find Date of Birth
    // 9         CSPL-00092    06-05-2019    Academic Year - OnValidate                        Call function for Update Customer
    // 10        CSPL-00092    06-05-2019    Course Code - OnValidate                          Assigne Value in Fields Call function for Update Customer
    // 11        CSPL-00092    06-05-2019    Address1 - OnValidate                             Call function for Update Customer
    // 12        CSPL-00092    06-05-2019    Address2 - OnValidate                             Call function for Update Customer
    // 13        CSPL-00092    06-05-2019    City - OnValidate                                 Call function for Update Customer
    // 14        CSPL-00092    06-05-2019    Post Code - OnValidate                            Call function for Update Customer
    // 15        CSPL-00092    06-05-2019    Country Code - OnValidate                         Call function for Update Customer and Assign Value in Fields
    // 16        CSPL-00092    06-05-2019    E-Mail Address - OnValidate                       Call function for Update Customer and Assign Value in Fields
    // 17        CSPL-00092    06-05-2019    Phone Number - OnValidate                         Call function for Update Customer and Assign Value in Fields
    // 18        CSPL-00092    06-05-2019    Fathers Annual Income - OnValidate                Assign Value in Fields
    // 19        CSPL-00092    06-05-2019    Mothers Annual Income - OnValidate                Assign Value in Fields
    // 20        CSPL-00092    06-05-2019    Guardian Annual Income - OnValidate               Assign Value in Field
    // 21        CSPL-00092    06-05-2019    Staff Code - OnValidate                           Assign Value in Fields
    // 22        CSPL-00092    06-05-2019    Semester - OnValidate                             Call function for Update Customer
    // 23        CSPL-00092    06-05-2019    Fee Classification Code - OnValidate              Call function for Update Customer
    // 24        CSPL-00092    06-05-2019    Section - OnValidate                              Call function for Update Customer
    // 25        CSPL-00092    06-05-2019    Student Status - OnValidate                       Validate data and Assign Value In Fields
    // 26        CSPL-00092    06-05-2019    Admitted Year - OnValidate                        Call function for Update Customer
    // 27        CSPL-00092    06-05-2019    Application No. - OnValidate                      Validate data,Call function for Update Customer
    // 28        CSPL-00092    06-05-2019    Global Dimension 1 Code - OnValidate              Call function for Update Customer
    // 29        CSPL-00092    06-05-2019    Global Dimension 2 Code - OnValidate              Call function for Update Customer
    // 30        CSPL-00092    06-05-2019    Category - OnValidate                             Call function for Update Customer
    // 31        CSPL-00092    06-05-2019    Branch Transfer - OnValidate                      Call function for Update Customer
    // 32        CSPL-00092    06-05-2019    Batch - OnValidate                                Call function for Update Customer
    // 33        CSPL-00092    06-05-2019    Year - OnValidate                                 Call function for Update Customer
    // 34        CSPL-00092    06-05-2019    Same As Permanent Address - OnValidate            Assign Value in Fields
    // 35        CSPL-00092    06-05-2019    Parents Income - OnValidate                       Call function for Update Customer
    // 36        CSPL-00092    06-05-2019    Scholarship Source - OnValidate                   Call function for Update Customer
    // 37        CSPL-00092    06-05-2019    Semester II Credit Earned - OnValidate            Assign Value in Field
    // 38        CSPL-00092    06-05-2019    Semester IV Credit Earned - OnValidate            Assign Value in Field
    // 39        CSPL-00092    06-05-2019    Semester VI Credit Earned - OnValidate            Assign Value in Field
    // 40        CSPL-00092    06-05-2019    Semester VIII Credit Earned - OnValidate          Assign Value in Field
    // 41        CSPL-00092    06-05-2019    Pending For Registration - OnValidate             Call function for Update Customer
    // 42        CSPL-00092    06-05-2019    Course Completion NOC - OnValidate                Call function for Update Customer
    // 43        CSPL-00092    06-05-2019    Enrollment No. - OnValidate                       Validate and Update Data
    // 44        CSPL-00092    06-05-2019    Hold Result - OnValidate                          Validate and Update Data
    // 45        CSPL-00092    06-05-2019    Entrance Test Rank - OnValidate                   Call function for Update Customer
    // 46        CSPL-00092    06-05-2019    Lateral Student - OnValidate                      Call function for Update Customer
    // 47        CSPL-00092    06-05-2019    FilterStudentCollegeWise                          Run Page
    // 48        CSPL-00092    06-05-2019    StudentFullName Find Student                      Full Name
    // 49        CSPL-00092    06-05-2019    UpdateCustomer                                    Function for Update Customer
    // 50        CSPL-00092    06-05-2019    PortalUser                                        Insert Portal User
    // 52        CSPL-00092    06-05-2019    CreditStudentToCustomer                           Generate Student to Customer
    // 53        CSPL-00092    06-05-2019    StudentCollegeINIT                                Assign Value in Field

    Caption = 'Student Master';
    //DataCaptionFields = "No.", "Enrollment No.", "Course Code", "Course Name";
    DrillDownPageID = "Student Details-CS";
    LookupPageID = "Student Details-CS";
    DataCaptionFields = "Original Student No.", "Student Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'SLcM No.';
            //NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "First Name"; Text[35])
        {
            Caption = 'First Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            Var
                StudentMasterRec: Record "Student Master-CS";

            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start\ Stud.Reset();
                if Rec."Original Student No." <> '' then begin
                    StudentMasterRec.Reset();
                    StudentMasterRec.SetRange("Original Student No.", Rec."Original Student No.");
                    StudentMasterRec.Setfilter("Enrollment No.", '<>%1', Rec."Enrollment No.");
                    if StudentMasterRec.FindSet() then
                        repeat
                            StudentMasterRec."First Name" := Rec."First Name";
                            StudentMasterRec.Modify(true);
                        until StudentMasterRec.Next() = 0;
                end;
                StudentFullName();
                //Code added for Call function for Find Student Full Name::CSPL-00092::06-05-2019:
            end;
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            Var
                StudentMasterRec: Record "Student Master-CS";

            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start\ Stud.Reset();
                if Rec."Original Student No." <> '' then begin
                    StudentMasterRec.Reset();
                    StudentMasterRec.SetRange("Original Student No.", Rec."Original Student No.");
                    StudentMasterRec.Setfilter("Enrollment No.", '<>%1', Rec."Enrollment No.");
                    if StudentMasterRec.FindSet() then
                        repeat
                            StudentMasterRec."Middle Name" := Rec."Middle Name";
                            StudentMasterRec.Modify(true);
                        until StudentMasterRec.Next() = 0;
                end;
                StudentFullName();
                //Code added for Call function for Find Student Full Name::CSPL-00092::06-05-2019: End
            end;
        }
        field(4; "Last Name"; Text[35])
        {
            Caption = 'Last Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            Var
                StudentMasterRec: Record "Student Master-CS";

            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start\ Stud.Reset();
                if Rec."Original Student No." <> '' then begin
                    StudentMasterRec.Reset();
                    StudentMasterRec.SetRange("Original Student No.", Rec."Original Student No.");
                    StudentMasterRec.Setfilter("Enrollment No.", '<>%1', Rec."Enrollment No.");
                    if StudentMasterRec.FindSet() then
                        repeat
                            StudentMasterRec."Last Name" := Rec."Last Name";
                            StudentMasterRec.Modify(true);
                        until StudentMasterRec.Next() = 0;
                end;
                StudentFullName();
                //Code added for Call function for Find Student Full Name::CSPL-00092::06-05-2019: End
            end;
        }
        field(5; "Name as on Certificate"; Text[100])
        {
            Caption = 'Name as on Certificate';
            DataClassification = CustomerContent;
        }
        field(6; "Roll No."; Code[10])
        {

            Caption = 'Roll No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(8; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            Var
                StudentMasterRec: Record "Student Master-CS";
                StudentSubjectRec: Record "Main Student Subject-CS";
                StudentSubjectExamRec: Record "Student Subject Exam";
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start\ Stud.Reset();
                if Rec."Original Student No." <> '' then begin
                    StudentMasterRec.Reset();
                    StudentMasterRec.SetRange("Original Student No.", Rec."Original Student No.");
                    StudentMasterRec.Setfilter("Enrollment No.", '<>%1', Rec."Enrollment No.");
                    if StudentMasterRec.FindSet() then
                        repeat
                            StudentMasterRec."Student Name" := Rec."Student Name";
                            StudentMasterRec.Modify(true);
                        until StudentMasterRec.Next() = 0;

                    StudentSubjectRec.Reset();
                    StudentSubjectRec.SetRange("Original Student No.", Rec."Original Student No.");
                    if StudentSubjectRec.FindSet() then
                        repeat
                            StudentSubjectRec."Student Name" := Rec."Student Name";
                            StudentSubjectRec.Modify(true);
                        until StudentSubjectRec.Next() = 0;

                    StudentSubjectExamRec.Reset();
                    StudentSubjectExamRec.SetRange("Original Student No.", Rec."Original Student No.");
                    if StudentSubjectExamRec.FindSet() then
                        repeat
                            StudentSubjectExamRec."Student Name" := Rec."Student Name";
                            StudentSubjectExamRec.Modify(true);
                        until StudentSubjectExamRec.Next() = 0;
                end;
                UpdateCustomer();
                "Name as on Certificate" := "Student Name";
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
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
                //Code added for Find Date of Birth::CSPL-00092::06-05-2019: Start
                IF "Date of Birth" <> 0D THEN BEGIN
                    Age := TODAY() - "Date of Birth";
                    TempAge := ROUND(Age / 365, 1, '=');
                    Age2 := Age MOD 365;
                    Months := ROUND(Age2 / 30, 1, '=');
                    Age := TempAge - 1;
                END ELSE BEGIN
                    CLEAR(Age);
                    CLEAR(Months);
                END;
                //Code added for Find Date of Birth::CSPL-00092::06-05-2019: End
            end;
        }
        field(10; "Fathers Name"; Text[40])
        {
            Caption = 'Fathers Name';
            DataClassification = CustomerContent;
        }
        field(11; "Mothers Name"; Text[40])
        {
            Caption = 'Mothers Name';
            DataClassification = CustomerContent;
        }
        // field(12; Citizenship; Code[20])
        // {
        //     Caption = 'Citizenship';
        //     DataClassification = CustomerContent;
        //     TableRelation = "Country/Region";
        // }
        field(12; Citizenship; Option)
        {
            Caption = 'Citizenship';
            OptionMembers = " ","Eligible Non Citizen","Non-Citizen","US Citizen",Unknown;

        }
        field(13; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(14; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));

            trigger OnValidate()
            var
                Sem: Record "Semester Master-CS";
                ExtraChar: Code[1];

            begin
                //"Fee Classification Code" := 'General';
                //Category := 'FE';
                MandatoryFieldsCheck();
                //Code added for Assign Value in Fields Call function for Update Customer::CSPL-00092::06-05-2019: Start
                ExtraChar := '';
                if "Parent Student No." = '' then begin
                    Validate("Original Student No.", "No.");
                    Validate("Enrollment Order", 1);
                end;
                CourseMasterCS.Reset();
                CourseMasterCS.SETRANGE(CourseMasterCS.Code, "Course Code");
                IF CourseMasterCS.FindFirst() THEN BEGIN
                    "Course Name" := CourseMasterCS.Description;
                    "Remaining Academic SAP" := CourseMasterCS."Academic SAP";
                    Graduation := CourseMasterCS.Graduation;
                    "Type Of Course" := CourseMasterCS."Type Of Course";
                    "Global Dimension 1 Code" := CourseMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := CourseMasterCS."Global Dimension 2 Code";
                    if "Enrollment No." = '' then begin
                        TestField(Semester);
                        TestField(Graduation);
                        Sem.get(Semester, Graduation);
                        if not CourseMasterCS."Lateral Entry Allowed" then
                            sem.TestField(Sequence, 1);
                        CourseMasterCS.TestField(CourseMasterCS."Enrollment Nos.");
                        Validate("Enrollment No.", NoSeriesMgmt.GetNextNo(CourseMasterCS."Enrollment Nos.", 0D, TRUE));
                        //EmailTemplate(Rec);
                        StudentGroup.EnableStudentGroupCode(Rec);
                    end;
                END ELSE BEGIN
                    "Global Dimension 2 Code" := '';
                    "Type Of Course" := "Type Of Course"::" ";
                    "Global Dimension 1 Code" := '';
                    "Course Name" := '';
                    "Remaining Academic SAP" := 0;
                    Graduation := '';
                END;
                GFPAndMSHHSCourseProcess();
                UpdateCustomer();
                If Rec."Student SFP Initiation" <> 0 then
                    Rec.Validate(Rec."SAFI Sync", Rec."SAFI Sync"::Pending);
                IF ("Course Code" In ['STDPROG', 'AUA-GHT']) and (Semester = 'MED1') then
                    UpdateDummyStudentSubject(Rec, Rec."Course Code", Rec.Semester, Rec."Academic Year", Rec.Term);         //15 Dec 2021
                //Code added for Assigne Value in Fields Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(15; "University Interested"; Code[20])
        {
            Caption = 'University Interested';
            DataClassification = CustomerContent;
        }
        field(17; Prequalification; Code[20])
        {
            Caption = 'Prequalification';
            TableRelation = "Not Sync Document-CS";
            DataClassification = CustomerContent;
        }
        field(18; "Name of Previous Inst"; Text[30])
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
        }
        field(21; "Address To"; Text[50])
        {
            Caption = 'Address To';
            DataClassification = CustomerContent;
        }
        field(22; Addressee; Text[100])
        {
            Caption = 'Addressee';
            DataClassification = CustomerContent;
        }
        field(23; Address1; Text[100])
        {
            Caption = 'Present Address1';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(24; Address2; Text[100])
        {
            Caption = 'Present Address2';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(25; City; Text[30])
        {
            Caption = 'City';
            DataClassification = CustomerContent;
            // TableRelation = "Post Code".City;
            // Editable = false;
            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(26; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = CustomerContent;
            // TableRelation = if ("Country Code" = const()) "Post Code"
            // else
            // if ("Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Country Code"));
            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Fields Call function for Update Customer::CSPL-00092::06-05-2019: End
                // PostCodeRec.Reset();
                // PostCodeRec.SetRange(PostCodeRec.Code, "Post Code");
                // IF PostCodeRec.FindFirst() THEN BEGIN
                //     "Country Code" := PostCodeRec."Country/Region Code";
                //     city := PostCodeRec.City;
                //     State := PostCodeRec."State Code";
                // END ELSE BEGIN
                //     "Country Code" := '';
                //     city := '';
                //     State := '';
                // END;
            end;


        }
        field(27; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer and Assign Value in Fields::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //CountryRegion.Reset();
                //CountryRegion.SETRANGE(CountryRegion.Code, "Country Code");
                //CountryRegion.SETRANGE(CountryRegion.EWS, TRUE);
                //CountryRegion.FINDFIRST();
                // "Fee Classification Code" := 'FOREIGN/NRI';
                //Category := 'FE';
                //Code added for Fields Call function for Update Customer and Assign Value in Fields::CSPL-00092::06-05-2019: End
            end;
        }
        field(28; "E-Mail Address"; Text[50])
        {
            Caption = 'E-Mail Address';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer  and Assign Value in Fields::CSPL-00092::06-05-2019: Start
                UpdateCustomer();

                IF "E-Mail Address" <> xRec."E-Mail Address" THEN BEGIN
                    PortalUserLoginCS2.Reset();
                    PortalUserLoginCS2.SETRANGE(U_ID, "No.");
                    PortalUserLoginCS2.SETRANGE("User Group", 'Student');
                    IF PortalUserLoginCS2.FINDFIRST() THEN BEGIN
                        PortalUserLoginCS2.Email := "E-Mail Address";
                        PortalUserLoginCS2.Updated := TRUE;
                        Updated := TRUE;
                        PortalUserLoginCS2."Created By" := FORMAT(UserId());
                        PortalUserLoginCS2."Created On" := TODAY();
                        PortalUserLoginCS2.Modify();
                    END;
                END;
                //Code added for Fields Call function for Update Customer  and Assign Value in Fields::CSPL-00092::06-05-2019: End
            end;
        }
        field(29; "Mobile Number"; Text[30])
        {
            Caption = 'Mobile Number';
            ExtendedDatatype = PhoneNo;
            DataClassification = CustomerContent;
        }
        field(30; "Phone Number"; Text[30])
        {
            Caption = 'Phone Number';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Fields Call function for Update Customer  and Assign Value in Fields::CSPL-00092::06-05-2019: Start
                UpdateCustomer();

                IF "Phone Number" <> xRec."Phone Number" THEN BEGIN
                    PortalUserLoginCS2.Reset();
                    PortalUserLoginCS2.SETRANGE(U_ID, "No.");
                    PortalUserLoginCS2.SETRANGE(PortalUserLoginCS2."User Group", 'Student');
                    IF PortalUserLoginCS2.FINDFIRST() THEN BEGIN
                        PortalUserLoginCS2.MobileNo := "Phone Number";
                        PortalUserLoginCS2.Updated := TRUE;
                        Updated := TRUE;
                        PortalUserLoginCS2."Created By" := FORMAT(UserId());
                        PortalUserLoginCS2."Created On" := TODAY();
                        PortalUserLoginCS2.Modify();
                    END;
                END;
                //Code added for Fields Call function for Update Customer  and Assign Value in Fields::CSPL-00092::06-05-2019: End
            end;
        }
        field(31; Gender; Option)
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Female,Male,Not Specified';
            OptionMembers = " ",Female,Male,"Not Specified";
        }
        field(32; State; Code[20])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            // Editable = false;
            TableRelation = if ("Country Code" = const()) "State SLcM CS"
            else
            if ("Country Code" = FILTER(<> '')) "State SLcM CS" WHERE("Country/Region Code" = field("Country Code"));

            // trigger OnLookup()
            // begin
            //     PostCodeRec.RESET();
            //     PostCodeRec.FINDSET();
            //     IF PAGE.RUNMODAL(367, PostCodeRec) = ACTION::LookupOK THEN
            //         State := FORMAT(PostCodeRec.County);
            // end;
        }
        field(34; Address3; Text[50])
        {
            Caption = 'Address3';
            DataClassification = CustomerContent;
        }
        field(36; "Visa Expiry Date"; Date)
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
            DataClassification = CustomerContent;
            OptionCaption = ' ,Veg,Non Veg';
            OptionMembers = " ",Veg,"Non Veg";
        }
        field(40; "Pass Port No."; Text[20])
        {
            Caption = 'Passport No.';
            DataClassification = CustomerContent;
        }
        field(41; "Pass Port Expiry Date"; Date)
        {
            Caption = 'Passport Exp Date';
            DataClassification = CustomerContent;
        }
        field(42; Caste; Code[20])
        {
            Caption = 'Caste';
            DataClassification = CustomerContent;
            TableRelation = "Caste Master-CS";
        }
        field(45; "Promotion Granted"; Boolean)
        {
            Caption = 'Promotion Granted';
            DataClassification = CustomerContent;
        }
        field(49; "Applicant Image"; BLOB)
        {
            Caption = 'Applicant Image';
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
            DataClassification = CustomerContent;
            TableRelation = Relative;
        }
        field(54; Quota; Code[10])
        {
            Caption = 'Quota';
            TableRelation = "Quota-CS";
            DataClassification = CustomerContent;
        }
        field(57; "Fathers Occupation"; Text[20])
        {
            Caption = 'Fathers Occupation';
            DataClassification = CustomerContent;
        }
        field(58; "Fathers Annual Income"; Decimal)
        {
            Caption = 'Fathers Annual Income';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: Start
                "Total Family Income" := "Fathers Annual Income";
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(60; "Mothers Occupation"; Text[20])
        {
            Caption = 'Mothers Occupation';
            DataClassification = CustomerContent;
        }
        field(61; "Mothers Annual Income"; Decimal)
        {
            Caption = 'Mothers Annual Income';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: Start
                "Total Family Income" := "Fathers Annual Income" + "Mothers Annual Income";
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(62; "Guardian Name"; Text[40])
        {
            Caption = 'Guardian Name';
            DataClassification = CustomerContent;
        }
        field(64; "Guardian Occupation"; Text[20])
        {
            Caption = 'Guardian Occupation';
            DataClassification = CustomerContent;
        }
        field(65; "Guardian Annual Income"; Decimal)
        {
            Caption = 'Guardian Annual Income';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: Start
                "Total Family Income" := "Fathers Annual Income" + "Mothers Annual Income" + "Guardian Annual Income";
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(66; Nationality; Text[30])
        {
            Caption = 'Nationality';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
            Trigger OnValidate()
            var
                CountryMaster: Record "Country/Region";
            Begin
                IF Nationality <> '' then begin
                    CountryMaster.Reset();
                    CountryMaster.SetRange(Code, Rec.Nationality);
                    IF CountryMaster.FindFirst() then
                        "Nationality Description" := CountryMaster.Nationality;

                end Else
                    "Nationality Description" := '';
            End;
        }
        field(67; "Physically Challenged"; Boolean)
        {
            Caption = 'Physically Challanged';
            DataClassification = CustomerContent;
        }
        field(68; "Visually Challenged"; Boolean)
        {
            Caption = 'Visually Challanged';
            DataClassification = CustomerContent;
        }
        field(69; "First Generation Leaner"; Boolean)
        {
            Caption = 'First Generation Leaner';
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
            DataClassification = CustomerContent;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: Start
                IF Employee.GET("Staff Code") THEN BEGIN
                    IF Employee."Middle Name" = '' THEN
                        "Staff Name" := Employee."First Name" + ' ' + Employee."Last Name"
                    ELSE
                        "Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                END ELSE
                    "Staff Name" := '';
                //Code added for Assign Value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(74; "Break In Study"; Boolean)
        {
            Caption = 'Break In Study';
            DataClassification = CustomerContent;
        }
        field(77; "Sports Person"; Boolean)
        {
            Caption = 'Sports Person';
            DataClassification = CustomerContent;
        }
        field(78; "Sports Specialization"; Text[30])
        {
            Caption = 'Sports Specialization';
            DataClassification = CustomerContent;
        }
        field(84; "Enquiry No."; Code[20])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
        }
        field(87; Religion; Code[20])
        {
            Caption = 'Religion';
            DataClassification = CustomerContent;
            TableRelation = "Religion Master-CS";
        }
        field(88; "Visa No."; Text[20])
        {
            Caption = 'Visa No.';
            DataClassification = CustomerContent;
        }
        field(89; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
        }
        field(90; Months; Integer)
        {
            Caption = 'Months';
            DataClassification = CustomerContent;
        }
        field(200; "Date of Joining"; Date)
        {
            Caption = 'Date of Joining';
            DataClassification = CustomerContent;
        }
        field(201; "Date of Leaving"; Date)
        {
            Caption = 'Date of Leaving';
            DataClassification = CustomerContent;
        }
        field(202; "New Student"; Boolean)
        {
            Caption = 'New Student';
            DataClassification = CustomerContent;
        }
        field(203; "Staff Name"; Text[92])
        {
            Caption = 'Staff Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(204; "Student Image"; BLOB)
        {
            Caption = 'Student Image';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;
        }
        field(1000; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";

            trigger OnValidate()
            var
                CourseSemMaster: Record "Course Sem. Master-CS";
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
                CourseSemMaster.Reset();
                CourseSemMaster.SetRange("Semester Code", Semester);
                CourseSemMaster.SetRange("MSPE Application", true);
                // if CourseSemMaster.FindFirst() then
                //     MSPEApplicationSubmissionAlert(Rec);
            end;
        }
        field(1001; "Fee Classification Code"; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Fee Classification Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(1002; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(1003; "Student Status"; Option)
        {
            Caption = 'Student Status';
            DataClassification = CustomerContent;
            Editable = true;
            OptionCaption = ' ,Student,Inactive,Provisional Student,Expired,Withdrwal -In- Process,Withdrawl/Discontinue,Student Transfer-In-Process,Course Completion,Casual,Reject & Rejoin,NFT,NFT-Extended,Academic Break,Terminated';
            OptionMembers = " ",Student,Inactive,"Provisional Student",Expired,"Withdrwal -In- Process","Withdrawl/Discontinue","Student Transfer-In-Process","Course Completion",Casual,"Reject & Rejoin",NFT,"NFT-Extended","Academic Break",Terminated;

            trigger OnValidate()
            var
                InformationOfStudentCS: Codeunit StudentsInfoCSCSLM;
            begin
                //Code added for Validate data and Assign Value In Fields::CSPL-00092::06-05-2019: Start
                Customer.Reset();
                Customer.SETRANGE("No.", "Original Student No.");
                IF Customer.FINDFIRST() THEN BEGIN
                    IF ("Student Status" = "Student Status"::Expired) OR ("Student Status" = "Student Status"::Inactive) THEN BEGIN
                        Customer.Blocked := Customer.Blocked::All;
                        Customer.Modify();
                    END ELSE
                        IF "Student Status" = "Student Status"::Student THEN
                            Customer.Blocked := Customer.Blocked::" ";
                    Customer.Modify();

                END;


                IF "Student Status" = "Student Status"::"Provisional Student" THEN BEGIN
                    TESTFIELD("First Name");
                    TESTFIELD("Academic Year");
                    TESTFIELD("Course Code");
                    TESTFIELD("E-Mail Address");
                    TESTFIELD("Mobile Number");
                    TESTFIELD("Fee Classification Code");
                    TESTFIELD(Category);
                    TESTFIELD(Semester);
                    IF CourseMasterCS1.GET("Course Code") THEN BEGIN
                        IF (CourseMasterCS1."Group Mandatory") AND (Semester = 'I') THEN
                            TESTFIELD(Group);
                        IF (CourseMasterCS1."Group Mandatory") AND (Semester = 'II') THEN
                            TESTFIELD(Group);
                    END;
                    //   "Enrollment No." := 'TEMP' + FORMAT("No.");
                    //   VALIDATE("Enrollment No.");
                    "Credit Student" := "Credit Student"::Applied;
                END ELSE
                    IF "Student Status" = "Student Status"::"Reject & Rejoin" THEN BEGIN
                        MainStudentSubjectCS.Reset();
                        MainStudentSubjectCS.SETRANGE("Student No.", "No.");
                        MainStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                        MainStudentSubjectCS.SETRANGE(Semester, Semester, 'VIII');
                        IF MainStudentSubjectCS.FINDSET() THEN
                            MainStudentSubjectCS.DELETEALL();

                        OptionalStudentSubjectCS.Reset();
                        OptionalStudentSubjectCS.SETRANGE("Student No.", "No.");
                        OptionalStudentSubjectCS.SETRANGE("Academic Year", "Academic Year");
                        OptionalStudentSubjectCS.SETRANGE(Semester, Semester, 'VIII');
                        IF OptionalStudentSubjectCS.FINDSET() THEN
                            OptionalStudentSubjectCS.DELETEALL();
                    END;


                IF "Credit Student" = "Credit Student"::Approved THEN BEGIN
                    IF "Student Status" = "Student Status"::Student THEN
                        CreditStudentToCustomer();
                    InformationOfStudentCS.StudentSubjectUpdateCS("No.");
                END;
                //Code added for Validate data and Assign Value In Fields::CSPL-00092::06-05-2019: End
            end;
        }
        field(1004; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(1005; "Current Year"; Code[20])
        {
            Caption = 'Current Year';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Year Master-CS";
        }
        field(2000; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate data,Call function for Update Customer::CSPL-00092::06-05-2019: Start
                /*
                IF ("Application No." <> '') AND (xRec."Application No." <> "Application No.") THEN BEGIN
                    StudentMasterCS.Reset();
                    StudentMasterCS.SETRANGE("Application No.", "Application No.");
                    IF StudentMasterCS.FINDFIRST() THEN
                        if not "Entry From Salesforce" then
                            ERROR(Text0002Lbl, "Application No.");
                END;
                */

                UpdateCustomer();
                StudentCollegeINIT("No.");
                //Code added for Validate data,Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(2001; "Total Credits"; Decimal)
        {
            CalcFormula = Sum("Main Student Subject-CS".Credit WHERE("Student No." = FIELD("No."),
                                                                      Result = FILTER(Pass)));
            Caption = 'Total Credits';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20007; Mess; Code[20])
        {
            Caption = 'Mess';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Location;
        }
        field(20009; CGPA; Decimal)
        {
            //CalcFormula = Average("Main Student Subject-CS".Points WHERE("Student No." = FIELD("No."),
            //                                                            Course = FIELD("Course Code")));
            Caption = 'CGPA';
            //FieldClass = FlowField;
        }
        field(20010; "CGPA Grade"; Code[20])
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
        field(50000; Specialization; Code[20])
        {
            Caption = 'Specialization';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 12-05-2019';
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                DimensionValue: Record "Dimension Value";
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                DimensionValue.Reset();
                DimensionValue.SetRange(Code, Rec."Global Dimension 1 Code");
                IF DimensionValue.FindFirst() then
                    "Institute Name" := DimensionValue.Name;
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50005; "Prospectus No."; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Prospectus No.';
            DataClassification = CustomerContent;
        }
        field(50006; "Gap Taken"; Code[10])
        {
            Description = 'CS Field Added 12-05-2019';
            DataClassification = CustomerContent;
            Caption = 'Gap Taken';
        }
        field(50007; Category; Code[20])
        {
            Caption = 'Sub- Category';
            Description = 'CS Field Added 12-05-2019';
            DataClassification = CustomerContent;

            TableRelation = "Category Master-CS".Code WHERE("Fee Classification" = FIELD("Fee Classification Code"));

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50009; "Branch Transfer"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Branch Transfer';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50010; Graduation; Code[20])
        {
            Caption = 'Graduation';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Graduation Master-CS";
            DataClassification = CustomerContent;
        }
        field(50011; Group; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Group Student-CS"."Group Code";
            Caption = 'Group';
            DataClassification = CustomerContent;
        }
        field(50012; Batch; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Batch';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50013; "Type Of Course"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = false;
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
            Caption = 'Type of Course';
            DataClassification = CustomerContent;
        }
        field(50014; "Final Years Course"; Code[10])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Final Years Course';
            DataClassification = CustomerContent;
        }
        field(50015; "Pay Type"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Paid,Unpaid';
            OptionMembers = " ",Paid,Unpaid;
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
        }
        field(50016; Year; Code[10])
        {
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Year Master-CS";
            Caption = 'Year';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50017; "Section & Roll No."; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = false;
            Caption = 'Section & Roll No.';
            DataClassification = CustomerContent;
        }
        field(50018; Address4; Text[50])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Address 4';
            DataClassification = CustomerContent;
        }
        field(50019; "Cor City"; Text[30])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Corresponding City';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50020; "Cor State"; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Corresponding State';
            Editable = false;
            DataClassification = CustomerContent;
            TableRelation = if ("cor Country Code" = const()) "State SLcM CS"
            else
            if ("cor Country Code" = FILTER(<> '')) "State SLcM CS" WHERE("Country/Region Code" = field("cor Country Code"));
            // trigger OnLookup()
            // begin
            //     PostCodeRec.RESET();
            //     PostCodeRec.FINDSET();
            //     IF PAGE.RUNMODAL(367, PostCodeRec) = ACTION::LookupOK THEN
            //         "cor State" := FORMAT(PostCodeRec.County);
            // end;
        }
        field(50021; "Cor Country Code"; Code[10])
        {
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Country/Region";
            Caption = 'Corresponding Country';
            DataClassification = CustomerContent;
        }
        field(50022; "Cor Post Code"; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            // TableRelation = "Post Code".Code;
            // TableRelation = if ("cor Country Code" = const()) "Post Code"
            // else
            // if ("cor Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("cor Country Code"));
            // Caption = 'Corresponding Post Code';
            // DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "cor Post Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         "cor Country Code" := PostCodeRec."Country/Region Code";
            //         "Cor city" := PostCodeRec.City;
            //         "cor State" := PostCodeRec."State Code";
            //     END ELSE BEGIN
            //         "cor Country Code" := '';
            //         "cor city" := '';
            //         "cor State" := '';
            //     END;
            // end;
        }
        field(50023; "Same As Permanent Address"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Same as Permanent Address';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Assign value in Fields::CSPL-00092::06-05-2019: Start
                IF "Same As Permanent Address" = TRUE THEN BEGIN
                    Address3 := Addressee;
                    Address4 := Address1;
                    "Address To" := Address2;
                    "Cor Post Code" := "Post Code";
                    "Cor City" := City;
                    "Cor State" := State;
                    "Cor Country Code" := "Country Code";

                END ELSE BEGIN
                    Address3 := '';
                    Address4 := '';
                    "Address To" := '';
                    "Cor Post Code" := '';
                    "Cor City" := '';
                    "Cor State" := '';
                    "Cor Country Code" := '';
                END;
                //Code added for Assign value in Fields::CSPL-00092::06-05-2019: End
            end;
        }
        field(50024; Disability; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Disability';
            DataClassification = CustomerContent;
        }
        field(50026; "Marital Status"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widowed';
            OptionMembers = " ",Single,Married,Separated,Divorced,Widowed;
            Caption = 'Marital Status';
            DataClassification = CustomerContent;
        }
        field(50027; "Mother Tongue"; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Mother Tongue-CS";
            Caption = 'Mother Tongue';
            DataClassification = CustomerContent;
        }
        field(50031; "Resident Status"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,Village,Town,City';
            OptionMembers = "  ",Village,Town,City;
            Caption = 'Resident Status';
            DataClassification = CustomerContent;
        }
        field(50035; "No. Of Assignment"; Integer)
        {
            CalcFormula = Count("Student Class Assignment-CS" WHERE(Semester = FIELD(Semester),
                                                                     "Student No." = FIELD("No.")));
            Description = 'CS Field Added 12-05-2019';
            Caption = 'No. of Assignment';
            FieldClass = FlowField;
        }
        field(50036; "Cor District"; Text[50])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Corrosponding District';
            DataClassification = CustomerContent;
        }
        field(50037; "Course Name"; Text[100])
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = false;
            Caption = 'Course Name';
            DataClassification = CustomerContent;
        }
        field(50039; "Parents Income"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Parents Income';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50040; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            Description = 'CS Field Added 12-05-2019';
            TableRelation = Currency;
            DataClassification = CustomerContent;
        }
        field(50041; "Scholarship Source"; Code[10])
        {
            Description = 'CS Field Added 12-05-2019';
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Scholarship), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            Caption = 'Scholarship Code';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                CLE: Record "Cust. Ledger Entry";
            begin
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: Start
                if ("Scholarship Source" <> '') and ("Scholarship Source" <> xRec."Scholarship Source") then begin
                    CLE.Reset();
                    CLE.SETRANGE(CLE."Customer No.", "Original Student No.");
                    CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
                    CLE.SETRANGE(CLE."Academic Year", "Academic Year");
                    CLE.SETRANGE(CLE.Year, Year);
                    ClE.SETRANGE(Semester, Semester);
                    CLE.SETRANGE("Waiver/Scholar/Grant Code", "Scholarship Source");
                    CLE.SETRANGE(CLE.Reversed, FALSE);
                    if CLE.FindFirst() then
                        Error('You cannot change the Schorlarship code, as Schorlarship is already generated for this semester.');
                end;
                UpdateCustomer();
                //Code added for Call function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50042; "Internal Rank"; Integer)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Internal Rank';
            DataClassification = CustomerContent;
        }
        field(50043; "External Rank"; Integer)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'External Rank';
            DataClassification = CustomerContent;
        }
        field(50044; "Check Manually"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Check Manually';
            DataClassification = CustomerContent;
        }
        field(50045; Updated; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(50055; "Pre Qualification Subject"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Pre Qualification Subject';
            DataClassification = CustomerContent;
        }
        field(50056; "Joining Day"; Integer)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Joining Day';
            DataClassification = CustomerContent;
        }
        field(50057; "Joining Month"; Integer)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Joining Month';
            DataClassification = CustomerContent;
        }
        field(50058; "Pre Qualification"; Option)
        {
            Description = 'CS Field Added 12-05-2019';
            OptionCaption = ' ,10th,12th,Diploma,Graduation,Post Graduation,Others';
            OptionMembers = " ","10th","12th",Diploma,Graduation,"Post Graduation",Others;
            Caption = 'Pre Qualification';
            DataClassification = CustomerContent;
        }
        field(50063; "State Of Domicile"; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'State of Domicile';
            DataClassification = CustomerContent;
        }
        field(50080; "Semester I Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester I Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50081; "Semester II Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester II Credit Earned';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: Start
                "Year 1 Credit Earned" := "Semester I Credit Earned" + "Semester II Credit Earned";
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(50082; "Semester III Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester III Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50083; "Semester IV Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester IV Credit Earned';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: Start
                "Year 2 Credit Earned" := "Semester III Credit Earned" + "Semester IV Credit Earned";
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(50084; "Semester V Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester V Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50085; "Semester VI Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester VI Credit Earned';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: Start
                "Year 3 Credit Earned" := "Semester V Credit Earned" + "Semester VI Credit Earned";
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(50086; "Semester VII Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester VII Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50087; "Semester VIII Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Semester VIII Credit Earned';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: Start
                "Year 4 Credit Earned" := "Semester VII Credit Earned" + "Semester VIII Credit Earned";
                //Code added for Assign value in Field::CSPL-00092::06-05-2019: End
            end;
        }
        field(50088; "Net Semester CGPA"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'GPA';
            DataClassification = CustomerContent;
        }
        field(50089; "Net Year CGPA"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Net Year CGPA';
            DataClassification = CustomerContent;
        }
        field(50090; "Year 1 Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Year 1 Credit Earned';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(50091; "Year 2 Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 2 Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50092; "Year 3 Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 2 Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50093; "Year 4 Credit Earned"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 4 Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50094; "Year 1 GPA"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 1 GPA';
            DataClassification = CustomerContent;
        }
        field(50095; "Year 2 GPA"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 2 GPA';
            DataClassification = CustomerContent;
        }
        field(50096; "Year 3 GPA"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 3 GPA';
            DataClassification = CustomerContent;
        }
        field(50097; "Year 4 GPA"; Decimal)
        {
            Description = 'CS Field Added 12-05-2019';
            Editable = true;
            Caption = 'Year 4 GPA';
            DataClassification = CustomerContent;
        }
        field(50098; "Pending For Registration"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Pending For Registration';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call Function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call Function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50099; "Course Completion NOC"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Course Completion NOC';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call Function for Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call Function for Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(50100; "Customer Exists"; Boolean)
        {
            CalcFormula = Exist(Customer WHERE("No." = FIELD("Original Student No.")));
            Description = 'CS Field Added 12-05-2019';
            FieldClass = FlowField;
            Caption = 'Customer Exists';
        }
        field(50101; "Course Type"; Option)
        {
            OptionCaption = ' ,Degree,Certificate,Diploma';
            OptionMembers = " ",Degree,Certificate,Diploma;
            CalcFormula = Lookup("Course Master-CS"."Course Type" WHERE(Code = FIELD("Course Code")));
            Description = 'CS Field Added 12-05-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50102; "Parent Login Password"; Code[30])
        {
            CalcFormula = Lookup("Portal User Login-CS".Password WHERE(Type = FILTER(Parent),
                                                                        SU_ID = FIELD("No.")));
            Description = 'CS Field Added 12-05-2019';
            FieldClass = FlowField;
        }
        field(50103; "Mobile Insert"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50104; "Mobile Update"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Mobile Insert';
            DataClassification = CustomerContent;
        }
        field(50105; "Mobile Result"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Mobile Result';
            DataClassification = CustomerContent;
        }
        field(50106; "Degree Code"; Code[20])
        {
            Description = 'CS Field Added 04-04-2020';
            Caption = 'Degree Code';
            DataClassification = CustomerContent;
            TableRelation = "Final Degree-CS";
        }
        field(50109; "Salesforce Inserted"; Boolean)
        {
            Caption = 'SalesForce Inserted';
            DataClassification = CustomerContent;
        }
        field(50110; "Visa Extension Date"; Date)
        {
            Caption = 'Visa Extension Date';
            DataClassification = CustomerContent;
        }
        field(50111; "Clinical Coordinator"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'Clinical Coordinator';
        }
        field(50112; "Document Specialist"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'Document Specialist';
        }
        field(50113; "Pass Port Issued By"; Text[50])
        {
            Caption = 'Pass Port Issued By';
            DataClassification = CustomerContent;
        }

        field(50118; Ethnicity; Code[20])
        {
            Caption = 'Ethnicity';
            DataClassification = CustomerContent;
            TableRelation = Ethnicity;
        }
        field(50119; Title; Option)
        {
            OptionCaption = ' ,Mr., Mrs., Miss, Ms.';
            OptionMembers = " ","Mr.","Mrs.","Miss","Ms.";
            Caption = 'Title';
        }
        field(50120; "Maiden Name"; Text[80])
        {
            Caption = 'Maiden Name';
            DataClassification = CustomerContent;
        }
        field(50121; "Social Security No."; Code[11])
        {
            Caption = 'Social Security No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMasterRec: Record "Student Master-CS";
                SSNGroupAreaCodeRec: Record "SSN Group Area Code";
                FourChar: Text;
                SevenChar: Text;
                Starting3D: Integer;
                Starting3D1: Text;
                Last4D: Integer;
                Last4D1: Text;
                Middle56D: Integer;
                Middle56D1: Text;
                FinalValue: Text;
                TotalLength: Integer;
            begin
                if "Social Security No." <> '' then begin

                    TotalLength := STRLEN("Social Security No.");
                    if TotalLength <> 11 then
                        Error('The SSN you enterned is not of 11 characters please verify your SSN and re-enter it');

                    StudentMasterRec.Reset();
                    //StudentMasterRec.SetFilter("No.", '<>%1', "No.");
                    StudentMasterRec.SetFilter("Original Student No.", '<>%1', Rec."Original Student No.");
                    StudentMasterRec.SetRange("Social Security No.", "Social Security No.");
                    if StudentMasterRec.FindFirst() then begin
                        if ("Parent Student No." <> '') or (StudentMasterRec."Parent Student No." <> '') then
                            TestField("Social Security No.", StudentMasterRec."Social Security No.");

                        Error('The SSN you enterned is duplicate please verify your SSN and re-enter it');
                    end;

                    Starting3D1 := COPYSTR("Social Security No.", 1, 3);
                    EVALUATE(Starting3D, Starting3D1);
                    IF Starting3D1 IN ['000', '666'] THEN
                        ERROR('Starting 3 Char of the SSN cannot be %1', Starting3D1);

                    // Blocked Larry Email on 27 July 2021 22:24 - OLR - Invalid Area Code Error - Start
                    // SSNGroupAreaCodeRec.Reset();
                    // SSNGroupAreaCodeRec.SetRange("Area Code", Starting3D1);
                    // if Not SSNGroupAreaCodeRec.FindFirst() then
                    //     ERROR('Starting 3 Char of the SSN is not found in SSN Group Area master');
                    // Blocked Larry Email on 27 July 2021 22:24 - OLR - Invalid Area Code Error - End

                    FourChar := COPYSTR("Social Security No.", 4, 1);
                    IF (FourChar <> '-') THEN
                        ERROR('4th Char of the SSN must be %1', '-');

                    Middle56D1 := COPYSTR("Social Security No.", 5, 2);
                    EVALUATE(Middle56D, Middle56D1);
                    IF NOT (Middle56D >= 01) AND (Middle56D <= 99) THEN
                        ERROR('Middle 2 Char of the SSN should be in-between %1', '01-99');

                    SevenChar := COPYSTR("Social Security No.", 7, 1);
                    IF (SevenChar <> '-') THEN
                        ERROR('7th Char of the SSN must be %1', '-');

                    Last4D1 := COPYSTR("Social Security No.", 8, 4);
                    EVALUATE(Last4D, Last4D1);
                    IF NOT (Last4D >= 1) AND (Last4D <= 9999) THEN
                        ERROR('Last 4 Char of the SSN should be in-between %1', '0001-9999');

                    FinalValue := Starting3D1 + Middle56D1 + Last4D1;
                    if FinalValue IN ['219099999', '999999999', '078051120', '111111111', '123456789', '987654320', '987654321'
                    , '987654322', '987654323', '987654324', '987654325', '987654326', '987654327', '987654328', '987654329'] then
                        Error('The format of the SSN you enterned is invalid please verify your SSN and re-enter it.');
                end;
            end;
        }
        field(50125; "FM1/IM1 Coordinator"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
            Caption = 'FM1/IM1 Coordinator';
        }
        field(50126; "Housing Group Pref.1"; Code[20])
        {
            Caption = 'Housing Group Pref.1';
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
            //Editable = false;
        }
        field(50127; "House No. Pref.1"; Code[20])
        {
            Caption = 'House No. Pref.1';
            DataClassification = CustomerContent;
            TableRelation = "Housing Master";
            //Editable = false;
        }
        field(50128; "Room Category Pref.1"; Code[20])
        {
            Caption = 'Room Category Pref.1';
            DataClassification = CustomerContent;
            TableRelation = "Room Category Master";
            // Editable = false;
        }
        field(50129; "Housing Group Pref.2"; Code[20])
        {
            Caption = 'Housing Group Pref.2';
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
            //Editable = false;
        }
        field(50130; "House No. Pref.2"; Code[20])
        {
            Caption = 'House No. Pref.2';
            DataClassification = CustomerContent;
            TableRelation = "Housing Master";
            //Editable = false;
        }
        field(50131; "Room Category Pref.2"; Code[20])
        {
            Caption = 'Room Category Pref.2';
            DataClassification = CustomerContent;
            TableRelation = "Room Category Master";
            // Editable = false;
        }
        field(50132; "Housing Group Pref.3"; Code[20])
        {
            Caption = 'Housing Group Pref.3';
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
            //Editable = false;
        }
        field(50133; "House No. Pref.3"; Code[20])
        {
            Caption = 'House No. Pref.3';
            DataClassification = CustomerContent;
            TableRelation = "Housing Master";
            //Editable = false;
        }
        field(50134; "Room Category Pref.3"; Code[20])
        {
            Caption = 'Room Category Pref.3';
            DataClassification = CustomerContent;
            TableRelation = "Room Category Master";
            // Editable = false;
        }
        field(50135; "Account Person Type"; Option)
        {
            Caption = 'Account Person Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Applicant,Alumni,Advisor';
            OptionMembers = Applicant,Alumni,Advisor;
        }
        field(50136; "School Level"; Text[30])
        {
            Caption = 'School Level';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50137; "Country Code (Phone)"; Text[5])
        {
            Caption = 'Country Code (Phone)';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50138; "Graduate GPA"; Decimal)
        {
            Caption = 'Graduate GPA';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50139; "High School GPA"; Decimal)
        {
            Caption = 'High School GPA';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50140; "Name on Passport"; text[107])
        {
            Caption = 'Name on Passport';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50141; "Other GPA"; Decimal)
        {
            Caption = 'Other GPA';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50142; "Permanent U.S. Resident"; Boolean)
        {
            Caption = 'Permanent U.S. Resident';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50143; "Person Lead Source"; Text[50])
        {
            Caption = 'Person Lead Source';
            DataClassification = CustomerContent;
            // Editable = false;
        }
        field(50144; "Pre-Req GPA"; Decimal)
        {
            Caption = 'Pre-Req GPA';
            DataClassification = CustomerContent;
        }
        field(50145; "Primary Lead Source"; Text[50])
        {
            Caption = 'Primary Lead Source';
            DataClassification = CustomerContent;
        }
        field(50146; "Skype"; Text[250])
        {
            Caption = 'Skype';
            DataClassification = CustomerContent;
        }
        field(50147; "Transfer GPA"; Decimal)
        {
            Caption = 'Transfer GPA';
            DataClassification = CustomerContent;
        }
        field(50148; "18 Digit ID"; Text[18])
        {
            Caption = 'Salesforce ID';
            DataClassification = CustomerContent;
        }
        field(50149; "FAFSA Received"; Boolean)
        {
            Caption = 'FAFSA Received';
            DataClassification = CustomerContent;
        }
        field(50150; "Residency Hospital 1"; Text[250])
        {
            Caption = 'Residency Hospital 1';
            DataClassification = CustomerContent;
        }
        field(50151; "Residency Hospital 2"; Text[250])
        {
            Caption = 'Residency Hospital 2';
            DataClassification = CustomerContent;
        }
        field(50152; "Residency Status"; Text[250])
        {
            Caption = 'Residency Status';
            DataClassification = CustomerContent;
        }
        field(50153; "Residency City"; Text[250])
        {
            Caption = 'Residency City';
            DataClassification = CustomerContent;
        }
        field(50154; "Residency Specialty 1"; Text[250])
        {
            Caption = 'Residency Specialty 1';
            DataClassification = CustomerContent;
        }
        field(50155; "Residency Specialty 2"; Text[250])
        {
            Caption = 'Residency Specialty 2';
            DataClassification = CustomerContent;
        }
        field(50156; "Residency State"; Text[250])
        {
            Caption = 'Residency State';
            DataClassification = CustomerContent;
        }
        field(50157; "Residency Year"; Text[250])
        {
            Caption = 'Residency Year';
            DataClassification = CustomerContent;
        }
        field(50158; "Room Mate Name Pref"; Text[50])
        {
            Caption = 'Room Mate Name Pref';
            DataClassification = CustomerContent;
        }
        field(50159; "Room Mate Email Pref"; Text[80])
        {
            Caption = 'Room Mate Email Pref';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(50160; Status; Code[20])
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            TableRelation = "Student Status";
            trigger OnValidate()
            var
                StatusChangeLogEntry: Record "Status Change Log entry";
                StudentStatusRec: Record "Student Status";
                StudentTimeLine: Record "Student Time Line";
                WebServiceFn: Codeunit WebServicesFunctionsCSL;
                SLcMToSalesForce: Codeunit SLcMToSalesforce;
                UserID_lTxt: Code[50];
                EffectiveDate: Date;
                NSLDSWithdrawal: Date;
                DateofDetermination: Date;
                LastAttendanceDate: Date;
            begin
                If xRec.Status <> Rec.Status then
                    "Status Sync" := True;

                UserID_lTxt := '';
                EffectiveDate := 0D;
                NSLDSWithdrawal := 0D;
                DateofDetermination := 0D;
                LastAttendanceDate := 0D;
                // StudentStatusRec.Reset();
                // StudentStatusRec.SetRange(Code, Rec.Status);
                // StudentStatusRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                // If StudentStatusRec.FindFirst() then
                //     IF StudentStatusRec.Status = StudentStatusRec.Status::"Pending Graduation" then
                //         UserID_lTxt := 'AUAUATSRV001\MANIPALADMIN'
                //     else
                UserID_lTxt := UserID();

                StudentStatusRec.Get(Status, "Global Dimension 1 Code");
                if StudentStatusRec.Status = StudentStatusRec.Status::Graduated then begin
                    EffectiveDate := "Date Awarded";
                    //NSLDSWithdrawal := "8 FA End Date";       12Jan2022
                    NSLDSWithdrawal := Rec."NSLDS Withdrawal Date";
                    LastAttendanceDate := Rec.LDA;
                    WebServiceFn.ChangeUserRoleToGraduate(Rec);   //22Dec2021
                end else
                    EffectiveDate := Today();

                if StudentStatusRec.Status IN [StudentStatusRec.Status::CLOA, StudentStatusRec.Status::ELOA, StudentStatusRec.Status::SLOA] then begin
                    DateofDetermination := Rec."Date Of Determination";
                    LastAttendanceDate := Rec.LDA;
                    IF StudentStatusRec.Status <> StudentStatusRec.Status::SLOA then
                        NSLDSWithdrawal := Rec."NSLDS Withdrawal Date";
                end;

                if StudentStatusRec.Status IN [StudentStatusRec.Status::Withdrawn, StudentStatusRec.Status::Graduated] then begin
                    DateofDetermination := Rec."Date Of Determination";
                    LastAttendanceDate := Rec.LDA;
                    NSLDSWithdrawal := Rec."NSLDS Withdrawal Date";
                    StatusChangeLogEntry.InsertRecordfun("No.", "Student Name", xRec.Status, Status, UserId(), Today(), Reason, "Reason Description", '', NSLDSWithdrawal, DateofDetermination, LastAttendanceDate, EffectiveDate, Today(), 0D);//Lucky 04-05-2022 - as per Stuti Dismisal Date should not flow to Status change log in case of Status WITH
                end else
                    StatusChangeLogEntry.InsertRecordfun("No.", "Student Name", xRec.Status, Status, UserId(), Today(), Reason, "Reason Description", '', NSLDSWithdrawal, DateofDetermination, LastAttendanceDate, EffectiveDate, Today(), "Dismissal Date");

                StudentTimeLine.InsertRecordFun("No.", "Student Name", 'Student Status has been changed ' + xRec.Status + ' to ' + Status, UserId(), Today());

                if Status <> '' then begin
                    StatusOnvalidate(Rec);
                end;

                Clear(Reason);
                Clear("Reason Description");
                SLcMToSalesForce.StudentStatusSFInsert(Rec);
            end;
        }

        field(50161; "New Term"; Option)
        {
            Caption = 'New Term';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(50162; "New Academic Year"; Code[10])
        {
            Caption = 'New Academic Year';
            DataClassification = CustomerContent;
        }
        field(50163; "Grant Code 1"; Code[10])
        {
            Caption = 'Grant Code 1';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Grant), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            var
                CLE: Record "Cust. Ledger Entry";
            begin
                if ("Grant Code 1" <> '') and ("Grant Code 1" <> xRec."Grant Code 1") then begin
                    if "Grant Code 2" = "Grant Code 1" then
                        Error('Same code is already selected in Grant Code 2');
                    if "Grant Code 3" = "Grant Code 1" then
                        Error('Same code is already selected in Grant Code 3');

                    CLE.Reset();
                    CLE.SETRANGE(CLE."Customer No.", "Original Student No.");
                    CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
                    CLE.SETRANGE(CLE."Academic Year", "Academic Year");
                    CLE.SETRANGE(CLE.Year, Year);
                    ClE.SETRANGE(Semester, Semester);
                    CLE.SETRANGE("Waiver/Scholar/Grant Code", "Grant Code 1");
                    CLE.SETRANGE(CLE.Reversed, FALSE);
                    if CLE.FindFirst() then
                        Error('You cannot change the Grant code 1, as Grant is already generated for this semester.');
                end;
                UpdateCustomer();
            end;
        }
        field(50164; "Other Lead Source"; Text[250])
        {
            Caption = 'Other Lead Source';
            DataClassification = CustomerContent;
        }
        field(50165; "Lease Agreement/Contract No."; Code[20])
        {
            Caption = 'Lease Agreement/Contract No.';
            DataClassification = CustomerContent;
        }
        field(50166; "Lease Agreement Group"; Text[50])
        {
            Caption = 'Lease Agreement Group';
            DataClassification = CustomerContent;
        }
        field(50167; "Transport Cell"; Code[20])
        {
            Caption = 'Transport Cell';
            DataClassification = CustomerContent;
        }
        field(50168; "Insurance Carrier"; Text[250])
        {
            Caption = 'Insurance Carrier';
            DataClassification = CustomerContent;
        }
        field(50169; "Policy Number / Group Number"; Code[30])
        {
            Caption = 'Policy No.';
            DataClassification = CustomerContent;
        }
        field(50170; "Insurance Valid From"; Date)
        {
            Caption = 'Insurance Valid From';
            DataClassification = CustomerContent;
        }
        field(50171; "Insurance Valid To"; Date)
        {
            Caption = 'Insurance Valid To';
            DataClassification = CustomerContent;
        }
        field(50172; "Parent Student No."; Code[20])
        {
            Caption = 'Parent Student No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Student Master-CS"."No." where("Parent Student No." = filter(''));
            trigger OnValidate()
            begin
                If "Parent Student No." <> '' then
                    If "Parent Student No." = "No." then
                        Error('"Parent Student No." cannot be same as "Student No."');
            end;
        }
        field(50173; "Registrar Signoff"; Boolean)
        {
            Caption = 'Registrar Signoff';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50175; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            trigger OnValidate()
            begin
                UpdateCustomer();
            end;
        }
        field(50176; "Sibling/Spouse No."; Code[20])
        {
            Caption = 'Sibling/Spouse No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            begin
                UpdateCustomer();
            end;
        }
        field(50178; "Financial Aid Approved"; Boolean)
        {
            Caption = 'Financial Aid Approved';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateCustomer();
            end;
        }
        field(50179; "Payment Plan Applied"; Boolean)
        {
            Caption = 'Payment Plan Applied';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Payment Plan Applied" = false then begin
                    "Payment Plan Instalment" := 0;
                    UpdateCustomer();
                    Modify();
                end;

            end;
        }
        field(50180; "FAFSA Applied"; Boolean)
        {
            Caption = 'FAFSA Applied';
            DataClassification = CustomerContent;
        }

        field(50182; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            trigger OnValidate()
            begin
                UpdateCustomer();
            end;
        }
        field(50183; "Self Payment Applied"; Boolean)
        {
            Caption = 'Self Payment Applied';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateCustomer();
            end;
        }
        field(50184; "Student Group"; Option)
        {
            Caption = 'Student On-Ground Group';
            DataClassification = CustomerContent;
            OptionCaption = ' ,On-Ground Check-In,On-Ground Check-In Completed';
            OptionMembers = " ","On-Ground Check-In","On-Ground Check-In Completed";

            Trigger Onvalidate()
            Var
                HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
            Begin
                If "Student Group" = "Student Group"::"On-Ground Check-In" then
                    HoldUpdate_lCU.OnGroundCheckInStudentGroupEnable("No.");

                If "Student Group" = "Student Group"::"On-Ground Check-In Completed" then
                    HoldUpdate_lCU.OnGroundCheckInCompletedGroupEnable("No.");

            End;
        }
        field(50185; "Semester IX GPA"; Decimal)
        {
            Caption = 'Semester IX GPA';
            DataClassification = CustomerContent;
        }
        field(50186; "Semester IX Credit Earned"; Decimal)
        {
            Caption = 'Semester IX Credit Earned';
            DataClassification = CustomerContent;
        }
        field(50187; "Emergency Contact First Name"; Text[35])
        {
            Caption = 'Emergency Contact First Name';
            DataClassification = CustomerContent;
        }
        field(50188; "Emergency Contact Last Name"; Text[30])
        {
            Caption = 'Emergency Contact First Name';
            DataClassification = CustomerContent;
        }
        field(50189; "Emergency Contact E-Mail"; Text[50])
        {
            Caption = 'Emergency Contact E-Mail';
            DataClassification = CustomerContent;
        }
        field(50190; "Emergency Contact Phone No."; Text[30])
        {
            Caption = 'Emergency Contact Phone No.';
            DataClassification = CustomerContent;
        }
        field(50191; "Emergency Contact Address"; Text[100])
        {
            Caption = 'Emergency Contact Address';
            DataClassification = CustomerContent;
        }
        field(50192; "Emergency Contact RelationShip"; Text[30])
        {
            Caption = 'Emergency Contact RelationShip';
            DataClassification = CustomerContent;
        }
        field(50193; "Emergency Contact Phone No. 2"; Text[30])
        {
            Caption = 'Emergency Contact Alternate Phone No.';
            DataClassification = CustomerContent;
        }

        field(50194; "Emergency Contact City"; Text[30])
        {
            Caption = 'Emergency Contact City"';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
            Editable = false;
        }
        field(50195; "Emergency Contact Postal Code"; Code[20])
        {
            Caption = 'Emergency Contact Postal Code';
            DataClassification = CustomerContent;
            //SD-SN-03-Dec-2020 +
            // TableRelation = if ("Emergency Contact Country Code" = const()) "Post Code"
            // else
            // if ("Emergency Contact Country Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Emergency Contact Country Code"));
            //SD-SN-03-Dec-2020 -
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Post Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         "Emergency Contact Country Code" := PostCodeRec."Country/Region Code";
            //         "Emergency Contact City" := PostCodeRec.City;
            //         "Emergency Contact State" := PostCodeRec."State Code";
            //     END ELSE BEGIN
            //         "Emergency Contact Country Code" := '';
            //         "Emergency Contact City" := '';
            //         "Emergency Contact State" := '';
            //     END;
            // end;
        }
        field(50196; "Emergency Contact Country Code"; Code[10])
        {
            Caption = 'Emergency Contact Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(50197; "Emergency Contact State"; Code[10])
        {
            Caption = 'Emergency Contact State';
            DataClassification = CustomerContent;
            TableRelation = if ("Emergency Contact Country Code" = const()) "State SLcM CS"
            else
            if ("Emergency Contact Country Code" = FILTER(<> '')) "State SLcM CS" WHERE("Country/Region Code" = field("Emergency Contact Country Code"));
            Editable = false;
        }
        field(50198; "Local Emergency First Name"; Text[35])
        {
            Caption = 'Local Emergency First Name';
            DataClassification = CustomerContent;
        }
        field(50199; "Local Emergency Last Name"; Text[35])
        {
            Caption = 'Local Emergency Last Name';
            DataClassification = CustomerContent;
        }
        field(50200; "Local Emergency Street Address"; Text[50])
        {
            Caption = 'Local Emergency Street Address';
            DataClassification = CustomerContent;
        }
        field(50201; "Local Emergency City"; Text[30])
        {
            Caption = 'Local Emergency City/Parish';
            DataClassification = CustomerContent;

        }
        field(50202; "Local Emergency Phone No."; Text[30])
        {
            Caption = 'Local Emergency Phone No.';
            DataClassification = CustomerContent;
        }
        field(50203; Remarks; Text[80])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(50204; "Estimated Graduation Date"; Date)
        {
            Caption = 'Estimated Graduation Date';
            DataClassification = CustomerContent;
            Trigger Onvalidate()
            Var
                DegreeAuditRec: Record "Degree Audit";
            Begin
                IF Rec."Student SFP Initiation" <> 0 then
                    Rec.Validate(Rec."SAFI Sync", Rec."SAFI Sync"::Pending);
                DegreeAuditRec.Reset();
                DegreeAuditRec.SETRANGE("Student No.", Rec."No.");
                DegreeAuditRec.SETRANGE("Course Code", Rec."Course Code");
                DegreeAuditRec.SETRANGE("Document Status", DegreeAuditRec."Document Status"::"Pending for Verification");
                If DegreeAuditRec.Findfirst() then begin
                    DegreeAuditRec.Validate("Estimated Graduation Date", Rec."Estimated Graduation Date");
                    DegreeAuditRec.Modify();
                end;
                if (Nationality <> 'AG') and ("Global Dimension 1 Code" = '9100') then
                    "Island Departure Date" := "Estimated Graduation Date";
            End;
        }
        field(50205; "Type of FA Roster"; Option)
        {
            Caption = 'Type of FA Roster';
            OptionCaption = ' ,COD,SFP';
            OptionMembers = " ",COD,SFP;
            DataClassification = CustomerContent;
        }

        field(50207; "IBAN No"; Code[20])
        {
            Caption = 'IBAN No';
            DataClassification = CustomerContent;
        }
        field(50209; "SWIFT No"; Code[20])
        {
            Caption = 'SWIFT No';
            TableRelation = "SWIFT Code";
            DataClassification = CustomerContent;
        }
        field(50208; "Fee Generated Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Original Student No."),
                                                                         "Semester" = FIELD(Semester),
                                                                         "Document Type" = filter(Invoice),
                                                                         "Enrollment No." = field("Enrollment No."),
                                                                          "Entry Type" = filter("Initial Entry")));
            Caption = 'Fee Generated Amount';
            Editable = false;

        }
        field(50210; "Housing Hold"; Boolean)
        {

            CalcFormula = Exist("Student Wise Holds" WHERE("Student No." = FIELD("No."),
                                                            //"Semester" = FIELD(Semester),
                                                            Status = filter(Enable),
                                                            "Hold Type" = filter(Housing)));
            Caption = 'Housing Hold';
            Editable = false;
            FieldClass = FlowField;

        }

        field(50211; "Bursar Hold"; Boolean)
        {
            Caption = 'Bursar Hold';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Student Wise Holds" WHERE("Student No." = FIELD("No."),
                                                            //"Semester" = FIELD(Semester),
                                                            Status = filter(Enable),
                                                            "Hold Type" = filter(Bursar)));

        }
        field(50212; "Financial Aid Hold"; Boolean)
        {
            Caption = 'Financial Aid Hold';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Student Wise Holds" WHERE("Student No." = FIELD("No."),
                                                            //"Semester" = FIELD(Semester),
                                                            Status = filter(Enable),
                                                            "Hold Type" = filter("Financial Aid")));


        }
        field(50213; "Registrar Hold"; Boolean)
        {
            Caption = 'Registrar Hold';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Student Wise Holds" WHERE("Student No." = FIELD("No."),
                                                            //"Semester" = FIELD(Semester),
                                                            Status = filter(Enable),
                                                            "Hold Type" = filter(Registrar)));

        }
        field(50214; "Immigration Hold"; Boolean)
        {
            Caption = 'Immigration Hold';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Exist("Student Wise Holds" WHERE("Student No." = FIELD("No."),
                                                            //"Semester" = FIELD(Semester),
                                                            Status = filter(Enable),
                                                            "Hold Type" = filter("Immigration")));

        }
        field(50215; "Housing Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Remain","Return";
        }
        field(50216; "Media Release Sign-off"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50217; "On Ground Check-In By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'On Ground Check-In By';
            Editable = false;
        }
        field(50218; "On Ground Check-In On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'On Ground Check-In Date';
            Editable = false;
        }
        field(50219; "On Ground Check-In Complete By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'On Ground Check-In Completed By';
            Editable = false;
        }
        field(50220; "On Ground Check-In Complete On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'On Ground Check-In Completed Date';
            Editable = false;
        }
        field(50221; "Separation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Separation Date';
            Editable = false;
        }
        field(50222; "Date Cleared"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Cleared';
            Editable = false;
        }
        field(50223; "Date Awarded"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Awarded';
            //Editable = false;
        }
        field(50225; "Student QRCode"; BLOB)
        {
            Caption = 'Student QRCode';
            DataClassification = CustomerContent;
            Compressed = false;
            SubType = Bitmap;
        }
        field(50226; "Remaining Academic SAP"; Integer)
        {
            Caption = 'Remaining Academic SAP';
            DataClassification = CustomerContent;
        }
        field(50227; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50228; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50229; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(50230; "OLR Completed Date"; Date)
        {
            Caption = 'OLR Completed Date';
            DataClassification = CustomerContent;
        }
        field(50231; "Grant Code 2"; Code[20])
        {
            Caption = 'Grant Code 2';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Grant), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            var
                CLE: Record "Cust. Ledger Entry";
            begin
                if ("Grant Code 2" <> '') and ("Grant Code 2" <> xRec."Grant Code 2") then begin
                    if "Grant Code 1" = "Grant Code 2" then
                        Error('Same code is already selected in Grant Code 1');
                    if "Grant Code 3" = "Grant Code 2" then
                        Error('Same code is already selected in Grant Code 3');

                    CLE.Reset();
                    CLE.SETRANGE(CLE."Customer No.", "Original Student No.");
                    CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
                    CLE.SETRANGE(CLE."Academic Year", "Academic Year");
                    CLE.SETRANGE(CLE.Year, Year);
                    ClE.SETRANGE(Semester, Semester);
                    CLE.SETRANGE("Waiver/Scholar/Grant Code", "Grant Code 2");
                    CLE.SETRANGE(CLE.Reversed, FALSE);
                    if CLE.FindFirst() then
                        Error('You cannot change the Grant code 2, as Grant is already generated for this semester.');
                end;
                UpdateCustomer();
            end;

        }
        field(50232; "Tuition Balance"; Decimal)
        {
            Caption = 'Tuition Balance';
            FieldClass = FlowField;
            // CalcFormula = Sum ("Detailed Cust. Ledg. Entry".Amount where("Customer No." = Field("Original Student No."), "Initial Entry Global Dim. 1" = Field("Global Dimension 1 Code"), "Currency Code" = field("Currency Code"), "Initial Entry Global Dim. 2" = filter('')));
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = Field("Original Student No."), "Enrollment No." = field("Enrollment No."), "Initial Entry Global Dim. 1" = Field("Global Dimension 1 Code"), "Currency Code" = field("Currency Code"), "Initial Entry Global Dim. 2" = filter('')));
            Editable = false;
        }
        field(50233; "Grenville Balance"; Decimal)
        {
            Caption = 'Grenville Balance';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Original Student No."), "Enrollment No." = field("Enrollment No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Code"), "Currency Code" = field("Currency Code"), "Initial Entry Global Dim. 2" = filter('9300')));
            Editable = False;
        }
        field(50234; "FAFSA Type"; Text[36])
        {
            Caption = 'FAFSA Type';
            DataClassification = CustomerContent;
        }
        field(50235; "Graduation Date"; Date)
        {
            Caption = 'Graduation Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                DegreeAuditRec: Record "Degree Audit";
                StudentDegree: Record "Student Degree";
            begin
                StudentDegree.Reset();
                StudentDegree.SetRange("Student No.", "No.");
                if StudentDegree.FindFirst() then begin
                    StudentDegree."Graduation Date" := "Graduation Date";
                    StudentDegree.Modify();
                end;

                DegreeAuditRec.Reset();
                DegreeAuditRec.SETRANGE("Student No.", Rec."No.");
                DegreeAuditRec.SETRANGE("Course Code", Rec."Course Code");
                DegreeAuditRec.SETRANGE("Document Status", DegreeAuditRec."Document Status"::"Pending for Verification");
                If DegreeAuditRec.Findfirst() then begin
                    DegreeAuditRec."Graduation Date" := Rec."Graduation Date";
                    DegreeAuditRec.Modify();
                end;
            end;
        }
        field(50236; "AUA Housing Balance"; Decimal)
        {
            Caption = 'AUA Housing Balance';
            FieldClass = FlowField;
            // CalcFormula = sum ("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Original Student No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Code"), "Currency Code" = field("Currency Code"), "Initial Entry Global Dim. 2" = filter('9500')));
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Original Student No."), "Enrollment No." = field("Enrollment No."), "Initial Entry Global Dim. 1" = field("Global Dimension 1 Code"), "Currency Code" = field("Currency Code"), "Initial Entry Global Dim. 2" = filter('9500')));
            Editable = False;
        }

        field(50237; "Current Balance"; Decimal)
        {
            Caption = 'Current Balance';
            FieldClass = FlowField;
            CalcFormula = sum("Detailed Cust. Ledg. Entry".Amount where("Customer No." = field("Original Student No."), "Enrollment No." = field("Enrollment No.")));
            Editable = false;
        }
        field(50250; "Clinical Document Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","In-Progress",Completed;
        }
        field(50251; "Titer Exception Flag"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50252; "Credential Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50253; "Financial Aid Status"; option)
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Aid Status';
            OptionMembers = " ","FINANCIAL AID SUSPENSION","FINANCIAL AID REVOCATION","FINANCIAL AID PROBATION","GOOD STANDING","FINANCIAL AID WARNING";
            OptionCaption = ' ,FINANCIAL AID SUSPENSION,FINANCIAL AID REVOCATION,FINANCIAL AID PROBATION,GOOD STANDING,FINANCIAL AID WARNING';
        }
        field(50254; "FA SAP Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'FA SAP Status';
            OptionMembers = " ","SAP REVOKE","SAP SATISFIED","SAP WARNING";
            OptionCaption = ' ,SAP REVOKE,SAP SATISFIED,SAP WARNING';
        }
        field(50255; "Current FA Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Current FA Academic Year';
            TableRelation = "Financial Aid Academic Year";
        }
        field(50256; "Students FA Academic Years"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50257; "Current Loan Period Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50258; "Current Loan Period End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50259; "5 FA Start Date"; Date)
        {
            Dataclassification = CustomerContent;
            Caption = '5 FA Start Date';
        }
        field(50260; "5 FA End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = '5 FA End Date';
        }
        field(50261; "6 FA Start Date"; Date)
        {
            Dataclassification = CustomerContent;
            Caption = '6 FA Start Date';
        }
        field(50262; "6 FA End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = '6 FA End Date';
        }
        field(50263; "7 FA Start Date"; Date)
        {
            Dataclassification = CustomerContent;
            Caption = '7 FA Start Date';
        }
        field(50264; "7 FA End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = '7 FA End Date';
        }
        field(50265; "8 FA Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = '8 FA Start Date';
        }
        Field(50266; "8 FA End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = '8 FA End Date';
        }
        field(50267; "Xtra Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Xtra Start Date';
        }
        field(50268; "Xtra End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Xtra End Date';
        }
        Field(50269; "FA SAP Sub Status"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'FA SAP Sub Status';
        }
        field(50270; "Failed SAP Reason"; Text[50])//Extend Length
        {
            DataClassification = CustomerContent;
            Caption = 'Failed SAP Reason';
        }
        field(50271; "Financial Aid Recipient"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Financial Aid Recipient';
        }
        field(50272; "FA SAP Status Action"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'FA SAP Status Action';
        }
        Field(50273; "FA SAP Outcome"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'FA SAP Outcome';
        }
        field(50274; "FA Semester Affected"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Semester Affected';
        }
        field(50275; "BSIC Opt Out"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BSIC Opt Out';
        }

        field(50281; "Date Of Determination"; Date)
        {
            Caption = 'Date of Determination';
            DataClassification = CustomerContent;
        }
        field(50282; "Last Date Of Attendance"; Date)
        {
            Caption = 'Last Date Of Attendance';
            DataClassification = CustomerContent;

        }
        field(50283; "Current Semester Start Date"; Date)
        {
            Caption = 'Current Semester Start Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50284; "Current Semester End Date"; Date)
        {
            Caption = 'Current Semester End Date';
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50285; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }

        Field(50286; "CBSE Date"; Date)
        {
            DataClassification = Customercontent;

        }
        Field(50287; "CCSE Date"; Date)
        {
            DataClassification = Customercontent;

        }
        field(50288; "CCSSE Date"; Date)
        {
            DataClassification = Customercontent;

        }
        Field(50289; "CBSE Attempts"; Integer)
        {
            DataClassification = Customercontent;

        }
        field(50290; "CCSE Attempts"; Integer)
        {
            DataClassification = Customercontent;

        }
        field(50291; "CCSSE Attempts"; Integer)
        {
            DataClassification = Customercontent;

        }
        field(50292; "Island Departure Date"; Date)
        {
            DataClassification = Customercontent;

        }
        field(50293; "Returning Student"; Boolean)
        {
            DataClassification = Customercontent;
            Editable = false;

        }
        field(50294; "OLR Email Sent"; Boolean)
        {
            DataClassification = Customercontent;
            Editable = false;

        }
        field(50295; "Immigration Expiration Date"; Date)
        {
            DataClassification = Customercontent;
            Editable = false;

        }
        field(50296; "Immigration Issuance Date"; Date)
        {
            DataClassification = Customercontent;
            Editable = false;

        }
        field(50297; Reason; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50298; "Reason Description"; text[2048])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50299; "Promotion Suggested"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50300; "Ferpa Release Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        Field(50301; "Semester Decision"; Option)
        {
            OptionCaption = ' ,Repeat ,Restart';
            OptionMembers = " ","Repeat ","Restart";
            DataClassification = CustomerContent;
        }
        field(50302; "Student SFP Initiation"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(50303; "Student SFP Update"; Integer)
        {
            DataClassification = CustomerContent;
        }
        Field(50304; "Dismissal Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(50305; "FA Semester"; Code[20]) //CSPL-00307
        {
            Caption = 'FA Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
            trigger OnValidate()
            var
            // myInt: Integer;
            begin
                CalculateSAP(Rec, '');
            end;
        }

        Field(50306; "Temporary Housing Name"; text[100])
        {
            Caption = 'Temporary Housing Name';
            DataClassification = CustomerContent;
        }
        Field(50307; "Temporary Room No."; Code[20])
        {
            Caption = 'Temporary Room No';
            DataClassification = CustomerContent;
        }
        Field(50308; "Temporary Apartment No."; Code[20])
        {
            Caption = 'Temporary Apartment No';
            DataClassification = CustomerContent;
        }
        field(50309; "Temprary Housing Email Sent"; boolean)
        {
            Caption = 'Temprary Housing Email Sent';
            DataClassification = CustomerContent;
        }
        Field(50310; "Nationality Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(50311; "OLR Email Sent Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50312; "MOU Agreement"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50313; "Student SFP Initiation Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        Field(50314; "ISIR E-mail Sent"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50315; "NMI Check Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        Field(50316; "NMI Check ABA"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        Field(50317; "NMI Check Account"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        Field(50318; "Student Return to Lender"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Pending,Complete';
            OptionMembers = " ","Pending","Complete";
        }
        field(50319; "Overall GPA"; Decimal)
        {
            Caption = 'Overall GPA';
            DataClassification = CustomerContent;
        }
        field(50320; "Basic Science GPA"; Decimal)
        {
            Caption = 'Basic Science GPA';
            DataClassification = CustomerContent;
        }

        field(50321; "Clinical GPA"; Decimal)
        {
            Caption = 'Clinical GPA';
            DataClassification = CustomerContent;
        }
        // Field(50322; "NMI Details Update"; Boolean)
        // {

        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Customer."NMI Check Update" where("No." = Field("Original Student No.")));
        //     Caption = 'NMI Refund Details Update';
        //     Editable = false;
        // }
        field(50323; "SAP Semester"; Code[10])//Lucky 
        {
            Caption = 'SAP Semester';
            DataClassification = CustomerContent;
        }
        Field(50324; "Incoming Cohort"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        Field(50325; "Institute Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50326; "Assistant Registrar"; Code[50])//Lucky 
        {
            Caption = 'Assistant Registrar';
            DataClassification = CustomerContent;
            TableRelation = "User Setup"."User ID";
        }
        Field(50327; "Clear OLR Data"; Boolean)
        {
            DataClassification = CustomerContent;

        }
        Field(50328; "Status Sync"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        Field(50329; "FM1/IM1 Start Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Roster Scheduling Line"."Start Date" where("Student No." = field("No."), "Clerkship Type" = filter("FM1/IM1"), Status = filter(<> Cancelled)));
            Editable = false;
        }
        Field(50330; "Teaching Assistant"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50331; "Lease Agreement"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(50332; "FM1/IM1 Start Date New"; Date)
        {
            //CSPL-00307-RTP
            Editable = false;
            Caption = 'FM1/IM1 Start Date';
        }
        Field(50333; "Airport Check-in"; Boolean)//GAURAV//25//01//23//START
        {
            DataClassification = CustomerContent;
        }
        field(50334; "Airport Check-in date"; date)
        {
            DataClassification = CustomerContent;
        }
        Field(50335; "Housing Check-in"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50336; "Housing Check-in date"; date)//GAURAV//25//01//23//END
        {
            DataClassification = CustomerContent;
        }
        field(50337; "SFP Sent Email"; Boolean)
        {
            Caption = 'SFP Sent Email';
            DataClassification = CustomerContent;
            Editable = true;
        }
        //Verity Integration Related changes
        field(50338; "DMS Insert"; Option)
        {
            OptionCaption = ' ,Pending,Synched,Failed';
            OptionMembers = " ",Pending,Synched,Failed;
        }
        field(50339; "DMS Update"; Option)
        {
            OptionCaption = ' ,Pending,Synched,Failed';
            OptionMembers = " ",Pending,Synched,Failed;
        }
        field(50340; "Admission Advisor"; Code[20])
        {
            DataClassification = CustomerContent;
            // TableRelation = "User Setup"."User ID";//CSPL-00307 - As per Sanjay Sir 12-04-23
            TableRelation = Employee."No." where(Department = filter(Verity));
            Description = '04102023        ADA for Enrollment/Student Creation API';
        }
        field(50341; "Registrar Advisor"; Code[20])
        {
            DataClassification = CustomerContent;
            // TableRelation = "User Setup"."User ID";//CSPL-00307 - As per Sanjay Sir 12-04-23
            TableRelation = Employee."No." where(Department = filter(Verity));
        }
        //CS_SG 20230523 FALL 2023 OLR Changes
        field(50342; "CitizenAntiguaBarbuda"; Boolean)
        {
            Caption = 'Are you a citizen of Antigua & Barbuda and reside in Antigua? ';
        }
        field(50343; "T4 Authorization Dummy"; Boolean)//GMCS//240523//FALL 2023 OLR Changes
        {
            DataClassification = CustomerContent;
            Caption = 'T4 OLR Authorization';
        }
        //CS_SG 20230523 FALL 2023 OLR Changes

        //Verity Integration Related changes
        field(50344; "Eligible Non Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50345; "US Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50346; "Antigua Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50347; "Indian Citizen"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50353; "OLR Finance Hold"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("Student Wise Holds" where("Student No." = Field("No."), "Hold Type" = Filter("OLR Finance"), Status = Filter(Enable)));
        }

        field(51000; "Blackboard Synch Status"; Option)//GAURAV//10.6.22//
        {
            OptionMembers = " ",Pending,Completed,Error;
            OptionCaption = ' ,Pending,Completed,Error';
        }

        field(51001; ExpectedGradeDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expected Graduation Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51002; ClnUsmleCertificationDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Certification Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51003; CompShelfAttempts; Integer)
        {
            Caption = 'Comp Shelf Attempt';
            Description = 'Nexus School Defined Fields';
            FieldClass = FlowField;
            CalcFormula = count("Student Subject Exam" where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
        }
        field(51004; CompShelfBest; Decimal)
        {
            Caption = 'Comp Shelf Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51005; CompShelfDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Comp Shelf Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51006; CompShelfPassed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Comp Shelf Passed';
            Description = 'Nexus School Defined Fields';
        }
        field(51007; ClnUsmleStep1EverApplied; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = exist("Student Subject Exam" where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 1")));
            Caption = 'CLN USMLE Step 1 Ever Applied';
            Description = 'Nexus School Defined Fields';
        }
        field(51008; ClnUsmleStep1MaxAttempt; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Subject Exam" where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 1")));
            Caption = 'CLN USMLE Step 1 Max Attempt';
            Description = 'Nexus School Defined Fields';
        }
        field(51009; ClnUsmleStep1Best; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 1")));
            Caption = 'CLN USMLE Step 1 Score';
            Description = 'Nexus School Defined Fields';
        }
        field(51010; ClnUsmleStep1Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN USMLE Step 1  Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51011; ClnUsmleStep1Passed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN USMLE STep 1 Passed';
            Description = 'Nexus School Defined Fields';
        }
        field(51012; ClnUsmleCKMaxAttempt; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Subject Exam" where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 2 CK")));
            Caption = 'CLN USMLE CK Max Attempt';
            Description = 'Nexus School Defined Fields';
        }
        field(51013; ClnUsmleCKBest; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 2 CK")));
            Caption = 'CLN USMLE CK Score';
            Description = 'Nexus School Defined Fields';
        }
        field(51014; ClnUsmleCKDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN USMLE CK Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51015; ClnUsmleCKPassed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN USMLE CK Passed';
            Description = 'Nexus School Defined Fields';
        }
        field(51016; ClnUsmleCSMaxAttempt; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Student Subject Exam" where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 2 CS")));
            Caption = 'CLN USMLE CS Max Attempt';
            Description = 'Nexus School Defined Fields';
        }
        field(51017; ClnUsmleCSBest; Decimal)
        {
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter("STEP 2 CS")));
            Caption = 'CLN USMLE CS Score';
            Description = 'Nexus School Defined Fields';
        }
        field(51018; ClnUsmleCSDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN USMLE CS Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51019; ClnUsmleCSPassed; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN USMLE CS Passed';
            Description = 'Nexus School Defined Fields';
        }
        // field(51020; KMCStudentID; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'KMC Student ID';
        //     Description = 'Nexus School Defined Fields';

        // }
        field(51021; QBStudentID; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'QB Student ID';
            Description = 'Nexus School Defined Fields';
        }
        field(51022; TSStudentEID; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'TS Student EID';
            Description = 'Nexus School Defined Fields';
        }
        field(51023; StudentAltKey; Code[8])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Alt Key';
            Description = 'Nexus School Defined Fields';
        }
        field(51024; SAPStatus; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'SAP Status';
            Description = 'Nexus School Defined Fields';
        }
        field(51025; SAPDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'SAP Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51026; StudentUSMLEConsentRelease; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Student USMLE Consent Release';
            Description = 'Nexus School Defined Fields';
        }
        field(51027; StudentFERPA; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Student FERPA';
            Description = 'Nexus School Defined Fields';
        }
        field(51028; AamcID; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Aamc ID';
            Description = 'Nexus School Defined Fields';
        }
        field(51029; UsmleID; Text[8])
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE ID';
            Description = 'Nexus School Defined Fields';
        }
        field(51030; UsmleRefCode; Text[12])
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Ref Code';
            Description = 'Nexus School Defined Fields';
        }
        field(51031; UsmleCertDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Cert Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51032; UsmleCertTranscriptDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Cert Transcript Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51033; EcfmgCertDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Ecfmg Cert Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51034; ManualEGD; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual EGD';
            Description = 'Nexus School Defined Fields';
        }
        field(51035; "Unique Medical School ID"; Text[61])
        {
            DataClassification = CustomerContent;
            Caption = 'Unique Medical School ID';
            Description = 'Nexus School Defined Fields';
        }
        field(51036; "Step I Test Window"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Step I Test Window';
            Description = 'Nexus School Defined Fields';
        }
        field(51037; "Step II (CS) Test Window"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Step II (CS) Test Window';
            Description = 'Nexus School Defined Fields';
        }
        field(51038; StudentConfirmedRegistration; Boolean)
        {
            Caption = 'Student Confirmed Registration';
            DataClassification = CustomerContent;
            Description = 'Nexus School Defined Fields';
        }
        field(51039; "Clinical Curriculum"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Curriculum';
            OptionCaption = ' ,84,94,75,90,78,88,86,96';
            OptionMembers = " ","84","94","75","90","78","88","86","96";
            Description = 'Nexus School Defined Fields';
        }
        field(51040; StudentMediaRelease; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Media Release';
            Description = 'Nexus School Defined Fields';
        }
        field(51041; StudentDocsUpdated; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Docs Updated';
            Description = 'Nexus School Defined Fields';
        }
        field(51042; StudentPassportIssuedBy; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Passport Issued By';
            Description = 'Nexus School Defined Fields';
        }
        field(51043; CountryOfCitizenship; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Country of Citizenship';
            Description = 'Nexus School Defined Fields';
        }
        field(51044; "Remote Learning Choice"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Remote Learning Choice';
            Description = 'Nexus School Defined Fields';
        }
        field(51045; Cln5thSemEnded; Date)
        {
            DataClassification = CustomerContent;
            Caption = '5th Sem Ended';
            Description = 'Nexus School Defined Fields';
        }
        field(51046; ClnDocsComplete; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Docs Complete';
            Description = 'Nexus School Defined Fields';
        }
        field(51047; ClnCurrentlyRotating; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currently Rotating';
            Description = 'Nexus School Defined Fields';
        }
        field(51048; Cln1stRotationStarted; Date)
        {
            DataClassification = CustomerContent;
            Caption = '1st Rotation Started';
            Description = 'Nexus School Defined Fields';
        }
        field(51049; ClnLastRotationEnd; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Rotation End';
            Description = 'Nexus School Defined Fields';
        }
        field(51050; ClnNextRotationStart; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Rotation Start';
            Description = 'Nexus School Defined Fields';
        }
        field(51051; ClnNextSemStart; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Next Sem Start';
            Description = 'Nexus School Defined Fields';

        }
        field(51052; ClnSemStart6; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Sem Start 6';
            Description = 'Nexus School Defined Fields';
        }
        field(51053; ClnSemStart7; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Sem Start 7';
            Description = 'Nexus School Defined Fields';
        }
        field(51054; ClnSemStart8; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Sem Start 8';
            Description = 'Nexus School Defined Fields';
        }
        field(51055; ClnWksOnRecord; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Wks on Record';
            Description = 'Nexus School Defined Fields';
        }
        field(51056; ClnWksTransferred; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Wks Transferred';
            Description = 'Nexus School Defined Fields';

        }
        field(51057; ClnWksScheduledHere; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'WkS Scheduled Here';
            Description = 'Nexus School Defined Fields';
        }
        field(51058; ClnWksSatisfiedHere; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'WKS Satisfied Here';
            Description = 'Nexus School Defined Fields';

        }
        field(51059; ClnWksSatisfiedOptimistic; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'WKS Satisfied Optimitic';
            Description = 'Nexus School Defined Fields';
        }
        field(51060; ClnWksSatisfiedPessimistic; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'WKS Satisfied Pessimistic';
            Description = 'Nexus School Defined Fields';
        }
        field(51061; ClnWksSatisfiedTotal; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'WKS Satisfied Total';
            Description = 'Nexus School Defined Fields';
        }
        field(51062; ClnWksFailed; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'WKS Failed';
            Description = 'Nexus School Defined Fields';
        }
        field(51063; ClnDog6; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog 6';
            Description = 'Nexus School Defined Fields';
        }
        field(51064; ClnDog7; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog 7';
            Description = 'Nexus School Defined Fields';
        }
        field(51065; ClnDog8; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog 8';
            Description = 'Nexus School Defined Fields';
        }
        field(51066; ClnDog5; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog 5';
            Description = 'Nexus School Defined Fields';
        }
        field(51067; ClnDogToDate; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog To Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51068; ClnDogSched; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog Sched';
            Description = 'Nexus School Defined Fields';
        }
        field(51069; ClnDogCurrSem; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog Curr Sem';
            Description = 'Nexus School Defined Fields';
        }
        field(51070; ClnDogCurrent; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Dog Current';
            Description = 'Nexus School Defined Fields';
        }
        field(51071; "FM1/IM1 Proposed Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Porposed Start Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51072; "FM1/IM1 Document Due Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Document Due Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51073; "Rotation Count"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Count';
            Description = 'Nexus School Defined Fields';
        }
        field(51074; ClnSemStart5; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Sem Start 5';
            Description = 'Nexus School Defined Fields';
        }
        field(51075; Cln6thSemEnded; Date)
        {
            DataClassification = CustomerContent;
            caption = '6th Sem Ended';
            Description = 'Nexus School Defined Fields';
        }
        field(51076; Cln7thSemEnded; Date)
        {
            DataClassification = CustomerContent;
            Caption = '7th Sem Ended';
            Description = 'Nexus School Defined Fields';
        }
        field(51077; Cln8thSemEnded; Date)
        {
            DataClassification = CustomerContent;
            Caption = '8th Sem Ended';
            Description = 'Nexus School Defined Fields';
        }
        field(51078; ClnWksFailedBilled; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Wks Failed Billed';
            Description = 'Nexus School Defined Fields';
        }
        field(51079; ClnBldSem6; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN Billed Sem 6';
            Description = 'Nexus School Defined Fields';
        }
        field(51080; ClnBldSem7; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN Billed Sem 7';
            Description = 'Nexus School Defined Fields';
        }
        field(51081; ClnBldSem8; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN Billed Sem 8';
            Description = 'Nexus School Defined Fields';
        }
        field(51082; ClnBldSem5; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN Billed Sem 5';
            Description = 'Nexus School Defined Fields';
        }
        field(51083; ClnBldSemXtra; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN Billed Sem Xtra';
            Description = 'Nexus School Defined Fields';
        }
        field(51084; StudentInsuranceCode; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Insurance Code';
            Description = 'Nexus School Defined Fields';
        }
        field(51085; Transport; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Transport';
            Description = 'Nexus School Defined Fields';
        }
        field(51086; Selfpay; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Selfpay';
            Description = 'Nexus School Defined Fields';
        }
        field(51087; ClnFinProc8; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin Proc 8';
            Description = 'Nexus School Defined Fields';
        }
        field(51088; ClnFinProc5; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin Proc 5';
            Description = 'Nexus School Defined Fields';
        }
        field(51089; ClnFinProc6; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin Proc 6';
            Description = 'Nexus School Defined Fields';
        }
        field(51090; ClnFinProc7; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Fin Proc 7';
            Description = 'Nexus School Defined Fields';
        }
        field(51091; StudentFinancialAid; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Financial Aid';
            Description = 'Nexus School Defined Fields';
        }
        field(51092; "Intent to Pay"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Intent to Pay';
            Description = 'Nexus School Defined Fields';
        }

        field(51093; UsmleTranscriptRcvdDate; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE Transcript Rcvd Date';
            Description = 'Nexus School Defined Fields';
        }
        field(51094; "Step II (CK) Test Window"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Step II (CK) Test Window';
            Description = 'Nexus School Defined Fields';
        }
        field(51095; "CLN Weeks Billed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'CLN Weeks Billed';
            Description = 'Required for Student Billing';
        }
        field(51096; "Document Exception Flag"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Exception Flag';
        }
        field(51097; "CCSE Score"; Decimal)
        {
            Caption = 'CCSE Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51098; "CCSSE PEDS Score"; Decimal)
        {
            Caption = 'CCSSE PEDS Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51099; "CCSSE IM Score"; Decimal)
        {
            Caption = 'CCSSE IM Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51100; "CCSSE FM Score"; Decimal)
        {
            Caption = 'CCSSE FM Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51101; "CCSSE SUR Score"; Decimal)
        {
            Caption = 'CCSSE SUR Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51102; "CCSSE PSY Score"; Decimal)
        {
            Caption = 'CCSSE PSY Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        field(51103; "CCSSE OB Score"; Decimal)
        {
            Caption = 'CCSSE OB Score';
            // FieldClass = FlowField;
            // CalcFormula = Max("Student Subject Exam".Total where("Original Student No." = field("Original Student No."), "Global Dimension 1 Code" = const('9000'), "Score Type" = filter(CBSE)));
            Description = 'Nexus School Defined Fields';
            Editable = false;
        }
        Field(51173; "Flight Arrival Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        Field(51174; "Flight Arrival Time"; Time)
        {
            DataClassification = CustomerContent;

        }
        Field(51175; "Flight Number"; Text[20])
        {
            DataClassification = CustomerContent;

        }
        Field(51176; "Airline/Carrier"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(51177; "Departure Date from Antigua"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(51178; "FIU Weeks Billed"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'FIU Weeks Billed';
            Description = 'Required for Student Billing';
        }
        field(51179; "Multiple Enrollment CGPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        Field(51180; "SAFI Sync"; Option)
        {
            OptionCaption = ' ,Pending,Complete,Failed';
            OptionMembers = " ",Pending,Complete,Failed;
        }
        Field(51181; "SFP-LOA"; Option)
        {
            OptionCaption = ' ,Pending,Complete,Failed';
            OptionMembers = " ",Pending,Complete,Failed;
        }
        field(51182; "Safi Sent"; date)
        {
            Caption = 'Safi Sent';
            DataClassification = CustomerContent;
        }
        field(51183; "Self-Pay Applied"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(51184; "VA Benefit"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(60000; "Clinical Documents to Validate"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Document Attachment" where("Student No." = field("No."),
            "Document Status" = filter("Portal Submitted" | Submitted | DRNYC | DROC | RESUBMIT | SENT | UREVIEW),
            "Transaction No." = filter(<> ''),
            "Document Category" = filter('CLINICAL'),
            "SLcM Document No" = filter('CLINICAL_DOCUMENTS')));
            Editable = false;
        }
        field(60001; "Clinical Hold Exist"; Boolean)
        {
            FieldClass = FlowField;
            // CalcFormula = exist("Student Group" where("Student No." = field("No."), "Group Type" = filter("Clinical Hold"), Blocked = filter(false)));
            CalcFormula = exist("Student Wise Holds" where("Student No." = field("No."), "Hold Code" = filter('CLNHOLD'), Status = Filter(Enable)));//CSPL-00307-RTP
            Editable = false;
        }
        field(60002; "Spcl Accommodation Appln"; Boolean)
        {
            Caption = 'Special Accommodation Application';
            FieldClass = FlowField;
            CalcFormula = exist("Std Spl Accommodation Category" where("Student ID" = field("No."), Category = filter(Health), "Approval Status" = filter(Approved)));
            Editable = false;
        }
        field(60003; "Subject Group Filter"; Code[20])
        {
            Caption = 'Subject Group Filter';
            FieldClass = FlowFilter;
            Editable = false;
        }
        field(60004; "Subject Code Filter"; Code[20])
        {
            Caption = 'Subject Code Filter';
            FieldClass = FlowFilter;
            Editable = false;
        }
        field(63001; "Calc. Semester I GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63002; "Calc. Semester II GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63003; "Calc. Semester III GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63004; "Calc. Semester IV GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63005; "Calc. Semester V GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63006; "Calc. Semester VI GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63007; "Calc. Semester VII GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63008; "Calc. Semester VIII GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63009; "Calc. Semester IX GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        field(63010; "Calc. GPA"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(63100; "Step 2 CK Exam Pass"; Boolean)
        {
            Caption = 'Step 2 CK Exam Pass';
            FieldClass = FlowField;
            CalcFormula = exist("Student Subject Exam" where("Student No." = field("No."), "Score Type" = filter("STEP 2 CK"), Result = filter(Pass)));
            Editable = false;
        }
        field(70000; "Grant Code 3"; Code[20])
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Grant Code 3';
            DataClassification = CustomerContent;
            TableRelation = "Source Scholarship-CS" WHERE("Discount Type" = FILTER(Grant), "Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            trigger OnValidate()
            var
                CLE: Record "Cust. Ledger Entry";
            begin
                if ("Grant Code 3" <> '') and ("Grant Code 3" <> xRec."Grant Code 3") then begin
                    if "Grant Code 1" = "Grant Code 3" then
                        Error('Same code is already selected in Grant Code 1');
                    if "Grant Code 2" = "Grant Code 3" then
                        Error('Same code is already selected in Grant Code 2');

                    CLE.Reset();
                    CLE.SETRANGE(CLE."Customer No.", "Original Student No.");
                    CLE.SETRANGE(CLE."Document Type", CLE."Document Type"::"Credit Memo");
                    CLE.SETRANGE(CLE."Academic Year", "Academic Year");
                    CLE.SETRANGE(CLE.Year, Year);
                    ClE.SETRANGE(Semester, Semester);
                    CLE.SETRANGE("Waiver/Scholar/Grant Code", "Grant Code 3");
                    CLE.SETRANGE(CLE.Reversed, FALSE);
                    if CLE.FindFirst() then
                        Error('You cannot change the Grant code 3, as Grant is already generated for this semester.');
                end;
                UpdateCustomer();
            end;
        }
        field(70001; "Applied For Scholarship"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Applied For Scholarship';
            DataClassification = CustomerContent;
        }
        field(70002; "Approved For Scholarship"; Boolean)
        {
            Description = 'CS Field Added 12-05-2019';
            Caption = 'Approved For Scholarship';
            DataClassification = CustomerContent;
        }
        field(71000; "FSA ID"; Text[30])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                StudentMasterRec: Record "Student Master-CS";
                SSNGroupAreaCodeRec: Record "SSN Group Area Code";
                //SLcMToSalesforceCod: Codeunit SLcMToSalesforce;
                FourChar: Text;
                SevenChar: Text;
                Starting3D: Integer;
                Starting3D1: Text;
                Last4D: Integer;
                Last4D1: Text;
                Middle56D: Integer;
                Middle56D1: Text;
                FinalValue: Text;
                TotalLength: Integer;
            begin
                if "FSA ID" <> '' then begin

                    TotalLength := STRLEN("FSA ID");
                    if TotalLength <> 11 then
                        Error('The FSA ID you enterned is not of 11 characters please verify your FSA ID and re-enter it');

                    StudentMasterRec.Reset();
                    //StudentMasterRec.SetFilter("No.", '<>%1', "No.");
                    StudentMasterRec.SetFilter("Original Student No.", '<>%1', Rec."Original Student No.");
                    StudentMasterRec.SetRange("FSA ID", "FSA ID");
                    if StudentMasterRec.FindFirst() then begin
                        if ("Parent Student No." <> '') or (StudentMasterRec."Parent Student No." <> '') then
                            TestField("FSA ID", StudentMasterRec."FSA ID");

                        Error('The FSA ID you enterned is duplicate please verify your FSA ID and re-enter it');
                    end;

                    Starting3D1 := COPYSTR("FSA ID", 1, 3);
                    EVALUATE(Starting3D, Starting3D1);
                    IF Starting3D1 IN ['000', '666'] THEN
                        ERROR('Starting 3 Char of the FSA ID cannot be %1', Starting3D1);

                    SSNGroupAreaCodeRec.Reset();
                    SSNGroupAreaCodeRec.SetRange("Area Code", Starting3D1);
                    if Not SSNGroupAreaCodeRec.FindFirst() then
                        ERROR('Starting 3 Char of the FSA ID is not found in SSN Group Area master');

                    FourChar := COPYSTR("FSA ID", 4, 1);
                    IF (FourChar <> '-') THEN
                        ERROR('4th Char of the FSA ID must be %1', '-');

                    Middle56D1 := COPYSTR("FSA ID", 5, 2);
                    EVALUATE(Middle56D, Middle56D1);
                    IF NOT (Middle56D >= 01) AND (Middle56D <= 99) THEN
                        ERROR('Middle 2 Char of the FSA ID should be in-between %1', '01-99');

                    SevenChar := COPYSTR("FSA ID", 7, 1);
                    IF (SevenChar <> '-') THEN
                        ERROR('7th Char of the FSA ID must be %1', '-');

                    Last4D1 := COPYSTR("FSA ID", 8, 4);
                    EVALUATE(Last4D, Last4D1);
                    IF NOT (Last4D >= 1) AND (Last4D <= 9999) THEN
                        ERROR('Last 4 Char of the FSA ID should be in-between %1', '0001-9999');

                    FinalValue := Starting3D1 + Middle56D1 + Last4D1;
                    if FinalValue IN ['219099999', '999999999', '078051120', '111111111', '123456789', '987654320', '987654321'
                    , '987654322', '987654323', '987654324', '987654325', '987654326', '987654327', '987654328', '987654329'] then
                        Error('The format of the FSA ID you enterned is invalid please verify your FSA ID and re-enter it.');

                    // SLcMToSalesforceCod.StudentMasterSFModify(Rec);
                end;
            end;
        }
        field(71001; "T4 Authorization"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'T4 Agreement';
            trigger OnValidate()
            var
                DepartmentApprover: Record "Document Approver Users";
            Begin
                If xRec."T4 Authorization" then
                    If not Rec."T4 Authorization" then begin
                        DepartmentApprover.Reset();
                        DepartmentApprover.SetRange("User ID", USerID());
                        DepartmentApprover.SetRange("Department Approver Type", DepartmentApprover."Department Approver Type"::"Bursar Department");
                        If not DepartmentApprover.FindFirst() then
                            Error('Only Bursar Department deactivate T4 Agreement');
                    end;
                If not xRec."T4 Authorization" then
                    If Rec."T4 Authorization" then begin
                        DepartmentApprover.Reset();
                        DepartmentApprover.SetRange("User ID", USerID());
                        DepartmentApprover.SetRange("Department Approver Type", DepartmentApprover."Department Approver Type"::"Bursar Department");
                        If not DepartmentApprover.FindFirst() then
                            Error('Only Bursar Department activate T4 Agreement');

                    end;
            End;
        }

        field(72001; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72002; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        //SD-SN-11-Dec-2020 + 
        field(72003; "Apply For Insurance"; Boolean)
        {

            Caption = 'Apply For Insurance';
            DataClassification = CustomerContent;
            Editable = false;
        }
        //SD-SN-11-Dec-2020 -
        field(72005; "ECFMG ID"; Code[20])
        {

            Caption = 'ECFMG ID';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(72006; "KMC ID"; Text[20])
        {
            Caption = 'KMC ID';
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(72007; "Original Student No."; Code[20])
        {
            Caption = 'Student ID';
            DataClassification = CustomerContent;
        }
        field(72008; "Enrollment Order"; Integer)
        {
            Caption = 'Enrollment Order';
            DataClassification = CustomerContent;
            MinValue = 1;
            MaxValue = 27;
        }
        field(72009; "No. of Enrollments"; Integer)
        {
            Caption = 'No. of Enrollments';
            FieldClass = FlowField;
            CalcFormula = Count("Student Master-CS" WHERE("Original Student No." = FIELD("Original Student No.")));
        }
        field(72010; "FERPA Release"; Option)
        {
            OptionMembers = " ",Accept,Decline;
        }
        field(33048920; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Description = 'CS Field Added 18-06-2019';
            DataClassification = CustomerContent;
        }
        field(33048921; "Portal ID"; Code[20])
        {
            Caption = 'Portal ID';
            Description = 'CS Field Added 18-06-2019';
            DataClassification = CustomerContent;
        }
        field(33048922; Department; Code[20])
        {
            Caption = 'Department';
            Description = 'CS Field Added 18-06-2019';
            TableRelation = "Department Head-CS";
            DataClassification = CustomerContent;
        }
        field(33048924; "Blood Group"; Option)
        {
            Caption = 'Blood Group';
            Description = 'CS Field Added 18-06-2019';
            OptionCaption = ' ,A+,A-,B+,B-,AB+,AB-,O+,O-';
            OptionMembers = " ","A+","A-","B+","B-","AB+","AB-","O+","O-";
            DataClassification = CustomerContent;
        }
        field(33048925; District; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'District';
            DataClassification = CustomerContent;
        }
        field(33048926; "Alternate Email Address"; Code[50])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Alternate Email';
            DataClassification = CustomerContent;
        }
        field(33048927; Domicile; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Domicile';
            DataClassification = CustomerContent;
        }
        field(33048928; "Emergency Contact No."; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Emergency Contact No.';
            DataClassification = CustomerContent;
        }
        field(33048934; Session; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            TableRelation = Session;
            Caption = 'Session';
            DataClassification = CustomerContent;
        }
        field(33048935; "Enrollment No."; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                CourseSemesterRec: Record "Course Sem. Master-CS";
                SFStudentCreation: Codeunit SFStudentCreationAuto;
                StudentStatutsMgt: Codeunit "Student Status Mangement";
                SLcMToSalesforceCodeunit: Codeunit SLcMToSalesforce;
                SemesterCount: Integer;
                NoofYear: Integer;
            begin
                //Code added for Validate and Update data::CSPL-00092::06-05-2019: Start
                Testfield(Status, '');
                //WebServicesFunctionsCS.StudentCreation(Rec);
                //RecStudentStatusManagement.EnableStudentWiseHold(Rec);   FALL 2023 OLR Changes
                if "Parent Student No." = '' then
                    CreditStudentToCustomer();
                Validate(Status, StudentStatutsMgt.NewStudenttoDesposited("Global Dimension 1 Code"));
                If "E-Mail Address" <> '' then
                    SLcMToSalesforceCodeunit.StudentMasterSFModify(Rec);

                // Code commented as it is being calculated on batch job -Start
                // CourseSemesterRec.Reset();
                // if CourseSemesterRec.FindSet() then
                //     SemesterCount := CourseSemesterRec.Count;

                // NoofYear := Round((SemesterCount / 2), 1, '>') * 365;

                // CourseSemesterRec.Reset();
                // CourseSemesterRec.SetRange("Course Code", "Course Code");
                // CourseSemesterRec.SetRange("Semester Code", Semester);
                // if CourseSemesterRec.FindFirst() then
                //     "Estimated Graduation Date" := CourseSemesterRec."Start Date" + NoofYear;
                // Code commented as it is being calculated on batch job -End
                // IF "E-Mail Address" <> '' then
                //     SFStudentCreation.EmailTrigger(Rec);
            end;
        }
        field(33048936; "Hold Result"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Hold Result';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Validate and Update data::CSPL-00092::06-05-2019: Start
                IF "Hold Result" = TRUE THEN BEGIN
                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", "Academic Year");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Actual Semester", Semester);
                    IF MainStudentSubjectCS.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS.Inactive := TRUE;
                            MainStudentSubjectCS.Updated := TRUE;
                            MainStudentSubjectCS.Modify();
                        UNTIL MainStudentSubjectCS.NEXT() = 0;

                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", "No.");
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", "Academic Year");
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Actual Semester", Semester);
                    IF OptionalStudentSubjectCS.FINDSET() THEN
                        REPEAT
                            OptionalStudentSubjectCS.Inactive := TRUE;
                            OptionalStudentSubjectCS.Updated := TRUE;
                            OptionalStudentSubjectCS.Modify();
                        UNTIL OptionalStudentSubjectCS.NEXT() = 0;
                END ELSE BEGIN
                    MainStudentSubjectCS.Reset();
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Student No.", "No.");
                    MainStudentSubjectCS.SETRANGE(MainStudentSubjectCS."Academic Year", "Academic Year");
                    IF MainStudentSubjectCS.FINDSET() THEN
                        REPEAT
                            MainStudentSubjectCS.Inactive := FALSE;
                            MainStudentSubjectCS.Updated := TRUE;
                            MainStudentSubjectCS.Modify();
                        UNTIL MainStudentSubjectCS.NEXT() = 0;


                    OptionalStudentSubjectCS.Reset();
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Student No.", "No.");
                    OptionalStudentSubjectCS.SETRANGE(OptionalStudentSubjectCS."Academic Year", "Academic Year");
                    IF OptionalStudentSubjectCS.FINDSET() THEN
                        REPEAT
                            OptionalStudentSubjectCS.Inactive := FALSE;
                            OptionalStudentSubjectCS.Updated := TRUE;
                            OptionalStudentSubjectCS.Modify();
                        UNTIL OptionalStudentSubjectCS.NEXT() = 0;

                END;
                //Code added for Validate and Update data::CSPL-00092::06-05-2019: End
            end;
        }
        field(33048937; Result; Option)
        {
            Description = 'CS Field Added 18-06-2019';
            OptionCaption = ' ,Pass,Fail,On Hold';
            OptionMembers = " ",Pass,Fail,"On Hold";
            Caption = 'Result';
            DataClassification = CustomerContent;
        }
        field(33048938; "Semester I"; Decimal)
        {
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('I')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Semester I';
        }
        field(33048939; "Semester II"; Decimal)
        {
            Caption = 'Semester II';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('II')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048940; "Semester III"; Decimal)
        {
            Caption = 'Semester III';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('III')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048941; "Semester IV"; Decimal)
        {
            Caption = 'Semester IV';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('IV')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048942; "Semester V"; Decimal)
        {
            Caption = 'Semester V';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('V')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048943; "Semester VI"; Decimal)
        {
            Caption = 'Semester VI';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('VI')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048944; "Semester VII"; Decimal)
        {
            Caption = 'Semester VII';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('VII')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048945; "Semester VIII"; Decimal)
        {
            Caption = 'Semester VIII';
            CalcFormula = Sum("Main Student Subject-CS".Total WHERE("Student No." = FIELD("No."),
                                                                     Semester = FILTER('VIII')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048946; "Max Marks Semester I"; Decimal)
        {
            Caption = 'Max Marks Semester I';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('I')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048947; "Max Marks Semester II"; Decimal)
        {
            Caption = 'Max Marks Semester II';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('II')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048948; "Max Marks Semester III"; Decimal)
        {
            Caption = 'Max Marks Semester III';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('III')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048949; "Max Marks Semester IV"; Decimal)
        {
            Caption = 'Max Marks Semester IV';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('IV')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048950; "Max Marks Semester V"; Decimal)
        {
            Caption = 'Max Marks Semester V';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('V')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048951; "Max Marks Semester VI"; Decimal)
        {
            Caption = 'Max Marks Semester VI';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('VI')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048952; "Max Marks Semester VII"; Decimal)
        {
            Caption = 'Max Marks Semester VII';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('VII')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048953; "Max Marks Semester VIII"; Decimal)
        {
            Caption = 'Max Marks Semester VIII';
            CalcFormula = Sum("Main Student Subject-CS"."Maximum Mark" WHERE("Student No." = FIELD("No."),
                                                                              Semester = FILTER('VIII')));
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33048954; "Semester I Pass"; Boolean)
        {
            Caption = 'Max Marks Semester I';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
        }
        field(33048955; "Semester II Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester II Pass';
            DataClassification = CustomerContent;
        }
        field(33048956; "Semester III Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester III Pass';
            DataClassification = CustomerContent;
        }
        field(33048957; "Semester IV Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester IV Pass';
            DataClassification = CustomerContent;
        }
        field(33048958; "Semester V Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester V Pass';
            DataClassification = CustomerContent;
        }
        field(33048959; "Semester VI Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester VI Pass';
            DataClassification = CustomerContent;
        }
        field(33048960; "Semester VII Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester VII Pass';
            DataClassification = CustomerContent;
        }
        field(33048961; "Semester VIII Pass"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Semester VIII Pass';
            DataClassification = CustomerContent;
        }
        field(33048962; "Semester I GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = true;
            Caption = 'Semester I GPA';
            DataClassification = CustomerContent;
        }
        field(33048963; "Semester II GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = true;
            Caption = 'Semester II GPA';
            DataClassification = CustomerContent;
        }
        field(33048964; "Semester III GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = true;
            Caption = 'Semester III GPA';
            DataClassification = CustomerContent;
        }
        field(33048965; "Semester IV GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Semester IV GPA';
            DataClassification = CustomerContent;
        }
        field(33048966; "Semester V GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Semester V GPA';
            DataClassification = CustomerContent;
        }
        field(33048967; "Semester VI GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Semester VI GPA';
            DataClassification = CustomerContent;
        }
        field(33048968; "Semester VII GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Semester VII GPA';
            DataClassification = CustomerContent;
        }
        field(33048969; "Semester VIII GPA"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Semester VIII GPA';
            DataClassification = CustomerContent;
        }
        field(33048970; "Transport Facility"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Transport Facility';
            DataClassification = CustomerContent;
        }
        field(33048971; Password; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Password';
            DataClassification = CustomerContent;
        }
        field(33048972; "Examination Form"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Editable = false;
            Caption = 'Examination Form';
            DataClassification = CustomerContent;
        }
        field(33048973; "Provisional Degree"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Provisional Degree';
            DataClassification = CustomerContent;
        }
        field(33048974; "Final Degree"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Final Degree';
            DataClassification = CustomerContent;
        }
        field(33048975; "Course Code(Minor)"; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            TableRelation = "Category Master-CS";
            Caption = 'Cource Code (Minor)';
            DataClassification = CustomerContent;
        }
        field(33048976; "No. Series"; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            TableRelation = "No. Series";
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(33048977; "Transport Allot"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Transport Allot';
            DataClassification = CustomerContent;
            // Trigger OnValidate()
            // var
            //     HoldEnable: Boolean;
            // begin
            //     //    if ("Transport Allot" <> xRec."Transport Allot") AND ("Transport Allot" <> false) then begin
            //     HoldEnable := BursarHoldCheck("No.");
            //     if HoldEnable = false then
            //         Error('Bursar hold is already disable for the semester, now you can change in the next semester.');
            //     //end;
            // end;
        }
        field(33048978; "OLR Completed"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'OLR Completed';
            DataClassification = CustomerContent;
        }
        field(33048979; "Portal DB"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Portal DB';
            DataClassification = CustomerContent;
        }
        field(33048980; "PAN Card Number"; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'PAN Card No.';
            DataClassification = CustomerContent;
        }
        field(33048981; "Aadhar Card Number"; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Aadhar No.';
            DataClassification = CustomerContent;
        }
        field(33048982; "Bank A/C Number"; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Bank A/c No.';
            DataClassification = CustomerContent;
        }
        field(33048983; "Account Holder Name"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Account Holder Name';
            DataClassification = CustomerContent;
        }
        field(33048984; "IFSC Code"; Code[11])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'IFSC Code';
            DataClassification = CustomerContent;
        }
        field(33048985; Branch; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Branch';
            DataClassification = CustomerContent;
        }
        field(33048986; "Bank Name"; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(33048987; "Father Contact Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Father Contact No.';
            DataClassification = CustomerContent;
        }
        field(33048988; "Father Email ID"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            ExtendedDatatype = EMail;
            Caption = 'Father E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(33048989; "Mother Contact Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Mother Contact No.';
            DataClassification = CustomerContent;
        }
        field(33048990; "Mother Email ID"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            ExtendedDatatype = EMail;
            Caption = 'Mother E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(33048991; "Guardian Contact Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Guardian Contact Number';
            DataClassification = CustomerContent;
        }
        field(33048992; "Guardian Email ID"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            ExtendedDatatype = EMail;
            Caption = 'Guardian E-Mail ID';
            DataClassification = CustomerContent;
        }
        field(33048993; "Sponsorer Name"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer Name';
            DataClassification = CustomerContent;
        }
        field(33048994; Relation; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Relation';
            DataClassification = CustomerContent;
        }
        field(33048995; "Sponsorer Address Line 1"; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer Address Line 1';
            DataClassification = CustomerContent;
        }
        field(33048996; "Sponsorer Address Line 2"; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer Address Line 2';
            DataClassification = CustomerContent;
        }
        field(33048997; "Sponsorer Address Line 3"; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer Address Line 3';
            DataClassification = CustomerContent;
        }
        field(33048998; "Sponsorer City"; Text[30])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer City';
            DataClassification = CustomerContent;
        }
        field(33048999; "Sponsorer State"; Code[10])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer State';
            DataClassification = CustomerContent;
        }
        field(33049000; "Sponsorer Country"; Code[10])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer Country';
            DataClassification = CustomerContent;
        }
        field(33049001; "Sponsorer Pin Code"; Code[10])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Sponsorer Pin Code';
            DataClassification = CustomerContent;
        }
        field(33049002; "Official Correspo Mobile No."; Code[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Official Correspo Mobile No.';
            DataClassification = CustomerContent;
        }
        field(33049003; "Transf Admission Higher Sem"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Transf Admission Higher Semester';
            DataClassification = CustomerContent;
        }
        field(33049004; "Addmission to which Sem"; Code[5])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Addmission to which Semester';
            DataClassification = CustomerContent;
        }
        field(33049005; "Number of Credits Earned"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Number of Credits Earned';
            DataClassification = CustomerContent;
        }
        field(33049006; "Pass Port Issued Date"; Date)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Passport Issued Date';
            DataClassification = CustomerContent;
        }
        field(33049007; "Visa Issued Date"; Date)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'VISA Issued Date';
            DataClassification = CustomerContent;
        }
        field(33049008; "RC/RP Number"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'RC/RP No.';
            DataClassification = CustomerContent;
        }
        field(33049009; "RC/RP Issued Date"; Date)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'RC/RP Issued Date';
            DataClassification = CustomerContent;
        }
        field(33049010; "RC/RP Expiry Date"; Date)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'RC/RP Expiry Date';
            DataClassification = CustomerContent;
        }
        field(33049011; "S Form ID"; Text[20])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'S Form ID';
            DataClassification = CustomerContent;
        }
        field(33049012; "Entrance Test Rank"; Integer)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Entrance Test Rank';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Code added for Call Function For Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call Function For Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(33049013; "UP Email Sent"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Up E-Mail Sent';
            DataClassification = CustomerContent;
        }
        field(33049014; "10th %"; Text[5])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = '10th %';
            DataClassification = CustomerContent;
        }
        field(33049015; "Physic Math Optional %"; Text[5])
        {
            Caption = '12th (Physics + Maths %)';
            Description = 'CS Field Added 18-06-2019';
            DataClassification = CustomerContent;
        }
        field(33049016; "Total Family Income"; Decimal)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Total Family Income';
            DataClassification = CustomerContent;
        }
        field(33049017; "Lateral Student"; Boolean)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Lateral Student';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Call Function For Update Customer::CSPL-00092::06-05-2019: Start
                UpdateCustomer();
                //Code added for Call Function For Update Customer::CSPL-00092::06-05-2019: End
            end;
        }
        field(33049018; "Credit Student"; Option)
        {
            Description = 'CS Field Added 18-06-2019';
            OptionCaption = ' ,Applied,Approved,Rejected';
            OptionMembers = " ",Applied,Approved,Rejected;
            Caption = 'Credit Student';
            DataClassification = CustomerContent;
        }
        field(33049019; "Updated On"; Date)
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(33049020; "Updated By"; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(33049021; Remark; Text[50])
        {
            Description = 'CS Field Added 18-06-2019';
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(33049022; "Communication Address"; Option)
        {
            Description = 'CS Field Added 18-06-2019';
            OptionCaption = ',Present, Permanent';
            OptionMembers = ,Present," Permanent";
            Caption = 'Communication Address';
            DataClassification = CustomerContent;
        }
        //SD-SN-03-Dec-2020+
        field(33049023; "Resident Address"; Text[250])
        {
            Caption = 'Resident Address';
            DataClassification = CustomerContent;
        }
        field(33049024; "Resident Country"; Code[10])
        {
            Caption = 'Resident Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(33049025; "Resident State"; Code[10])
        {
            Caption = 'Resident State';
            DataClassification = CustomerContent;
        }
        field(33049026; "Resident City"; Text[30])
        {
            Caption = 'Resident City';
            DataClassification = CustomerContent;
            //TableRelation = "Post Code".City;
        }
        field(33049027; "Resident Zip Code"; Code[20])
        {
            Caption = 'Resident Zip Code';
            DataClassification = CustomerContent;
            // TableRelation = if ("Resident Country" = const()) "Post Code"
            // else
            // if ("Resident Country" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field("Resident Country"));
        }
        field(33049028; "Resident Plan"; Option)
        {
            OptionMembers = " ","From Antigua","From my home";
            Caption = 'Resident Plan';
            DataClassification = CustomerContent;
        }

        //SD-SN-15-Dec-2020 + Fields Added
        field(33049029; "Sub-Stage"; Text[50])
        {
            Caption = 'Sub-Stage';
            DataClassification = CustomerContent;
        }
        field(33049030; "Student Accepted Date"; Date)
        {
            Caption = 'Student Accepted Date';
            DataClassification = CustomerContent;
        }
        field(33049031; Housing; Option)
        {
            Caption = 'Housing';
            DataClassification = CustomerContent;
            OptionCaption = ' ,AUA Housing,Independent Housing';
            OptionMembers = " ","AUA Housing","Independent Housing";
        }
        field(33049032; "Seat Deposit Paid"; Boolean)
        {
            Caption = 'Seat Deposit Paid';
            DataClassification = CustomerContent;
        }
        field(33049033; "Housing Deposit Waived"; Boolean)
        {
            Caption = 'Housing Deposit Waived';
            DataClassification = CustomerContent;
        }
        field(33049034; "Housing Deposit Date"; Date)
        {
            Caption = 'Housing Deposit Date';
            DataClassification = CustomerContent;
        }
        field(33049035; "Housing/Waiver Application No."; Code[20])
        {
            Caption = 'Housing/Waiver Application No.';
            DataClassification = CustomerContent;
        }
        field(33049036; "Deposit Waived"; Boolean)
        {

            Caption = 'Deposit Waived';
            DataClassification = CustomerContent;
        }
        field(33049037; "Deposit Paid Date"; Date)
        {
            Caption = 'Deposit Paid Date';
            DataClassification = CustomerContent;
        }
        field(33049039; "Application Sub-type"; Text[50])
        {
            Caption = 'Application Sub-type';
            DataClassification = CustomerContent;
        }
        //SD-SN-15-Dec-2020 - Feilds Added 

        //SD-SN-21-Dec-2020 + Feilds Added 
        field(33049040; "Status Manually Changed by"; Text[50])
        {
            Caption = 'Status Manually Changed by';
            DataClassification = CustomerContent;
        }
        field(33049041; "Status Manually Changed on"; Date)
        {
            Caption = 'Status Manually Changed on';
            DataClassification = CustomerContent;
        }
        field(33049042; "Application Type"; Text[50])
        {
            Caption = 'Application Type';
            DataClassification = CustomerContent;
        }
        field(33049043; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        //SD-SN-21-Dec-2020 - Feilds Added 
        //
        field(33049044; "Local Emergency Email Address"; Text[80])
        {
            Caption = 'Local Emergency Email Address';
            DataClassification = CustomerContent;
        }
        field(33049045; "Lead Date"; date)
        {
            Caption = 'Lead Date';
            DataClassification = CustomerContent;
        }
        field(33049046; "Lead Type Code"; code[20])
        {
            Caption = 'Lead Type Code';
            DataClassification = CustomerContent;
        }
        field(33049047; Block; Boolean)
        {
            Caption = 'Block';
            DataClassification = CustomerContent;
        }
        field(33049048; Vet; Text[10])
        {
            Caption = 'Vet';
            DataClassification = CustomerContent;
        }
        field(33049049; "Original Start Date"; date)
        {
            Caption = 'Original Start Date';
            DataClassification = CustomerContent;
        }
        field(33049050; "Original Exp. Start Date"; date)
        {
            Caption = 'Original Exp. Start Date';
            DataClassification = CustomerContent;
        }
        field(33049051; "Raw Last Name"; Text[70])
        {
            Caption = 'Raw Last Name';
            DataClassification = CustomerContent;
        }
        field(33049052; "Raw First Name"; text[70])
        {
            Caption = 'Raw First Name';
            DataClassification = CustomerContent;
        }
        field(33049053; "Phone Extension"; text[20])
        {
            Caption = 'Phone Extension';
            DataClassification = CustomerContent;
        }
        field(33049054; "Application Received Date"; Date)
        {
            Caption = 'Application Received Date';
            DataClassification = CustomerContent;
        }
        field(33049055; "Re-Entry Date"; date)
        {
            Caption = 'Re-Entry Date';
            DataClassification = CustomerContent;
        }
        field(33049056; "Mid Date"; Date)
        {
            Caption = 'Mid Date';
            DataClassification = CustomerContent;
        }
        field(33049057; LDA; date)
        {
            Caption = 'LDA';
            DataClassification = CustomerContent;
            Trigger Onvalidate()
            Var
                DegreeAuditRec: Record "Degree Audit";
            Begin
                DegreeAuditRec.Reset();
                DegreeAuditRec.SETRANGE("Student No.", Rec."No.");
                DegreeAuditRec.SETRANGE("Course Code", Rec."Course Code");
                If DegreeAuditRec.Findfirst() then begin
                    DegreeAuditRec.Validate("Last Date Of Attendance", Rec.LDA);
                    DegreeAuditRec.Modify();
                end;
            End;
        }
        field(33049058; "Status Date"; date)
        {
            Caption = 'Status Date';
            DataClassification = CustomerContent;
        }
        field(33049059; "Grade Level Description"; code[20])
        {
            Caption = 'Grade Level Description';
            DataClassification = CustomerContent;
        }
        //
        field(33049060; "Credits Attempt"; Integer)
        {
            Caption = 'Credits Attempt';
            DataClassification = CustomerContent;
        }
        field(33049061; "Program Version ID"; code[20])
        {
            Caption = 'Program Version ID';
            DataClassification = CustomerContent;
        }
        field(33049062; "Transfer In Date"; date)
        {
            Caption = 'Transfer In Date';
            DataClassification = CustomerContent;
        }
        field(33049063; SAP; Integer)
        {
            Caption = 'SAP';
            DataClassification = CustomerContent;
        }
        field(33049064; "Billing Method ID"; code[20])
        {
            Caption = 'Billing Method ID';
            DataClassification = CustomerContent;
        }
        field(33049065; "GPA Credits"; Decimal)
        {
            Caption = 'GPA Credits';
            DataClassification = CustomerContent;
        }
        field(33049066; "Date Placed"; Date)
        {
            Caption = 'Date Placed';
            DataClassification = CustomerContent;
        }
        field(33049067; "NSLDS Withdrawal Date"; Date)
        {
            Caption = 'NSLDS Withdrawal Date';
            DataClassification = CustomerContent;
        }
        field(33049068; "Suffix Code"; text[10])
        {
            Caption = 'Suffix Code';
            DataClassification = CustomerContent;
        }
        field(33049069; "Address Type"; Text[35])
        {
            Caption = 'Address Type';
            DataClassification = CustomerContent;
        }
        field(33049070; "External SIS ID"; code[50])
        {
            Caption = 'External SIS ID';
            DataClassification = CustomerContent;
        }

        field(33049090; "Fee Generated"; boolean)
        {
            Caption = 'Fee Generated';
            DataClassification = CustomerContent;
        }



    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Course Code", Semester, "Academic Year")
        {
        }
        key(Key3; "Academic Year", "Student Status")
        {
        }
        key(Key4; "Course Code")
        {
        }
        key(Key5; "Enrollment No.")
        {
        }
        key(Key6; "Academic Year", "Global Dimension 1 Code", "Course Code", State, "Country Code", District)
        {
        }
        key(Key7; Semester)
        {
        }
        key(Key8; "Student Name")
        {
        }
        key(Key9; "Fathers Name")
        {
        }
        key(Key10; "Admitted Year")
        {
        }
        key(Key11; Category)
        {
        }
        key(Key12; "Course Code", "Fee Classification Code", Gender, "Enrollment No.")
        {
        }
        key(Key13; Section, "Enrollment No.")
        {
        }
        key(Key14; "Fee Classification Code", Gender, "Latest GPA")
        {
        }
        key(Key15; "Latest GPA")
        {
        }
        key(Key16; "Course Code", Section)
        {
        }
        key(Key17; "Course Code", "Fee Classification Code", Gender)
        {
        }
        key(Key18; "Roll No.")
        {
        }
        key(Key19; "Original Student No.", "Enrollment Order")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Enrollment No.", "No.", "Student Name", "Fathers Name", "Course Code")
        {

        }
    }

    trigger OnInsert()
    var
        DocumentApproverUserRec: Record "Document Approver Users";
    begin

        //Code added for No. Series and Assign Value in Fields::CSPL-00092::06-05-2019: Start
        UserSetupRec.Get(UserId());

        // DocumentApproverUserRec.Reset();
        // DocumentApproverUserRec.Setrange("User ID", UserSetupRec."User ID");
        // DocumentApproverUserRec.SetFilter("Department Approver Type", '%1|%2', DocumentApproverUserRec."Department Approver Type"::" ", DocumentApproverUserRec."Department Approver Type"::Admissions);
        // If not DocumentApproverUserRec.Findfirst() then
        //     Error('You are not authorized to create new student.');

        EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        IF "No." = '' THEN BEGIN
            EducationSetupRec.TESTFIELD("Student No.");
            NoSeriesMgmt.InitSeries(EducationSetupRec."Student No.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        IF "Enrollment No." <> '' THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETRANGE("Enrollment No.", "Enrollment No.");
            IF StudentMasterCS.FINDFIRST() THEN
                ERROR(Text0001Lbl, "Enrollment No.");
        END;
        /*
        IF "Application No." <> '' THEN BEGIN
            StudentMasterCS.Reset();
            StudentMasterCS.SETRANGE("Application No.", "Application No.");
            IF StudentMasterCS.FINDFIRST() THEN
                ERROR(Text0002Lbl, "Application No.");
        END;
        */
        //"Student Status" := "Student Status"::Student;
        "Creation Date" := Today();
        "Created By" := Userid();
        "User ID" := FORMAT(UserId());
        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());
        "Mobile Insert" := TRUE;
        Inserted := True;

        //StudentCollegeINIT("No.");
        //Code added for No. Series and Assign Value in Fields::CSPL-00092::06-05-2019: End
    end;

    trigger OnModify()
    var

    begin
        //Code added for Assign Value in Fields::CSPL-00092::06-05-2019: Start
        IF xRec.Updated = Updated THEN
            Updated := TRUE;

        IF "Mobile Insert" = FALSE THEN
            IF xRec."Mobile Update" = "Mobile Update" THEN
                "Mobile Update" := TRUE;


        "Updated On" := TODAY();
        "Updated By" := FORMAT(UserId());

        IF Rec."Student SFP Initiation" <> 0 then begin

            If Rec."First Name" <> '' then
                Rec."Student SFP Update" := 1;


            If Rec."Last Name" <> '' then
                Rec."Student SFP Update" := 1;


            IF Rec.Addressee <> '' then
                Rec."Student SFP Update" := 1;


            If Rec.City <> '' then
                Rec."Student SFP Update" := 1;


            If Rec."Post Code" <> '' then
                Rec."Student SFP Update" := 1;


            If Rec.State <> '' then
                Rec."Student SFP Update" := 1;


            If Rec."Phone Number" <> '' then
                Rec."Student SFP Update" := 1;


            If Rec."Mobile Number" <> '' then
                Rec."Student SFP Update" := 1;


            If (Rec."Financial Aid Approved") or (not Rec."Financial Aid Approved") then
                Rec."Student SFP Update" := 1;

        end;
        IF "Student SFP Initiation" = 2 then begin
            "Type of FA Roster" := "Type of FA Roster"::SFP;
            "Student SFP Initiation Date" := Today();
        end;
        //Code added for Assign Value in Fields::CSPL-00092::06-05-2019: End
    end;

    trigger onDelete()
    begin
        If "Enrollment No." <> '' then
            CheckDeleteValidation(Rec);
    end;

    var
        //PostCode: Record "225";
        Employee: Record Employee;
        CourseMasterCS: Record "Course Master-CS";
        EducationSetupRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        StudentMasterCS: Record "Student Master-CS";
        PortalUserLoginCS: Record "Portal User Login-CS";
        PortalUserLoginCS1: Record "Portal User Login-CS";
        PortalUserLoginCS2: Record "Portal User Login-CS";
        CourseMasterCS1: Record "Course Master-CS";
        CustomerCS1: Record "Customer";
        Customer: Record "Customer";
        MainStudentSubjectCS: Record "Main Student Subject-CS";
        OptionalStudentSubjectCS: Record "Optional Student Subject-CS";
        PostCodeRec: Record "Post Code";
        StudentGroup: Record "Student Group";

        RecStudentStatusManagement: Codeunit "Student Status Mangement";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCS: Codeunit "WebServicesFunctionsCSL";
        EntryNo: Integer;
        Text0002Lbl: Label 'The Application No. is already Exist. %1';
        Text0001Lbl: Label 'The Enrollment No. is already Exist. %1';
        Text001: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        returnentryno: Integer;

    procedure FilterStudentCollegeWise()
    var
        recUserSetup: Record "User Setup";

    begin
        //Code added for Run Page::CSPL-00092::06-05-2019: Start
        //recUserSetup.Reset();
        // recUserSetup.SETRANGE(recUserSetup."Global Dimension 2 Code", "Global Dimension 1 Code");
        IF recUserSetup.GET("Global Dimension 1 Code") THEN
            PAGE.RUN(50260);

        //Code added for Run Page::CSPL-00092::06-05-2019: End
    end;

    procedure AssistEdit(OLDStudent: Record "Student Master-CS"): Boolean
    var

    begin

    end;

    local procedure StudentFullName()
    begin
        //Code added for Find Student Full Name::CSPL-00092::06-05-2019: Start
        TESTFIELD("First Name");
        CLEAR("Student Name");

        "Student Name" := "First Name";
        IF ("Last Name" <> '') AND ("Middle Name" = '') THEN
            "Student Name" := "First Name" + ' ' + "Last Name"
        ELSE
            IF ("Last Name" = '') AND ("Middle Name" <> '') THEN
                "Student Name" := "First Name" + ' ' + "Middle Name"
            ELSE
                IF ("Last Name" <> '') AND ("Middle Name" <> '') THEN
                    "Student Name" := Format("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
        VALIDATE("Student Name");
        //Code added for Find Student Full Name::CSPL-00092::06-05-2019: End
    end;

    procedure UpdateCustomer()
    var
        Stud: Record "Student Master-CS";
    begin
        //Code added for Update Customer::CSPL-00092::06-05-2019: Start
        if "Enrollment No." <> '' then begin
            //key(Key19; "Original Student No.", "Enrollment Order")
            Stud.Reset();
            Stud.SetCurrentKey("Original Student No.", "Enrollment Order");
            Stud.Ascending(true);
            Stud.SetRange("Original Student No.", Rec."Original Student No.");
            if Stud.FindLast() then
                if Stud."Enrollment Order" = Rec."Enrollment Order" then begin
                    Customer.Reset();
                    Customer.SETRANGE("No.", "Original Student No.");
                    IF Customer.FINDFIRST() THEN BEGIN
                        Customer.VALIDATE(Name, "Student Name");
                        Customer.VALIDATE("Search Name", "Student Name");
                        Customer.VALIDATE(Address, Address1);
                        Customer.VALIDATE("Address 2", Address2);
                        //Customer.VALIDATE(City, City);
                        Customer.Cities := City;
                        Customer."Postal Code" := "Post Code";
                        Customer."Phone No." := "Mobile Number";
                        Customer.VALIDATE("E-Mail", "E-Mail Address");
                        Customer.Term := Term;
                        Customer.VALIDATE("Country/Region Code", "Country Code");
                        Customer.VALIDATE("Global Dimension 1 Code", "Global Dimension 1 Code");
                        Customer.VALIDATE("Global Dimension 2 Code", "Global Dimension 2 Code");
                        Customer."Academic Year" := "Academic Year";
                        Customer.VALIDATE(Semester, Semester);
                        Customer.VALIDATE(Year, Year);
                        Customer.VALIDATE("Course Code", "Course Code");
                        Customer.VALIDATE("Application No.", "Application No.");
                        Customer.VALIDATE("Admitted Year", "Admitted Year");
                        Customer.VALIDATE("Enrollment No.", "Enrollment No.");
                        Customer.VALIDATE("Parents Income", "Parents Income");
                        Customer.VALIDATE("Fee Classification Code", "Fee Classification Code");
                        Customer.VALIDATE(Category, Category);
                        Customer.VALIDATE("Scholarship Source", "Scholarship Source");
                        Customer.validate("Grant Code 1", "Grant Code 1");
                        Customer.validate("Grant Code 2", "Grant Code 2");
                        Customer.validate("Grant Code 3", "Grant Code 3");
                        Customer.VALIDATE("Entrance Test Rank", "Entrance Test Rank");
                        Customer.VALIDATE("Lateral Student", "Lateral Student");
                        Customer.VALIDATE("Branch Transfer", "Branch Transfer");
                        Customer.VALIDATE("Pending For Registration", "Pending For Registration");
                        Customer.VALIDATE("Course Completion NOC", "Course Completion NOC");
                        Customer.VALIDATE(Section, Section);
                        Customer.VALIDATE("Roll No.", "Roll No.");
                        Customer.VALIDATE(Batch, Batch);
                        Customer."Sibling/Spouse No." := "Sibling/Spouse No.";
                        Customer."Financial Aid Approved" := "Financial Aid Approved";
                        Customer."Payment Plan Applied" := "Payment Plan Applied";
                        Customer.VALIDATE("Payment Plan Instalment", "Payment Plan Instalment");
                        Customer."Self Payment Applied" := "Self Payment Applied";
                        Customer.Modify();
                        Updated := true;
                    end;
                end;
        END;
        //Code added for Update Customer::CSPL-00092::06-05-2019: End
    end;

    procedure PortalUser()
    begin
        //Code added for Insert Portal User::CSPL-00092::06-05-2019: Start
        PortalUserLoginCS.Reset();
        IF PortalUserLoginCS.FINDLAST() THEN
            EntryNo := PortalUserLoginCS.No + 1
        ELSE
            EntryNo := 1;

        PortalUserLoginCS1.Reset();
        PortalUserLoginCS1.SETRANGE("Login ID", "Enrollment No.");
        IF NOT PortalUserLoginCS1.FINDSET() THEN
            REPEAT
                PortalUserLoginCS1.INIT();
                PortalUserLoginCS1.No := EntryNo;
                PortalUserLoginCS1.Type := PortalUserLoginCS1.Type::Student;
                PortalUserLoginCS1."Login ID" := "Enrollment No.";
                PortalUserLoginCS1.Password := "Enrollment No.";
                // PortalUsers.Password  := 'MU@16477';
                PortalUserLoginCS1."User Group" := 'STUDENT';
                PortalUserLoginCS1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                PortalUserLoginCS1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                PortalUserLoginCS1.U_ID := "No.";
                PortalUserLoginCS1.Role_Code := 'ROLE00004';
                PortalUserLoginCS1.WindowsAuthentication := FALSE;
                PortalUserLoginCS1.IsAdmin := FALSE;
                PortalUserLoginCS1.UserName := copystr("Student Name", 1, 50);
                PortalUserLoginCS1.MobileNo := "Mobile Number";
                PortalUserLoginCS1.Email := "E-Mail Address";
                PortalUserLoginCS1."Created By" := FORMAT(UserId());
                PortalUserLoginCS1."Created On" := TODAY();
                PortalUserLoginCS1.INSERT();
                EntryNo += 1;
            UNTIL PortalUserLoginCS1.NEXT() = 0;

        //Code added for Insert Portal User::CSPL-00092::06-05-2019: End
    end;

    procedure CreditStudentToCustomer()
    begin
        //Code added for Generate Student to Customer::CSPL-00092::06-05-2019: Start
        CustomerCS1.Reset();
        CustomerCS1.SETRANGE("No.", "No.");
        IF NOT CustomerCS1.FINDSET() THEN
            REPEAT
                CustomerCS1.INIT();
                CustomerCS1."No." := "No.";

                CustomerCS1.VALIDATE(Name, "Student Name");
                CustomerCS1.VALIDATE("Search Name", "Student Name");
                CustomerCS1.VALIDATE(Address, Address1);
                CustomerCS1.VALIDATE("Address 2", Address2);
                CustomerCS1.VALIDATE(City, City);
                CustomerCS1.VALIDATE("Phone No.", "Mobile Number");
                CustomerCS1.VALIDATE("E-Mail", "E-Mail Address");
                CustomerCS1.VALIDATE("Country/Region Code", "Country Code");
                CustomerCS1."Fee Classification Code" := "Fee Classification Code";
                CustomerCS1.VALIDATE("Gen. Bus. Posting Group", 'DOMESTIC');
                CustomerCS1.VALIDATE("Customer Posting Group", 'GENERAL');
                CustomerCS1.VALIDATE("VAT Bus. Posting Group", 'NO VAT');
                CustomerCS1.Category := Category;
                CustomerCS1."Global Dimension 1 Code" := "Global Dimension 1 Code";
                CustomerCS1."Global Dimension 2 Code" := "Global Dimension 2 Code";
                CustomerCS1."Academic Year" := "Academic Year";
                CustomerCS1.VALIDATE("Admitted Year", "Admitted Year");
                CustomerCS1.VALIDATE("Parents Income", "Parents Income");
                CustomerCS1.VALIDATE("Scholarship Source", "Scholarship Source");
                CustomerCS1.VALIDATE("Entrance Test Rank", "Entrance Test Rank");
                CustomerCS1.VALIDATE(Semester, Semester);
                CustomerCS1.VALIDATE(Year, Year);
                CustomerCS1.VALIDATE("Course Code", "Course Code");
                CustomerCS1.VALIDATE("Application No.", "Application No.");
                CustomerCS1."Enrollment No." := "Enrollment No.";
                CustomerCS1.INSERT(TRUE);


            UNTIL CustomerCS1.NEXT() = 0;

        //Code added for Generate Student to Customer::CSPL-00092::06-05-2019: End
    end;

    procedure StudentCollegeINIT("No.": Code[20])
    var
        StudentCOLLEGE2: Record "Student Extension New-CS";
    begin
        //Code added for Assign Value in Fields::CSPL-00092::06-05-2019: Start
        StudentCOLLEGE2.Reset();
        StudentCOLLEGE2.SETRANGE("No.", "No.");
        IF NOT StudentCOLLEGE2.FINDFIRST() THEN BEGIN
            StudentCOLLEGE2.INIT();
            StudentCOLLEGE2."No." := "No.";
            StudentCOLLEGE2."Enrollment No." := "Enrollment No.";
            StudentCOLLEGE2."Application No" := "Application No.";
            StudentCOLLEGE2.INSERT();
        END ELSE BEGIN
            StudentCOLLEGE2."Enrollment No." := "Enrollment No.";
            StudentCOLLEGE2."Application No" := "Application No.";
            StudentCOLLEGE2.Modify();
        END;
        //Code added for Assign Value in Fields::CSPL-00092::06-05-2019: End
    end;

    procedure HostelRoomBedAssigned(StudNo: Code[20]; pType: option Hostel,Room,Bed,HostelGroup,RoomCategory): Code[20]
    var
        HostelLedger: Record "Housing Ledger";
        HostelNo: Code[20];
        RoomNo: Code[20];
        BedNo: Code[10];
        HousingGroup: Code[20];
        HousingRoomCategory: Code[20];
        Assigned: Integer;
    begin
        HostelNo := '';
        RoomNo := '';
        BedNo := '';
        HousingGroup := '';
        HousingRoomCategory := '';

        HostelLedger.Reset();
        HostelLedger.SetRange("Student No.", StudNo);
        HostelLedger.CalcSums("Room Assignment");
        Assigned := HostelLedger."Room Assignment";
        if Assigned <> 0 then begin
            HostelLedger.FINDLAST();
            HostelNo := HostelLedger."Housing ID";
            RoomNo := HostelLedger."Room No.";
            BedNo := HostelLedger."Bed No.";
            HousingGroup := HostelLedger."Housing Group";
            HousingRoomCategory := HostelLedger."Room Category Code";

        end;
        if pType = pType::Hostel then
            exit(HostelNo);

        if pType = pType::Room then
            exit(RoomNo);
        if pType = pType::Bed then
            exit(BedNo);

        if pType = pType::HostelGroup then
            exit(HousingGroup);

        if pType = pType::RoomCategory then
            exit(HousingRoomCategory);

    end;

    procedure BursarHoldCheck(StudentNo: Code[20]): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldOption: Option Enable,Disable;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        // StudentWiseHoldRec.Setrange(Semester, Semester);
        // StudentWiseHoldRec.Setrange("Academic Year", "Academic Year");
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Bursar);
        if StudentWiseHoldRec.FindFirst() then begin
            HoldOption := StudentWiseHoldRec.Status;
            If HoldOption = HoldOption::Enable Then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure RegistrarHoldCheck(StudentNo: Code[20]): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldOption: Option Enable,Disable;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Registrar);
        if StudentWiseHoldRec.FindFirst() then begin
            HoldOption := StudentWiseHoldRec.Status;
            If HoldOption = HoldOption::Enable Then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure FinancialAIDHoldCheck(StudentNo: Code[20]): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldOption: Option Enable,Disable;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::"Financial Aid");
        if StudentWiseHoldRec.FindFirst() then begin
            HoldOption := StudentWiseHoldRec.Status;
            If HoldOption = HoldOption::Enable Then
                exit(true)
            else
                exit(false);
        end else
            exit(false);
    end;

    procedure HousingHoldCheck(StudentNo: Code[20]): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldOption: Option Enable,Disable;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Housing);
        if StudentWiseHoldRec.FindFirst() then begin
            HoldOption := StudentWiseHoldRec.Status;
            If HoldOption = HoldOption::Enable Then
                exit(true)
            else
                exit(false);
        end;
    end;

    procedure ImmigrationHoldCheck(StudentNo: Code[20]): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldOption: Option Enable,Disable;
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentNo);
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Immigration);
        if StudentWiseHoldRec.FindFirst() then begin
            HoldOption := StudentWiseHoldRec.Status;
            If HoldOption = HoldOption::Enable Then
                exit(true)
            else
                exit(false);
        end;
    end;

    Procedure OnGroundCheckInToComplete(StudentRec: Record "Student Master-CS")
    var
        RecHoldStatusLedger: Record "Hold Status Ledger";
        StudentHoldRec: Record "Student Hold";
        SalesForceCodeunit: Codeunit SLcMToSalesforce;
        StudentStatusMangCod: Codeunit "Student Status Mangement";
        HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
        StudentGroup: Record "Student Group";
        HousingMail_lCU: Codeunit "Hosusing Mail";
        StudentMappingReport: Report "Student Subject Mapping";
        LastNo: Integer;
        HoldPresent: Boolean;
    begin


        HousingMail_lCU.StudentMasterUpdateN('', StudentRec."No.", StudentRec);
        StudentRec.Modify();

        RecHoldStatusLedger.Reset();
        if RecHoldStatusLedger.FINDLAST() then
            LastNo := RecHoldStatusLedger."Entry No." + 1
        else
            LastNo := 1;

        RecHoldStatusLedger.Init();
        RecHoldStatusLedger."Entry No." := LastNo;
        RecHoldStatusLedger."Student No." := StudentRec."No.";
        RecHoldStatusLedger."Student Name" := StudentRec."Student Name";
        RecHoldStatusLedger."Academic Year" := StudentRec."Academic Year";
        RecHoldStatusLedger."Admitted Year" := StudentRec."Admitted Year";
        RecHoldStatusLedger.Semester := StudentRec.Semester;
        RecHoldStatusLedger."Entry Date" := Today();
        RecHoldStatusLedger."Entry Time" := Time();
        RecHoldStatusLedger."Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
        RecHoldStatusLedger."Global Dimension 2 Code" := StudentRec."Global Dimension 2 Code";
        RecHoldStatusLedger."User ID" := FORMAT(UserId());
        RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::"Registrar Sign-off";

        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
        StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::"Registrar Sign-off");
        If StudentHoldRec.FindFirst() then begin

            RecHoldStatusLedger."Hold Code" := StudentHoldRec."Hold Code";
            RecHoldStatusLedger."Hold Description" := StudentHoldRec."Hold Description";
        end;
        RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Enable;
        RecHoldStatusLedger.Insert();
        Clear(StudentMappingReport);
        StudentMappingReport.SetTableView(StudentRec);
        StudentMappingReport.Setdata(StudentRec);
        StudentMappingReport.UseRequestPage(false);
        StudentMappingReport.Run();
        HoldPresent := StudentRec.HoldChecks(StudentRec);
        if HoldPresent then
            StudentGroup.EnableStudentConditionalregistrationGroupCode(StudentRec, 'CONDREG');

        StudentRec.Validate("Registrar Signoff", true);
        StudentRec."Returning Student" := true;
        StudentRec.Modify();
        DeleteDummyStudentSubject(StudentRec."No.", StudentRec."Course Code", StudentRec.Semester, StudentRec."Academic Year", StudentRec.Term);        //Delete Dummy Student Subject
        //HoldUpdate_lCU.OnGroundCheckInCompletedGroupDisable(StudentRec."No.");
        SalesForceCodeunit.OnlineRegistrationInsert(StudentRec);

        // IF StudentRec."On Ground Check-In Complete On" <> 0D then
        //     ImmigrationApplicationSubmissionEmail(StudentRec);//CSPL-00307 11-11-21

    end;


    procedure HoldChecks(StudentRecLcl: Record "Student Master-CS"): Boolean
    var
    begin
        // if StudentRecLcl."OLR Completed" = false then
        //     Error('Online Registration is not completed for student %1', StudentRecLcl."No.");
        // if RegistrarHoldCheck(StudentRecLcl."No.") = true then
        //     error('Registrar Hold is still Enable for student %1', StudentRecLcl."No.");
        if BursarHoldCheck(StudentRecLcl."No.") = true then
            Exit(true);
        if FinancialAIDHoldCheck(StudentRecLcl."No.") = true then
            Exit(true);
        if HousingHoldCheck(StudentRecLcl."No.") = true then
            Exit(true);
        if ImmigrationHoldCheck(StudentRecLcl."No.") = true then
            Exit(true);
    end;

    // procedure RegistrarCheck(StudentRecLcl: Record "Student Master-CS")
    // var
    // begin
    //     if RegistrarHoldCheck(StudentRecLcl."No.") = true then
    //         error('Registrar Hold is still Enable for student %1', StudentRecLcl."No.");
    // end;

    procedure MandatoryfieldsCheck()
    begin
        TESTFIELD("First Name");
        TESTFIELD("Date of Birth");
        TESTFIELD(Gender);
        TESTFIELD("Academic Year");
        TESTFIELD(Semester);
        TESTFIELD("Admitted Year");
        TESTFIELD("Alternate Email Address");
        //TestField("Fee Classification Code");
        TestField(Status, '');
        // TESTFIELD("Mobile Number");
        // TESTFIELD("Fee Classification Code");
    end;

    procedure FinancialAidSignoff(StudentRec: Record "Student Master-CS")
    Var
        Student: Record "Student Master-CS";
        FinancialAIDRec: Record "Financial AID";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        Text003Lbl: Label 'Financial AID Application No. %1 is still pending for the student.';
    begin
        // FinancialAIDRec.Reset();
        // FinancialAIDRec.SetRange("Student No.", StudentRec."No.");
        // FinancialAIDRec.SetRange("Academic Year", StudentRec."Academic Year");
        // FinancialAIDRec.SetRange(Semester, StudentRec.Semester);
        // FinancialAIDRec.SetRange(Term, StudentRec.Term);
        // FinancialAIDRec.SetFilter(Type, '%1', FinancialAIDRec.Type::"Financial Aid");
        // if not FinancialAIDRec.FindFirst() then
        //     error('Financial Aid application must exist to perform this activity.');

        // FinancialAIDRec.Reset();
        // FinancialAIDRec.SetRange("Student No.", StudentRec."No.");
        // FinancialAIDRec.SetRange("Academic Year", StudentRec."Academic Year");
        // FinancialAIDRec.SetRange(Semester, StudentRec.Semester);
        // FinancialAIDRec.SetRange(Term, StudentRec.Term);
        // FinancialAIDRec.SetFilter(FinancialAIDRec.Status, '%1', FinancialAIDRec.Status::"Pending for Approval");
        // FinancialAIDRec.SetFilter(Type, '%1', FinancialAIDRec.Type::"Financial Aid");
        // if FinancialAIDRec.FindFirst() then
        //     Error(Text003Lbl, FinancialAIDRec."Application No.");

        if FinancialAIDHoldCheck(StudentRec."No.") = true then begin
            Student.Reset();
            Student.SetRange("Original Student No.", StudentRec."Original Student No.");
            if Student.FindSet() then begin
                repeat
                    StudentHoldRec.Reset();
                    StudentHoldRec.SetRange("Global Dimension 1 Code", Student."Global Dimension 1 Code");
                    StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::"Financial Aid");
                    IF StudentHoldRec.FindFirst() then begin
                        StudentWiseHoldRec.Reset();
                        StudentWiseHoldRec.SetRange("Student No.", Student."No.");
                        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::"Financial Aid");
                        if StudentWiseHoldRec.FINDFIRST() then begin
                            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                            StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                            StudentWiseHoldRec.Modify();


                            RecCodeUnit50037.HoldStatusLedgerEntryInsert(Student."No.", StudentWiseHoldRec."Hold Code",
                            StudentWiseHoldRec."Hold Description", StudentWiseHoldRec."Hold Type"::"Financial Aid", StudentWiseHoldRec.Status);
                            // RecHoldStatusLedger.Reset();
                            // RecHoldStatusLedger.SetRange("Student No.", StudentRec."No.");
                            // RecHoldStatusLedger.SetRange("Academic Year", StudentRec."Academic Year");
                            // RecHoldStatusLedger.SetRange(Semester, StudentRec.Semester);
                            // RecHoldStatusLedger.SetRange("Hold Type", RecHoldStatusLedger."Hold Type"::" ");
                            // IF RecHoldStatusLedger.FindFirst() then begin
                            //     RecHoldStatusLedger."Table Caption" := TableName();
                            //     RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::"Financial Aid";
                            //     RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
                            //     RecHoldStatusLedger.Modify();
                            // end;
                            Student."Financial Aid Approved" := true;
                            Student.Modify();
                        end;
                    end;


                until Student.Next() = 0;
            end;
        end else
            Error('There is no Financial AID Hold enabled for Student No. %1', StudentRec."No.");
    end;

    procedure ImmigrationHoldSignoff(StudentRec: Record "Student Master-CS")
    Var
        Student: Record "Student Master-CS";
        ImmigrationHeaderRec: Record "Immigration Header";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
    begin
        ImmigrationHeaderRec.Reset();
        ImmigrationHeaderRec.SetRange("Student No", StudentRec."No.");
        ImmigrationHeaderRec.SetRange("Academic Year", StudentRec."Academic Year");
        ImmigrationHeaderRec.SetRange(Semester, StudentRec.Semester);
        ImmigrationHeaderRec.SetRange(Term, StudentRec.Term);
        if ImmigrationHeaderRec.FindFirst() then
            if ImmigrationHeaderRec."Document Status" <> ImmigrationHeaderRec."Document Status"::Verified then
                error('Immigration Document must be verified to perform this activity.');

        if not (ImmigrationHoldCheck(StudentRec."No.") = true) then
            Error('There is no Immigration Hold enabled for Student No. %1', StudentRec."No.");

        Student.Reset();
        Student.SetRange("Original Student No.", StudentRec."Original Student No.");
        if Student.FindSet() then
            repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Global Dimension 1 Code", Student."Global Dimension 1 Code");
                StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Immigration);
                IF StudentHoldRec.FindFirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", Student."No.");
                    StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Immigration);
                    if StudentWiseHoldRec.FINDFIRST() then begin
                        StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                        StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                        StudentWiseHoldRec.Modify();

                        RecCodeUnit50037.HoldStatusLedgerEntryInsert(Student."No.", StudentWiseHoldRec."Hold Code",
                        StudentWiseHoldRec."Hold Description", StudentWiseHoldRec."Hold Type"::Immigration, StudentWiseHoldRec.Status);
                    end;
                    Student."Financial Aid Approved" := true;
                    Student.Modify();

                end;
            until Student.Next() = 0;

    end;

    procedure CheckFeeGeneration(StudentNo: Code[20]): Boolean
    var
        // GLEntry: Record "G/L Entry";
        // CustRec: Record Customer;
        // StudentRec: Record "Student Master-CS";
        // FeeCourseHead: Record "Fee Course Head-CS";
        // FeeCourseLine: Record "Fee Course Line-CS";
        // CourseRec: Record "Course Master-CS";
        // FeeComponentMasterCS: Record "Fee Component Master-CS";
        // HousingApplication: Record "Housing Application";
        // StudentRegistration: Record "Student Registration-CS";
        // Count1: Integer;
        // Count2: Integer;
        StudentFeeGenerationRep: Report "Fee Generation New";

    begin
        Exit(StudentFeeGenerationRep.CheckFeeGenerated(StudentNo, '', '', '', false));
        // Count1 := 0;
        // Count2 := 0;
        // CustRec.Get(StudentNo);
        // StudentRec.Get(StudentNo);
        // FeeCourseHead.Reset();
        // FeeCourseHead.SETRANGE(FeeCourseHead."Course Code", CustRec."Course Code");
        // FeeCourseHead.SETRANGE(FeeCourseHead."Academic Year", CustRec."Academic Year");
        // FeeCourseHead.SETRANGE(FeeCourseHead."Global Dimension 1 Code", CustRec."Global Dimension 1 Code");
        // FeeCourseHead.SETRANGE(FeeCourseHead."Other Fees", false);
        // CourseRec.Get(CustRec."Course Code");
        // If CourseRec."Admitted Year Wise Fee" then
        //     FeeCourseHead.SETRANGE(FeeCourseHead."Admitted Year", CustRec."Admitted Year");
        // If CourseRec."Semester Wise Fee" then
        //     FeeCourseHead.SETRANGE(FeeCourseHead.Semester, CustRec.Semester);
        // FeeCourseHead.SETRANGE(Year, CustRec.Year);
        // IF FeeCourseHead.findfirst() THEN BEGIN
        //     FeeCourseLine.Reset();
        //     FeeCourseLine.SETRANGE("Document No.", FeeCourseHead."No.");
        //     IF FeeCourseLine.findfirst() THEN
        //         REPEAT
        //             FeeComponentMasterCS.GET(FeeCourseLine."Fee Code");
        //             IF NOT (FeeComponentMasterCS."Type Of Fee" In [FeeComponentMasterCS."Type Of Fee"::"INSTALMENT FEE"]) then begin
        //                 If FeeComponentMasterCS."Fee Category" = FeeComponentMasterCS."Fee Category"::Optional then begin
        //                     IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::RENT then begin
        //                         HousingApplication.Reset();
        //                         HousingApplication.SetRange("Student No.", CustRec."No.");
        //                         HousingApplication.SetRange("Academic Year", CustRec."Academic Year");
        //                         HousingApplication.SetRange(Semester, CustRec.Semester);
        //                         HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
        //                         HousingApplication.SetRange("Global Dimension 2 Code", FeeComponentMasterCS."Global Dimension 2 Code");
        //                         If HousingApplication.FindLast() then
        //                             Count2 := Count2 + 1;
        //                     end;

        //                     IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::DAMAGEDEP then begin
        //                         HousingApplication.Reset();
        //                         HousingApplication.SetRange("Student No.", CustRec."No.");
        //                         HousingApplication.SetRange("Academic Year", CustRec."Academic Year");
        //                         HousingApplication.SetRange(Semester, CustRec.Semester);
        //                         HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
        //                         HousingApplication.SetRange("Global Dimension 2 Code", FeeComponentMasterCS."Global Dimension 2 Code");
        //                         If HousingApplication.FindLast() then
        //                             Count2 := Count2 + 1;
        //                     end;

        //                     IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::"BUS-SEMESTER" then begin
        //                         If StudentRec."Transport Allot" then
        //                             Count2 := Count2 + 1;
        //                     end;
        //                     IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::GHTSURCHRG then begin
        //                         If StudentRec."Student Type" = StudentRec."Student Type"::"GHT Student" then
        //                             Count2 := Count2 + 1;
        //                     end;

        //                     IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::HEALTHINS then begin
        //                         StudentRegistration.Reset();
        //                         StudentRegistration.SetRange("Student No", CustRec."No.");
        //                         StudentRegistration.SetRange("Academic Year", CustRec."Academic Year");
        //                         StudentRegistration.SetRange(Semester, CustRec.Semester);
        //                         StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
        //                         StudentRegistration.SetRange("Apply for Insurance", true);
        //                         IF StudentRegistration.FindFirst() Then
        //                             Count2 := Count2 + 1;
        //                     end;

        //                     IF FeeComponentMasterCS."Type Of Fee" = FeeComponentMasterCS."Type Of Fee"::REPATINS then begin
        //                         StudentRegistration.Reset();
        //                         StudentRegistration.SetRange("Student No", CustRec."No.");
        //                         StudentRegistration.SetRange("Academic Year", CustRec."Academic Year");
        //                         StudentRegistration.SetRange(Semester, CustRec.Semester);
        //                         StudentRegistration.SetRange("Document Type", StudentRegistration."Document Type"::Registration);
        //                         StudentRegistration.SetRange("Apply for Insurance", false);
        //                         IF StudentRegistration.FindFirst() Then
        //                             Count2 := Count2 + 1;
        //                     end;
        //                 end Else
        //                     Count2 := Count2 + 1;

        //                 GLEntry.Reset();
        //                 GLEntry.SETRANGE("Enrollment No.", CustRec."Enrollment No.");
        //                 GLEntry.SETRANGE("Academic Year", CustRec."Academic Year");
        //                 GLEntry.SETRANGE(Year, CustRec.Year);
        //                 GLEntry.SETRANGE(Semester, CustRec.Semester);
        //                 GLEntry.SETRANGE(Reversed, false);
        //                 GLEntry.SETRANGE("Fee Code", FeeCourseLine."Fee Code");
        //                 GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Invoice);
        //                 IF GLEntry.findfirst() THEN
        //                     Count1 := Count1 + 1;
        //             end;
        //         until FeeCourseLine.Next() = 0;
        // end;

        // If Count1 = Count2 then
        //     exit(true)
        // else
        //     exit(false);

    End;

    /// <summary> 
    /// Description for GenerateBarCode.
    /// </summary>
    // procedure GenerateBarCode()
    // var

    //     Method: Text;
    //     OutStr: OutStream;
    //     Window: Dialog;
    //     // HttpResponseMessage: DotNet HttpResponseMessage1;
    //     // null: DotNet null1;
    //     // ImageStream: DotNet ImageStream1;
    //     Value1: Text[2048];
    // Begin
    //     Value1 := "Student Name" + ', ' + "Course Code" + ', ' + "Admitted Year";

    //     Window.OPEN('Generating Bar Code');
    //     Method := 'barcode/qr/qr.png?value=' + Value1 + '';
    //     QRCodeManagement.CallRESTWebService('http://barcodes4.me/',
    //                                         Method,
    //                                         'GET',
    //                                         null,
    //                                         HttpResponseMessage);

    //     ImageStream := HttpResponseMessage.Content.ReadAsStreamAsync().Result();

    //     CLEAR("Student QRCode");
    //     Modify();
    //     "Student QRCode".CREATEOUTSTREAM(OutStr);
    //     ImageStream.WriteTo(OutStr);
    //     Window.CLOSE();
    // End;

    Procedure CheckAcademicAdmittedYear(AcademicYear: Code[20]; AdmittedYear: Code[20])
    var
        AcademicYearMaster: Record "Academic Year Master-CS";
        AYYearInInt: Integer;
        ADYYearInInt: Integer;
    begin

        if (AcademicYear <> '') and (AdmittedYear <> '') then begin
            AcademicYearMaster.Get(AcademicYear);
            AYYearInInt := AcademicYearMaster.Sequence;
            AcademicYearMaster.Get(AdmittedYear);
            ADYYearInInt := AcademicYearMaster.Sequence;

            if ADYYearInInt > AYYearInInt then
                Error('"Admitted Year" cannot be greater than "Academic Year"');
        end;

    end;

    //SD-SN-11-JAN-21 +
    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        IF MapPoint.FINDFIRST THEN
            MapMgt.MakeSelection(DATABASE::Customer, GETPOSITION)
        ELSE
            MESSAGE(Text001);
    end;
    //SD-SN-11-JAN-21 -
    procedure CheckDeleteValidation(_Rec: Record "Student Master-CS")
    var
        StudentStatus_lRec: Record "Student Status";
        HousingApplication_lRec: Record "Housing Application";
        FinancialAid_lRec: Record "Financial AID";
        OptOut_lRec: Record "Opt Out";
        StudentRegistration_lRec: Record "Student Registration-CS";
        CustomerLedgerEntry_lRec: Record "Cust. Ledger Entry";
        FerpaDetails_lRec: Record "FERPA Details";
        FerpaInfoHdr_lRec: Record "FERPA Information Header";
        FerpaModuleAllowed_lRec: Record "FERPA Module Allowed";

    Begin

        If Status <> '' then
            IF StudentStatus_lRec.Get(_Rec.Status, _Rec."Global Dimension 1 Code") then
                IF Not (StudentStatus_lRec.Status IN [StudentStatus_lRec.Status::Deposited, StudentStatus_lRec.Status::Declined, StudentStatus_lRec.Status::Deferred]) then
                    ERROR('Student status of %1 is %2', _Rec."First Name" + ' ' + _Rec."Last Name", StudentStatus_lRec.Description);



        HousingApplication_lRec.Reset();
        HousingApplication_lRec.SetRange("Student No.", _Rec."No.");
        If HousingApplication_lRec.FindFirst() then
            Error('Housing Application is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        FinancialAid_lRec.Reset();
        FinancialAid_lRec.SetRange("Student No.", _Rec."No.");
        If FinancialAid_lRec.FindFirst() then
            Error('Financial Aid is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        OptOut_lRec.Reset();
        OptOut_lRec.SetRange("Student No.", _Rec."No.");
        IF OptOut_lRec.FindFirst() then
            Error('Housing Waiver is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        StudentRegistration_lRec.Reset();
        StudentRegistration_lRec.SetRange("Enrollment No", _Rec."Enrollment No.");
        StudentRegistration_lRec.SetRange("Course Code", _Rec."Course Code");
        StudentRegistration_lRec.SetRange("Academic Year", _Rec."Academic Year");
        StudentRegistration_lRec.SetRange(Semester, _Rec.Semester);
        StudentRegistration_lRec.SetRange(Term, _Rec.Term);
        IF StudentRegistration_lRec.FindFirst() then
            Error('Student Registration is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        CustomerLedgerEntry_lRec.Reset();
        CustomerLedgerEntry_lRec.SetRange("Enrollment No.", _Rec."Enrollment No.");
        IF CustomerLedgerEntry_lRec.FindFirst() then
            Error('Customer Ledger Entry is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        FerpaDetails_lRec.Reset();
        FerpaDetails_lRec.SetRange("Student No.", _Rec."No.");
        IF FerpaDetails_lRec.FindFirst() then
            Error('Ferpa Details is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        FerpaInfoHdr_lRec.Reset();
        FerpaInfoHdr_lRec.SetRange("Student No", _Rec."No.");
        IF FerpaInfoHdr_lRec.FindFirst() then
            Error('Ferpa Information Header is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");

        FerpaModuleAllowed_lRec.Reset();
        FerpaModuleAllowed_lRec.SetRange("Student No.", _Rec."No.");
        IF FerpaModuleAllowed_lRec.FindFirst() then
            Error('Ferpa Module Allowed is exist for Student : %1', _Rec."First Name" + ' ' + _Rec."Last Name");



    End;

    // procedure EmailTemplate(StudentMasterRec: Record "Student Master-CS")
    // var
    //     UserSetup: Record "User Setup";
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     usersetupapprover: Record "Document Approver Users";
    //     Count1: Integer;
    //     CCRecipient: Text[100];
    //     CCRecipients: List of [Text];
    //     emailaddress: text;


    // Begin
    //     SMTPMailSetup.Get();
    //     emailaddress := '';
    //     usersetupapprover.Reset();
    //     usersetupapprover.SetFilter("Department Approver Type", '%1|%2', usersetupapprover."Department Approver Type"::Admissions,
    //                                 usersetupapprover."Department Approver Type"::"Financial Aid Department");
    //     if usersetupapprover.FindSet() then begin
    //         repeat
    //             UserSetup.get(usersetupapprover."User ID");
    //             if UserSetup."E-Mail" <> '' then
    //                 emailaddress := UserSetup."E-Mail"
    //         until usersetupapprover.Next() = 0;

    //     end;
    //     // UserSetup.Reset();
    //     // UserSetup.SetFilter("Department Approver", '%1|%2', UserSetup."Department Approver"::Admissions, UserSetup."Department Approver"::"Financial Aid Department");
    //     // UserSetup.SetFilter("E-Mail", '<>%1', '');
    //     // if UserSetup.FindFirst() then
    //     if emailaddress <> '' then
    //         SMTPMail.Create('MEA', SmtpMailSetup."Email Address", emailaddress, StudentMasterRec."No." + ' New Student Created', '', TRUE);

    //     Count1 := 0;
    //     usersetupapprover.Reset();
    //     usersetupapprover.SetFilter("Department Approver Type", '%1|%2', usersetupapprover."Department Approver Type"::Admissions,
    //                                 usersetupapprover."Department Approver Type"::"Financial Aid Department");
    //     if usersetupapprover.FindSet() then begin
    //         repeat
    //             UserSetup.Reset();
    //             UserSetup.SetRange("User ID", usersetupapprover."User ID");
    //             UserSetup.SetFilter("E-Mail", '<>%1|%2', '', emailaddress);
    //             if UserSetup.FindSet() then
    //                 repeat
    //                     Count1 += 1;
    //                     if Count1 > 1 then begin
    //                         CCRecipient := UserSetup."E-Mail";
    //                         CCRecipients := CCRecipient.Split(';');
    //                         SMTPMail.AddBCC(CCRecipients);
    //                     end;
    //                 until UserSetup.Next() = 0;
    //         until usersetupapprover.Next() = 0;

    //     end;
    //     SMTPMail.AppendtoBody('Dear Admissions Team,');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('This is to inform you that a new student has been created in SLcM. Please refer to the below details:');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('Student ID: ' + StudentMasterRec."No.");
    //     SMTPMail.AppendtoBody('<Br>');
    //     SMTPMail.AppendtoBody('Student Name: ' + StudentMasterRec."First Name" + ' ' + StudentMasterRec."Middle Name" + ' ' + StudentMasterRec."Last Name");
    //     SMTPMail.AppendtoBody('<Br>');
    //     SMTPMail.AppendtoBody('Enrolment No.: ' + StudentMasterRec."Enrollment No.");
    //     SMTPMail.AppendtoBody('<Br>');
    //     SMTPMail.AppendtoBody('Course: ' + StudentMasterRec."Course Code");
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Log into the SLcM System for more details.');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Thank you,');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('SLcM System Administrator');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //Mail_lCU.Send();
    // End;

    // procedure MSPEApplicationSubmissionAlert(StudentMasterRec: Record "Student Master-CS")
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;

    // Begin
    //     IF StudentMasterRec."E-Mail Address" <> '' then begin
    //         SMTPMailSetup.Get();
    //         SMTPMail.Create('MEA', SmtpMailSetup."Email Address", StudentMasterRec."E-Mail Address", 'MSPE Application Submission Alert', '', TRUE);
    //         SMTPMail.AppendtoBody('Dear ' + StudentMasterRec."Student Name");
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('This is to inform you that we are accepting applications for MSPE (Medical Student Performance Evaluation) request forms.');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('Please login to your SLcM student portal to apply as a first time or repeat applicant, whichever is applicable.');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('Your applications will be further updated by Graduate Affairs Team and sent back for review.');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('You may also track status updates under “MSPE Application Status” page on SLcM student portal.');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('For any clarifications, please contact Graduate Affairs team at jferron@auamed.org or call on 212-661-8899 x 161');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         if (StudentMasterRec.Semester = 'CLN7') or (StudentMasterRec.Semester = 'CLN9') then begin
    //             SMTPMail.AppendtoBody('<br><Br>');
    //             SMTPMail.AppendtoBody('*(Please ignore if you have already applied)');
    //             SMTPMail.AppendtoBody('<br><Br>');
    //         end;
    //         SMTPMail.AppendtoBody('Regards,');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('Graduate Affairs Team');
    //         SMTPMail.AppendtoBody('<br><Br>');
    //         SMTPMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //         SmtpMail.AppendtoBody('<br>');
    //         //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //         //Mail_lCU.Send();
    //     end;
    // End;

    // procedure DegreeAuditEmailTemplate(var Stud: Record "Student Master-CS")
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CourseDegreeRec: Record "Course Degree";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     DegreeName: text[2048];
    // begin
    //     Stud.TESTFIELD("E-Mail Address");

    //     CourseDegreeRec.Reset();
    //     CourseDegreeRec.SetRange("Course Code", Stud."Course Code");
    //     if CourseDegreeRec.FindSet() then begin
    //         Repeat
    //             IF DegreeName = '' then
    //                 DegreeName := CourseDegreeRec."Degree Name"
    //             ELSE
    //                 DegreeName += ',' + CourseDegreeRec."Degree Name";
    //         Until CourseDegreeRec.Next() = 0;
    //     end else
    //         Error('There is no course degree mapped with the Student.');

    //     SmtpMailRec.Get();

    //     // UserSetupRec.Reset();
    //     // UserSetupRec.SetRange("Department Approver", UserSetupRec."Department Approver"::Graduation);
    //     // If UserSetupRec.FindFirst() Then
    //     //     UserSetupRec.TestField(UserSetupRec."Department Approver");

    //     Recipient := Stud."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ('Submit your Degree Audit Application! ');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Stud."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are pleased to inform you that you may be eligible for graduation.  In order for us to confirm that you have satisfied all requirements for graduation, we will need to complete your Degree Audit.  Once completed, and all graduation requirements have been confirmed, you will receive your'
    //                          + ' ' + Format(DegreeName + ' ' + 'Degree.'));

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('To initiate the audit, please submit "Graduate Contact Information Form" located on your SLcM student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For any further information, please contact registrar@auamed.org');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Office of the Registrar');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE � PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Degree Audit', 'MEA', SenderAddress, Format(Stud."Student Name"),
    //     Stud."No.", Subject, BodyText, 'Degree Audit', 'Degree Audit', '', '',
    //     Recipient, 1, Stud."Mobile Number", '', 1);
    // end;

    procedure BursarSignoff(StudentNo: Code[20])
    Var
        // HoldUserMappingRec: Record "Holds User Mapping";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        StudentRec: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        FinancialAIDRec: Record "Financial AID";
        RSL: Record "Roster Scheduling Line";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        Text003Lbl: Label 'Financial AID Application No. %1 is still pending for the student.';

    begin
        // HoldUserMappingRec.Reset();
        // HoldUserMappingRec.SetRange("User ID", UserId());
        // if HoldUserMappingRec.FindFirst() then begin

        StudentRec.Get(StudentNo);
        // if HousingHoldCheck(StudentRec."No.") = true then
        //     error('Housing Hold is Enable for Student No. %1', StudentRec."No.");
        // if CheckFeeGeneration(StudentRec."No.") = False then (Block for Michael Bucher dated 14April2021)
        //     error('Fee is not Generated or all components of fee is not Generated for Student No. %1', StudentRec."No.");

        if FinancialAIDHoldCheck(StudentNo) = true then begin
            FinancialAIDRec.Reset();
            FinancialAIDRec.SetRange("Student No.", StudentNo);
            FinancialAIDRec.SetRange("Academic Year", StudentRec."Academic Year");
            FinancialAIDRec.SetRange(Semester, StudentRec.Semester);
            FinancialAIDRec.SetRange(Term, StudentRec.Term);
            FinancialAIDRec.SetFilter(FinancialAIDRec.Status, '%1', FinancialAIDRec.Status::"Pending for Approval");
            if FinancialAIDRec.FindFirst() then
                Error(Text003Lbl, FinancialAIDRec."Application No.")
            else
                FinancialAidWithBursarSignoff(StudentNo);
        end;


        StudentMaster_lRec.Reset();
        StudentMaster_lRec.Setrange("Original Student No.", StudentRec."Original Student No.");
        IF StudentMaster_lRec.FindSet() then begin
            Repeat
                StudentHoldRec.Reset();
                StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Bursar);
                IF StudentHoldRec.FindFirst() then begin
                    StudentWiseHoldRec.Reset();
                    StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::Bursar);
                    if StudentWiseHoldRec.FINDFIRST() then begin
                        StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                        StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                        StudentWiseHoldRec.Modify();
                        RecCodeUnit50037.HoldStatusLedgerEntryInsert(StudentMaster_lRec."No.", StudentWiseHoldRec."Hold Code",
                        StudentWiseHoldRec."Hold Description", StudentWiseHoldRec."Hold Type"::Bursar, StudentWiseHoldRec.Status);
                        // RSL.RemoveBursarHoldfromRotation(StudentMaster_lRec);//CSPL-00307-RTP // As per Ajay 16-03-23
                        RSL.AutoPublishedRotation_On_CLN_Hold_Removed(StudentMaster_lRec);//CSPL-00307-RTP // As per Ajay 16-03-23
                    end;
                end;
            until StudentMaster_lRec.Next() = 0;
        end;
        // end else
        //     Error('You do not have the permission to disable Bursar signoff');
    end;

    procedure FinancialAidWithBursarSignoff(StudentNo: Code[20])
    Var
        StudentRec: Record "Student Master-CS";
        StudentMaster_lRec: Record "Student Master-CS";
        FinancialAIDRec: Record "Financial AID";
        StudentWiseHoldRec: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
    begin
        if FinancialAIDHoldCheck(StudentNo) = true then begin
            StudentRec.Get(StudentNo);

            StudentMaster_lRec.Reset();
            StudentMaster_lRec.SetRange("Original Student No.", StudentRec."Original Student No.");
            IF StudentMaster_lRec.FindSet() then begin
                repeat
                    StudentHoldRec.Reset();
                    StudentHoldRec.SetRange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                    StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::"Financial Aid");
                    If StudentHoldRec.FindFirst() then begin
                        StudentWiseHoldRec.Reset();
                        StudentWiseHoldRec.SetRange("Student No.", StudentMaster_lRec."No.");
                        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::"Financial Aid");
                        if StudentWiseHoldRec.FINDFIRST() then begin
                            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                            StudentWiseHoldRec."Hold Description" := StudentHoldRec."Signoff Description";
                            StudentWiseHoldRec.Modify();

                            RecCodeUnit50037.HoldStatusLedgerEntryInsert(StudentMaster_lRec."No.", StudentWiseHoldRec."Hold Code",
                            StudentWiseHoldRec."Hold Description", StudentWiseHoldRec."Hold Type"::"Financial Aid", StudentWiseHoldRec.Status);

                            StudentMaster_lRec."Financial Aid Approved" := true;
                            StudentMaster_lRec.Modify();
                        end;
                    end;
                until StudentMaster_lRec.Next() = 0;
            end;
        end else
            Error('There is no Financial AID Hold enabled for Student No. %1', StudentRec."No.");

    end;

    procedure ExtraCharCalc(InputInt: Integer): Code[1]
    begin
        if InputInt = 2 then
            exit('A')
        else
            if InputInt = 3 then
                exit('B')
            else
                if InputInt = 4 then
                    exit('C')
                else
                    if InputInt = 5 then
                        exit('D')
                    else
                        if InputInt = 6 then
                            exit('E')
                        else
                            if InputInt = 7 then
                                exit('F')
                            else
                                if InputInt = 8 then
                                    exit('G')
                                else
                                    if InputInt = 9 then
                                        exit('H')
                                    else
                                        if InputInt = 10 then
                                            exit('I')
                                        else
                                            if InputInt = 11 then
                                                exit('J')
                                            else
                                                if InputInt = 12 then
                                                    exit('K')
                                                else
                                                    if InputInt = 13 then
                                                        exit('L')
                                                    else
                                                        if InputInt = 14 then
                                                            exit('M')
                                                        else
                                                            if InputInt = 15 then
                                                                exit('N')
                                                            else
                                                                if InputInt = 16 then
                                                                    exit('O')
                                                                else
                                                                    if InputInt = 17 then
                                                                        exit('P')
                                                                    else
                                                                        if InputInt = 18 then
                                                                            exit('Q')
                                                                        else
                                                                            if InputInt = 19 then
                                                                                exit('R')
                                                                            else
                                                                                if InputInt = 20 then
                                                                                    exit('S')
                                                                                else
                                                                                    if InputInt = 21 then
                                                                                        exit('T')
                                                                                    else
                                                                                        if InputInt = 22 then
                                                                                            exit('U')
                                                                                        else
                                                                                            if InputInt = 23 then
                                                                                                exit('V')
                                                                                            else
                                                                                                if InputInt = 24 then
                                                                                                    exit('W')
                                                                                                else
                                                                                                    if InputInt = 25 then
                                                                                                        exit('X')
                                                                                                    else
                                                                                                        if InputInt = 26 then
                                                                                                            exit('Y')
                                                                                                        else
                                                                                                            if InputInt = 27 then
                                                                                                                exit('Z');
    end;

    procedure GenerateBarCodeNew(_Rec: Record "Student Master-CS")
    var
        TempBlob_lRec: Record "TempBlob Test";
        TempBlob: Codeunit "Temp Blob";
        Base64convert: Codeunit "Base64 Convert";
        Window: Dialog;
        Client: HttpClient;
        HttpResponse: HttpResponseMessage;
        Value1: Text[2048];
        InStr: InStream;
        String: Text;
    Begin
        Value1 := _Rec."Enrollment No." + ', ' + _Rec."Student Name" + ', ' + _Rec."Academic Year" + ', ' + _Rec."Course Code" + ', ' + Format(_Rec.Term);
        Window.OPEN('Generating QR Code');
        Client.Get('https://qrcode.tec-it.com/API/QRCode?data=' + Value1, HttpResponse);
        TempBlob.CreateInStream(InStr);
        HttpResponse.Content().ReadAs(InStr);
        String := Base64Convert.ToBase64(InStr);
        Base64convert.FromBase64(String);
        _Rec."Student QRCode" := TempBlob_lRec.Blob;
        _Rec.Modify();
    End;

    procedure StatusOnvalidate(Var StudentMasterRec: Record "Student Master-CS")
    var
        StudentStatusRec: Record "Student Status";
    begin
        // StudentStatusRec.Reset();
        // IF StudentStatusRec.Get(StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code") then begin
        //     if (StudentStatusRec.Status in [StudentStatusRec.Status::"Pending Graduation"]) AND (StudentMasterRec."Global Dimension 1 Code" = '9000') then
        //         DegreeAuditEmailTemplate(StudentMasterRec);
        // end else
        //     Error('The Status does not exist. Identification fields and Values: Code = %1, Institute Code = %2, for Student No. = %3',
        //     StudentMasterRec.Status, StudentMasterRec."Global Dimension 1 Code", StudentMasterRec."No.");

    end;

    procedure UpdateExamBestValues()
    Var
        SSE: Record "Student Subject Exam";
    begin
        CompShelfBest := 0;
        CompShelfDate := 0D;
        CompShelfPassed := false;
        "CCSE Score" := 0;
        "CCSE Date" := 0D;
        ClnUsmleStep1Best := 0;
        ClnUsmleStep1Date := 0D;
        ClnUsmleStep1Passed := false;
        ClnUsmleCKBest := 0;
        ClnUsmleCKDate := 0D;
        ClnUsmleCKPassed := false;
        ClnUsmleCSBest := 0;
        ClnUsmleCSDate := 0D;
        ClnUsmleCSPassed := false;
        "CCSSE SUR Score" := 0;
        "CCSSE OB Score" := 0;
        "CCSSE IM Score" := 0;
        "CCSSE PEDS Score" := 0;
        "CCSSE FM Score" := 0;
        "CCSSE PSY Score" := 0;
        If "Original Student No." <> '' then begin
            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CBSE);
            //SSE.SetRange(Total, CompShelfBest);
            if SSE.FindLast() then begin
                CompShelfBest := SSE.Total;
                CompShelfDate := SSE."Sitting Date";
                if SSE.Result = SSE.Result::Pass then
                    CompShelfPassed := true
                else
                    CompShelfPassed := false;
            end;

            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSE);
            //SSE.SetRange(Total, CompShelfBest);
            if SSE.FindLast() then begin
                "CCSE Score" := SSE.Total;
                "CCSE Date" := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     CompShelfPassed := true
                // else
                //     CompShelfPassed := false;
            end;

            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::"STEP 1");
            //SSE.SetRange(Total, ClnUsmleStep1Best);
            if SSE.FindLast() then begin
                ClnUsmleStep1Best := SSE.Total;
                ClnUsmleStep1Date := SSE."Sitting Date";
                if SSE.Result = SSE.Result::Pass then
                    ClnUsmleStep1Passed := true
                else
                    ClnUsmleStep1Passed := false;
            end;

            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::"STEP 2 CK");
            // SSE.SetRange(Total, ClnUsmleCKBest);
            if SSE.FindLast() then begin
                ClnUsmleCKBest := SSE.Total;
                ClnUsmleCKDate := SSE."Sitting Date";
                if SSE.Result = SSE.Result::Pass then
                    ClnUsmleCKPassed := true
                else
                    ClnUsmleCKPassed := false;
            end;

            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::"STEP 2 CS");
            //SSE.SetRange(Total, ClnUsmleCSBest);
            if SSE.FindLast() then begin
                ClnUsmleCSBest := SSE.Total;
                ClnUsmleCSDate := SSE."Sitting Date";
                if SSE.Result = SSE.Result::Pass then
                    ClnUsmleCSPassed := true
                else
                    ClnUsmleCSPassed := false;
            end;

            EducationSetupRec.Reset();
            EducationSetupRec.SetRange("Global Dimension 1 Code", '9000');
            if EducationSetupRec.FindFirst() then;

            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSSE);
            SSE.SetRange("Core Clerkship Subject Code", EducationSetupRec."Surgery Subject Group");
            if SSE.FindLast() then begin
                "CCSSE SUR Score" := SSE."Shelf Exam Value";
                // ClnUsmleCSDate := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     ClnUsmleCSPassed := true
                // else
                //     ClnUsmleCSPassed := false;
            end;
            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSSE);
            SSE.SetRange("Core Clerkship Subject Code", EducationSetupRec."OBG Subject Group");
            if SSE.FindLast() then begin
                "CCSSE OB Score" := SSE."Shelf Exam Value";
                // ClnUsmleCSDate := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     ClnUsmleCSPassed := true
                // else
                //     ClnUsmleCSPassed := false;
            end;
            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSSE);
            SSE.SetRange("Core Clerkship Subject Code", EducationSetupRec."IM Subject Group");
            if SSE.FindLast() then begin
                "CCSSE IM Score" := SSE."Shelf Exam Value";
                // ClnUsmleCSDate := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     ClnUsmleCSPassed := true
                // else
                //     ClnUsmleCSPassed := false;
            end;
            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSSE);
            SSE.SetRange("Core Clerkship Subject Code", EducationSetupRec."Pediatrics Subject Group");
            if SSE.FindLast() then begin
                "CCSSE PEDS Score" := SSE."Shelf Exam Value";
                // ClnUsmleCSDate := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     ClnUsmleCSPassed := true
                // else
                //     ClnUsmleCSPassed := false;
            end;
            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSSE);
            SSE.SetRange("Core Clerkship Subject Code", EducationSetupRec."Family Medicine Subject Group");
            if SSE.FindLast() then begin
                "CCSSE FM Score" := SSE."Shelf Exam Value";
                // ClnUsmleCSDate := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     ClnUsmleCSPassed := true
                // else
                //     ClnUsmleCSPassed := false;
            end;
            SSE.Reset();
            SSE.SetCurrentKey("Sitting Date");
            SSE.SetRange("Original Student No.", "Original Student No.");
            SSE.SetRange("Enrollment No", Rec."Enrollment No.");
            SSE.SetRange("Global Dimension 1 Code", '9000');
            SSE.SetRange("Score Type", SSE."Score Type"::CCSSE);
            SSE.SetRange("Core Clerkship Subject Code", EducationSetupRec."Psychiatric Subject Group");
            if SSE.FindLast() then begin
                "CCSSE PSY Score" := SSE."Shelf Exam Value";
                // ClnUsmleCSDate := SSE."Sitting Date";
                // if SSE.Result = SSE.Result::Pass then
                //     ClnUsmleCSPassed := true
                // else
                //     ClnUsmleCSPassed := false;
            end;
        end;

        //Modify();
    end;


    //CS:NS-------------Start
    Procedure CalculateGPA(StudentNo: Code[20])
    var
        StudentMaster_lRec: Record "Student Master-CS";
        StudentSubject_lRec: Record "Main Student Subject-CS";
        GradeMaster_lRec: Record "Grade Master-CS";
        FinalGPA: Decimal;
        TotalQpts: Decimal;
        TotalCreditAttempt: Decimal;
    begin
        TotalQpts := 0;
        TotalCreditAttempt := 0;
        FinalGPA := 0;
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("No.", StudentNo);
        IF StudentMaster_lRec.FindFirst() then begin
            StudentSubject_lRec.Reset();
            StudentSubject_lRec.Setrange("Student No.", StudentMaster_lRec."No.");
            StudentSubject_lRec.Setrange(Course, StudentMaster_lRec."Course Code");
            StudentSubject_lRec.SetRange(TC, False);
            StudentSubject_lRec.Setfilter(Grade, '<>%1', '');
            IF StudentSubject_lRec.FindSet() then begin
                repeat
                    GradeMaster_lRec.Reset();
                    GradeMaster_lRec.SetRange(Code, StudentSubject_lRec.Grade);
                    GradeMaster_lRec.SetRange("Global Dimension 1 Code", StudentSubject_lRec."Global Dimension 1 Code");
                    IF GradeMaster_lRec.FindFirst() then begin
                        TotalQpts += GradeMaster_lRec."Grade Points" * StudentSubject_lRec."Credits Attempt";
                        If GradeMaster_lRec."Consider for GPA" then
                            TotalCreditAttempt += StudentSubject_lRec."Credits Attempt";
                    end;
                until StudentSubject_lRec.Next() = 0;
            end;
            If TotalCreditAttempt <> 0 then
                FinalGPA := Round(TotalQpts / TotalCreditAttempt);

            StudentMaster_lRec."Graduate GPA" := FinalGPA;
            StudentMaster_lRec.Modify();

            //Update Student Honors-----------------Start

            StudentHonorsInsert(StudentMaster_lRec."No.", FinalGPA);

            //Update Student Honors-----------------End
        end

    end;

    procedure StudentHonorsInsert(StudentNo: Code[20]; GPA: Decimal)
    var
        StudentHonors_lRec: Record "Student Honors";
        StudentMaster_lRec: Record "Student Master-CS";
        HonorsMaster_lRec: Record Honors;
        CourseMasterRec: Record "Course Master-CS";
    Begin
        StudentMaster_lRec.Reset();
        StudentMaster_lRec.SetRange("No.", StudentNo);
        If StudentMaster_lRec.FindFirst() then begin
            CourseMasterRec.Reset();
            CourseMasterRec.SetRange(Code, StudentMaster_lRec."Course Code");
            CourseMasterRec.SetRange("Honors Applicable", true);
            if CourseMasterRec.FindFirst() then begin
                HonorsMaster_lRec.Reset();
                HonorsMaster_lRec.SetFilter("Min. Range", '<=%1', GPA);
                HonorsMaster_lRec.SetFilter("Max. Range", '>=%1', GPA);
                HonorsMaster_lRec.Setrange("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                HonorsMaster_lRec.SetFilter("Effective Date", '<=%1', StudentMaster_lRec."Creation Date");
                IF HonorsMaster_lRec.FindLast() then begin
                    StudentHonors_lRec.Reset();
                    StudentHonors_lRec.SetRange("Honors Code", HonorsMaster_lRec.Code);
                    StudentHonors_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    StudentHonors_lRec.SetRange("Min. Range", HonorsMaster_lRec."Min. Range");
                    StudentHonors_lRec.Setrange("Max. Range", HonorsMaster_lRec."Max. Range");
                    StudentHonors_lRec.Setrange("Global Dimension 1 Code", HonorsMaster_lRec."Global Dimension 1 Code");
                    IF Not StudentHonors_lRec.FindFirst() then begin
                        StudentHonors_lRec.Init();
                        StudentHonors_lRec.Validate("Honors Code", HonorsMaster_lRec.Code);
                        StudentHonors_lRec.Validate("Student No.", StudentMaster_lRec."No.");
                        StudentHonors_lRec.Validate("Global Dimension 1 Code", StudentMaster_lRec."Global Dimension 1 Code");
                        StudentHonors_lRec.Insert(True);
                    end;
                end;
            end;
        end;
    End;

    Procedure OnGroundCheckInCmpltProcess(StudentRec: Record "Student Master-CS")
    Var
        HoldUpdate_lCU: Codeunit "Hold Bulk Upload";
        StudentStatusMangCod: Codeunit "Student Status Mangement";
        RegistrarHold: Boolean;
    begin
        RegistrarHold := StudentRec.RegistrarHoldCheck(StudentRec."No.");
        if RegistrarHold then
            Error('Registrar Hold is Enable');
        StudentRec.validate("Student Group", StudentRec."Student Group"::"On-Ground Check-In Completed");
        HoldUpdate_lCU.OnGroundCheckInCompletedGroupEnable(StudentRec."No.");
        StudentRec."On Ground Check-In Complete On" := Today();
        StudentRec."On Ground Check-In Complete By" := UserId();
        StudentRec.validate(Status, StudentStatusMangCod.RegistrarSignoff(StudentRec."No.", StudentRec.Status, StudentRec.Semester, StudentRec."Global Dimension 1 Code"));
        StudentRec.Modify();
        HoldUpdate_lCU.OnGroundCheckInStudentGroupDisable(StudentRec."No.");
    end;


    Procedure SemesterDecisionInsert(StudentMaster_pRec: Record "Student Master-CS"; SemesterDecision: Option " ","Repeat ","Restart")
    Var
        EducationSetup_lRec: Record "Education Setup-CS";
        OLRUpdateLine_lRec: Record "OLR Update Line";
        StudentSemesterLogEntry_lRec: Record "Student Semester Log Entry";
        HousingApplication_lRec: Record "Housing Application";
        OptOut_lRec: Record "Opt Out";
        PaymentPlan_lRec: Record "Financial AID";
        Ferpa_lRec: Record "FERPA Details";
        StudentRegistration_lRec: Record "Student Registration-CS";
        WebserviceFnCU: Codeunit WebServicesFunctionsCSL;
    Begin
        // EducationSetup_lRec.Reset();
        // EducationSetup_lRec.Setrange("Global Dimension 1 Code", StudentMaster_pRec."Global Dimension 1 Code");
        // IF EducationSetup_lRec.Findfirst() then begin
        //     If EducationSetup_lRec."Returning OLR Academic Year" <> StudentMaster_pRec."Academic Year" then
        //         EducationSetup_lRec.TestField("Returning OLR Academic Year", StudentMaster_pRec."Academic Year");
        //     If EducationSetup_lRec."Returning OLR Term" <> StudentMaster_pRec.Term then
        //         EducationSetup_lRec.Testfield("Returning OLR Term", StudentMaster_pRec.Term);
        // end;

        // OLRUpdateLine_lRec.Reset();
        // OLRUpdateLine_lRec.Setrange("Student No.", StudentMaster_pRec."No.");
        // OLRUpdateLine_lRec.SetRange("OLR Academic Year", StudentMaster_pRec."Academic Year");
        // OLRUpdateLine_lRec.SetRange("OLR Term", StudentMaster_pRec.Term);
        // If not OLRUpdateLine_lRec.FindFirst() then
        //     Error('OLR Returning Student Activation does not exist for Student No. : %1, Academic Year : %2, Term : %3', StudentMaster_pRec."No.", StudentMaster_pRec."Academic Year", Format(StudentMaster_pRec.Term));


        // StudentSemesterLogEntry_lRec.Reset();
        // StudentSemesterLogEntry_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
        // StudentSemesterLogEntry_lRec.SetRange("Academic Year", StudentMaster_pRec."Academic Year");
        // StudentSemesterLogEntry_lRec.SetRange(Term, StudentMaster_pRec.Term);
        // If Not StudentSemesterLogEntry_lRec.FindFirst() then begin
        //     StudentSemesterLogEntry_lRec.Init();
        //     StudentSemesterLogEntry_lRec."Student No." := StudentMaster_pRec."No.";
        //     StudentSemesterLogEntry_lRec."Academic Year" := StudentMaster_pRec."Academic Year";
        //     StudentSemesterLogEntry_lRec.Term := StudentMaster_pRec.Term;
        //     StudentSemesterLogEntry_lRec."Student Name" := StudentMaster_pRec."Student Name";
        //     StudentSemesterLogEntry_lRec."Original Student No." := StudentMaster_pRec."Original Student No.";
        //     StudentSemesterLogEntry_lRec."Enrollment No." := StudentMaster_pRec."Enrollment No.";
        //     StudentSemesterLogEntry_lRec."Course Code" := StudentMaster_pRec."Course Code";
        //     StudentSemesterLogEntry_lRec.Semester := StudentMaster_pRec.Semester;
        //     StudentSemesterLogEntry_lRec.Inserted := True;
        //     StudentSemesterLogEntry_lRec."Created By" := UserID();
        //     StudentSemesterLogEntry_lRec."Created On" := Today();
        //     StudentSemesterLogEntry_lRec."Semester Decision" := SemesterDecision;
        //     StudentSemesterLogEntry_lRec.Insert();


        StudentRegistration_lRec.Reset();
        StudentRegistration_lRec.SetRange("Student No", StudentMaster_pRec."No.");
        StudentRegistration_lRec.SetRange("Academic Year", StudentMaster_pRec."Academic Year");
        StudentRegistration_lRec.SetRange(Term, StudentMaster_pRec.Term);
        IF StudentRegistration_lRec.FindFirst() then begin
            StudentRegistration_lRec.Rename(StudentMaster_pRec."No.", StudentMaster_pRec."Course Code", StudentMaster_pRec."Academic Year", StudentMaster_pRec.Semester, StudentMaster_pRec.Term);
        end;

        HousingApplication_lRec.Reset();
        HousingApplication_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
        HousingApplication_lRec.SetRange("Academic Year", StudentMaster_pRec."Academic Year");
        HousingApplication_lRec.SetRange(Term, StudentMaster_pRec.Term);
        IF HousingApplication_lRec.FindFirst() then begin
            HousingApplication_lRec.Semester := StudentMaster_pRec.Semester;
            HousingApplication_lRec.Modify();
        end;
        OptOut_lRec.Reset();
        OptOut_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
        OptOut_lRec.SetRange("Academic Year", StudentMaster_pRec."Academic Year");
        OptOut_lRec.SetRange(Term, StudentMaster_pRec.Term);
        IF OptOut_lRec.FindFirst() then begin
            OptOut_lRec.Semester := StudentMaster_pRec.Semester;
            OptOut_lRec.Modify();
        end;
        PaymentPlan_lRec.Reset();
        PaymentPlan_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
        PaymentPlan_lRec.SetRange("Academic Year", StudentMaster_pRec."Academic Year");
        PaymentPlan_lRec.SetRange(Term, StudentMaster_pRec.Term);
        If PaymentPlan_lRec.FindFirst() then begin
            PaymentPlan_lRec.Semester := StudentMaster_pRec.Semester;
            PaymentPlan_lRec.Modify();
        end;
        Ferpa_lRec.Reset();
        Ferpa_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
        Ferpa_lRec.SetRange("Academic Year", StudentMaster_pRec."Academic Year");
        Ferpa_lRec.SetRange(Term, StudentMaster_pRec.Term);
        IF Ferpa_lRec.FindFirst() then begin
            Ferpa_lRec.Semester := StudentMaster_pRec.Semester;
            Ferpa_lRec.Modify();
        end;

        OLRUpdateLine_lRec.Reset();
        OLRUpdateLine_lRec.Setrange("Student No.", StudentMaster_pRec."No.");
        OLRUpdateLine_lRec.SetRange("OLR Academic Year", StudentMaster_pRec."Academic Year");
        OLRUpdateLine_lRec.SetRange("OLR Term", StudentMaster_pRec.Term);
        If OLRUpdateLine_lRec.FindFirst() then begin
            OLRUpdateLine_lRec."OLR Semester" := StudentMaster_pRec.Semester;
            OLRUpdateLine_lRec.Modify();
            WebserviceFnCU.OLRReturningStudentEmailNotifyFn(OLRUpdateLine_lRec, false);
        end;

        // end;
    End;

    // End;

    procedure CopyHoldAndGroups(OldStudentNo: Code[20]; NewStudentNo: Code[20])
    Var
        OldStudentHold_lRec: Record "Student Wise Holds";
        OldStudentHoldLedger_lRec: Record "Hold Status Ledger";
        OldStudentGroup_lRec: Record "Student Group";
        OldStudentGroupLedger_lRec: Record "Student Group Ledger";
        NewStudentHold_lRec: Record "Student Wise Holds";
        NewStudentHoldLedger_lRec: Record "Hold Status Ledger";
        NewStudentGroup_lRec: Record "Student Group";
        NewStudentGroupLedger_lRec: Record "Student Group Ledger";
        OldStudentMaster: Record "Student Master-CS";
        NewStudentMaster: Record "Student Master-CS";
        OriginalStudentMaster: Record "Student Master-CS";
        EntryNo: Integer;
    begin
        OriginalStudentMaster.Reset();
        OriginalStudentMaster.SetRange("No.", OldStudentNo);
        IF OriginalStudentMaster.FindFirst() then begin
            OldStudentMaster.Reset();
            OldStudentMaster.SetRange("Original Student No.", OriginalStudentMaster."Original Student No.");
            IF OldStudentMaster.FindSet() then begin
                Repeat
                    OldStudentHold_lRec.Reset();
                    OldStudentHold_lRec.Setrange("Student No.", OldStudentMaster."No.");
                    OldStudentHold_lRec.SetFilter("Hold Code", '<>%1', 'HOUSINGHOLD');
                    IF OldStudentHold_lRec.FindSet() then begin
                        repeat
                            NewStudentMaster.Reset();
                            IF NewStudentMaster.Get(NewStudentNo) then begin
                                NewStudentHold_lRec.Reset();
                                NewStudentHold_lRec.SetRange("Student No.", NewStudentMaster."No.");
                                NewStudentHold_lRec.SetRange("Hold Code", OldStudentHold_lRec."Hold Code");
                                IF not NewStudentHold_lRec.FindFirst() then begin
                                    NewStudentHold_lRec.Init();
                                    NewStudentHold_lRec.Validate("Student No.", NewStudentMaster."No.");
                                    NewStudentHold_lRec.Validate("Hold Code", OldStudentHold_lRec."Hold Code");
                                    NewStudentHold_lRec.Status := OldStudentHold_lRec.Status;
                                    NewStudentHold_lRec.Inserted := true;
                                    NewStudentHold_lRec.Updated := true;
                                    NewStudentHold_lRec."Group Code" := OldStudentHold_lRec."Group Code";
                                    NewStudentHold_lRec."Created By" := UserId();
                                    NewStudentHold_lRec."Created On" := Today();
                                    NewStudentHold_lRec."Modified By" := UserId();
                                    NewStudentHold_lRec."Modified On" := Today();
                                    NewStudentHold_lRec.Insert();
                                end;

                                OldStudentHoldLedger_lRec.Reset();
                                OldStudentHoldLedger_lRec.SetRange("Student No.", OldStudentHold_lRec."Student No.");
                                OldStudentHoldLedger_lRec.SetRange("Hold Code", OldStudentHold_lRec."Hold Code");
                                If OldStudentHoldLedger_lRec.FindLast() then begin
                                    EntryNo := 0;
                                    NewStudentHoldLedger_lRec.Reset();
                                    If NewStudentHoldLedger_lRec.FindLast() then
                                        EntryNo += NewStudentHoldLedger_lRec."Entry No." + 1
                                    Else
                                        EntryNo += 1;

                                    NewStudentHoldLedger_lRec.Init();
                                    NewStudentHoldLedger_lRec."Entry No." := EntryNo;
                                    NewStudentHoldLedger_lRec."Entry Date" := Today();
                                    NewStudentHoldLedger_lRec."Entry Time" := Time();
                                    NewStudentHoldLedger_lRec.Validate("Student No.", NewStudentMaster."No.");
                                    NewStudentHoldLedger_lRec.Validate("Hold Code", OldStudentHoldLedger_lRec."Hold Code");
                                    NewStudentHoldLedger_lRec."Student Name" := NewStudentMaster."Student Name";
                                    NewStudentHoldLedger_lRec.Semester := NewStudentMaster.Semester;
                                    NewStudentHoldLedger_lRec."Academic Year" := NewStudentMaster."Academic Year";
                                    NewStudentHoldLedger_lRec."Admitted Year" := NewStudentMaster."Admitted Year";
                                    NewStudentHoldLedger_lRec."Group Code" := OldStudentHoldLedger_lRec."Group Code";
                                    NewStudentHoldLedger_lRec."Global Dimension 1 Code" := OldStudentHoldLedger_lRec."Global Dimension 1 Code";
                                    NewStudentHoldLedger_lRec."Global Dimension 2 Code" := OldStudentHoldLedger_lRec."Global Dimension 2 Code";
                                    NewStudentHoldLedger_lRec.Status := OldStudentHoldLedger_lRec.Status;
                                    NewStudentHoldLedger_lRec.Inserted := true;
                                    NewStudentHoldLedger_lRec.Updated := True;
                                    NewStudentHoldLedger_lRec.Insert();

                                end;
                            end;
                        until OldStudentHold_lRec.Next() = 0;
                    end;
                    OldStudentGroup_lRec.Reset();
                    OldStudentGroup_lRec.SetRange("Student No.", OldStudentMaster."No.");
                    OldStudentGroup_lRec.SetFilter("Groups Code", '<>%1&<>%2&<>%3', 'ONGRDCIC', 'ONGRDCI', 'HOUSINGHOLD');
                    IF OldStudentGroup_lRec.FindSet() then begin
                        repeat
                            NewStudentMaster.Reset();
                            IF NewStudentMaster.Get(NewStudentNo) then begin
                                NewStudentGroup_lRec.Reset();
                                NewStudentGroup_lRec.SetRange("Student No.", NewStudentMaster."No.");
                                NewStudentGroup_lRec.SetRange("Groups Code", OldStudentGroup_lRec."Groups Code");
                                IF not NewStudentGroup_lRec.FindFirst() then begin
                                    NewStudentGroup_lRec.Init();
                                    NewStudentGroup_lRec.Validate("Student No.", NewStudentMaster."No.");
                                    NewStudentGroup_lRec.Validate("Groups Code", OldStudentGroup_lRec."Groups Code");
                                    NewStudentGroup_lRec."Created By" := UserId();
                                    NewStudentGroup_lRec."Creation Date" := Today();
                                    NewStudentGroup_lRec."Modified By" := UserId();
                                    NewStudentGroup_lRec."Modified On" := Today();
                                    NewStudentGroup_lRec.Insert();
                                end;

                                EntryNo := 0;
                                NewStudentGroupLedger_lRec.Reset();
                                IF NewStudentGroupLedger_lRec.FindLast() then
                                    EntryNo += NewStudentGroupLedger_lRec."Entry No." + 1
                                Else
                                    EntryNo += 1;

                                OldStudentGroupLedger_lRec.Reset();
                                OldStudentGroupLedger_lRec.SetRange("Student No.", OldStudentMaster."No.");
                                OldStudentGroupLedger_lRec.SetRange("Group Code", OldStudentGroup_lRec."Groups Code");
                                IF OldStudentGroupLedger_lRec.FindLast() then begin
                                    NewStudentGroupLedger_lRec.Init();
                                    NewStudentGroupLedger_lRec."Entry No." := EntryNo;
                                    NewStudentGroupLedger_lRec."Entry Date" := Today();
                                    NewStudentGroupLedger_lRec."Entry Time" := Time();
                                    NewStudentGroupLedger_lRec.Validate("Student No.", NewStudentMaster."No.");
                                    NewStudentGroupLedger_lRec.Validate("Group Code", OldStudentGroupLedger_lRec."Group Code");
                                    NewStudentGroupLedger_lRec.Status := OldStudentGroupLedger_lRec.Status;
                                    NewStudentGroupLedger_lRec."Modified By" := UserId();
                                    NewStudentGroupLedger_lRec."Modified On" := Today();
                                    NewStudentGroupLedger_lRec.Insert();
                                end;
                            end;
                        until OldStudentGroup_lRec.Next() = 0;
                    end;
                until OldStudentMaster.Next() = 0;
            end;
        end;
    end;

    procedure GFPAndMSHHSCourseProcess()
    var
        CourseMaster_lRec: Record "Course Master-CS";
    Begin
        CourseMaster_lRec.Reset();
        CourseMaster_lRec.SetRange(Code, Rec."Course Code");
        IF CourseMaster_lRec.FindFirst() then begin
            If not CourseMaster_lRec."OLR Applicable" then begin
                Rec.Validate(Status, 'ROL');
                Rec."OLR Completed" := true;
                Rec."OLR Completed Date" := Today();
                Rec.Validate("Student Group", Rec."Student Group"::"On-Ground Check-In");
                Rec."On Ground Check-In By" := Rec."No.";
                Rec."On Ground Check-In On" := Today();
            end;
        end;
        UpdateHoldAndGroup(Rec."No.");

    End;

    procedure UpdateHoldAndGroup(StudentNo: Code[20])
    var
        StudentMaster_lRec: Record "Student Master-CS";
        StudentMaster_lRec1: Record "Student Master-CS";
        OldStudentHold_lRec: Record "Student Wise Holds";
        OldStudentHoldLedger_lRec: Record "Hold Status Ledger";
        OldStudentGroup_lRec: Record "Student Group";
        OldStudentGroupLedger_lRec: Record "Student Group Ledger";
        NewStudentHold_lRec: Record "Student Wise Holds";
        NewStudentHoldLedger_lRec: Record "Hold Status Ledger";
        NewStudentGroup_lRec: Record "Student Group";
        NewStudentGroupLedger_lRec: Record "Student Group Ledger";
        OriginalStudentMaster: Record "Student Master-CS";
        OriginalStudentMaster1: Record "Student Master-CS";

        EntryNo: Integer;
    Begin
        OriginalStudentMaster1.Reset();
        If OriginalStudentMaster1.Get(StudentNo) then;
        OriginalStudentMaster.Reset();
        OriginalStudentMaster.SetRange("Original Student No.", OriginalStudentMaster1."Original Student No.");
        If OriginalStudentMaster.FindSet() then begin
            repeat
                StudentMaster_lRec.Reset();
                StudentMaster_lRec.SetRange("Original Student No.", OriginalStudentMaster."Original Student No.");
                StudentMaster_lRec.Setrange("No.", StudentNo);
                If StudentMaster_lRec.FindFirst() then begin
                    OldStudentHold_lRec.Reset();
                    OldStudentHold_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    If OldStudentHold_lRec.FindSet() then begin
                        repeat
                            If OriginalStudentMaster."No." <> StudentNo then begin
                                StudentMaster_lRec1.Reset();
                                StudentMaster_lRec1.SetRange("No.", OriginalStudentMaster."No.");
                                IF StudentMaster_lRec1.FindFirst() then begin
                                    NewStudentHold_lRec.Reset();
                                    NewStudentHold_lRec.SetRange("Student No.", StudentMaster_lRec1."No.");
                                    NewStudentHold_lRec.SetRange("Hold Code", OldStudentHold_lRec."Hold Code");
                                    If Not NewStudentHold_lRec.FindFirst() then begin
                                        NewStudentHold_lRec.Init();
                                        NewStudentHold_lRec.Validate("Student No.", StudentMaster_lRec1."No.");
                                        NewStudentHold_lRec.Validate("Hold Code", OldStudentHold_lRec."Hold Code");
                                        NewStudentHold_lRec.Status := OldStudentHold_lRec.Status;
                                        NewStudentHold_lRec.Inserted := true;
                                        NewStudentHold_lRec.Updated := true;
                                        NewStudentHold_lRec."Group Code" := OldStudentHold_lRec."Group Code";
                                        NewStudentHold_lRec."Created By" := UserId();
                                        NewStudentHold_lRec."Created On" := Today();
                                        NewStudentHold_lRec."Modified By" := UserId();
                                        NewStudentHold_lRec."Modified On" := Today();
                                        NewStudentHold_lRec.Insert();

                                        OldStudentHoldLedger_lRec.Reset();
                                        OldStudentHoldLedger_lRec.SetRange("Student No.", StudentMaster_lRec1."No.");
                                        OldStudentHoldLedger_lRec.SetRange("Hold Code", OldStudentHold_lRec."Hold Code");
                                        If OldStudentHoldLedger_lRec.FindLast() then begin
                                            EntryNo := 0;
                                            NewStudentHoldLedger_lRec.Reset();
                                            If NewStudentHoldLedger_lRec.FindLast() then
                                                EntryNo += NewStudentHoldLedger_lRec."Entry No." + 1
                                            Else
                                                EntryNo += 1;

                                            NewStudentHoldLedger_lRec.Init();
                                            NewStudentHoldLedger_lRec."Entry No." := EntryNo;
                                            NewStudentHoldLedger_lRec."Entry Date" := Today();
                                            NewStudentHoldLedger_lRec."Entry Time" := Time();
                                            NewStudentHoldLedger_lRec.Validate("Student No.", StudentMaster_lRec1."No.");
                                            NewStudentHoldLedger_lRec.Validate("Hold Code", OldStudentHoldLedger_lRec."Hold Code");
                                            NewStudentHoldLedger_lRec."Student Name" := StudentMaster_lRec1."Student Name";
                                            NewStudentHoldLedger_lRec.Semester := StudentMaster_lRec1.Semester;
                                            NewStudentHoldLedger_lRec."Academic Year" := StudentMaster_lRec1."Academic Year";
                                            NewStudentHoldLedger_lRec."Admitted Year" := StudentMaster_lRec1."Admitted Year";
                                            NewStudentHoldLedger_lRec."Group Code" := OldStudentHoldLedger_lRec."Group Code";
                                            NewStudentHoldLedger_lRec."Global Dimension 1 Code" := OldStudentHoldLedger_lRec."Global Dimension 1 Code";
                                            NewStudentHoldLedger_lRec."Global Dimension 2 Code" := OldStudentHoldLedger_lRec."Global Dimension 2 Code";
                                            NewStudentHoldLedger_lRec.Inserted := true;
                                            NewStudentHoldLedger_lRec.Updated := True;
                                            NewStudentHoldLedger_lRec.Status := NewStudentHoldLedger_lRec.Status::Enable;
                                            NewStudentHoldLedger_lRec.Insert();

                                        end;
                                    end;
                                    If NewStudentHold_lRec.FindFirst() then begin
                                        If NewStudentHold_lRec.Status = NewStudentHold_lRec.Status::Disable then begin
                                            NewStudentHold_lRec.Status := NewStudentHold_lRec.Status::Enable;
                                            NewStudentHold_lRec.Inserted := false;
                                            NewStudentHold_lRec.Updated := true;
                                            NewStudentHold_lRec."Group Code" := OldStudentHold_lRec."Group Code";
                                            NewStudentHold_lRec."Created By" := UserId();
                                            NewStudentHold_lRec."Created On" := Today();
                                            NewStudentHold_lRec."Modified By" := UserId();
                                            NewStudentHold_lRec."Modified On" := Today();
                                            NewStudentHold_lRec.Modify();

                                            OldStudentHoldLedger_lRec.Reset();
                                            OldStudentHoldLedger_lRec.SetRange("Student No.", StudentMaster_lRec1."No.");
                                            OldStudentHoldLedger_lRec.SetRange("Hold Code", OldStudentHold_lRec."Hold Code");
                                            If OldStudentHoldLedger_lRec.FindLast() then begin
                                                EntryNo := 0;
                                                NewStudentHoldLedger_lRec.Reset();
                                                If NewStudentHoldLedger_lRec.FindLast() then
                                                    EntryNo += NewStudentHoldLedger_lRec."Entry No." + 1
                                                Else
                                                    EntryNo += 1;

                                                NewStudentHoldLedger_lRec.Init();
                                                NewStudentHoldLedger_lRec."Entry No." := EntryNo;
                                                NewStudentHoldLedger_lRec."Entry Date" := Today();
                                                NewStudentHoldLedger_lRec."Entry Time" := Time();
                                                NewStudentHoldLedger_lRec.Validate("Student No.", StudentMaster_lRec1."No.");
                                                NewStudentHoldLedger_lRec.Validate("Hold Code", OldStudentHoldLedger_lRec."Hold Code");
                                                NewStudentHoldLedger_lRec."Student Name" := StudentMaster_lRec1."Student Name";
                                                NewStudentHoldLedger_lRec.Semester := StudentMaster_lRec1.Semester;
                                                NewStudentHoldLedger_lRec."Academic Year" := StudentMaster_lRec1."Academic Year";
                                                NewStudentHoldLedger_lRec."Admitted Year" := StudentMaster_lRec1."Admitted Year";
                                                NewStudentHoldLedger_lRec."Group Code" := OldStudentHoldLedger_lRec."Group Code";
                                                NewStudentHoldLedger_lRec."Global Dimension 1 Code" := OldStudentHoldLedger_lRec."Global Dimension 1 Code";
                                                NewStudentHoldLedger_lRec."Global Dimension 2 Code" := OldStudentHoldLedger_lRec."Global Dimension 2 Code";
                                                NewStudentHoldLedger_lRec.Inserted := true;
                                                NewStudentHoldLedger_lRec.Updated := True;
                                                NewStudentHoldLedger_lRec.Status := NewStudentHoldLedger_lRec.Status::Enable;
                                                NewStudentHoldLedger_lRec.Insert();
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until OldStudentHold_lRec.Next() = 0;
                    end;

                    OldStudentGroup_lRec.Reset();
                    OldStudentGroup_lRec.SetRange("Student No.", StudentMaster_lRec."No.");
                    OldStudentGroup_lRec.SetFilter("Groups Code", '<>%1&<>%2', 'ONGRDCIC', 'ONGRDCI');
                    If OldStudentGroup_lRec.FindSet() then begin
                        Repeat
                            IF OriginalStudentMaster."No." <> StudentNo then begin
                                StudentMaster_lRec1.Reset();
                                StudentMaster_lRec1.SetRange("No.", OriginalStudentMaster."No.");
                                If StudentMaster_lRec1.FindFirst() then begin
                                    NewStudentGroup_lRec.Reset();
                                    NewStudentGroup_lRec.SetRange("Student No.", StudentMaster_lRec1."No.");
                                    NewStudentGroup_lRec.SetRange("Groups Code", OldStudentGroup_lRec."Groups Code");
                                    IF Not NewStudentGroup_lRec.FindFirst() then begin
                                        NewStudentGroup_lRec.Init();
                                        NewStudentGroup_lRec.Validate("Student No.", StudentMaster_lRec1."No.");
                                        NewStudentGroup_lRec.Validate("Groups Code", OldStudentGroup_lRec."Groups Code");
                                        NewStudentGroup_lRec."Created By" := UserId();
                                        NewStudentGroup_lRec."Creation Date" := Today();
                                        NewStudentGroup_lRec."Modified By" := UserId();
                                        NewStudentGroup_lRec."Modified On" := Today();
                                        NewStudentGroup_lRec.Insert();

                                        EntryNo := 0;
                                        NewStudentGroupLedger_lRec.Reset();
                                        IF NewStudentGroupLedger_lRec.FindLast() then
                                            EntryNo += NewStudentGroupLedger_lRec."Entry No." + 1
                                        Else
                                            EntryNo += 1;

                                        OldStudentGroupLedger_lRec.Reset();
                                        OldStudentGroupLedger_lRec.SetRange("Student No.", StudentMaster_lRec1."No.");
                                        OldStudentGroupLedger_lRec.SetRange("Group Code", OldStudentGroup_lRec."Groups Code");
                                        IF OldStudentGroupLedger_lRec.FindLast() then begin
                                            NewStudentGroupLedger_lRec.Init();
                                            NewStudentGroupLedger_lRec."Entry No." := EntryNo;
                                            NewStudentGroupLedger_lRec."Entry Date" := Today();
                                            NewStudentGroupLedger_lRec."Entry Time" := Time();
                                            NewStudentGroupLedger_lRec.Validate("Student No.", StudentMaster_lRec1."No.");
                                            NewStudentGroupLedger_lRec.Validate("Group Code", OldStudentGroupLedger_lRec."Group Code");
                                            NewStudentGroupLedger_lRec.Status := OldStudentGroupLedger_lRec.Status;
                                            NewStudentGroupLedger_lRec."Modified By" := UserId();
                                            NewStudentGroupLedger_lRec."Modified On" := Today();
                                            NewStudentGroupLedger_lRec.Insert();
                                        end;
                                    end;
                                end;
                            end;
                        until OldStudentGroup_lRec.Next() = 0;
                    end;
                end
            Until OriginalStudentMaster.Next() = 0;
        end;


    End;

    //CSPL-00307 Start

    // procedure ImmigrationApplicationSubmissionEmail(RecStudent: Record "Student Master-CS")
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    // begin
    //     SMTPMailSetup.GET;
    //     RecStudent.TESTFIELD("E-Mail Address");
    //     Recipient := RecStudent."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderAddress := SmtpMailSetup."Email Address";


    //     CLEAR(SMTPMail);
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", Recipients, RecStudent."No." + ' Immigration Application Submission Alert – For Students On the Island ONLY!', '');
    //     SMTPMail.AppendtoBody('<br/><b><u><p style="color:#ff0000;">* Please Note that this email notification is only for students who are currently on the Island!</p></u></b><br/><br/>');
    //     Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('This is to inform you to submit your Immigration Application under Applications section by logging into your Student Portal.<br/><br/>');
    //     SMTPMail.AppendtoBody('Please complete the immigration application 14 days upon completing your On-Ground Check-in/Student ID Verification with the Registrar’s Office at the AUA Campus.<br/><br/>');
    //     SMTPMail.AppendtoBody('Follow-up emails will be sent by the Residential Services Department with additional information and instructions including the date for submission of the hard copies of your immigration application to the Residential Services Department.');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     SMTPMail.AppendtoBody('Regards,<br/>');
    //     SMTPMail.AppendtoBody('Residential Services Team');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('<br/>');
    //     Smtpmail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();      //26-08-2022 SLCM - Immigration Notice

    //     // MESSAGE('Mail sent');
    //     //FOR NOTIFICATION +
    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Immigration Application Submission Alert', 'MEA', SenderAddress, RecStudent."Student Name",
    //     Format(RecStudent."No."), Subject, BodyText, 'Immigration Application Submission Alert', 'Immigration Application Submission Alert', '', '',
    //     Recipient, 1, RecStudent."Mobile Number", '', 1);
    //     //FOR NOTIFICATION -
    // end;

    procedure CalculateSAP(Var RecStudent: Record "Student Master-CS"; GradebookNo: code[20])
    var
        RecSAPRequrementSetup: Record "SAP Requirement Setup";
        PaceofProgression: Decimal;
        MaximumTimeFrame: Decimal;

        StudSub: Record "Main Student Subject-CS";
        CSemester: Record "Course Sem. Master-CS";
        // CSubject: Record "Course Wise Subject Line-CS";
        CourseMasterRec: Record "Course Master-CS";
        CourseMasterRec1: Record "Course Master-CS";
        Stud: Record "Student Master-CS";
        StudentMaster: Record "Student Master-CS";
        Grade: Record "Grade Master-CS";
        UserSetupRec: Record "User Setup";
        GradePointsArr: Array[9] of Decimal;
        CreditAttemptArr: array[9] of Decimal;
        GPA: Decimal;
        Ctr: Integer;
        CtrTot: Integer;
        SemesterTxt: Code[20];
        MultipleEnrollmentBool: Boolean;
        Int: Integer;
        TotQualityPoint: Decimal;
        TotCreditAttempt: Decimal;
        CourseFilter: Text;
        SemesterGPA: Array[9] of decimal;
        TotalCreditEarned: Decimal;
        PrevTerm: Integer;
        MultipleTerm: Boolean;
        Counter: Integer;
        GPAMatch: Boolean;
        TimeFrameMatch: Boolean;
        PeceProgMatch: Boolean;
        PrevStudent: Text;
        SAPReviewEntries: Record "SAFI LP Date Element";
        TermandYear: Text;
        StudSub2: Record "Main Student Subject-CS";
        EduSetup: Record "Education Setup-CS";
        VarNoSeriesMngt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        ComulativeGPA: Decimal;
        CalculationSemester: code[10];
        CalculationAcademicYear: code[10];
        CalculationTerm: Option FALL,SPRING,SUMMER;
        GradeBookHeader: Record "Grade Book Header";
    begin
        IF (NOT RecStudent."FAFSA Received") OR (RecStudent."Type of FA Roster" = RecStudent."Type of FA Roster"::" ") then
            exit;
        Clear(CalculationAcademicYear);
        Clear(CalculationSemester);
        Clear(CalculationTerm);
        IF GradebookNo <> '' then begin
            GradeBookHeader.Reset();
            GradeBookHeader.SetRange("Document No.", GradebookNo);
            IF GradeBookHeader.FindFirst() then begin
                CalculationSemester := GradeBookHeader.Semester; // as per stuti in case of Grade publish the grade book semester would be consider otherwise student card semester would use for manual SAP calculation
                CalculationAcademicYear := GradeBookHeader."Academic year";
                CalculationTerm := GradeBookHeader.Term;
            end;
        end;
        Stud.Reset();
        Stud.Get(RecStudent."No.");
        IF GradebookNo = '' then begin
            CalculationSemester := Stud.Semester;
            CalculationAcademicYear := Stud."Academic year";
            CalculationTerm := Stud.Term;
        end;
        SAPReviewEntries.Reset();
        SAPReviewEntries.SetRange("Student No.", Stud."No.");
        SAPReviewEntries.SetRange("Academic Year", CalculationAcademicYear);
        SAPReviewEntries.SetRange("Student Term", CalculationTerm);
        SAPReviewEntries.SetRange("Student Semester", CalculationSemester);
        IF SAPReviewEntries.FindFirst() then begin
            Message('SAP for %1 is already present for %2', CalculationSemester, Stud."No.");
            exit;
        end;
        //******Code for GPA Starts*****************
        Int := 0;
        Ctr += 1;
        Clear(PrevStudent);
        MultipleEnrollmentBool := false;
        CourseMasterRec1.Reset();
        CourseMasterRec1.SetRange(Code, Stud."Course Code");
        IF CourseMasterRec1.FindFirst() then
            IF CourseMasterRec1."Transcript Data Filter" then
                MultipleEnrollmentBool := true;

        If MultipleEnrollmentBool then begin
            CourseFilter := '';
            CourseMasterRec.Reset();
            CourseMasterRec.SetRange("Transcript Data Filter", true);
            IF CourseMasterRec.FindSet() then begin
                repeat

                    IF CourseFilter = '' then
                        CourseFilter := CourseMasterRec.Code
                    Else
                        CourseFilter += '|' + CourseMasterRec.Code;
                until CourseMasterRec.Next() = 0;
            end;
        end;
        if (Stud."Course Code" <> '') and (Stud.Status <> '') then begin
            StudentMaster.Reset();
            If not MultipleEnrollmentBool then begin
                StudentMaster.SetRange("Enrollment No.", Stud."Enrollment No.");
                StudentMaster.SetRange("Course Code", Stud."Course Code");
            end;
            If MultipleEnrollmentBool then begin
                StudentMaster.SetRange("Original Student No.", Stud."Original Student No.");
                StudentMaster.SetFilter("Course Code", CourseFilter);
            end;
            StudentMaster.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
            StudentMaster.SetRange("FAFSA Received", true);
            If StudentMaster.FindSet() then begin
                repeat
                    Clear(GradePointsArr);
                    Clear(CreditAttemptArr);
                    Clear(GPA);
                    Clear(PaceofProgression);
                    Clear(MaximumTimeFrame);
                    SemesterTxt := '';
                    TotQualityPoint := 0;
                    TotCreditAttempt := 0;
                    TotalCreditEarned := 0;
                    Counter := 0;
                    Clear(PrevTerm);
                    Clear(MultipleTerm);
                    Clear(PeceProgMatch);
                    Clear(GPAMatch);
                    Clear(TimeFrameMatch);
                    Clear(ComulativeGPA);
                    StudSub.Reset();
                    StudSub.SetCurrentKey(Semester, Sequence);
                    If MultipleEnrollmentBool then begin
                        StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                        StudSub.SetFilter(Course, CourseFilter);
                    end;
                    If not MultipleEnrollmentBool then begin
                        StudSub.SetRange(Course, StudentMaster."Course Code");
                        StudSub.SetRange("Student No.", StudentMaster."No.");
                    end;
                    StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    Studsub.Setfilter(Semester, '<>%1', '');
                    StudSub.SetFilter("Level Description", '<>%1&<>%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                    StudSub.SetRange(TC, false);
                    if StudSub.FindSet() then
                        repeat
                            Int := Studsub.Sequence;
                            SemesterTxt := Studsub.Semester;
                            IF SemesterTxt = StudSub.Semester then begin
                                Grade.Reset();
                                Grade.SetRange(Code, StudSub.Grade);
                                Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                                if Grade.FindFirst() then begin
                                    If Grade."Consider for GPA" then begin
                                        CreditAttemptArr[Int] += StudSub."Credits Attempt"; //for non Clinicals
                                        TotCreditAttempt += StudSub."Credits Attempt";
                                        TotalCreditEarned += StudSub."Credit Earned";
                                    end;
                                    GradePointsArr[Int] += Grade."Grade Points" * StudSub."Credits Attempt";
                                    TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                                end;
                            end;
                            IF PrevTerm <> StudSub.Term then begin
                                PrevTerm := StudSub.Term;
                                Counter += 1;
                            end;
                        until StudSub.Next() = 0;

                    StudSub.Reset();
                    If MultipleEnrollmentBool then begin
                        StudSub.SetRange("Original Student No.", StudentMaster."Original Student No.");
                        StudSub.SetFilter(Course, CourseFilter);
                    end;
                    If not MultipleEnrollmentBool then begin
                        StudSub.SetRange(Course, StudentMaster."Course Code");
                        StudSub.SetRange("Student No.", StudentMaster."No.");
                    end;
                    StudSub.SetFilter(Grade, '<>%1&<>%2&<>%3&<>%4&<>%5', '', 'X', 'M', 'UC', 'SC');
                    StudSub.SetFilter("Level Description", '%1|%2', StudSub."Level Description"::"Level 2 Clinical Rotation", StudSub."Level Description"::"Level 2 Elective Rotation");
                    StudSub.SetRange(TC, false);
                    if StudSub.FindSet() then
                        repeat
                            Int := 9;
                            Grade.Reset();
                            Grade.SetRange(Code, StudSub.Grade);
                            Grade.SetRange("Global Dimension 1 Code", StudSub."Global Dimension 1 Code");
                            if Grade.FindFirst() then begin
                                If Grade."Consider for GPA" then begin
                                    CreditAttemptArr[Int] += StudSub."Credits Attempt"; //for Clinicals
                                    TotCreditAttempt += StudSub."Credits Attempt";
                                    TotalCreditEarned += StudSub."Credit Earned";
                                end;
                                GradePointsArr[Int] += Grade."Grade Points" * StudSub."Credits Attempt";
                                TotQualityPoint += Grade."Grade Points" * StudSub."Credits Attempt";
                            end;
                        until StudSub.Next() = 0;

                    if CreditAttemptArr[1] <> 0 then
                        SemesterGPA[1] := Round(GradePointsArr[1] / CreditAttemptArr[1]);
                    if CreditAttemptArr[2] <> 0 then
                        SemesterGPA[2] := Round(GradePointsArr[2] / CreditAttemptArr[2]);
                    if CreditAttemptArr[3] <> 0 then
                        SemesterGPA[3] := Round(GradePointsArr[3] / CreditAttemptArr[3]);
                    if CreditAttemptArr[4] <> 0 then
                        SemesterGPA[4] := Round(GradePointsArr[4] / CreditAttemptArr[4]);
                    if CreditAttemptArr[5] <> 0 then
                        SemesterGPA[5] := ROund(GradePointsArr[5] / CreditAttemptArr[5]);
                    if CreditAttemptArr[6] <> 0 then
                        SemesterGPA[6] := Round(GradePointsArr[6] / CreditAttemptArr[6]);
                    if CreditAttemptArr[7] <> 0 then
                        SemesterGPA[7] := Round(GradePointsArr[7] / CreditAttemptArr[7]);
                    if CreditAttemptArr[8] <> 0 then
                        SemesterGPA[8] := Round(GradePointsArr[8] / CreditAttemptArr[8]);
                    if CreditAttemptArr[9] <> 0 then
                        SemesterGPA[9] := Round(GradePointsArr[9] / CreditAttemptArr[9]);
                    if TotCreditAttempt <> 0 then
                        ComulativeGPA := Round(TotQualityPoint / TotCreditAttempt);
                //******Code for GPA Ends*****************
                until StudentMaster.Next() = 0;
                RecSAPRequrementSetup.Reset();
                RecSAPRequrementSetup.SetRange("Course Code", Stud."Course Code");
                RecSAPRequrementSetup.SetRange("Global Dimension 1 Code", Stud."Global Dimension 1 Code");
                RecSAPRequrementSetup.SetRange(Semester, CalculationSemester);
                IF RecSAPRequrementSetup.FindFirst() Then begin
                    // UserSetup.Reset();
                    // IF UserSetup.Get(UserId) then;
                    EduSetup.Reset();
                    EduSetup.SetFilter("SAP Users Email ID", '<>%1', '');
                    if EduSetup.FindFirst() then;

                    MaximumTimeFrame := TotCreditAttempt;//All the attempt Credit is Timeframe which should be less then the maximum Timeframe defined on setup 
                    GPA := ComulativeGPA;
                    IF CalculationSemester IN ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'BSIC'] then begin //Clinical
                        IF TotCreditAttempt <> 0 then
                            PaceofProgression := Round(((TotalCreditEarned / TotCreditAttempt) * 100)); // in %

                        // IF (Stud.Semester = 'BSIC') then
                        //     GPA := SemesterGPA[5]
                        // else
                        //     GPA := SemesterGPA[9];

                        IF (GPA >= RecSAPRequrementSetup.GPA) then
                            GPAMatch := true;

                        IF (PaceofProgression >= RecSAPRequrementSetup."Pace of Progression") then
                            PeceProgMatch := true;

                        IF (MaximumTimeFrame <= RecSAPRequrementSetup."Maximum Timeframe") then
                            TimeFrameMatch := true;

                        IF (GPAMatch AND PeceProgMatch AND TimeFrameMatch) then begin
                            Stud."FA SAP Status" := Stud."FA SAP Status"::"SAP SATISFIED";
                            Stud.Modify();
                        end else begin
                            IF (Stud."FA SAP Status" = Stud."FA SAP Status"::" ") then begin
                                Stud."FA SAP Status" := Stud."FA SAP Status"::"SAP WARNING";
                                Stud."Financial Aid Status" := Stud."Financial Aid Status"::"FINANCIAL AID WARNING";
                                IF NOT GPAMatch then
                                    Stud."Failed SAP Reason" := 'GPA';
                                IF (NOT PeceProgMatch) AND (NOT GPAMatch) then
                                    Stud."Failed SAP Reason" := Stud."Failed SAP Reason" + '; Pace of Progression'
                                else
                                    IF (NOT PeceProgMatch) then
                                        Stud."Failed SAP Reason" := 'Pace of Progression';

                                IF ((NOT TimeFrameMatch) AND (NOT GPAMatch)) OR ((NOT TimeFrameMatch) AND (NOT PeceProgMatch)) then
                                    Stud."Failed SAP Reason" := Stud."Failed SAP Reason" + '; Max Timeframe'
                                else
                                    if (not TimeFrameMatch) then
                                        Stud."Failed SAP Reason" := 'Max Timeframe';
                                // IF PrevStudent <> Stud."Original Student No." then begin
                                //     PrevStudent := Stud."Original Student No.";
                                // if EduSetup."SAP Users Email ID" <> '' then
                                //     SAPStatusWarningMail(Stud."No.", GPA, GPAMatch, PaceofProgression, PeceProgMatch, TimeFrameMatch, EduSetup."SAP Users Email ID", GradebookNo);  ////AUTO MAIL
                                // end;

                            end
                            else begin
                                Stud."FA SAP Status" := Stud."FA SAP Status"::"SAP REVOKE";
                                Stud."Financial Aid Status" := Stud."Financial Aid Status"::"FINANCIAL AID SUSPENSION";
                                IF NOT GPAMatch then
                                    Stud."Failed SAP Reason" := 'GPA';
                                IF (NOT PeceProgMatch) AND (NOT GPAMatch) then
                                    Stud."Failed SAP Reason" := Stud."Failed SAP Reason" + '; Pace of Progression'
                                else
                                    IF (NOT PeceProgMatch) then
                                        Stud."Failed SAP Reason" := 'Pace of Progression';

                                IF ((NOT TimeFrameMatch) AND (NOT GPAMatch)) OR ((NOT TimeFrameMatch) AND (NOT PeceProgMatch)) then
                                    Stud."Failed SAP Reason" := Stud."Failed SAP Reason" + '; Max Timeframe'
                                else
                                    if (not TimeFrameMatch) then
                                        Stud."Failed SAP Reason" := 'Max Timeframe';

                                // IF PrevStudent <> Stud."Original Student No." then begin
                                //     PrevStudent := Stud."Original Student No.";

                                // if EduSetup."SAP Users Email ID" <> '' then
                                //     SAPStatusRevokeMail(Stud."No.", GPA, GPAMatch, PaceofProgression, PeceProgMatch, TimeFrameMatch, EduSetup."SAP Users Email ID", GradebookNo);   ////AUTO MAIL
                                // end;
                            end;
                        end
                    end else
                        IF CalculationSemester IN ['MED1', 'MED2', 'MED3', 'MED4'] then begin // Basic sciences
                            IF ((Counter MOD 2) = 0) then begin
                                IF TotCreditAttempt <> 0 then
                                    PaceofProgression := Round(((TotalCreditEarned / TotCreditAttempt) * 100)); // in % 

                                /* IF Stud.Semester IN ['MED1,MED2'] then
                                      IF (CreditAttemptArr[1] + CreditAttemptArr[2]) > 0 then
                                          GPA := Round((GradePointsArr[1] + GradePointsArr[2]) / (CreditAttemptArr[1] + CreditAttemptArr[2]))
                                      else
                                          IF Stud.Semester IN ['MED3,MED4'] then
                                              IF (CreditAttemptArr[3] + CreditAttemptArr[4]) > 0 then
                                                  GPA := Round((GradePointsArr[3] + GradePointsArr[4]) / (CreditAttemptArr[3] + CreditAttemptArr[4]));*/

                                IF (GPA >= RecSAPRequrementSetup.GPA) then
                                    GPAMatch := true;

                                IF (PaceofProgression >= RecSAPRequrementSetup."Pace of Progression") then
                                    PeceProgMatch := true;

                                IF (MaximumTimeFrame <= RecSAPRequrementSetup."Maximum Timeframe") then
                                    TimeFrameMatch := true;
                                IF (GPAMatch AND PeceProgMatch AND TimeFrameMatch) then begin
                                    Stud."FA SAP Status" := Stud."FA SAP Status"::"SAP SATISFIED";
                                    Stud.Modify();
                                end else begin
                                    Stud."FA SAP Status" := Stud."FA SAP Status"::"SAP REVOKE";
                                    Stud."Financial Aid Status" := Stud."Financial Aid Status"::"FINANCIAL AID SUSPENSION";
                                    IF NOT GPAMatch then
                                        Stud."Failed SAP Reason" := 'GPA';
                                    IF (NOT PeceProgMatch) AND (NOT GPAMatch) then
                                        Stud."Failed SAP Reason" := Stud."Failed SAP Reason" + '; Pace of Progression'
                                    else
                                        IF (NOT PeceProgMatch) then
                                            Stud."Failed SAP Reason" := 'Pace of Progression';

                                    IF ((NOT TimeFrameMatch) AND (NOT GPAMatch)) OR ((NOT TimeFrameMatch) AND (NOT PeceProgMatch)) then
                                        Stud."Failed SAP Reason" := Stud."Failed SAP Reason" + '; Max Timeframe'
                                    else
                                        if (not TimeFrameMatch) then
                                            Stud."Failed SAP Reason" := 'Max Timeframe';


                                    // IF PrevStudent <> Stud."Original Student No." then begin
                                    //     PrevStudent := Stud."Original Student No.";
                                    // if EduSetup."SAP Users Email ID" <> '' then
                                    //     SAPStatusRevokeMail(Stud."No.", GPA, GPAMatch, PaceofProgression, PeceProgMatch, TimeFrameMatch, EduSetup."SAP Users Email ID", GradebookNo);   ////AUTO MAIL
                                    // end;
                                End;
                            end;
                        end;

                    Stud.Modify();
                    IF (Stud."FA SAP Status" <> Stud."FA SAP Status"::" ") then begin
                        Clear(TermandYear);
                        StudSub.Reset();
                        StudSub.SetCurrentKey("Student No.", Year, Sequence);
                        StudSub.SetRange("Student No.", Stud."No.");
                        StudSub.SetRange(Year, Stud.Year);
                        StudSub.SetAscending(Sequence, true);
                        IF StudSub.FindFirst() then begin
                            TermandYear := Format(StudSub.Term) + ' ' + StudSub."Academic Year" + ' ' + CalculationSemester;
                            StudSub2.Reset();
                            StudSub2.SetRange("Student No.", Stud."No.");
                            StudSub2.SetFilter(Sequence, '%1', StudSub.Sequence + 1);
                            IF StudSub2.FindFirst() then begin
                                TermandYear := TermandYear + ' & ' + Format(StudSub2.Term) + ' ' + StudSub2."Academic Year" + ' ' + CalculationSemester;
                            end
                        end;
                        SAPReviewEntries.Reset();
                        SAPReviewEntries.SetRange("Student No.", Stud."No.");
                        SAPReviewEntries.SetRange("Academic Year", CalculationAcademicYear);
                        SAPReviewEntries.SetRange("Student Term", CalculationTerm);
                        SAPReviewEntries.SetRange("Student Semester", CalculationSemester);
                        IF SAPReviewEntries.IsEmpty then begin
                            SAPReviewEntries.Reset();
                            SAPReviewEntries.init();
                            SAPReviewEntries.Insert(True);
                            SAPReviewEntries.Validate("Student No.", Stud."No.");
                            SAPReviewEntries.GPA := GPA;
                            SAPReviewEntries."Pace of Progression" := PaceofProgression;
                            SAPReviewEntries."Time Frame" := MaximumTimeFrame;
                            SAPReviewEntries."SAP Status" := Stud."FA SAP Status";
                            SAPReviewEntries."GPA Match" := GPAMatch;
                            SAPReviewEntries."Pace of Progression Match" := PeceProgMatch;
                            SAPReviewEntries."Time Frame Match" := TimeFrameMatch;
                            SAPReviewEntries.GradeBookDocumentNo := GradebookNo;
                            IF CalculationSemester IN ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'BSIC'] then
                                SAPReviewEntries.Term_AcademicYear := Format(CalculationTerm) + ' ' + CalculationAcademicYear + ' ' + CalculationSemester
                            else
                                SAPReviewEntries.Term_AcademicYear := TermandYear;
                            SAPReviewEntries.Modify();
                        end;
                    end;
                end else
                    Error('SAP Requirement Setup Not found for Institute %1, Course %2 , Semester %3 ', Stud."Global Dimension 1 Code", Stud."Course Code", CalculationSemester);
            end;
        end;

    end;

    // procedure SAPStatusRevokeMail(StudentNo: Code[20]; GPA: Decimal; GPAMatch: Boolean; PeceofProgression: Decimal; PeceofProgMatch: Boolean; TimeFrameMatch: Boolean; UserEmail: Text[200]; GradeBookNo: Code[20])
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     TermandYear: Text;
    //     StudSub: Record "Main Student Subject-CS";
    //     StudentSubject: Record "Main Student Subject-CS";
    //     Grade: code[20];
    //     Counter: integer;
    //     RecStudent: Record "Student Master-CS";
    //     StudSub2: Record "Main Student Subject-CS";
    //     StudenGradeBooks: Record "Student Subject GradeBook";
    //     GradeBookHeader: Record "Grade Book Header";
    //     CalculationSemester: code[10];
    // begin
    //     RecStudent.Get(StudentNo);
    //     IF GradeBookNo <> '' then begin
    //         GradeBookHeader.Reset();
    //         GradeBookHeader.SetRange("Document No.", GradeBookNo);
    //         if GradeBookHeader.FindFirst() then
    //             CalculationSemester := GradeBookHeader.Semester;
    //     end else
    //         CalculationSemester := RecStudent.Semester;
    //     Counter := 0;
    //     SMTPMailSetup.GET;
    //     // RecStudent.TESTFIELD("E-Mail Address");
    //     // Recipient := RecStudent."E-Mail Address";
    //     IF UserEmail <> '' then
    //         Recipient := UserEmail
    //     else
    //         Recipient := 'stuti.khandelwal@corporateserve.com;lucky.kumar@corporateserve.com';
    //     // StuSub.Reset();
    //     // StuSub.SetRange("Student No.", RecStudent."No.");
    //     // StuSub.SetRange(Semester, RecStudent.Semester);
    //     // IF StuSub.FindFirst() then begin
    //     //     TermandYear := Format(StuSub.Term) + ' ' + StuSub."Academic Year";
    //     //     StuSub.Reset();
    //     //     StuSub.SetRange("Student No.", RecStudent."No.");
    //     //     StuSub.SetFilter(Term, '<>%1', RecStudent.Term);
    //     //     IF StuSub.FindFirst() then begin
    //     //         TermandYear := TermandYear + ' & ' + Format(StuSub.Term) + ' ' + StuSub."Academic Year";
    //     //     end
    //     // end;
    //     StudSub.Reset();
    //     StudSub.SetCurrentKey("Student No.", Year, Sequence);
    //     StudSub.SetRange("Student No.", RecStudent."No.");
    //     StudSub.SetRange(Year, RecStudent.Year);
    //     StudSub.SetAscending(Sequence, true);
    //     IF StudSub.FindFirst() then begin
    //         TermandYear := Format(StudSub.Term) + ' ' + StudSub."Academic Year";
    //         StudSub2.Reset();
    //         StudSub2.SetRange("Student No.", RecStudent."No.");
    //         StudSub2.SetFilter(Sequence, '%1', StudSub.Sequence + 1);
    //         IF StudSub2.FindFirst() then begin
    //             TermandYear := TermandYear + ' & ' + Format(StudSub2.Term) + ' ' + StudSub2."Academic Year";
    //         end
    //     end;
    //     StudenGradeBooks.Reset();
    //     StudenGradeBooks.SetCurrentKey("Entry No.");
    //     StudenGradeBooks.SetRange("Student No.", RecStudent."No.");
    //     StudenGradeBooks.SetRange(Status, StudenGradeBooks.Status::Published);
    //     StudenGradeBooks.SetAscending("Entry No.", false);
    //     if StudenGradeBooks.FindFirst() then
    //         Grade := StudenGradeBooks."Grade To Be Published";
    //     IF CalculationSemester IN ['MED1', 'MED2', 'MED3', 'MED4'] then begin
    //         CLEAR(SMTPMail);
    //         SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Satisfactory Academic Progress (SAP) Status', '', TRUE);
    //         Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('We are writing to inform you that you did not meet Satisfactory Academic Progress (SAP) during <b>' + TermandYear + '</b> Semesters.<br/>');
    //         SMTPMail.AppendtoBody('<table border="1" width="100%" align="center" >' +
    //                             '<thead>' +
    //                                 '<tr>' +
    //                                 '<th>Your Cumulative Grade at the end of <b>' + Format(RecStudent.Term) + ' ' + RecStudent."Academic Year" + '</b> : <br/> Grade : <b>' + Format(Grade) + '<b/></th><th> The SAP requirement(s) you did not meet are: <br/>');
    //         IF NOT GPAMatch then
    //             SMTPMail.AppendtoBody(' &#9745 GPA <b>' + Format(GPA) + '</b>')
    //         else
    //             SMTPMail.AppendtoBody('&#9744 GPA <b>' + Format(GPA) + '</b>');

    //         IF NOT PeceofProgMatch then
    //             SMTPMail.AppendtoBody('<br/> &#9745 Pace of Progression <b>' + Format(PeceofProgression) + '</b>')
    //         else
    //             SMTPMail.AppendtoBody('<br/> &#9744 Pace of Progression <b>' + Format(PeceofProgression) + '</b>');

    //         IF NOT TimeFrameMatch then
    //             SMTPMail.AppendtoBody('<br/> &#9745 Maximum Timeframe <b> NOT MEETS </b>')
    //         else
    //             SMTPMail.AppendtoBody('<br/> &#9744 Maximum Timeframe <b> MEETS </b>');
    //         SMTPMail.AppendtoBody('</th></tr></thead></table>');
    //         SMTPMail.AppendtoBody('Due to the above instance of not meeting the SAP requirements you have been placed on Financial Aid Suspension.<br/>');
    //         SMTPMail.AppendtoBody('<P>The Federal Government requires that students who receive financial aid maintain Satisfactory Academic Progress (SAP) towards their degree. AUACOM evaluates its Basic Science Students Annually to determine eligibility. ' +
    //                             'Students not meeting these standards at the end of the Year are not eligible to receive financial aid. However, students may appeal this status if there were circumstances that interfered with their ability to meet these Satisfactory Academic Progress standards. ' +
    //                             'Students wishing to complete a Satisfactory Academic Progress (SAP) Appeal, must visit the portal and submit their SAP Appeal with supporting documentation. A student may only appeal if the failure to make Satisfactory Academic Progress was due to extenuating circumstances.</P>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('Please review the ‘INFORMATION & PROCEDURES FINANCIAL AID SUSPENSION’ handout for further information regarding the SP Standards and the options available to you.');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('Regards,<br/>');
    //         SMTPMail.AppendtoBody('Office of Student Financial Service');


    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         // MESSAGE('Mail sent');
    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Semester Appeal Form Alert', 'MEA', SenderAddress, RecStudent."Student Name",
    //         Format(RecStudent."No."), Subject, BodyText, 'Semester Appeal Form Alert', 'Semester Appeal Form Alert', '', '',
    //         Recipient, 1, RecStudent."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -
    //     End;

    //     IF CalculationSemester IN ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'BSIC'] then begin
    //         CLEAR(SMTPMail);
    //         SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Satisfactory Academic Progress (SAP) Status', '', TRUE);
    //         Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('We are writing to inform you that you did not meet Satisfactory Academic Progress (SAP) during <b>' + Format(RecStudent.Term) + ' ' + RecStudent."Academic Year" + ' ' + CalculationSemester + '</b> Semester.<br/>');
    //         SMTPMail.AppendtoBody('<table border="1" width="100%" align="center" >' +
    //                             '<thead>' +
    //                                 '<tr>' +
    //                                 '<th>Your Cumulative Grade at the end of <b>' + Format(RecStudent.Term) + ' ' + RecStudent."Academic Year" + ' ' + CalculationSemester + '</b> : <br/> Grade : <b>' + Format(Grade) + '<b/></th><th> The SAP requirement(s) you did not meet are: <br/>');
    //         IF NOT GPAMatch then
    //             SMTPMail.AppendtoBody(' &#9745 GPA <b>' + Format(GPA) + '</b>')
    //         else
    //             SMTPMail.AppendtoBody('&#9744 GPA <b>' + Format(GPA) + '</b>');

    //         IF NOT PeceofProgMatch then
    //             SMTPMail.AppendtoBody('<br/> &#9745 Pace of Progression <b>' + Format(PeceofProgression) + '</b>')
    //         else
    //             SMTPMail.AppendtoBody('<br/> &#9744 Pace of Progression <b>' + Format(PeceofProgression) + '</b>');

    //         IF NOT TimeFrameMatch then
    //             SMTPMail.AppendtoBody('<br/> &#9745 Maximum Timeframe <b> NOT MEETS </b>')
    //         else
    //             SMTPMail.AppendtoBody('<br/> &#9744 Maximum Timeframe <b> MEETS </b>');
    //         SMTPMail.AppendtoBody('</th></tr></thead></table>');
    //         SMTPMail.AppendtoBody('Since this is not your first instance of not meeting the SAP requirements you have been placed on <b>Financial Aid Suspension</b>.<br/>');
    //         SMTPMail.AppendtoBody('<P>The Federal Government requires that students who receive financial aid maintain Satisfactory Academic Progress (SAP) towards their degree.' +
    //                             ' AUACOM evaluates its Clinical/BSIC Students <b>every Semester</b> to determine eligibility. Students not meeting these standards at the end of the Semester are not eligible to receive financial aid. ' +
    //                             'However, students may appeal this status if there were circumstances that interfered with their ability to meet these Satisfactory Academic Progress standards. Students wishing to complete a Satisfactory Academic Progress (SAP) Appeal, ' +
    //                             'must visit the portal and submit their SAP Appeal with supporting documentation. A student may only appeal if the failure to make Satisfactory Academic Progress was due to extenuating circumstances.</P>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('Please review the ‘INFORMATION & PROCEDURES FINANCIAL AID SUSPENSION’ handout for further information regarding the SP Standards and the options available to you.');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('Regards,<br/>');
    //         SMTPMail.AppendtoBody('Office of Student Financial Service');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();

    //         // MESSAGE('Mail sent');
    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Semester Appeal Form Alert', 'MEA', SenderAddress, RecStudent."Student Name",
    //         Format(RecStudent."No."), Subject, BodyText, 'Semester Appeal Form Alert', 'Semester Appeal Form Alert', '', '',
    //         Recipient, 1, RecStudent."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -

    //     End;
    // end;

    // procedure SAPStatusWarningMail(StudentNo: Code[20]; GPA: Decimal; GPAMatch: Boolean; PeceofProgression: Decimal; PeceofProgMatch: Boolean; TimeFrameMatch: Boolean; UserEmail: Text[200]; GradeBookNo: Code[20])
    // var
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     Recipient: Text;
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     BodyText: Text;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     StudentSubject: Record "Main Student Subject-CS";
    //     Grade: Code[20];
    //     Counter: integer;
    //     // CCs: List of [Text];
    //     TermandYear: Text;
    //     StudSub: Record "Main Student Subject-CS";
    //     StudSub2: Record "Main Student Subject-CS";
    //     RecStudent: Record "Student Master-CS";
    //     StudenGradeBooks: Record "Student Subject GradeBook";
    //     GradeBookHeader: Record "Grade Book Header";
    //     CalculationSemester: code[10];
    // begin
    //     RecStudent.Get(StudentNo);
    //     IF GradeBookNo <> '' then begin
    //         GradeBookHeader.Reset();
    //         GradeBookHeader.SetRange("Document No.", GradeBookNo);
    //         if GradeBookHeader.FindFirst() then
    //             CalculationSemester := GradeBookHeader.Semester;
    //     end else
    //         CalculationSemester := RecStudent.Semester;
    //     StudenGradeBooks.Reset();
    //     StudenGradeBooks.SetCurrentKey("Entry No.");
    //     StudenGradeBooks.SetRange("Student No.", RecStudent."No.");
    //     StudenGradeBooks.SetRange(Status, StudenGradeBooks.Status::Published);
    //     StudenGradeBooks.SetAscending("Entry No.", false);
    //     if StudenGradeBooks.FindFirst() then
    //         Grade := StudenGradeBooks.Grade;
    //     Counter := 0;
    //     SMTPMailSetup.GET;
    //     // RecStudent.TESTFIELD("E-Mail Address");
    //     // Recipient := RecStudent."E-Mail Address";
    //     IF UserEmail <> '' then
    //         Recipient := UserEmail
    //     else
    //         Recipient := 'stuti.khandelwal@corporateserve.com;lucky.kumar@corporateserve.com';
    //     IF CalculationSemester IN ['CLN5', 'CLN6', 'CLN7', 'CLN8', 'CLN9', 'BSIC'] then begin //  Clinical/BSIC
    //         CLEAR(SMTPMail);
    //         SMTPMail.Create('', SmtpMailSetup."Email Address", Recipient, 'Satisfactory Academic Progress (SAP) Status', '', TRUE);
    //         Smtpmail.AppendtoBody('Dear ' + RecStudent."Student Name" + ',');
    //         Smtpmail.AppendtoBody('<br/>');
    //         Smtpmail.AppendtoBody('<br/>');
    //         SMTPMail.AppendtoBody('We are writing to inform you that you did not meet Satisfactory Academic Progress (SAP) during <b>' + Format(RecStudent.Term) + ' ' + RecStudent."Academic Year" + ' ' + CalculationSemester + '</b> Semesters.<br/>');

    //         SMTPMail.AppendtoBody('<table border="1" width="100%" align="center" >' +
    //                             '<thead>' +
    //                                 '<tr>' +
    //                                 '<th>Your Cumulative Grade at the end of <b>' + Format(RecStudent.Term) + ' ' + RecStudent."Academic Year" + ' ' + CalculationSemester + '</b> : <br/> Grade : <b>' + Format(Grade) + '<b/></th><th> The SAP requirement(s) you did not meet are: <br/>');
    //         IF NOT GPAMatch then
    //             SMTPMail.AppendtoBody(' &#9745 GPA <b>' + Format(GPA) + '</b>')
    //         else
    //             SMTPMail.AppendtoBody('&#9744 GPA <b>' + Format(GPA) + '</b>');

    //         IF NOT PeceofProgMatch then
    //             SMTPMail.AppendtoBody('<br/> &#9745 Pace of Progression <b>' + Format(PeceofProgression) + '</b>')
    //         else
    //             SMTPMail.AppendtoBody('<br/> &#9744 Pace of Progression <b>' + Format(PeceofProgression) + '</b>');

    //         IF NOT TimeFrameMatch then
    //             SMTPMail.AppendtoBody('<br/> &#9745 Maximum Timeframe <b> NOT MEETS </b>')
    //         else
    //             SMTPMail.AppendtoBody('<br/> &#9744 Maximum Timeframe <b> MEETS </b>');
    //         SMTPMail.AppendtoBody('</th></tr></thead></table>');
    //         SMTPMail.AppendtoBody('As this is your first instance of not meeting the SAP requirements you have been placed on Financial Aid Warning<br/>');
    //         SMTPMail.AppendtoBody('<p>The Federal Government requires that students who receive financial aid maintain Satisfactory Academic Progress (SAP) towards their degree. AUACOM evaluates its Clinical/BSIC Students every Semester to determine eligibility. ' +
    //                             'Students not meeting these standards at the end of the Semester are not eligible to receive financial aid.</p>');
    //         SMTPMail.AppendtoBody('Kindly visit the Portal and accept the warning application for Satisfactory Academic Progress (SAP)<br/>');
    //         SMTPMail.AppendtoBody('Please review the ‘INFORMATION & PROCEDURES FINANCIAL AID SUSPENSION’ handout for further information regarding the SP Standards and the options available to you.');
    //         SMTPMail.AppendtoBody('<br/><br/>[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].<br/><br/>');
    //         SMTPMail.AppendtoBody('Regards,<br/>');
    //         SMTPMail.AppendtoBody('Office of Student Financial Service');
    //         BodyText := SmtpMail.GetBody();
    //         Mail_lCU.Send();
    //         //FOR NOTIFICATION +
    //         WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Semester Appeal Form Alert', 'MEA', SenderAddress, RecStudent."Student Name",
    //         Format(RecStudent."No."), Subject, BodyText, 'Semester Appeal Form Alert', 'Semester Appeal Form Alert', '', '',
    //         Recipient, 1, RecStudent."Mobile Number", '', 1);
    //         //FOR NOTIFICATION -
    //     end;
    // end;
    //CSPL-00307 Ends

    PRocedure UpdateDummyStudentSubject(StudentMaster_pRec: Record "Student Master-CS"; CourseCode: Code[20]; SemesterL: Code[20]; AcademicYearL: Code[20]; pTerm: Option FALL,SPRING,SUMMER)
    var
        CourseWiseSubjectLineCS: Record "Course Wise Subject Line-CS";
        EducationSetup: Record "Education Setup-CS";
        MainStudentSubjectCS: Record "Medical Scholars Line";
        MainStudentSubjectCS1: Record "Medical Scholars Line";
        CourseSemesterMasterRec: Record "Course Sem. Master-CS";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    Begin
        EducationSetup.Reset();
        EducationSetup.Setrange("Global Dimension 1 Code", StudentMaster_pRec."Global Dimension 1 Code");
        IF EducationSetup.FindFirst() then;

        CourseWiseSubjectLineCS.Reset();
        CourseWiseSubjectLineCS.SETRANGE("Course Code", StudentMaster_pRec."Course Code");
        CourseWiseSubjectLineCS.SETRANGE(Semester, SemesterL);
        // CourseWiseSubjectLineCS.SETRANGE("Academic Year", "Academic Year");
        CourseWiseSubjectLineCS.SetRange("Global Dimension 1 Code", StudentMaster_pRec."Global Dimension 1 Code");
        IF CourseWiseSubjectLineCS.findset() THEN
            REPEAT
                if CourseWiseSubjectLineCS."Global Dimension 1 Code" = '9000' then begin
                    //                            if (CourseWiseSubjectLineCS.Level = 1) or (CourseWiseSubjectLineCS.Examination = true) then begin
                    if (CourseWiseSubjectLineCS.Level = 1) then begin
                        CourseSemesterMasterRec.Reset();
                        CourseSemesterMasterRec.SetRange("Course Code", CourseWiseSubjectLineCS."Course Code");
                        CourseSemesterMasterRec.SetRange("Semester Code", SemesterL);
                        CourseSemesterMasterRec.SetRange("Academic Year", AcademicYearL);
                        CourseSemesterMasterRec.SetRange("Global Dimension 1 Code", StudentMaster_pRec."Global Dimension 1 Code");
                        CourseSemesterMasterRec.SetRange(Term, pTerm);
                        CourseSemesterMasterRec.FindFirst();


                        MainStudentSubjectCS1.Reset();
                        MainStudentSubjectCS1.SETRANGE("Student No", StudentMaster_pRec."Original Student No.");
                        MainStudentSubjectCS1.SETRANGE("Course Code", StudentMaster_pRec."Course Code");
                        MainStudentSubjectCS1.SETRANGE("Semster No", SemesterL);
                        MainStudentSubjectCS1.SETRANGE("Academic Year", AcademicYearL);
                        MainStudentSubjectCS1.SETRANGE(Subject, CourseWiseSubjectLineCS."Subject Code");
                        MainStudentSubjectCS1.SetRange("Start Date", CourseSemesterMasterRec."Start Date");
                        IF NOT MainStudentSubjectCS1.findfirst() THEN BEGIN
                            MainStudentSubjectCS.init();
                            MainStudentSubjectCS."Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."Dummy Student Subject", Today, true);
                            MainStudentSubjectCS."Line No." := 10000;
                            MainStudentSubjectCS."Student No" := StudentMaster_pRec."No.";
                            MainStudentSubjectCS."Course Code" := StudentMaster_pRec."Course Code";
                            MainStudentSubjectCS.VALIDATE("Academic Year", AcademicYearL);
                            MainStudentSubjectCS.Term := pTerm;
                            MainStudentSubjectCS."Semster No" := SemesterL;
                            MainStudentSubjectCS."Start Date" := CourseSemesterMasterRec."Start Date";
                            MainStudentSubjectCS."End Date" := CourseSemesterMasterRec."End Date";
                            MainStudentSubjectCS."Expected End Date" := CourseSemesterMasterRec."End Date";
                            MainStudentSubjectCS.Subject := CourseWiseSubjectLineCS."Subject Code";
                            MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            MainStudentSubjectCS.Level := CourseWiseSubjectLineCS.Level;
                            MainStudentSubjectCS.Grade := '';
                            MainStudentSubjectCS.Insert();
                        END;
                    end;
                end;
                if CourseWiseSubjectLineCS."Global Dimension 1 Code" = '9100' then begin
                    if (CourseWiseSubjectLineCS.Level = 1) then begin
                        MainStudentSubjectCS1.Reset();
                        MainStudentSubjectCS1.SETRANGE("Student No", StudentMaster_pRec."No.");
                        MainStudentSubjectCS1.SETRANGE("Course Code", StudentMaster_pRec."Course Code");
                        MainStudentSubjectCS1.SETRANGE("Semster No", StudentMaster_pRec.Semester);
                        MainStudentSubjectCS1.SETRANGE("Academic Year", StudentMaster_pRec."Academic Year");
                        MainStudentSubjectCS1.SETRANGE(Subject, CourseWiseSubjectLineCS."Subject Code");
                        MainStudentSubjectCS1.SetRange("Start Date", CourseSemesterMasterRec."Start Date");
                        IF NOT MainStudentSubjectCS1.findfirst() THEN BEGIN
                            MainStudentSubjectCS.init();
                            MainStudentSubjectCS."Document No." := NoSeriesMgmt.GetNextNo(EducationSetup."Dummy Student Subject", Today, true);
                            MainStudentSubjectCS."Line No." := 10000;
                            MainStudentSubjectCS."Student No" := StudentMaster_pRec."No.";
                            MainStudentSubjectCS."Course Code" := StudentMaster_pRec."Course Code";
                            MainStudentSubjectCS.VALIDATE("Academic Year", "Academic Year");
                            MainStudentSubjectCS.Term := Term;
                            MainStudentSubjectCS."Semster No" := CourseWiseSubjectLineCS.Semester;
                            MainStudentSubjectCS."Start Date" := CourseSemesterMasterRec."Start Date";
                            MainStudentSubjectCS."End Date" := CourseSemesterMasterRec."End Date";
                            MainStudentSubjectCS."Expected End Date" := CourseSemesterMasterRec."End Date";
                            MainStudentSubjectCS.Subject := CourseWiseSubjectLineCS."Subject Code";
                            MainStudentSubjectCS.Description := CourseWiseSubjectLineCS.Description;
                            MainStudentSubjectCS.Credit := CourseWiseSubjectLineCS.Credit;
                            MainStudentSubjectCS.Level := CourseWiseSubjectLineCS.Level;
                            MainStudentSubjectCS.Grade := '';
                            MainStudentSubjectCS.Insert();
                        END;
                    end;
                end;
            UNTIL CourseWiseSubjectLineCS.NEXT() = 0

    End;

    Procedure StudentSemesterDecisionInsert(StudentMaster_pRec: Record "Student Master-CS"; SemesterDecision: Option " ","Repeat ","Restart")
    Var
        EducationSetup_lRec: Record "Education Setup-CS";
        OLRUpdateLine_lRec: Record "OLR Update Line";
        StudentSemesterLogEntry_lRec: Record "Student Semester Log Entry";
        HousingApplication_lRec: Record "Housing Application";
        OptOut_lRec: Record "Opt Out";
        PaymentPlan_lRec: Record "Financial AID";
        Ferpa_lRec: Record "FERPA Details";
        FerpaInformHdr: Record "FERPA Information Header";
        FerpaModuledAll: Record "FERPA Module Allowed";
        StudentRegistration_lRec: Record "Student Registration-CS";
        WebserviceFnCU: Codeunit WebServicesFunctionsCSL;
    Begin
        EducationSetup_lRec.Reset();
        EducationSetup_lRec.Setrange("Global Dimension 1 Code", StudentMaster_pRec."Global Dimension 1 Code");
        IF EducationSetup_lRec.Findfirst() then begin
            //     If EducationSetup_lRec."Returning OLR Academic Year" <> StudentMaster_pRec."Academic Year" then
            //         EducationSetup_lRec.TestField("Returning OLR Academic Year", StudentMaster_pRec."Academic Year");
            //     If EducationSetup_lRec."Returning OLR Term" <> StudentMaster_pRec.Term then
            //         EducationSetup_lRec.Testfield("Returning OLR Term", StudentMaster_pRec.Term);
            // end;

            OLRUpdateLine_lRec.Reset();
            OLRUpdateLine_lRec.Setrange("Student No.", StudentMaster_pRec."No.");
            OLRUpdateLine_lRec.SetRange("OLR Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            OLRUpdateLine_lRec.SetRange("OLR Term", EducationSetup_lRec."Returning OLR Term");
            If not OLRUpdateLine_lRec.FindFirst() then
                Error('OLR Returning Student Activation does not exist for Student No. : %1, Academic Year : %2, Term : %3', StudentMaster_pRec."No.", StudentMaster_pRec."Academic Year", Format(StudentMaster_pRec.Term));
        end;

        EducationSetup_lRec.Reset();
        EducationSetup_lRec.SetRange("Global Dimension 1 Code", StudentMaster_pRec."Global Dimension 1 Code");
        IF EducationSetup_lRec.FindFirst() then begin
            OLRUpdateLine_lRec.Reset();
            OLRUpdateLine_lRec.Setrange("Student No.", StudentMaster_pRec."No.");
            OLRUpdateLine_lRec.SetRange("OLR Academic Year", EducationSetup_lRec."Returning OLR Academic Year");
            OLRUpdateLine_lRec.SetRange("OLR Term", EducationSetup_lRec."Returning OLR Term");
            If OLRUpdateLine_lRec.FindFirst() then begin
                StudentSemesterLogEntry_lRec.Reset();
                StudentSemesterLogEntry_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
                StudentSemesterLogEntry_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                StudentSemesterLogEntry_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                If Not StudentSemesterLogEntry_lRec.FindFirst() then begin
                    StudentSemesterLogEntry_lRec.Init();
                    StudentSemesterLogEntry_lRec."Student No." := StudentMaster_pRec."No.";
                    StudentSemesterLogEntry_lRec."Academic Year" := OLRUpdateLine_lRec."OLR Academic Year";
                    StudentSemesterLogEntry_lRec.Term := OLRUpdateLine_lRec."OLR Term";
                    StudentSemesterLogEntry_lRec."Student Name" := StudentMaster_pRec."Student Name";
                    StudentSemesterLogEntry_lRec."Original Student No." := StudentMaster_pRec."Original Student No.";
                    StudentSemesterLogEntry_lRec."Enrollment No." := StudentMaster_pRec."Enrollment No.";
                    StudentSemesterLogEntry_lRec."Course Code" := StudentMaster_pRec."Course Code";
                    StudentSemesterLogEntry_lRec.Semester := StudentMaster_pRec.Semester;
                    StudentSemesterLogEntry_lRec.Inserted := True;
                    StudentSemesterLogEntry_lRec."Created By" := UserID();
                    StudentSemesterLogEntry_lRec."Created On" := Today();
                    StudentSemesterLogEntry_lRec."Semester Decision" := SemesterDecision;
                    StudentSemesterLogEntry_lRec.Insert();
                end;


                StudentRegistration_lRec.Reset();
                StudentRegistration_lRec.SetRange("Student No", StudentMaster_pRec."No.");
                StudentRegistration_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                StudentRegistration_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                IF StudentRegistration_lRec.FindFirst() then begin
                    StudentRegistration_lRec.Rename(StudentMaster_pRec."No.", StudentMaster_pRec."Course Code", OLRUpdateLine_lRec."OLR Academic Year", StudentMaster_pRec.Semester, OLRUpdateLine_lRec."OLR Term");
                end;

                HousingApplication_lRec.Reset();
                HousingApplication_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
                HousingApplication_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                HousingApplication_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                IF HousingApplication_lRec.FindFirst() then begin
                    HousingApplication_lRec.Semester := StudentMaster_pRec.Semester;
                    HousingApplication_lRec.Modify();
                end;
                OptOut_lRec.Reset();
                OptOut_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
                OptOut_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                OptOut_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                IF OptOut_lRec.FindFirst() then begin
                    OptOut_lRec.Semester := StudentMaster_pRec.Semester;
                    OptOut_lRec.Modify();
                end;
                PaymentPlan_lRec.Reset();
                PaymentPlan_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
                PaymentPlan_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                PaymentPlan_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                If PaymentPlan_lRec.FindFirst() then begin
                    PaymentPlan_lRec.Semester := StudentMaster_pRec.Semester;
                    PaymentPlan_lRec.Modify();
                end;
                Ferpa_lRec.Reset();
                Ferpa_lRec.SetRange("Student No.", StudentMaster_pRec."No.");
                Ferpa_lRec.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                Ferpa_lRec.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                IF Ferpa_lRec.FindSet() then begin
                    Repeat
                        Ferpa_lRec.Semester := StudentMaster_pRec.Semester;
                        Ferpa_lRec.Modify();
                    until Ferpa_lRec.Next() = 0;
                end;

                FerpaInformHdr.Reset();
                FerpaInformHdr.SetRange("Student No", StudentMaster_pRec."No.");
                FerpaInformHdr.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                FerpaInformHdr.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                If FerpaInformHdr.FindSet() then begin
                    repeat
                        FerpaInformHdr.Semester := StudentMaster_pRec.Semester;
                        FerpaInformHdr.Modify();
                    until FerpaInformHdr.Next() = 0;

                end;

                FerpaModuledAll.Reset();
                FerpaModuledAll.SetRange("Student No.", StudentMaster_pRec."No.");
                FerpaModuledAll.SetRange("Academic Year", OLRUpdateLine_lRec."OLR Academic Year");
                FerpaModuledAll.SetRange(Term, OLRUpdateLine_lRec."OLR Term");
                IF FerpaModuledAll.Findset() then begin
                    Repeat
                        FerpaModuledAll.Semester := StudentMaster_pRec.Semester;
                        FerpaModuledAll.Modify();
                    until FerpaModuledAll.Next() = 0;

                end;

                // OLRUpdateLine_lRec.Reset();
                // OLRUpdateLine_lRec.Setrange("Student No.", StudentMaster_pRec."No.");
                // OLRUpdateLine_lRec.SetRange("OLR Academic Year", StudentMaster_pRec."Academic Year");
                // OLRUpdateLine_lRec.SetRange("OLR Term", StudentMaster_pRec.Term);
                // If OLRUpdateLine_lRec.FindFirst() then begin
                OLRUpdateLine_lRec."OLR Semester" := StudentMaster_pRec.Semester;
                OLRUpdateLine_lRec.Modify();
                WebserviceFnCU.OLRReturningStudentEmailNotifyFn(OLRUpdateLine_lRec, false);

                StudentMaster_pRec."Semester Decision" := SemesterDecision;
                StudentMaster_pRec.Modify();
            end;

        end;
    End;

    procedure DeleteDummyStudentSubject(StudentNo: Code[20]; CourseCode: Code[20]; Semester: Code[20]; AcademicYear: Code[20]; pTerm: Option FALL,SPRING,SUMMER)
    var
        MedicalScholarLine: Record "Medical Scholars Line";
    Begin
        MedicalScholarLine.Reset();
        MedicalScholarLine.SetRange("Student No", StudentNo);
        MedicalScholarLine.SetRange("Academic Year", AcademicYear);
        MedicalScholarLine.SetRange(Term, pTerm);
        // IF MedicalScholarLine.FindFirst() then
        MedicalScholarLine.DeleteAll();
    End;

    //CS_SG 20230523
    procedure HoldChecksOLRFinance(StudentRecLcl: Record "Student Master-CS"): Boolean
    var
        StudentWiseHoldRec: Record "Student Wise Holds";
    begin
        StudentWiseHoldRec.Reset();
        StudentWiseHoldRec.SetRange("Student No.", StudentRecLcl."No.");
        StudentWiseHoldRec.SetRange(StudentWiseHoldRec."Hold Type", StudentWiseHoldRec."Hold Type"::"OLR Finance");
        if StudentWiseHoldRec.FindFirst() then begin
            if StudentWiseHoldRec.Status = StudentWiseHoldRec.Status::Enable then
                exit(true)
            else
                exit(false);
        end;
    end;
    //CS_SG 20230523
}