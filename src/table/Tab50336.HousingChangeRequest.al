table 50336 "Housing Change Request"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Change Request';
    LookupPageId = "Housing Change Request List";
    DrillDownPageId = "Housing Change Request List";
    DataCaptionFields = "Application No.", "Student Name";


    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No.';
            trigger OnValidate()
            begin
                IF "Application No." <> xRec."Application No." THEN BEGIN
                    // UserSetupRec.Get(UserId());
                    // EducationSetupRec.Reset();
                    // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    // EducationSetupRec.FindFirst();
                    GlSetup.get();
                    NoSeriesMgt.TestManual(GlSetup."Housing Change/Vacate No.");
                    "No.Series" := '';
                END;
            end;

        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Date';
            Editable = false;

        }

        field(3; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            begin
                // if ("Student No." <> '') and ("Student No." <> xRec."Student No.") then
                //     if Type = type::"Re-Registration" then begin
                //         HousingChangeRequest.Reset();
                //         HousingChangeRequest.SetRange("Student No.", "Student No.");
                //         HousingChangeRequest.Setfilter(Status, '<>%1', Status::Rejected);
                //         IF HousingChangeRequest.FindFirst() then
                //             Error('Student Already Exist');
                //     end;

                if StudentMasterRec.Get("Student No.") then begin
                    "Enrolment No." := StudentMasterRec."Enrollment No.";
                    "Student Name" := StudentMasterRec."Student Name";
                    Semester := StudentMasterRec.Semester;
                    "Academic Year" := StudentMasterRec."Academic Year";
                    "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                    Term := StudentMasterRec.Term;
                end else begin
                    "Enrolment No." := '';
                    "Student Name" := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Original Application No." := '';
                    "Effective Date" := 0D;
                    "Global Dimension 1 Code" := '';
                    "Housing ID" := '';
                    "Housing Name" := '';
                    "Housing Address" := '';
                    "Housing Address 2" := '';
                    "Housing City" := '';
                    "Housing Country" := '';
                    "Housing Pref. 1" := '';

                end;
            end;
        }
        field(4; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrolment No.';
            Editable = false;

        }
        field(5; "Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Date';
            trigger OnValidate()
            begin
                If "Effective Date" <= "Application Date" then
                    Error('Effective Date should be greated than Application Date');
            end;

        }
        field(6; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter(Housing));
            trigger OnValidate()
            begin
                IF ReasonCodeRec.Get("Reason Code") then
                    "Reason Description" := ReasonCodeRec.Description
                else
                    "Reason Description" := '';
            end;

        }
        field(7; "Original Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Original Application No.';
            TableRelation = "Housing Application" where(status = filter(Approved), "Student No." = field("Student No."), "Inventory Verified" = Const(true));

            trigger OnValidate()
            begin
                if "Original Application No." <> '' then begin
                    HostelApplicationRec.Get("Original Application No.");
                    Validate("Housing ID", HostelApplicationRec."Housing ID");
                end else begin
                    "Effective Date" := 0D;
                    "Global Dimension 1 Code" := '';
                    "Housing ID" := '';
                    "Housing Name" := '';
                    "Housing Address" := '';
                    "Housing Address 2" := '';
                    "Housing City" := '';
                    "Housing Country" := '';
                    "Housing Pref. 1" := '';
                end;
            end;

        }
        field(8; "New Application No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'New Application No.';
            Editable = false;

        }
        field(9; "Room Keys Returned"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Keys Returned';

        }
        field(10; "Reason Description"; text[250])
        {
            DataClassification = CustomerContent;
            caption = 'Reason Description';
        }

        field(11; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Pending for Approval,Approved,Rejected';
            OptionMembers = "Pending for Approval",Approved,Rejected;
            Editable = false;
        }
        field(12; "Approve/Reject Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Approve/Reject Date';
        }

        field(13; "Approve/Reject Remarks"; text[2048])
        {
            DataClassification = CustomerContent;
            caption = 'Approve/Reject Remarks';

        }
        field(14; "Renew Start Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Renew Start Date';
            trigger OnValidate()
            begin
                IF "Renew End Date" = 0D then begin
                    If "Renew Start Date" < WorkDate() then
                        Error('Renew Start date is not less than to Workdate');
                end else
                    Error('Renew End date is not blank');
            end;
        }
        field(15; "Renew End Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Renew End Date';
            trigger OnValidate()
            begin
                If "Renew End Date" <= "Renew Start Date" then
                    Error('Renew End date is not less than to Renew Start date');
            end;
        }
        field(16; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Vacate,Change Request,Re-Registration';
            OptionMembers = " ",Vacate,"Change Request","Re-Registration";
            Caption = 'Application Type';
            Editable = false;

        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }

        field(19; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(20; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(21; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(22; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(23; "No.Series"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.Series';
            TableRelation = "Reason Code".code;

        }
        field(24; "Posted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted';
            Editable = false;

        }
        field(25; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry From Portal';
            Editable = false;

        }
        field(26; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(27; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(28; "Housing Pref. 1"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 1';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
            trigger OnValidate()
            begin
                if HousingMasterRec.Get("Housing Pref. 1") then
                    "Housing Pref. 1 Name" := HousingMasterRec."Housing Name"
                else
                    "Housing Pref. 1 Name" := '';
            end;
        }
        field(29; "Housing Pref. 2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 2';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
            trigger OnValidate()
            begin
                if HousingMasterRec.Get("Housing Pref. 2") then
                    "Housing Pref. 2 Name" := HousingMasterRec."Housing Name"
                else
                    "Housing Pref. 2 Name" := '';
            end;
        }
        field(30; "Housing Pref. 3"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 3';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
            trigger OnValidate()
            begin
                if HousingMasterRec.Get("Housing Pref. 3") then
                    "Housing Pref. 3 Name" := HousingMasterRec."Housing Name"
                else
                    "Housing Pref. 3 Name" := '';
            end;
        }
        field(31; "With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'With Spouse';

        }
        field(32; "Room Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';
            TableRelation = "Room Category Master"."Room Category Code";

        }
        field(33; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }

        field(34; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(35; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            Editable = false;
        }
        field(36; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            Editable = false;
        }
        field(37; "Housing Pref. 1 Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 1 Name';
            Editable = false;
        }
        field(38; "Housing Pref. 2 Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 2 Name';
            Editable = false;
        }
        field(39; "Housing Pref. 3 Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 3 Name';
            Editable = false;
        }
        field(40; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            Editable = false;
            trigger OnValidate()
            begin
                if HousingMasterRec.Get("Housing ID") then begin
                    "Housing Name" := HousingMasterRec."Housing Name";
                    "Housing Address" := HousingMasterRec.Address;
                    "Housing Address 2" := HousingMasterRec."Address 2";
                    "Housing City" := HousingMasterRec.City;
                    "Housing Country" := HousingMasterRec.Country;
                    "Contact Number" := HousingMasterRec."Contact Number";
                    "E-Mail" := HousingMasterRec."E-mail";
                end else begin
                    "Housing Name" := '';
                    "Housing Address" := '';
                    "Housing Address 2" := '';
                    "Housing City" := '';
                    "Housing Country" := '';
                    "Contact Number" := '';
                    "E-Mail" := '';
                end;
            end;
        }
        field(41; "Housing Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Name';
            Editable = false;
        }
        Field(42; "Housing Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Address';
            Editable = false;
        }
        Field(43; "Housing Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Address 2';
            Editable = false;
        }
        Field(44; "Housing City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing City';
            Editable = false;
        }
        Field(45; "Housing Country"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Housing Country';
            TableRelation = "Country/Region";
        }
        Field(46; "Contact Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Housing Contact Number';
        }
        Field(47; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Housing E-Mail';
            ExtendedDatatype = EMail;
        }
        field(48; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved By';
            Editable = false;
        }
        field(49; "Approved On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved On';
            Editable = false;
        }
        field(50; "Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected By';
            Editable = false;
        }
        field(51; "Rejected On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected On';
            Editable = false;
        }
        field(52; "Approved In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved In Days';
            Editable = false;
        }
        field(53; "Rejected In Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Rejected In Days';
            Editable = false;
        }
        field(54; "Term"; Option)
        {
            Caption = 'Session';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(55; "Present Address1"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Present Address2"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Present Address3"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Lease Agreement/Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Lease Agreement Group"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(64; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            // TableRelation = if (country = const()) "Post Code"
            // else
            // if (Country = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = field(Country));
            // trigger OnValidate()
            // begin
            //     PostCodeRec.Reset();
            //     PostCodeRec.SetRange(PostCodeRec.Code, "Post Code");
            //     IF PostCodeRec.FindFirst() THEN BEGIN
            //         Country := PostCodeRec."Country/Region Code";
            //         city := PostCodeRec.City;
            //         County := PostCodeRec.County;
            //     END ELSE BEGIN
            //         Country := '';
            //         city := '';
            //         County := '';
            //     END;
            // end;
        }
        Field(65; "City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
            // TableRelation = if (country = const()) "Post Code".City
            // else
            // if (Country = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = field(Country));
        }
        Field(66; "Country"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(67; County; Text[30])
        {
            Caption = 'State';
            DataClassification = CustomerContent;
            trigger OnLookup()
            begin
                PostCodeRec.RESET();
                PostCodeRec.FINDSET();
                IF PAGE.RUNMODAL(367, PostCodeRec) = ACTION::LookupOK THEN
                    County := FORMAT(PostCodeRec.County);
            end;
        }
        field(68; "Room Mate Name Pref"; Text[50])
        {
            Caption = 'Apartment Mate Name Pref';
            DataClassification = CustomerContent;
        }
        field(69; "Room Mate Email Pref"; Text[80])
        {
            Caption = 'Apartment Mate Email Pref';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(70; "Mid Sem Break"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        // Field(71; "Room No."; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Apartment No.';
        //     trigger OnLookup()
        //     var
        //         RoomMaster: Record "Room Master";
        //         RoomMasterTemp: Record "Room Master" temporary;
        //         Student: Record "Student Master-CS";
        //         RoomMasterListTemp: Page "Room Master List Temp";

        //     begin
        //         Commit();
        //         Student.Get("Student No.");
        //         if "Pref. 1 Selected" then
        //             Clear(RoomMasterListTemp);
        //         RoomMaster.Reset();
        //         if "Pref. 1 Selected" then
        //             RoomMaster.SetRange("Housing ID", "Housing Pref. 1")
        //         else
        //             if "Pref. 2 Selected" then
        //                 RoomMaster.SetRange("Housing ID", "Housing Pref. 2")
        //             else
        //                 if "Pref. 3 Selected" then
        //                     RoomMaster.SetRange("Housing ID", "Housing Pref. 3")
        //                 else
        //                     Error(RoomCatErr);
        //         RoomMaster.SetRange("Room Category Code", "Room Category Code");
        //         RoomMaster.SetRange(Blocked, false);
        //         RoomMaster.SetFilter("Available Beds", '<>%1', 0);
        //         if RoomMaster.FindSet() then
        //             repeat
        //                 // if RoomMasterListTemp.CheckEligibleRoom(RoomMaster, "With Spouse", Student) then
        //                 RoomMasterListTemp.addedvaluetoTempRec(RoomMaster);
        //             until RoomMaster.Next() = 0;

        //         RoomMasterListTemp.LookupMode(true);
        //         if RoomMasterListTemp.RunModal() = Action::LookupOK then begin
        //             RoomMasterListTemp.GetRecord(RoomMasterTemp);
        //             "Room No." := RoomMasterTemp."Room No.";
        //             "Bed No." := '';
        //         end;
        //         StartEndDateCreation(Rec, "Student No.", "Academic Year", Term, Semester, "Global Dimension 1 Code");
        //     end;

        //     trigger OnValidate()
        //     begin
        //         if Rec."Room No." <> '' then
        //             Error('Use Lookup to select the Apartment No.');

        //     end;
        // }
        // Field(72; "Bed No."; Code[20])
        // {
        //     DataClassification = CustomerContent;
        // }

    }



    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(key2; "Created On")
        {

        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Application No.", "Student No.", "Student Name", "Application Date")
        { }
    }

    var

        CompanyInformationRec: Record "Company Information";
        StudentMasterRec: Record "Student Master-CS";
        EducationSetupRec: Record "Education Setup-CS";
        HousingChangeRequest: Record "Housing Change Request";
        ReasonCodeRec: Record "Reason Code";
        HostelApplicationRec: Record "Housing Application";
        HostelLedgerRec: Record "Housing Ledger";
        HostelLedgerRec1: Record "Housing Ledger";
        RoomWiseBedRec: Record "Room Wise Bed";
        HostelApplicationRec1: Record "Housing Application";
        HousingMasterRec: Record "Housing Master";
        PostCodeRec: Record "Post Code";
        UserSetupRec: Record "User Setup";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        LastNo: Integer;



    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
        "Application Date" := WORKDATE();
        // UserSetupRec.Get(UserId());
        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        // EducationSetupRec.FindFirst();
        GlSetup.Get();
        IF "Application No." = '' THEN BEGIN
            GlSetup.TESTFIELD("Housing Change/Vacate No.");
            NoSeriesMgt.InitSeries(GlSetup."Housing Change/Vacate No.", xRec."No.Series", 0D, "Application No.", "No.Series");

        end;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        Updated := true;
    end;

    procedure PostApplication(ApplicationNo: Code[20])
    var

        HostelMaster: Record "Housing Master";
        HousingApplication: Record "Housing Application";
        RecStudentMaster: Record "Student Master-CS";
        LeaseStartDate: Date;
        LeaseEndDate: Date;
        ContractNo: Code[20];
    begin
        HousingChangeRequest.Get(ApplicationNo);
        RecStudentMaster.Get(HousingChangeRequest."Student No.");
        //HousingChangeRequest.TestField(HousingChangeRequest.Status, HousingChangeRequest.Status::Approved);
        HousingApplication.Get(HousingChangeRequest."Original Application No.");
        IF HousingApplication."With Spouse" = true then begin
            RoomWiseBedRec.Reset();
            RoomWiseBedRec.setrange("Housing ID", HousingApplication."Housing ID");
            RoomWiseBedRec.SetRange("Room No.", HousingApplication."Room No.");
            RoomWiseBedRec.Setfilter(Available, '%1', false);
            if RoomWiseBedRec.findfirst() then begin
                repeat
                    HostelLedgerRec.Reset();
                    if HostelLedgerRec.FINDLAST() then
                        LastNo := HostelLedgerRec."Entry No." + 1
                    else
                        LastNo := 1;

                    HostelLedgerRec.Init();
                    HostelLedgerRec."Entry No." := LastNo;
                    HostelLedgerRec."Application No." := HousingChangeRequest."Application No.";
                    HostelLedgerRec."Original Application No." := HousingChangeRequest."Original Application No.";
                    HostelLedgerRec.Status := HostelLedgerRec.Status::UnAssigned;

                    HostelLedgerRec."Housing ID" := HousingApplication."Housing ID";
                    HostelLedgerRec."Room Category Code" := HousingApplication."Room Category Code";
                    HostelLedgerRec."Housing Group" := HousingApplication."Housing Group";
                    HostelLedgerRec.Type := HousingChangeRequest.Type;
                    HostelLedgerRec."Room No." := RoomWiseBedRec."Room No.";
                    HostelLedgerRec."Bed No." := RoomWiseBedRec."Bed No.";
                    HostelLedgerRec."Student No." := HousingChangeRequest."Student No.";
                    HostelLedgerRec."Student Name" := HousingChangeRequest."Student Name";
                    HostelLedgerRec."Academic Year" := RecStudentMaster."Academic Year";
                    HostelLedgerRec.Semester := RecStudentMaster.Semester;
                    HostelLedgerRec."Enrolment No." := HousingChangeRequest."Enrolment No.";
                    HostelLedgerRec."Room Assignment" := -1;
                    HostelLedgerRec."Global Dimension 1 Code" := HousingChangeRequest."Global Dimension 1 Code";
                    HostelLedgerRec."Global Dimension 2 Code" := HousingChangeRequest."Global Dimension 2 Code";
                    HostelLedgerRec.Term := HousingChangeRequest.Term;
                    if Type = Type::"Change Request" Then
                        HostelLedgerRec."Housing Changed On" := WORKDATE();
                    if Type = Type::Vacate Then
                        HostelLedgerRec."Housing Vacated On" := WORKDATE();
                    HostelLedgerRec."Posting Date" := WORKDATE();
                    HostelMaster.ContractDetail(HostelLedgerRec."Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
                    HostelLedgerRec."Contract No." := ContractNo;
                    HostelLedgerRec."Room Mate Name Pref" := HousingChangeRequest."Room Mate Name Pref";
                    HostelLedgerRec."Room Mate Email Pref" := HousingChangeRequest."Room Mate Email Pref";
                    HostelLedgerRec.Insert(true);

                    RoomWiseBedRec.Available := true;
                    RoomWiseBedRec.Modify();
                until RoomWiseBedRec.Next() = 0;
            end;
        end else begin
            HostelLedgerRec.Reset();
            if HostelLedgerRec.FINDLAST() then
                LastNo := HostelLedgerRec."Entry No." + 1
            else
                LastNo := 1;

            HostelLedgerRec.Init();
            HostelLedgerRec."Entry No." := LastNo;
            HostelLedgerRec."Application No." := HousingChangeRequest."Application No.";
            HostelLedgerRec."Original Application No." := HousingChangeRequest."Original Application No.";
            HostelLedgerRec.Status := HostelLedgerRec.Status::UnAssigned;
            HostelLedgerRec1.Reset();
            HostelLedgerRec1.SetRange("Original Application No.", HousingChangeRequest."Original Application No.");
            IF HostelLedgerRec1.FindSet() then;
            HostelLedgerRec."Housing ID" := HostelLedgerRec1."Housing ID";
            HostelLedgerRec."Room Category Code" := HostelLedgerRec1."Room Category Code";
            HostelLedgerRec."Housing Group" := HostelLedgerRec1."Housing Group";
            HostelLedgerRec.Type := HousingChangeRequest.Type;
            HostelLedgerRec."Room No." := HostelLedgerRec1."Room No.";
            HostelLedgerRec."Bed No." := HostelLedgerRec1."Bed No.";
            HostelLedgerRec."Student No." := HousingChangeRequest."Student No.";
            HostelLedgerRec."Student Name" := HousingChangeRequest."Student Name";
            HostelLedgerRec."Academic Year" := HostelLedgerRec1."Academic Year";
            HostelLedgerRec.Semester := HostelLedgerRec1.Semester;
            HostelLedgerRec."Enrolment No." := HousingChangeRequest."Enrolment No.";
            HostelLedgerRec."Room Assignment" := -1;
            HostelLedgerRec."Global Dimension 1 Code" := HousingChangeRequest."Global Dimension 1 Code";
            HostelLedgerRec."Global Dimension 2 Code" := HousingChangeRequest."Global Dimension 2 Code";
            HostelLedgerRec.Term := HousingChangeRequest.Term;
            if Type = Type::"Change Request" Then
                HostelLedgerRec."Housing Changed On" := WORKDATE();
            if Type = Type::Vacate Then
                HostelLedgerRec."Housing Vacated On" := WORKDATE();
            HostelLedgerRec."Posting Date" := WORKDATE();
            HostelMaster.ContractDetail(HostelLedgerRec."Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
            HostelLedgerRec."Contract No." := ContractNo;
            HostelLedgerRec."Room Mate Name Pref" := HousingChangeRequest."Room Mate Name Pref";
            HostelLedgerRec."Room Mate Email Pref" := HousingChangeRequest."Room Mate Email Pref";
            HostelLedgerRec.Insert(true);
            RoomWiseBedRec.Reset();
            RoomWiseBedRec.SetRange("Room No.", HostelLedgerRec1."Room No.");
            RoomWiseBedRec.SetRange("Bed No.", HostelLedgerRec1."Bed No.");
            if RoomWiseBedRec.FINDFIRST() then begin
                RoomWiseBedRec.Available := true;
                RoomWiseBedRec.Modify();
            end;
        end;
        HostelApplicationRec1.Reset();
        HostelApplicationRec1.SetRange("Application No.", HousingChangeRequest."Original Application No.");
        IF HostelApplicationRec1.FindFirst() then begin
            HostelApplicationRec1.Status := HostelApplicationRec1.Status::Vacated;
            HostelApplicationRec1.Modify();
        End;

        // HousingChangeRequest.Posted := true;
        // HousingChangeRequest.Modify();

    end;

    procedure CreateHostelApplication()
    var

    begin
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        EducationSetupRec.FindFirst();
        HostelApplicationRec1.Reset();
        HostelApplicationRec1.Init();
        HostelApplicationRec1."Application No." := NoSeriesMgt.GetNextNo(EducationSetupRec."Housing Application No.", 0D, TRUE);
        HostelApplicationRec1."Application Date" := WORKDATE();
        HostelApplicationRec1.Validate("Student No.", "Student No.");
        HostelApplicationRec1.Validate("Housing Pref. 1", "Housing Pref. 1");
        HostelApplicationRec1.Validate("Housing Pref. 2", "Housing Pref. 2");
        HostelApplicationRec1.Validate("Housing Pref. 3", "Housing Pref. 3");
        HostelApplicationRec1."Room Category Code" := "Room Category Code";
        HostelApplicationRec1."With Spouse" := "With Spouse";
        HostelApplicationRec1."Enrolment No." := "Enrolment No.";
        HostelApplicationRec1."Global Dimension 1 Code" := "Global Dimension 1 Code";
        HostelApplicationRec1."Global Dimension 2 Code" := "Global Dimension 2 Code";
        HostelApplicationRec1.Status := HostelApplicationRec1.Status::"Pending for Approval";
        HostelApplicationRec."Entry From Change" := true;
        HostelApplicationRec1.Insert(true);
        "New Application No." := HostelApplicationRec1."Application No.";
        Modify();
        HostelApplicationRec1.Reset();
        HostelApplicationRec1.SetRange("Application No.", "New Application No.");
        if HostelApplicationRec1.find() then
            PAGE.RUN(Page::"Housing Application Card", HostelApplicationRec1);
    end;

    procedure RenewApplication()
    var

    begin
        //TestField(Status, Status::Approved);
        HostelApplicationRec1.Reset();
        HostelApplicationRec1.SetRange("Application No.", "Original Application No.");
        HostelApplicationRec1.SetRange(Posted, true);
        if HostelApplicationRec1.FindFirst() then begin
            HostelApplicationRec1."Applied to Continue" := true;
            HostelApplicationRec1.Modify(true);
        end;

    end;

    // procedure HostelChangerequesMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Housing Change Request Status';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your request for the Housing Change has been' + ' ' + Format(Status));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail id.');
    //     BodyText := SmtpMail.GetBody();
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Alloment', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Alloment', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure VacateRequestApproved(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No." + ' ' + 'Housing Vacate Request Approved';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that your Housing Vacate Request #' + ' ' + "Application No." + ' ' + 'has been approved.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Vacate Approved', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Vacate', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure VacateRequestRejected(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     CompanyInformationRec: Record "Company Information";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     UserSetupRec.Get(UserId());
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No." + ' ' + 'Housing Vacate Request Rejected';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that your Housing Vacate Request #' + ' ' + "Application No." + ' ' + 'has been rejected.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Please contact the Residential Services team for further details at' + ' ' +
    //                          UserSetupRec."E-Mail" + ' ' + 'or' + ' ' + UserSetupRec."Phone No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Vacate Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Vacate', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;



    // procedure HousingChangeRequestApproved(NewApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     HostelApplication: Record "Housing Application";
    //     RecHousing: Record "Housing Master";
    //     RecRoomMaster: Record "Room Master";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     CompanyInformationRec.Get();
    //     HostelApplication.Get(NewApplicationNo);
    //     RecHousing.Get(HostelApplication."Housing ID");
    //     RecRoomMaster.Get(HostelApplication."Housing ID", HostelApplication."Room No.");
    //     SmtpMailRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No." + ' ' + 'Housing Change Request Approval';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are pleased to inform you that your Housing Change Request #' + ' ' + "Application No."
    //                         + ' ' + 'has been approved. Below are the housing details for this semester:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Housing Property: ' + RecHousing."Housing Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Floor: ' + FORMAT(RecRoomMaster."Floor No."));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Apartment Category: ' + HostelApplication."Room Category Code");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Apartment Number: ' + HostelApplication."Room No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Room Number: ' + HostelApplication."Bed No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please collect your Apartment keys from Residential services office and validate Inventory in your student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     If CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Change Approval', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Change', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure HousingChangeRequestRejected(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin

    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     UserSetupRec.Get(UserId());
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No." + ' ' + 'Housing Change Request Rejected';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that your Housing Vacate Request #' + ' ' + "Application No." + ' ' + 'has been rejected.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('You may contact the Residential Services team for further details at' + ' ' +
    //                          UserSetupRec."E-Mail" + ' ' + 'or' + ' ' + UserSetupRec."Phone No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Change Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Change', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure RegistrationRequestApproved(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     HostelApplication: Record "Housing Application";
    //     RecHousing: Record "Housing Master";
    //     RecRoomMaster: Record "Room Master";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     CompanyInformationRec.Get();
    //     HostelApplication.Get("Original Application No.");
    //     RecHousing.Get(HostelApplication."Housing ID");
    //     RecRoomMaster.Get(HostelApplication."Housing ID", HostelApplication."Room No.");
    //     SmtpMailRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No." + ' ' + 'Housing Re-Registration Request Approved';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are pleased to inform you that your application for Housing Re-Registration #' + ' ' + "Application No."
    //                         + ' ' + 'has been approved, below are the housing details for this semester:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Housing Property: ' + RecHousing."Housing Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Floor: ' + FORMAT(RecRoomMaster."Floor No."));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Apartment Category: ' + HostelApplication."Room Category Code");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Apartment Number: ' + HostelApplication."Room No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Room Number: ' + HostelApplication."Bed No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Same housing details will be updated during Online Registration for the next semester.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Re-Registration Approval', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Re-Registration', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure RegistrationRequestRejected(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No." + ' ' + 'Housing Re-Registration Request Rejected';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that your Re-Registration request has been rejected. Kindly contact the');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('department office for the details and if you can reapply for it.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-mail id.');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Re-Registration Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Re-Registration', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;


    procedure Assistedit(OldHousingChangeRequest: Record "Housing Change Request"): Boolean
    begin
        WITH HousingChangeRequest DO BEGIN
            HousingChangeRequest := Rec;
            // UserSetupRec.Get(UserId());
            // EducationSetupRec.Reset();
            // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            // EducationSetupRec.FindFirst();
            // EducationSetupRec.TESTFIELD("Housing Change/Vacate No.");
            GlSetup.get();
            GlSetup.TestField("Housing Change/Vacate No.");
            IF NoSeriesMgt.SelectSeries(GlSetup."Housing Change/Vacate No.", OldHousingChangeRequest."No.Series", "No.Series")
            THEN BEGIN
                NoSeriesMgt.SetSeries("Application No.");
                Rec := HousingChangeRequest;
                EXIT(TRUE);
            END;
        END;

    End;


}