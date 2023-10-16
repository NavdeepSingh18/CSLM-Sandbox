table 50334 "Housing Application"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Application';
    LookupPageId = "Posted Housing Application";
    DrillDownPageId = "Posted Housing Application";
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
                    GlSetup.Get();
                    NoSeriesMgt.TestManual(GlSetup."Housing Application No.");
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
            var
                RecHousingChangeApp: Record "Housing Change Request";
                RecHousingApplication: Record "Housing Application";
                EducationSetup_lRec: Record "Education Setup-CS";
                HousingMailCod: Codeunit "Hosusing Mail";
                StudentMasterCS: Record "Student Master-CS"; //CS_SG 20230523
            begin
                StudentMasterCS.Get(Rec."Student No."); //CS_SG 20230523
                //StudentMasterCS.TestField(CitizenAntiguaBarbuda, false); //CS_SG 20230523
                if ("Student No." <> xRec."Student No.") AND ("Student No." <> '') then begin
                    RecHousingChangeApp.Reset();
                    RecHousingChangeApp.SetRange("Student No.", "Student No.");
                    RecHousingChangeApp.SetRange(Status, Status::"Pending for Approval");
                    RecHousingChangeApp.SetRange(Type, RecHousingChangeApp.Type::"Change Request");
                    IF not RecHousingChangeApp.findfirst() then begin
                        if StudentRec.Get("Student No.") then;
                        EducationSetup_lRec.Reset();
                        EducationSetup_lRec.Setrange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");          //20Nov2021
                        EducationSetup_lRec.SetRange("Pre Housing App. Allowed", false);
                        If EducationSetup_lRec.FindFirst() then begin
                            RecHousingApplication.Reset();
                            RecHousingApplication.SetFilter("Application No.", '<>%1', "Application No.");
                            RecHousingApplication.SetRange("Student No.", "Student No.");
                            RecHousingApplication.Setfilter(Status, '%1|%2', RecHousingApplication.Status::"Pending for Approval", RecHousingApplication.Status::Approved);
                            IF RecHousingApplication.FindFirst() then
                                Error('Housing Application is already applied');

                            // StudentRec.Get("Student No.");               //19Nov2021
                            // if StudentRec.HostelRoomBedAssigned("Student No.", 2) <> '' then
                            //     Error('Housing is already assigned to Student No. %1', "Student No.");
                        end;
                    end;
                    StudentRec.Reset();
                    if StudentRec.Get("Student No.") then begin
                        "Enrolment No." := StudentRec."Enrollment No.";
                        "Original Student No." := StudentRec."Original Student No.";
                        "Student Name" := StudentRec."Student Name";
                        "Global Dimension 1 Code" := StudentRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentRec."Global Dimension 2 Code";
                        Semester := StudentRec.Semester;
                        "Academic Year" := StudentRec."Academic Year";
                        Term := StudentRec.Term;
                        "Course Code" := StudentRec."Course Code";
                        "Course Name" := StudentRec."Course Name";
                        "Date of Birth" := StudentRec."Date of Birth";
                        "Student ID" := StudentRec."Original Student No.";
                        if StudentRec."Returning Student" and (not (StudentRec."Registrar Signoff")) then begin
                            EducationSetupCS.Reset();
                            EducationSetupCS.SetRange("Global Dimension 1 Code", StudentRec."Global Dimension 1 Code");
                            EducationSetupCS.SetRange("Pre Housing App. Allowed", false);        //22Dec2021
                            if EducationSetupCS.FindFirst() then begin
                                OLRUpdateLine.Reset();
                                OLRUpdateLine.SetRange("Student No.", StudentRec."No.");
                                OLRUpdateLine.SetRange("OLR Academic Year", EducationSetupCS."Returning OLR Academic Year");
                                OLRUpdateLine.SetRange("OLR Term", EducationSetupCS."Returning OLR Term");
                                OLRUpdateLine.SetRange(Confirmed, true);
                                OLRUpdateLine.FindFirst();
                                "Academic Year" := OLRUpdateLine."OLR Academic Year";
                                Term := OLRUpdateLine."OLR Term";
                                Semester := OLRUpdateLine."OLR Semester";
                            end;
                        end;

                        validate(Gender, StudentRec.Gender);
                        CustLedgerEntryRec.Reset();
                        CustLedgerEntryRec.SETRANGE(CustLedgerEntryRec."Document Type", CustLedgerEntryRec."Document Type"::Payment);
                        CustLedgerEntryRec.SetRange("Customer No.", StudentRec."Original Student No.");
                        CustLedgerEntryRec.SetRange("Enrollment No.", StudentRec."Enrollment No.");
                        CustLedgerEntryRec.SetRange("Deposit Type", CustLedgerEntryRec."Deposit Type"::"Housing Deposit");
                        CustLedgerEntryRec.SetRange(Reversed, false);
                        if CustLedgerEntryRec.FindFirst() then begin
                            CustLedgerEntryRec.CalcFields(CustLedgerEntryRec.Amount);
                            "Deposit Amount" := ABS(CustLedgerEntryRec.Amount);
                        end;
                    end;



                    // HousingApplicationRec.Reset();
                    // HousingApplicationRec.SetRange("Student No.", "Student No.");
                    // if HousingApplicationRec.IsEmpty() then
                    //     HousingStudentInformation("Student No.");

                    HousingApplicationRec.Reset();
                    HousingApplicationRec.SetRange("Student No.", "Student No.");
                    HousingApplicationRec.SetRange(Posted, true);
                    If HousingApplicationRec.FindLast() then begin
                        if HousingApplicationRec."Applied to Continue" then begin
                            if CONFIRM(Text001Lbl, true) then begin
                                if HousingMasterBlock(HousingApplicationRec."Housing Pref. 1") = false then begin
                                    Validate("Housing Pref. 1", HousingApplicationRec."Housing Pref. 1");
                                    "Housing Group Pref.1" := HousingApplicationRec."Housing Group Pref.1";
                                    "Room Category Pref.1" := HousingApplicationRec."Room Category Pref.1";
                                    Validate("Pref. 1 Selected", HousingApplicationRec."Pref. 1 Selected");
                                end;

                                if HousingMasterBlock(HousingApplicationRec."Housing Pref. 2") = false then begin
                                    Validate("Housing Pref. 2", HousingApplicationRec."Housing Pref. 2");
                                    "Housing Group Pref.2" := HousingApplicationRec."Housing Group Pref.2";
                                    "Room Category Pref.2" := HousingApplicationRec."Room Category Pref.2";
                                    Validate("Pref. 2 Selected", HousingApplicationRec."Pref. 2 Selected");
                                end;

                                if HousingMasterBlock(HousingApplicationRec."Housing Pref. 3") = false then begin
                                    Validate("Housing Pref. 3", HousingApplicationRec."Housing Pref. 3");
                                    "Housing Group Pref.3" := HousingApplicationRec."Housing Group Pref.3";
                                    "Room Category Pref.3" := HousingApplicationRec."Room Category Pref.3";
                                    Validate("Pref. 3 Selected", HousingApplicationRec."Pref. 3 Selected");
                                end;
                                if RoomMasterBlock(HousingApplicationRec."Room No.") = False then
                                    "Room No." := HousingApplicationRec."Room No.";
                                BedMasterBlock(HousingApplicationRec."Bed No.", BedBool, Avabool);
                                if (BedBool = false) AND (Avabool = true) then begin
                                    HousingApplicationRec1.reset();
                                    HousingApplicationRec1.SetRange(posted, false);
                                    HousingApplicationRec1.SetRange("Bed No.", HousingApplicationRec."Bed No.");
                                    if HousingApplicationRec1.IsEmpty() then
                                        "Bed No." := HousingApplicationRec."Bed No.";
                                end;
                                "Preference Remarks" := HousingApplicationRec."Preference Remarks";
                                "With Spouse" := HousingApplicationRec."With Spouse";
                                "Room Mate Name Pref" := HousingApplicationRec."Room Mate Name Pref";
                                "Room Mate Email Pref" := HousingApplicationRec."Room Mate Email Pref";
                            end;
                        end else
                            HousingStudentInformation("Student No.");
                    end;
                    StartEndDateCreation(Rec, "Student No.", "Academic Year", Term, Semester, "Global Dimension 1 Code");

                    // if ("Entry From Portal" = false) And ("Student No." <> '') then
                    //     HousingMailCod.MailSendforHousingApplicationSubmit("Student No.", "Application No.");
                end else begin
                    "Original Student No." := '';
                    "Enrolment No." := '';
                    "Student Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    Semester := '';
                    "Academic Year" := '';
                    "With Spouse" := false;
                    Term := 0;
                    validate(Gender, Gender::" ");
                    "Date of Birth" := 0D;
                    "Student ID" := '';
                end;
                //HousingMailCod.CheckHousingWaiver(Rec);

            end;
        }
        field(4; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrolment No.';
            Editable = false;

        }
        field(5; "With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'With Spouse';
            trigger OnValidate()
            begin
                "Pref. 1 Selected" := false;
                "Pref. 2 Selected" := false;
                "Pref. 3 Selected" := false;
                "Housing Cost" := 0;
                /*IF "With Spouse" THEN begin
                    IF CONFIRM(Text001Lbl, FALSE) then
                        "Room Category Code" := ''
                    else
                        Error('');
                end;
                end else
                    if Confirm(Text002Lbl, false) then
                        IF StudentMasterRec.Get("Student No.") then
                            "Room Category Code" := StudentMasterRec."Room Category Code"
                        else
                            Error('');*/
            end;

        }
        field(6; "Housing Pref. 1"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 1';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
            trigger OnValidate()
            begin
                "Housing Pref. 1 Name" := '';
                "Pref. 1 Selected" := false;
                "Housing Group Pref.1" := '';
                "Room Category Pref.1" := '';
                "Housing Group" := '';
                "Bed No." := '';
                "Room No." := '';
                "Housing Cost" := 0;

                //  ContractDetailCheck("Housing Pref. 1");

                if RecHousingMaster.Get("Housing Pref. 1") then begin
                    "Housing Pref. 1 Name" := RecHousingMaster."Housing Name";
                    "Housing Group Pref.1" := RecHousingMaster."Housing Group";
                    //SendtoSalesForceAPI();
                end;
            end;
        }
        field(7; "Pref. 1 Selected"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pref. 1 Selected';
            trigger OnValidate()
            begin
                if "Pref. 1 Selected" then begin
                    TestField("Housing Pref. 1");
                    TestField("Housing Group Pref.1");
                    TestField("Room Category Pref.1");
                    TestField("Pref. 2 Selected", false);
                    TestField("Pref. 3 Selected", false);
                    "Bed No." := '';
                    "Room No." := '';
                    //     ContractDetailCheck('');
                    "Housing ID" := "Housing Pref. 1";
                    "Housing Group" := "Housing Group Pref.1";
                    "Room Category Code" := "Room Category Pref.1";
                    RecHousingMaster.get("Housing ID");
                    "Global Dimension 2 Code" := RecHousingMaster."Global Dimension 2 Code";
                    "Housing Cost" := HousingCost("Housing ID", "Room Category Code", "With Spouse");
                end else begin
                    "Bed No." := '';
                    "Room No." := '';
                    //   ContractDetailCheck('');
                    "Housing ID" := '';
                    "Housing Group" := '';
                    "Room Category Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Housing Cost" := 0;
                end;
                GetStudentNo("Housing ID");

            end;
        }
        field(8; "Housing Pref. 2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 2';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
            trigger OnValidate()
            begin
                "Pref. 2 Selected" := false;
                "Housing Pref. 2 Name" := '';
                "Housing Group Pref.2" := '';
                "Housing Group" := '';
                "Bed No." := '';
                "Room No." := '';
                "Housing Cost" := 0;

                //ContractDetailCheck("Housing Pref. 2");

                if RecHousingMaster.Get("Housing Pref. 2") then begin
                    "Housing Pref. 2 Name" := RecHousingMaster."Housing Name";
                    "Housing Group Pref.2" := RecHousingMaster."Housing Group";
                    //SendtoSalesForceAPI();
                end;
            end;
        }
        field(9; "Pref. 2 Selected"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pref. 2 Selected';
            trigger OnValidate()
            begin
                if "Pref. 2 Selected" then begin
                    TestField("Housing Pref. 2");
                    TestField("Housing Group Pref.2");
                    TestField("Room Category Pref.2");
                    TestField("Pref. 1 Selected", false);
                    TestField("Pref. 3 Selected", false);
                    "Bed No." := '';
                    "Room No." := '';
                    //    ContractDetailCheck('');
                    "Housing ID" := "Housing Pref. 2";
                    "Housing Group" := "Housing Group Pref.2";
                    "Room Category Code" := "Room Category Pref.2";
                    RecHousingMaster.get("Housing ID");
                    "Global Dimension 2 Code" := RecHousingMaster."Global Dimension 2 Code";
                    "Housing Cost" := HousingCost("Housing ID", "Room Category Code", "With Spouse");
                end else begin
                    "Bed No." := '';
                    "Room No." := '';
                    //    ContractDetailCheck('');
                    "Housing ID" := '';
                    "Housing Group" := '';
                    "Room Category Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Housing Cost" := 0;
                end;
                GetStudentNo("Housing ID");
            end;

        }
        field(10; "Housing Pref. 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 3';
            TableRelation = "Housing Master"."Housing ID" where(Blocked = const(false));
            trigger OnValidate()
            begin
                "Bed No." := '';
                "Room No." := '';
                "Pref. 3 Selected" := false;
                //    ContractDetailCheck("Housing Pref. 3");

                if RecHousingMaster.Get("Housing Pref. 3") then begin
                    "Housing Pref. 3 Name" := RecHousingMaster."Housing Name";
                    "Housing Group Pref.3" := RecHousingMaster."Housing Group";
                    //SendtoSalesForceAPI();
                end else begin
                    "Housing Pref. 3 Name" := '';
                    "Housing Group" := '';
                end;
                // IF "Housing Pref. 3" <> '' THEN
                //     "Housing ID" := "Housing Pref. 3"
                // else begin
                //     "Housing ID" := '';
                //     "Housing Group Pref.3" := '';
                //     "Room Category Pref.3" := '';
                // end;
                // if Xrec."Housing Pref. 3" <> "Housing Pref. 3" then begin
                //     "Housing ID" := '';
                //     "Housing Group Pref.3" := '';
                //     "Room Category Pref.3" := '';
                // end;


            end;

        }
        field(11; "Pref. 3 Selected"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pref. 3 Selected';
            trigger OnValidate()
            begin
                if "Pref. 3 Selected" then begin
                    TestField("Housing Pref. 3");
                    TestField("Housing Group Pref.3");
                    TestField("Room Category Pref.3");
                    TestField("Pref. 1 Selected", false);
                    TestField("Pref. 2 Selected", false);
                    "Bed No." := '';
                    "Room No." := '';
                    //  ContractDetailCheck('');
                    "Housing ID" := "Housing Pref. 3";
                    "Housing Group" := "Housing Group Pref.3";
                    "Room Category Code" := "Room Category Pref.3";
                    RecHousingMaster.get("Housing ID");
                    "Global Dimension 2 Code" := RecHousingMaster."Global Dimension 2 Code";
                    "Housing Cost" := HousingCost("Housing ID", "Room Category Code", "With Spouse");
                end else begin
                    "Bed No." := '';
                    "Room No." := '';
                    //    ContractDetailCheck('');
                    "Housing ID" := '';
                    "Housing Group" := '';
                    "Room Category Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Housing Cost" := 0;
                end;
                GetStudentNo("Housing ID");
            end;

        }
        field(12; "Room Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Code';
            TableRelation = "Room Category Master"."Room Category Code";
        }

        field(13; "Room No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment No.';
            trigger OnLookup()
            var
                RoomMaster: Record "Room Master";
                RoomMasterTemp: Record "Room Master" temporary;
                Student: Record "Student Master-CS";
                RoomMasterListTemp: Page "Room Master List Temp";

            begin
                Commit();
                Student.Get("Student No.");
                if "Pref. 1 Selected" then
                    Clear(RoomMasterListTemp);
                RoomMaster.Reset();
                if "Pref. 1 Selected" then
                    RoomMaster.SetRange("Housing ID", "Housing Pref. 1")
                else
                    if "Pref. 2 Selected" then
                        RoomMaster.SetRange("Housing ID", "Housing Pref. 2")
                    else
                        if "Pref. 3 Selected" then
                            RoomMaster.SetRange("Housing ID", "Housing Pref. 3")
                        else
                            Error(RoomCatErr);
                RoomMaster.SetRange("Room Category Code", "Room Category Code");
                RoomMaster.SetRange(Blocked, false);
                RoomMaster.SetFilter("Available Beds", '<>%1', 0);
                if RoomMaster.FindSet() then
                    repeat
                        // if RoomMasterListTemp.CheckEligibleRoom(RoomMaster, "With Spouse", Student) then
                        RoomMasterListTemp.addedvaluetoTempRec(RoomMaster);
                    until RoomMaster.Next() = 0;

                RoomMasterListTemp.LookupMode(true);
                if RoomMasterListTemp.RunModal() = Action::LookupOK then begin
                    RoomMasterListTemp.GetRecord(RoomMasterTemp);
                    "Room No." := RoomMasterTemp."Room No.";
                    "Bed No." := '';
                end;
                StartEndDateCreation(Rec, "Student No.", "Academic Year", Term, Semester, "Global Dimension 1 Code");
            end;

            trigger OnValidate()
            begin
                if Rec."Room No." <> '' then
                    Error('Use Lookup to select the Apartment No.');

            end;
        }
        field(14; "Bed No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Room No.';
            TableRelation = "Room Wise Bed"."Bed No." where("Housing ID" = field("Housing ID"), "Room No." = field("Room No."), Available = const(true), Blocked = const(false));
            trigger OnValidate()
            Var
                RoomWiseBedRec: Record "Room Wise Bed";
            begin
                RoomWiseBedRec.Reset();
                RoomWiseBedRec.SetRange("Bed No.", "Bed No.");
                if RoomWiseBedRec.FindFirst() then
                    "Bed Size" := RoomWiseBedRec."Bed Size"
                else
                    "Bed Size" := '';
            end;
        }
        field(15; "Preference Remarks"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Special Accomodations';

        }
        field(16; "Ledger Entry No."; Integer)
        {
            Caption = 'Ledger Entry No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Housing Ledger"."Entry No." where("Original Application No." = field("Application No.")));
            Editable = false;

        }
        field(17; "Created By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(18; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
            Editable = false;

        }
        field(19; "Modified By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        field(20; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = false;

        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(23; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted';
            Editable = false;

        }
        field(24; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;

        }
        field(25; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;

        }
        field(26; "Entry From Portal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry From Portal';
            Editable = false;

        }
        field(27; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Insert';
            Editable = false;

        }
        field(28; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = false;

        }
        field(29; "Requested Application No."; Code[20])
        {
            Caption = 'Requested Application No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Housing Change Request"."Application No." where("Original Application No." = field("Application No.")));
            Editable = false;

        }
        field(30; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Pending for Approval,Approved,Cancelled,Vacated,Assigned';
            OptionMembers = "Pending for Approval",Approved,Rejected,Vacated,Assigned;
            Editable = false;
        }
        field(31; "Inventory Verified"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Verified';
            trigger OnValidate()
            begin
                StudentRoomWiseInventory.Reset();
                StudentRoomWiseInventory.SetRange("Application No.", "Application No.");
                StudentRoomWiseInventory.SetRange("Student No.", "Student No.");
                StudentRoomWiseInventory.SetRange("Quantity Verified Alloment", false);
                IF StudentRoomWiseInventory.FindFirst() then
                    Error('Please Check, Room Inventory is not verified')
                else begin
                    HostelLedger.Reset();
                    HostelLedger.SetRange("Application No.", "Application No.");
                    HostelLedger.SetRange("Student No.", "Student No.");
                    IF HostelLedger.FindSet() then
                        HostelLedger.ModifyAll("Inventory Verified", true)
                    else
                        HostelLedger.ModifyAll("Inventory Verified", false);
                end;

            end;

        }
        field(32; "Rejection Reason Code"; Code[20])
        {
            Caption = 'Rejection Reason Code';
            TableRelation = "Reason Code".Code where(Type = filter(Housing));
            trigger OnValidate()
            var
                ReasonCode: Record "Reason Code";
            begin
                ReasonCode.Reset();
                ReasonCode.SetRange(Code, "Rejection Reason Code");
                if ReasonCode.FindFirst() then
                    "Rejection Description" := ReasonCode.Description
                else
                    "Rejection Description" := '';
            end;
        }
        field(33; "No.Series"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.Series';
            TableRelation = "No. Series";

        }
        field(34; "Room Category Pref.1"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Pref.1';
            // TableRelation = IF ("With Spouse" = Const(true)) "Room Category Master"."Room Category Code" where("Maximum No. of Bed" = filter(> 1))
            // else
            // IF ("With Spouse" = Const(false)) "Room Category Master"."Room Category Code" where("With Spouse" = const(false));
            trigger OnLookup()
            var
                RoomMasterRec: Record "Room Master";
            begin
                RoomMasterRec.Reset();
                RoomMasterRec.SetRange("Housing ID", "Housing Pref. 1");
                if "With Spouse" then
                    RoomMasterRec.SetFilter("Available Beds", '>%1', 1)
                else
                    RoomMasterRec.SetFilter("Available Beds", '>%1', 0);
                // IF PAGE.RUNMODAL(Page::"Housing Wise Categorgy List", RoomMasterRec) = ACTION::LookupOK THEN BEGIN
                //     "Room Category Pref.1" := RoomMasterRec."Room Category Code";
                //     Commit();
                //     "Pref. 1 Selected" := false;
                //     "Housing Cost" := 0;
                //     //SendtoSalesForceAPI();
                // end;
            end;

            trigger OnValidate()
            begin
                if "Room Category Pref.1" <> '' then
                    "Room Category Code" := "Room Category Pref.1"
                else
                    "Room Category Code" := '';

                "Pref. 1 Selected" := false;
                "Housing Cost" := 0;
                //SendtoSalesForceAPI();

            end;



        }
        field(35; "Room Category Pref.2"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Pref.2';
            // TableRelation = IF ("With Spouse" = Const(true)) "Room Category Master"."Room Category Code" where("Maximum No. of Bed" = filter(> 1))
            // else
            // IF ("With Spouse" = Const(false)) "Room Category Master"."Room Category Code" where("With Spouse" = const(false));
            trigger OnLookup()
            var
                RoomMasterRec: Record "Room Master";
            begin
                RoomMasterRec.Reset();
                RoomMasterRec.SetRange("Housing ID", "Housing Pref. 2");
                if "With Spouse" then
                    RoomMasterRec.SetFilter("Available Beds", '>%1', 1)
                else
                    RoomMasterRec.SetFilter("Available Beds", '>%1', 0);
                // IF PAGE.RUNMODAL(Page::"Housing Wise Categorgy List", RoomMasterRec) = ACTION::LookupOK THEN BEGIN
                //     "Room Category Pref.2" := RoomMasterRec."Room Category Code";
                //     //SendtoSalesForceAPI();
                // end;


            end;

            trigger OnValidate()
            begin
                if "Room Category Pref.2" <> '' then
                    "Room Category Code" := "Room Category Pref.2"
                else
                    "Room Category Code" := '';

                "Pref. 2 Selected" := false;
                "Housing Cost" := 0;
                //SendtoSalesForceAPI();

            end;
        }
        field(36; "Room Category Pref.3"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Apartment Category Pref.3';
            // TableRelation = IF ("With Spouse" = Const(true)) "Room Category Master"."Room Category Code" where("Maximum No. of Bed" = filter(> 1))
            // else
            // IF ("With Spouse" = Const(false)) "Room Category Master"."Room Category Code" where("With Spouse" = const(false));
            // trigger OnLookup()
            // var
            //     RoomMasterRec: Record "Room Master";
            // begin
            //     RoomMasterRec.Reset();
            //     RoomMasterRec.SetRange("Housing ID", "Housing Pref. 3");
            //     if "With Spouse" then
            //         RoomMasterRec.SetFilter("Available Beds", '>%1', 1)
            //     else
            //         RoomMasterRec.SetFilter("Available Beds", '>%1', 0);
            //     if RoomMasterRec.FindSet() then
            //         // IF PAGE.RUNMODAL(Page::"Housing Wise Categorgy List", RoomMasterRec) = ACTION::LookupOK THEN BEGIN
            //         //     "Room Category Pref.3" := RoomMasterRec."Room Category Code";
            //         //     //SendtoSalesForceAPI();
            //         // end;


            // end;

            // trigger OnValidate()
            // begin
            //     if "Room Category Pref.3" <> '' then
            //         "Room Category Code" := "Room Category Pref.3"
            //     else
            //         "Room Category Code" := '';

            //     "Pref. 3 Selected" := false;
            //     "Housing Cost" := 0;
            //     //SendtoSalesForceAPI();
            // end;
        }
        field(37; "Housing Group Pref.1"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
            Caption = 'Housing Group Pref.1';
            Editable = false;
            trigger OnValidate()
            begin
                if "Housing Group Pref.1" <> '' then
                    "Housing Group" := "Housing Group Pref.1"
                else
                    "Housing Group" := '';

                //SendtoSalesForceAPI();
            end;

        }
        field(38; "Housing Group Pref.2"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
            Caption = 'Housing Group Pref.2';
            Editable = false;
            trigger OnValidate()
            begin
                if "Housing Group Pref.2" <> '' then
                    "Housing Group" := "Housing Group Pref.2"
                else
                    "Housing Group" := '';

                //SendtoSalesForceAPI();
            end;

        }
        field(39; "Housing Group Pref.3"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Housing Group";
            Editable = false;
            Caption = 'Housing Group Pref.3';
            trigger OnValidate()
            begin
                if "Housing Group Pref.3" <> '' then
                    "Housing Group" := "Housing Group Pref.3"
                else
                    "Housing Group" := '';

                //SendtoSalesForceAPI();
            end;

        }
        field(40; "Housing Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Group';
        }
        field(41; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing ID';
            TableRelation = "Housing Master";
        }
        field(42; "Applied to Continue"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Applied to Continue';
            Editable = False;
        }
        field(43; "Accepted for Previous Housing"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Accepted for Previous Housing';
            Editable = False;
        }
        field(44; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = False;
        }
        field(45; Semester; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            Editable = false;
        }
        field(46; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            Editable = false;

        }
        field(47; "Rejection Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Rejection Description';
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
        field(54; "Housing Pref. 1 Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 1 Name';
            Editable = false;
        }
        field(55; "Housing Pref. 2 Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 2 Name';
            Editable = false;
        }
        field(56; "Housing Pref. 3 Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Pref. 3 Name';
            Editable = false;
        }
        field(57; "Entry From Change"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry From Change';
            Editable = false;

        }
        field(58; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;

        }
        field(59; "Housing Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            // Editable = false;
            Trigger OnValidate()
            var
                UserSetup_lRec: Record "User Setup";
                HousingLedger_lRec: Record "Housing Ledger";
                ApartmentCategoryFeeSetup: Record "Room Category Fee Setup";
                StudentTimeline: Record "Student Time Line";
            begin
                If Rec."Housing Cost" <> 0 then begin
                    ApartmentCategoryFeeSetup.Reset();
                    ApartmentCategoryFeeSetup.SetRange("Housing ID", Rec."Housing ID");
                    ApartmentCategoryFeeSetup.SetRange("Room Category Code", Rec."Room Category Code");
                    ApartmentCategoryFeeSetup.SetRange(Cost, Rec."Housing Cost");
                    ApartmentCategoryFeeSetup.FindFirst();

                    If Status = Status::"Pending for Approval" then begin
                        If xRec."Housing Cost" <> 0 then
                            If Rec."Housing Cost" <> xRec."Housing Cost" then begin
                                "Old Housing Cost" := xRec."Housing Cost";
                                StudentTimeline.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Housing Cost has been changed from ' + Format(xRec."Housing Cost") + ' to ' + Format(Rec."Housing Cost"), UserId(), Today());
                            end;
                    end;

                    If Status = Status::Approved then begin
                        UserSetup_lRec.Reset();
                        UserSetup_lRec.SetRange("User ID", UserId());
                        If UserSetup_lRec.FindFirst() then
                            If not UserSetup_lRec."Housing Cost Permission" then
                                Error('You do not have permission to change Housing Cost.');

                        HousingLedger_lRec.Reset();
                        HousingLedger_lRec.SetRange("Application No.", Rec."Application No.");
                        HousingLedger_lRec.SetRange(Status, HousingLedger_lRec.Status::Assigned);
                        If HousingLedger_lRec.FindSet() then begin
                            repeat
                                HousingLedger_lRec."Housing Cost" := Rec."Housing Cost";
                                HousingLedger_lRec.Modify();
                            until HousingLedger_lRec.Next() = 0;
                        end;
                        If xRec."Housing Cost" <> 0 then
                            If Rec."Housing Cost" <> xRec."Housing Cost" then begin
                                "Old Housing Cost" := xRec."Housing Cost";
                                StudentTimeline.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Housing Cost has been changed from ' + Format(xRec."Housing Cost") + ' to ' + Format(Rec."Housing Cost"), UserId(), Today());
                            end;
                    end;
                end else begin
                    ApartmentCategoryFeeSetup.Reset();
                    ApartmentCategoryFeeSetup.SetRange("Housing ID", Rec."Housing ID");
                    ApartmentCategoryFeeSetup.SetRange("Room Category Code", Rec."Room Category Code");
                    ApartmentCategoryFeeSetup.SetRange(Cost, Rec."Housing Cost");
                    ApartmentCategoryFeeSetup.FindFirst();

                    If Status = Status::"Pending for Approval" then begin
                        If xRec."Housing Cost" <> 0 then
                            If Rec."Housing Cost" <> xRec."Housing Cost" then begin
                                "Old Housing Cost" := xRec."Housing Cost";
                                StudentTimeline.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Housing Cost has been changed from ' + Format(xRec."Housing Cost") + ' to ' + Format(Rec."Housing Cost"), UserId(), Today());
                            end;
                    end;

                    If Status = Status::Approved then begin
                        UserSetup_lRec.Reset();
                        UserSetup_lRec.SetRange("User ID", UserId());
                        If UserSetup_lRec.FindFirst() then
                            If not UserSetup_lRec."Housing Cost Permission" then
                                Error('You do not have permission to change Housing Cost.');

                        HousingLedger_lRec.Reset();
                        HousingLedger_lRec.SetRange("Application No.", Rec."Application No.");
                        HousingLedger_lRec.SetRange(Status, HousingLedger_lRec.Status::Assigned);
                        If HousingLedger_lRec.FindSet() then begin
                            repeat
                                HousingLedger_lRec."Housing Cost" := Rec."Housing Cost";
                                HousingLedger_lRec.Modify();
                            until HousingLedger_lRec.Next() = 0;
                        end;
                        If xRec."Housing Cost" <> 0 then
                            If Rec."Housing Cost" <> xRec."Housing Cost" then begin
                                "Old Housing Cost" := xRec."Housing Cost";
                                StudentTimeline.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Housing Cost has been changed from ' + Format(xRec."Housing Cost") + ' to ' + Format(Rec."Housing Cost"), UserId(), Today());
                            end;
                    end;
                end;
            end;

        }
        field(60; "Room Mate Name Pref"; Text[50])
        {
            Caption = 'Apartment Mate Name Pref';
            DataClassification = CustomerContent;
        }
        field(61; "Room Mate Email Pref"; Text[80])
        {
            Caption = 'Apartment Mate Email Pref';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(62; "Inserted In SalesForce"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(63; "Insert Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(64; "Update Sync"; Integer)
        {
            DataClassification = CustomerContent;
            MaxValue = 99;
            MinValue = 0;
            Editable = false;
        }
        field(65; "Entry From Salesforce"; Boolean)
        {
            Caption = 'Entry From Salesforce';
            DataClassification = CustomerContent;
        }
        field(66; "Lease Status Code"; code[20])
        {
            Caption = 'Lease Status Code';
            DataClassification = CustomerContent;
        }
        field(67; "Bill Code"; code[20])
        {
            Caption = 'Bill Code';
            DataClassification = CustomerContent;
        }
        field(68; Gender; Option)
        {
            OptionMembers = " ",Female,Male,"Not Specified";
            OptionCaption = ' ,Female,Male,Not Specified';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Gender = Gender::" " then
                    "Gender Text" := '';

                if Gender = Gender::Female then
                    "Gender Text" := 'Female';

                if Gender = Gender::Male then
                    "Gender Text" := 'Male';

                if Gender = Gender::"Not Specified" then
                    "Gender Text" := 'Not Specified';
            end;
        }
        field(69; "Gender Text"; Text[15])
        {
            DataClassification = CustomerContent;
        }
        field(70; "Bed Size"; text[50])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(71; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(72; "Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';
            Editable = false;

        }
        Field(73; "Flight Arrival Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        Field(74; "Flight Arrival Time"; Time)
        {
            DataClassification = CustomerContent;

        }
        Field(75; "Flight Number"; Text[20])
        {
            DataClassification = CustomerContent;

        }
        Field(76; "Airline/Carrier"; Text[100])
        {
            DataClassification = CustomerContent;

        }
        Field(77; "Departure Date from Antigua"; Date)
        {
            DataClassification = CustomerContent;

        }
        Field(78; "Housing Deposit Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        Field(79; "On Hold"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;

        }

        Field(80; "Temporary Housing Name"; text[100])
        {
            Caption = 'Upcoming Housing Name';
            // FieldClass = FlowField;
            // CalcFormula = lookup("Student Master-CS"."Temporary Housing Name" where("No." = field("Student No.")));
            DataClassification = CustomerContent;
        }
        Field(81; "Temporary Room No."; Code[20])
        {
            Caption = 'Upcoming Room No';
            // FieldClass = FlowField;
            // CalcFormula = lookup("Student Master-CS"."Temporary Room No." where("No." = field("Student No.")));
            DataClassification = CustomerContent;
        }
        Field(82; "Temporary Apartment No."; Code[20])
        {
            Caption = 'Upcoming Apartment No';
            // FieldClass = FlowField;
            // CalcFormula = lookup("Student Master-CS"."Temporary Apartment No." where("No." = field("Student No.")));
            DataClassification = CustomerContent;
        }
        Field(83; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(84; "Student ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;

        }
        Field(85; "1st Time Island"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(86; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        Field(87; "Course Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(88; "Student Status"; Code[20])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("No." = field("Student No.")));
        }
        field(89; "Old Housing Cost"; Decimal)
        {
            Editable = false;
        }
        field(90; "Medical Condition"; Boolean)//GMCS//240523//FALL 2023 OLR Changes
        {
            DataClassification = CustomerContent;
        }
        field(91; Disability; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(92; "Traveling With Spouse"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(93; "Travel Spouse & Child"; Boolean)
        {
            Caption = 'Traveling with spouse and children';
            DataClassification = CustomerContent;
        }
        field(94; "Travel Ser. Animal"; Boolean)
        {
            Caption = 'Traveling with Service Animal';
            DataClassification = CustomerContent;
        }
        field(95; Other; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(96; "Other Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(97; "Special Roommate Preference"; Text[1024])
        {
            DataClassification = CustomerContent;//GMCS//240523//FALL 2023 OLR Changes
        }
    }

    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(Key2; "Created On")
        {
        }
        Key(Key3; "Application Date")
        { }
    }

    var
        EducationSetupRec: Record "Education Setup-CS";
        UserSetupRec: Record "User Setup";
        CompanyInformationRec: Record "Company Information";
        StudentMasterRec: Record "Student Master-CS";
        StudentRoomWiseInventory: Record "Student Room Wise Inventory";
        HostelLedger: Record "Housing Ledger";
        HostelLedgerRec: Record "Housing Ledger";
        CustLedgerEntryRec: Record "Cust. Ledger Entry";
        HousingInventoryAllocationRec: Record "Housing Inventory Allocation";
        HousingInventoryAllocationRec1: Record "Housing Inventory Allocation";
        StudentRoomWiseInventoryRec: Record "Student Room Wise Inventory";
        StudentRec: Record "Student Master-CS";
        RoomWiseBedRec: Record "Room Wise Bed";
        HostelApplication: Record "Housing Application";
        EducationSetupCS: Record "Education Setup-CS";
        OLRUpdateLine: Record "OLR Update Line";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        HousingApplicationRec: Record "Housing Application";
        HousingApplicationRec1: Record "Housing Application";
        RecHousingMaster: Record "Housing Master";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        RecCodeUnit50037: Codeunit "Hosusing Mail";
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
        LastNo: Integer;

        BedBool: Boolean;
        AvaBool: Boolean;

        LeaseStartDate: Date;
        LeaseEndDate: Date;
        ContractNo: Code[20];
        RoomCatErr: Label 'Apartment Category must be selected';
        Text001Lbl: Label 'This application is in continuation with previous housing alloment, do you want to continue with the same housing preferences?';

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := TODAY();
        Inserted := true;
        "Application Date" := WORKDATE();
        // UserSetupRec.Get(UserId());
        // EducationSetupRec.Reset();
        // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        GlSetup.get();
        IF "Application No." = '' THEN BEGIN
            GlSetup.TESTFIELD("Housing Application No.");
            NoSeriesMgt.InitSeries(GlSetup."Housing Application No.", xRec."No.Series", 0D, "Application No.", "No.Series");
        end;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := TODAY();
        Updated := true;

        if "Housing Deposit Date" = 0D then begin
            StudentMasterRec.Reset();
            StudentMasterRec.SetRange("No.", "Student No.");
            if StudentMasterRec.FindFirst() then
                "Housing Deposit Date" := StudentMasterRec."Housing Deposit Date";
        end;

        CustLedgerEntryRec.Reset();
        CustLedgerEntryRec.SETRANGE(CustLedgerEntryRec."Document Type", CustLedgerEntryRec."Document Type"::Payment);
        CustLedgerEntryRec.SetRange("Customer No.", StudentRec."Original Student No.");
        CustLedgerEntryRec.SetRange("Enrollment No.", StudentRec."Enrollment No.");
        CustLedgerEntryRec.SetRange("Deposit Type", CustLedgerEntryRec."Deposit Type"::"Housing Deposit");
        CustLedgerEntryRec.SetRange(Reversed, false);
        if CustLedgerEntryRec.FindFirst() then begin
            CustLedgerEntryRec.CalcFields(CustLedgerEntryRec.Amount);
            "Deposit Amount" := ABS(CustLedgerEntryRec.Amount);
        end;

    end;

    procedure PostApplication(ApplicationNo: Code[20]; ChangeReqAppNo: Code[20])
    var
        HousingMaster: Record "Housing Master";
        RecStudentWiseHold: Record "Student Wise Holds";
        StudentHoldRec: Record "Student Hold";
        BedCount: Integer;
    begin
        HostelApplication.Get(ApplicationNo);
        HostelApplication.TestField("Student No.");
        HostelApplication.TestField("Enrolment No.");
        HostelApplication.TestField("Room Category Code");
        HostelApplication.TestField("Room No.");
        HostelApplication.TestField("Bed No.");
        // HostelApplication.TestField(Status, Status::Approved);
        PostStudentRoomWiseInventoryInit(HostelApplication); //CSPL-00307-T1-T1236 - Replace Variable HostelApplication from Rec 
        BedCount := 0;
        IF HostelApplication."With Spouse" = true then begin
            RoomWiseBedRec.Reset();
            RoomWiseBedRec.setrange("Housing ID", HostelApplication."Housing ID");
            RoomWiseBedRec.SetRange("Room No.", HostelApplication."Room No.");
            RoomWiseBedRec.Setfilter(Available, '%1', true);
            if RoomWiseBedRec.FindSet() then begin
                repeat
                    BedCount := BedCount + 1;
                    HostelLedgerRec.Reset();
                    if HostelLedgerRec.FINDLAST() then
                        LastNo := HostelLedgerRec."Entry No." + 1
                    else
                        LastNo := 1;

                    HostelLedgerRec.Init();
                    HostelLedgerRec."Entry No." := LastNo;
                    if ChangeReqAppNo <> '' then begin
                        HostelLedgerRec."Application No." := ChangeReqAppNo;
                        HostelLedgerRec.Type := HostelLedgerRec.Type::"Change Request";
                    end
                    else begin
                        HostelLedgerRec."Application No." := ApplicationNo;
                        HostelLedgerRec.Type := HostelLedgerRec.Type::" ";
                    end;
                    HostelLedgerRec."Original Application No." := ApplicationNo;
                    HostelLedgerRec.Status := HostelLedgerRec.Status::Assigned;
                    if HostelApplication."Pref. 1 Selected" then
                        HostelLedgerRec."Housing ID" := HostelApplication."Housing Pref. 1";
                    if HostelApplication."Pref. 2 Selected" then
                        HostelLedgerRec."Housing ID" := HostelApplication."Housing Pref. 2";
                    if HostelApplication."Pref. 3 Selected" then
                        HostelLedgerRec."Housing ID" := HostelApplication."Housing Pref. 3";

                    HousingMaster.ContractDetail(HostelLedgerRec."Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
                    HostelLedgerRec."Contract No." := ContractNo;
                    HostelLedgerRec."Housing Group" := HostelApplication."Housing Group";
                    HostelLedgerRec."Room Category Code" := HostelApplication."Room Category Code";
                    HostelLedgerRec."Room No." := RoomWiseBedRec."Room No.";
                    HostelLedgerRec."Bed No." := RoomWiseBedRec."Bed No.";
                    HostelLedgerRec."Bed Size" := RoomWiseBedRec."Bed Size";
                    HostelLedgerRec."Student No." := HostelApplication."Student No.";
                    // if StudentRec.GET(HostelApplication."Student No.") then begin
                    //     //HostelLedgerRec."Academic Year" := StudentRec."Academic Year";
                    //     HostelLedgerRec.Semester := StudentRec.Semester;
                    // end;


                    if BedCount > 1 then
                        HostelLedger."Spouse Entry" := true;

                    HostelLedger."With Spouse" := HostelApplication."With Spouse";
                    HostelLedgerRec."Enrolment No." := HostelApplication."Enrolment No.";
                    HostelLedgerRec."Student Name" := HostelApplication."Student Name";
                    HostelLedgerRec."Room Assignment" := 1;
                    HostelLedgerRec."Global Dimension 1 Code" := HostelApplication."Global Dimension 1 Code";
                    HostelLedgerRec."Global Dimension 2 Code" := HostelApplication."Global Dimension 2 Code";
                    HostelLedgerRec."Housing Allotted Start Date" := HostelApplication."Start Date";
                    HostelLedgerRec."Housing Alloted End Date" := HostelApplication."End Date";
                    HostelLedgerRec."Housing Cost" := HostelApplication."Housing Cost";
                    HostelLedgerRec."Posting Date" := WORKDATE();
                    HostelLedgerRec."Room Mate Name Pref" := HostelApplication."Room Mate Name Pref";
                    HostelLedgerRec."Room Mate Email Pref" := HostelApplication."Room Mate Email Pref";
                    HostelLedgerRec."Academic Year" := HostelApplication."Academic Year";
                    HostelLedgerRec.Term := HostelApplication.Term;
                    HostelLedgerRec.Semester := HostelApplication.Semester;
                    HostelLedgerRec."1st Time Island" := HostelApplication."1st Time Island";
                    HostelLedgerRec.Insert(true);

                    RoomWiseBedRec.Available := False;
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
            if ChangeReqAppNo <> '' then begin
                HostelLedgerRec."Application No." := ChangeReqAppNo;
                HostelLedgerRec.Type := HostelLedgerRec.Type::"Change Request";
            end
            else begin
                HostelLedgerRec."Application No." := ApplicationNo;
                HostelLedgerRec.Type := HostelLedgerRec.Type::" ";
            end;
            HostelLedgerRec."Original Application No." := ApplicationNo;
            HostelLedgerRec.Status := HostelLedgerRec.Status::Assigned;
            if HostelApplication."Pref. 1 Selected" then
                HostelLedgerRec."Housing ID" := HostelApplication."Housing Pref. 1";
            if HostelApplication."Pref. 2 Selected" then
                HostelLedgerRec."Housing ID" := HostelApplication."Housing Pref. 2";
            if HostelApplication."Pref. 3 Selected" then
                HostelLedgerRec."Housing ID" := HostelApplication."Housing Pref. 3";

            HousingMaster.ContractDetail(HostelLedgerRec."Housing ID", LeaseStartDate, LeaseEndDate, ContractNo);
            HostelLedgerRec."Contract No." := ContractNo;
            HostelLedgerRec."Housing Group" := HostelApplication."Housing Group";
            HostelLedgerRec."Room Category Code" := HostelApplication."Room Category Code";

            HostelLedgerRec."Room No." := HostelApplication."Room No.";
            HostelLedgerRec."Bed No." := HostelApplication."Bed No.";
            HostelLedgerRec."Bed Size" := RoomWiseBedRec."Bed Size";
            HostelLedgerRec."Student No." := HostelApplication."Student No.";
            // if StudentRec.GET(HostelApplication."Student No.") then begin
            //     //HostelLedgerRec."Academic Year" := StudentRec."Academic Year";
            //     HostelLedgerRec.Semester := StudentRec.Semester;
            // end;
            HostelLedgerRec."Enrolment No." := HostelApplication."Enrolment No.";
            HostelLedgerRec."Student Name" := HostelApplication."Student Name";
            HostelLedgerRec."Room Assignment" := 1;
            HostelLedgerRec."Global Dimension 1 Code" := HostelApplication."Global Dimension 1 Code";
            HostelLedgerRec."Global Dimension 2 Code" := HostelApplication."Global Dimension 2 Code";
            HostelLedgerRec."Housing Allotted Start Date" := HostelApplication."Start Date";
            HostelLedgerRec."Housing Alloted End Date" := HostelApplication."End Date";

            HostelLedgerRec."Housing Cost" := HostelApplication."Housing Cost";
            HostelLedgerRec."Posting Date" := WORKDATE();
            HostelLedgerRec."Academic Year" := HostelApplication."Academic Year";
            HostelLedgerRec.Term := HostelApplication.Term;
            HostelLedgerRec.Semester := HostelApplication.Semester;
            HostelLedgerRec."1st Time Island" := HostelApplication."1st Time Island";
            HostelLedgerRec.Insert(true);
            RoomWiseBedRec.Reset();
            RoomWiseBedRec.SetRange("Housing ID", HostelApplication."Housing ID");
            RoomWiseBedRec.SetRange("Room No.", HostelApplication."Room No.");
            RoomWiseBedRec.SetRange("Bed No.", HostelApplication."Bed No.");
            if RoomWiseBedRec.FINDFIRST() then begin
                RoomWiseBedRec.Available := False;
                RoomWiseBedRec.Modify();
            end;

        end;
        // HostelApplication.Status := HostelApplication.Status::Approved;
        // HostelApplication.Posted := true;
        // HostelApplication.Modify();



        StudentHoldRec.Reset();
        StudentHoldRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        StudentHoldRec.SetRange("Hold Type", StudentHoldRec."Hold Type"::Housing);
        if StudentHoldRec.FindFirst() then;

        RecStudentWiseHold.Reset();
        RecStudentWiseHold.SetRange("Student No.", "Student No.");
        // RecStudentWiseHold.SetRange("Academic Year", StudentRec."Academic Year");
        // RecStudentWiseHold.SetRange(Semester, StudentRec.Semester);
        RecStudentWiseHold.SetRange("Hold Type", RecStudentWiseHold."Hold Type"::Housing);
        IF RecStudentWiseHold.FindFirst() then begin
            RecStudentWiseHold.validate(Status, RecStudentWiseHold.Status::Disable);
            RecStudentWiseHold."Hold Description" := StudentHoldRec."Signoff Description";
            IF RecStudentWiseHold.Modify() then begin
                RecCodeUnit50037.HoldStatusLedgerEntryInsert("Student No.", RecStudentWiseHold."Hold Code",
                RecStudentWiseHold."Hold Description", RecStudentWiseHold."Hold Type"::Housing, RecStudentWiseHold.Status::Disable);
                // RecHoldStatusLedger.Reset();
                // RecHoldStatusLedger.SetRange("Student No.", "Student No.");
                // RecHoldStatusLedger.SetRange("Academic Year", StudentRec."Academic Year");
                // RecHoldStatusLedger.SetRange(Semester, StudentRec.Semester);
                // RecHoldStatusLedger.SetRange("Hold Type", RecHoldStatusLedger."Hold Type"::" ");
                // IF RecHoldStatusLedger.FindFirst() then begin
                //     RecHoldStatusLedger."Table Caption" := TableName();
                //     RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::Housing;
                //     RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
                //     RecHoldStatusLedger.Modify();
                // end;
            end;
        end;
    end;

    procedure PostStudentRoomWiseInventoryInit(HostelApplication: Record "Housing Application")
    var
    begin
        // StudentRoomWiseInventoryRec.Init(); //CSPL-00307-T1-T1236
        HousingInventoryAllocationRec1.Reset();
        HousingInventoryAllocationRec1.SetRange("Housing ID", HostelApplication."Housing ID");
        HousingInventoryAllocationRec1.SetRange("Room No.", HostelApplication."Room No.");
        HousingInventoryAllocationRec1.SetFilter(Qunatity, '>%1', 0);
        if not HousingInventoryAllocationRec1.findfirst() then
            //     If CONFIRM('There is no Inventory mapped with this Apartment, Do you still want to continue?', false) then
            // end else
            //         Exit;
            Error('There is no inventory available for Apartment no. : %1', HostelApplication."Room No.");

        HousingInventoryAllocationRec.Reset();
        if HostelApplication."Pref. 1 Selected" then
            HousingInventoryAllocationRec.SetRange("Housing ID", HostelApplication."Housing Pref. 1");
        if HostelApplication."Pref. 2 Selected" then
            HousingInventoryAllocationRec.SetRange("Housing ID", HostelApplication."Housing Pref. 2");
        if HostelApplication."Pref. 3 Selected" then
            HousingInventoryAllocationRec.SetRange("Housing ID", HostelApplication."Housing Pref. 3");
        HousingInventoryAllocationRec.SetRange("Room No.", HostelApplication."Room No.");
        HousingInventoryAllocationRec.SetFilter(Qunatity, '>%1', 0);
        if HousingInventoryAllocationRec.FINDFIRST() then begin
            Repeat
                //StudentRoomWiseInventoryRec."Ledger Entry No." := HostelLedgerRec."Entry No.";
                StudentRoomWiseInventoryRec.Reset();
                IF NOT StudentRoomWiseInventoryRec.Get(HostelApplication."Application No.", HousingInventoryAllocationRec."Item Code") then begin //CSPL-00307-T1-T1236
                    StudentRoomWiseInventoryRec.Reset();
                    StudentRoomWiseInventoryRec.Init();
                    StudentRoomWiseInventoryRec."Housing ID" := HousingInventoryAllocationRec."Housing ID";
                    StudentRoomWiseInventoryRec."Room No." := HostelApplication."Room No.";
                    StudentRoomWiseInventoryRec."Application No." := HostelApplication."Application No.";
                    StudentRoomWiseInventoryRec."Student No." := HostelApplication."Student No.";
                    StudentRoomWiseInventoryRec."Enrolment No." := HostelApplication."Enrolment No.";
                    StudentRoomWiseInventoryRec."Student Name" := HostelApplication."Student Name";
                    StudentRoomWiseInventoryRec."Item No." := HousingInventoryAllocationRec."Item Code";
                    StudentRoomWiseInventoryRec."Item Name" := HousingInventoryAllocationRec."Item Name";
                    StudentRoomWiseInventoryRec."Quantity Allotted" := HousingInventoryAllocationRec.Qunatity;
                    StudentRoomWiseInventoryRec."Inventory Category" := HousingInventoryAllocationRec."Inventory Category";
                    StudentRoomWiseInventoryRec.Insert(true);
                end;
            Until HousingInventoryAllocationRec.NEXT() = 0;
        end;


    end;

    // procedure StudentHostelAssignMail(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     RecHousing: record "Housing Master";
    //     RecRoomMaster: Record "Room Master";
    //     RoomCategoryMaster: Record "Room Category Master";
    //     educationsetup: Record "Education Setup-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     HostelNo: Code[20];
    //     AddCCmail: List of [Text];
    //     addccmailtext: text;

    // begin
    //     HostelApplication.Get(ApplicationNo);
    //     RoomCategoryMaster.Reset();
    //     RoomCategoryMaster.Setrange("Room Category Code", HostelApplication."Room Category Code");
    //     RoomCategoryMAster.Findfirst();

    //     CompanyInformationRec.Get();
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(HostelApplication."Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //     addccmailtext := '';
    //     educationsetup.Reset();
    //     educationsetup.SetRange("Global Dimension 1 Code", Studentmaster."Global Dimension 1 Code");
    //     if educationsetup.FindFirst() then
    //         addccmailtext := educationsetup."Housing Approval CC E-mail";

    //     addccmail := addccmailtext.Split(';');

    //     Recipient := Studentmaster."E-Mail Address";
    //     if HostelApplication."Pref. 1 Selected" then
    //         HostelNo := HostelApplication."Housing Pref. 1";
    //     if HostelApplication."Pref. 2 Selected" then
    //         HostelNo := HostelApplication."Housing Pref. 2";
    //     if HostelApplication."Pref. 3 Selected" then
    //         HostelNo := HostelApplication."Housing Pref. 3";

    //     RecHousing.Get(HostelNo);
    //     RecRoomMaster.Get(HostelNo, HostelApplication."Room No.");
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := HostelApplication."Application No." + ' ' + 'AUA Housing Assignment Approval Letter';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ' ' + StudentMaster."Last Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are pleased to inform you that your Housing Application' + ' ' + HostelApplication."Application No." + ' ' + 'has been approved. Below are the housing details for this semester:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Housing Name: ' + RecHousing."Housing Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     // SmtpMail.AppendtoBody('Floor: ' + FORMAT(RecRoomMaster."Floor No."));
    //     // SmtpMail.AppendtoBody('<br>');
    //     // SmtpMail.AppendtoBody('Apartment Category: ' + HostelApplication."Room Category Code");
    //     // SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Apartment Number: ' + HostelApplication."Room No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Room Category: ' + RoomCategoryMaster."Room Category Name");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Room Number: ' + HostelApplication."Bed No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('The Meet &amp; Greet team will be at the airport when you arrive. You will then be transported to your assigned housing where the keys and information packet will be available for you.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('You may contact Residential Services regarding any further information by sending an email to studentservices@auamed.net.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Residential Services Team ');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     if addccmailtext <> '' then
    //         SmtpMail.AddCC(AddCCmail);
    //     if CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Alloment Approval', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Alloment', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure HousingRejectionMail()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     educationsetup: Record "Education Setup-CS";
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    //     addccmail: List of [Text];
    //     addccmailtext: Text;
    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     addccmailtext := '';
    //     educationsetup.Reset();
    //     educationsetup.SetRange("Global Dimension 1 Code", Studentmaster."Global Dimension 1 Code");
    //     if educationsetup.FindFirst() then
    //         addccmailtext := educationsetup."Housing Approval CC E-mail";

    //     addccmail := addccmailtext.Split(';');

    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Application No.") + ' ' + 'Housing Application Request Cancelled');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is to inform you that your Housing Application' + ' ' +
    //                         Format("Application No.") + ' ' + 'has been Cancelled as per your confirmation.');

    //     // SmtpMail.AppendtoBody('<br>');         As per Mishma mail (17 Apr 2023)
    //     // SmtpMail.AppendtoBody('Please proceed to apply for Housing Waiver Application on SLcM Student portal under Housing Section at the earliest.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For any clarifications, you may contact Residential Services team.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE   PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     //SmtpMail.AppendtoBody('<br>');
    //     ////SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     if addccmailtext <> '' then
    //         SmtpMail.AddCC(addccmail);
    //     if CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Alloment Rejected', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Alloment', 'Housing', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure OLREmailSend()
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[100];
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
    //     Subject := (Format("Application No.") + ' ' + 'Housing Application Request On Hold');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that your Housing Application' + ' ' +
    //                         Format("Application No.") + ' ' + 'has been placed on Hold owing to unavailability of your preferred Housing facility.');

    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('In order to confirm on the available Housing facility, please contact Residential Services team immediately.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE   PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing OLR Email', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing OLR', 'Housing OLR', Format("Application No."), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    procedure Assistedit(OldHostelApplication: Record "Housing Application"): Boolean
    begin
        WITH HostelApplication DO BEGIN
            HostelApplication := Rec;
            // UserSetupRec.Get(UserId());
            // EducationSetupRec.Reset();
            // EducationSetupRec.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            GlSetup.FindFirst();
            GlSetup.TESTFIELD("Housing Application No.");
            IF NoSeriesMgt.SelectSeries(GlSetup."Housing Application No.", OldHostelApplication."No.Series", "No.Series")
            THEN BEGIN
                NoSeriesMgt.SetSeries("Application No.");
                Rec := HostelApplication;
                EXIT(TRUE);
            END;
        END;

    End;


    procedure ContractDetailCheck(HostelID: Code[20]);
    var
        HostelContractDetail: Record "Housing Contract";

        HousingMasterRec: Record "Housing Master";
        HousingMasterRec1: Record "Housing Master";
        HostelID1: Code[20];

    begin
        IF HostelID = '' Then begin
            if "Pref. 1 Selected" then
                HostelID1 := "Housing Pref. 1";
            if "Pref. 2 Selected" then
                HostelID1 := "Housing Pref. 2";
            if "Pref. 3 Selected" then
                HostelID1 := "Housing Pref. 3";
        end Else
            HostelID1 := HostelID;

        HousingMasterRec.Reset();
        HousingMasterRec.SetRange("Housing ID", HostelID1);
        HousingMasterRec.SetRange("Owned By University", false);
        If HousingMasterRec.FindFirst() then begin
            HousingMasterRec.TestField(HousingMasterRec."Vendor No.");
            HostelContractDetail.Reset();
            HostelContractDetail.SetRange("Housing ID", HostelID1);
            HostelContractDetail.SetFilter("Start Date", '<=%1', WorkDate());
            HostelContractDetail.SetFilter("End Date", '>=%1', WorkDate());
            if HostelContractDetail.FINDLAST() then
                ContractNo := HostelContractDetail."Contract No."
            else
                error('Contract details for Housing id %1 is not available in the system', HostelID1);
        end;
        HousingMasterRec1.Reset();
        HousingMasterRec1.SetRange("Housing ID", HostelID1);
        HousingMasterRec1.SetRange("Owned By University", true);
        If HousingMasterRec1.FindFirst() then begin
            HousingMasterRec1.TestField(HousingMasterRec1."Contact Person Name");
            HousingMasterRec1.TestField(HousingMasterRec1."Contact Number");

        end;
    end;

    procedure HousingMasterBlock(HostelID: Code[20]) HostelBlock: Boolean
    var

        HousingMasterRec: Record "Housing Master";
    begin
        if HostelID <> '' then
            if HousingMasterRec.Get(HostelID) then
                HostelBlock := HousingMasterRec.Blocked;
    end;

    procedure RoomMasterBlock(RoomNo: Code[20]) RoomBlock: Boolean
    var

        RoomMasterRec: Record "Room Master";
    begin
        if RoomNo <> '' then
            if RoomMasterRec.Get(RoomNo) then
                RoomBlock := RoomMasterRec.Blocked;
    end;

    procedure BedMasterBlock(BedNo: Code[20]; Var BedBlock: Boolean; Var BedAvailable: Boolean)
    var

        BedMasterRec: Record "Room Wise Bed";
    begin
        if BedNo <> '' then
            if BedMasterRec.Get(BedNo) then begin
                BedBlock := BedMasterRec.Blocked;
                BedAvailable := BedMasterRec.Available;
            end;
    end;

    procedure HousingStudentInformation(StudentNo: Code[20])
    begin
        IF StudentMasterRec.Get("Student No.") then begin
            if HousingMasterBlock(StudentMasterRec."House No. Pref.1") = false then
                Validate("Housing Pref. 1", StudentMasterRec."House No. Pref.1");
            if HousingMasterBlock(StudentMasterRec."House No. Pref.2") = false then
                Validate("Housing Pref. 2", StudentMasterRec."House No. Pref.2");
            if HousingMasterBlock(StudentMasterRec."House No. Pref.3") = false then
                Validate("Housing Pref. 3", StudentMasterRec."House No. Pref.3");
            "Room Category Pref.1" := StudentMasterRec."Room Category Pref.1";
            "Room Category Pref.2" := StudentMasterRec."Room Category Pref.2";
            "Room Category Pref.3" := StudentMasterRec."Room Category Pref.3";
            "Housing Group Pref.1" := StudentMasterRec."Housing Group Pref.1";
            "Housing Group Pref.2" := StudentMasterRec."Housing Group Pref.2";
            "Housing Group Pref.3" := StudentMasterRec."Housing Group Pref.3";
            "Room Mate Name Pref" := StudentMasterRec."Room Mate Name Pref";
            "Room Mate Email Pref" := StudentMasterRec."Room Mate Email Pref";
        end else begin
            "Enrolment No." := '';
            "Housing Pref. 1" := '';
            "Housing Pref. 2" := '';
            "Housing Pref. 3" := '';
            "Room Category Pref.1" := '';
            "Room Category Pref.2" := '';
            "Room Category Pref.3" := '';
            "Housing Group Pref.1" := '';
            "Housing Group Pref.2" := '';
            "Housing Group Pref.3" := '';
            "Global Dimension 1 Code" := '';
            "Global Dimension 2 Code" := '';
            "Room Mate Name Pref" := '';
            "Room Mate Email Pref" := '';
        end;
    end;

    Procedure GetStudentNo(HousingID: Code[20])
    Var
        RoomMasterRec: Record "Room Master";
    begin
        IF "Housing ID" <> '' then begin
            RoomMasterRec.Reset();
            RoomMasterRec.SetRange("Housing ID", "Housing ID");
            RoomMasterRec.SetRange("Room Category Code", "Room Category Code");
            if RoomMasterRec.FindFirst() then begin
                RoomMasterRec."Student No." := "Student No.";
                RoomMasterRec."Student Name" := "Student Name";
                RoomMasterRec.Modify();
            end;
        end else begin
            RoomMasterRec.Reset();
            RoomMasterRec.SetRange("Student No.", "Student No.");
            RoomMasterRec.SetRange("Room Category Code", "Room Category Code");
            if RoomMasterRec.FindFirst() then begin
                RoomMasterRec."Student No." := '';
                RoomMasterRec."Student Name" := '';
                RoomMasterRec.Modify();
            end;
        end;

    end;

    Procedure HousingCost(HousingID: Code[20]; RoomCategory: Code[20]; WithSpouse: Boolean): Decimal
    Var
        RoomCategoryFeeRec: Record "Room Category Fee Setup";
    begin
        IF WithSpouse then begin
            RoomCategoryFeeRec.Reset();
            RoomCategoryFeeRec.SetCurrentKey("Effective From");
            RoomCategoryFeeRec.SetRange("Housing ID", HousingID);
            RoomCategoryFeeRec.SetRange("Room Category Code", RoomCategory);
            RoomCategoryFeeRec.SetFilter("Effective From", '<=%1', WorkDate());
            RoomCategoryFeeRec.FindLast();
            if RoomCategoryFeeRec."With Spouse Cost" <= 0 then
                Error('Housing With Spouse Cost cannot be zero for selected category');
            exit(RoomCategoryFeeRec."With Spouse Cost");
        end else begin
            RoomCategoryFeeRec.Reset();
            RoomCategoryFeeRec.SetCurrentKey("Effective From");
            RoomCategoryFeeRec.SetRange("Housing ID", HousingID);
            RoomCategoryFeeRec.SetRange("Room Category Code", RoomCategory);
            RoomCategoryFeeRec.SetFilter("Effective From", '<=%1', WorkDate());
            RoomCategoryFeeRec.FindLast();
            if RoomCategoryFeeRec.Cost <= 0 then
                Error('Housing Cost cannot be zero for selected category');
            exit(RoomCategoryFeeRec.Cost);
        end;

    end;

    // Procedure StartEndDateCreation(StudentNo: Code[20]; AY: Code[20]; Term: Option FALL,SPRING,SUMMER; Sem: Code[10]; GD1: Code[20])
    // Var
    //     CourseSemMasterRec: Record "Course Sem. Master-CS";
    // begin
    //     StudentMasterRec.Get(StudentNo);
    //     CourseSemMasterRec.Reset();
    //     CourseSemMasterRec.SetRange("Course Code", StudentMasterRec."Course Code");
    //     CourseSemMasterRec.SetRange("Academic Year", StudentMasterRec."Academic Year");
    //     CourseSemMasterRec.SetRange(Term, StudentMasterRec.Term);
    //     CourseSemMasterRec.SetRange("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
    //     if CourseSemMasterRec.FindFirst() then begin
    //         "Start Date" := CourseSemMasterRec."Start Date";
    //         "End Date" := CourseSemMasterRec."End Date";
    //     end;
    // end;
    Procedure StartEndDateCreation(var HousApp: Record "Housing Application"; StudentNo: Code[20]; AY: Code[20]; Term: Option FALL,SPRING,SUMMER; Sem: Code[10]; GD1: Code[20])
    Var
        CourseSemMasterRec: Record "Course Sem. Master-CS";
        Stud: Record "Student Master-CS";
    begin
        Stud.Get(StudentNo);
        CourseSemMasterRec.Reset();
        CourseSemMasterRec.SetRange("Course Code", Stud."Course Code");
        CourseSemMasterRec.SetRange("Academic Year", AY);
        CourseSemMasterRec.SetRange(Term, Term);
        CourseSemMasterRec.SetRange("Semester Code", Sem);
        CourseSemMasterRec.SetRange("Global Dimension 1 Code", GD1);
        if CourseSemMasterRec.FindFirst() then begin
            HousApp."Start Date" := CourseSemMasterRec."Start Date";
            HousApp."End Date" := CourseSemMasterRec."End Date";
        end;
    end;

    Procedure SendtoSalesForceAPI()
    var
        OptOut_lRec: Record "Opt Out";
        SLcMtoSalesForce_lCU: Codeunit SLcMToSalesforce;

    begin

        if ("Housing Pref. 1" <> '') and ("Housing Group Pref.1" <> '') and ("Room Category Pref.1" <> '') then
            SLcMtoSalesForce_lCU.HousingWaiverAndApplicationAPI(Rec, OptOut_lRec, 0);

        If ("Housing Pref. 2" <> '') and ("Housing Group Pref.2" <> '') and ("Room Category Pref.2" <> '') then
            SLcMtoSalesForce_lCU.HousingWaiverAndApplicationAPI(Rec, OptOut_lRec, 0);

        If ("Housing Pref. 3" <> '') and ("Housing Group Pref.3" <> '') and ("Room Category Pref.3" <> '') then
            SLcMtoSalesForce_lCU.HousingWaiverAndApplicationAPI(Rec, OptOut_lRec, 0);

    end;

    procedure BulkApproved(Var RecHousingApplication: Record "Housing Application"; Var RecTempHousingApp: Record "Housing Application" temporary; HideDialog: Boolean)
    var
        usersetupapprover: Record "Document Approver Users";
        OptOut_lRec: Record "Opt Out";
        StudentTimeLineRec: Record "Student Time Line";
        StudentRec: Record "Student Master-CS";
        EducationSetup: Record "Education Setup-CS";
        HousingChangeRequestRec: Record "Housing Change Request";
        UserSetup: Record "User Setup";
        SalesForceCodeunit: Codeunit SLcMToSalesforce;
        HosusingMailCod: Codeunit "Hosusing Mail";
        HousingType: Integer;
        Text003Lbl: Label 'Application No. %1 has been approved.';
    begin
        //CSPL-00307-T1-T1236

        usersetupapprover.Reset();
        usersetupapprover.setrange("User ID", UserId());
        usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
        IF not usersetupapprover.FindFirst() then
            Error('You do not have permission to Approve the Application');

        if IsAnyErrorExist(RecHousingApplication) = false then begin //CSPL-00307-T1-T1236
            if RecHousingApplication."On Hold" then
                Error('Application No. %1 is on Hold', RecHousingApplication."Application No.");
            // if UserSetup.Get(UserId()) then
            //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Residential Services" then
            //         Error('You do not have permission to Approve the Application');

            EducationSetup.Reset();
            EducationSetup.SetRange("Global Dimension 1 Code", RecHousingApplication."Global Dimension 1 Code");
            EducationSetup.SetRange("Pre Housing App. Allowed", false);
            if EducationSetup.FindFirst() then begin
                if EducationSetup."Even/Odd Semester" <> RecHousingApplication.Term then
                    Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', RecHousingApplication."Application No.");
                if EducationSetup."Academic Year" <> RecHousingApplication."Academic Year" then
                    Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', RecHousingApplication."Application No.");
            end;

            if (RecHousingApplication."Rejection Reason Code" <> '') or (RecHousingApplication."Rejection Description" <> '') then
                Error('Rejection reason code & Rejection description must be blank.');

            StudentRec.Reset();
            StudentRec.Get(RecHousingApplication."Student No.");

            if StudentRec.HostelRoomBedAssigned(RecHousingApplication."Student No.", 2) <> '' then
                Error('Housing is already assigned to Student No. %1', RecHousingApplication."Student No.");



            IF NOT HideDialog then begin
                IF NOT CONFIRM(Text001Lbl, FALSE, RecHousingApplication."Application No.") THEN
                    exit;
            end;

            IF NOT (RecHousingApplication.Status IN [RecHousingApplication.Status::"Pending for Approval", RecHousingApplication.Status::Assigned]) then //CSPL-00307-T1-T1236
                Error('Status must not be %1', RecHousingApplication.Status);
            RecHousingApplication.Testfield("Student No.");
            RecHousingApplication.TestField("Start Date");
            RecHousingApplication.TestField("End Date");
            RecHousingApplication.TestField("Room No.");
            RecHousingApplication.TestField("Bed No.");
            if RecHousingApplication."Housing ID" = '' then
                Error('Any one out of three housing preferences must be selected');

            if RecHousingApplication."Housing Cost" = 0 then
                Error('Housing Cost must have value in it, please check Apartment Category Fee Setup.');


            // //SD-SN-22-Dec-2020 +
            // SalesForceCodeunit.HousingAllomentInformationSFInsert(OptOut_lRec, Rec, 0);
            // //SD-SN-22-Dec-2020 -
            HousingChangeRequestRec.Reset();
            HousingChangeRequestRec.SetRange("New Application No.", RecHousingApplication."Application No.");
            if HousingChangeRequestRec.FindFirst() then
                Error('You can only Approve this entry from housing change request page');

            HosusingMailCod.StudentHousingTypeUpdate(RecHousingApplication."Student No.", RecHousingApplication."Housing ID", RecHousingApplication."Room No.", RecHousingApplication."Bed No.");
            PostApplication(RecHousingApplication."Application No.", '');
            // StudentHostelAssignMail(RecHousingApplication."Application No.");
            StudentTimeLineRec.InsertRecordFun(RecHousingApplication."Student No.", RecHousingApplication."Student Name", 'Housing Hold Disable', UserId(), Today());


            RecHousingApplication.Status := RecHousingApplication.Status::Approved;
            RecHousingApplication.Posted := True;
            RecHousingApplication."Approved By" := UserId();
            RecHousingApplication."Approved On" := Today();
            RecHousingApplication."Approved In Days" := Today() - RecHousingApplication."Application Date";
            RecHousingApplication.Modify();
            //SD-SN-22-Dec-2020 +
            //SalesForceCodeunit.HousingAllomentInformationSFInsert(OptOut_lRec, Rec, 0);
            // SalesForceCodeunit.HousingWaiverAndApplicationAPI(RecHousingApplication, OptOut_lRec, 0);//Lucky for Testing
            //SD-SN-22-Dec-2020 -

            // Message(Text003Lbl, RecHousingApplication."Application No.");
        end else begin
            //CSPL-00307-T1-T1236 
            RecTempHousingApp.Reset();
            RecTempHousingApp.Init();
            RecTempHousingApp := RecHousingApplication;
            RecTempHousingApp.Insert();
        end;
        // CurrPage.Close();

    end;

    procedure CheckHousingAlreadyAssigned(RecHousingApp: Record "Housing Application"): Boolean
    var
        RecHousingLedger: Record "Housing Ledger";
        RoomWiseBed: Record "Room Wise Bed";
    begin
        //CSPL-00307-T1-T1236
        RecHousingLedger.Reset();
        RecHousingLedger.SetCurrentKey("Housing ID", "Room Category Code", "Room No.", "Bed No.");
        RecHousingLedger.SetRange("Housing ID", RecHousingApp."Housing ID");
        RecHousingLedger.SetRange("Room Category Code", RecHousingApp."Room Category Code");
        RecHousingLedger.SetRange("Room No.", RecHousingApp."Room No.");
        RecHousingLedger.SetRange("Bed No.", RecHousingApp."Bed No.");
        RecHousingLedger.CalcSums("Room Assignment");
        IF RecHousingLedger."Room Assignment" > 0 then begin
            RoomWiseBed.Reset();
            RoomWiseBed.SetRange("Housing ID", RecHousingLedger."Housing ID");
            RoomWiseBed.SetRange("Room Category Code", RecHousingLedger."Room Category Code");
            RoomWiseBed.SetRange("Room No.", RecHousingLedger."Room No.");
            RoomWiseBed.SetRange("Bed No.", RecHousingLedger."Bed No.");
            If RoomWiseBed.FindFirst() then
                If not RoomWiseBed.Available then
                    exit(true);
            IF RoomWiseBed.Available then
                exit(false);
        end else
            exit(false);
    end;

    procedure IsAnyErrorExist(RecHousingApp: Record "Housing Application"): Boolean
    var
        RecHousingLedger: Record "Housing Ledger";
        HousingChangeRequestRec: Record "Housing Change Request";
    begin
        //CSPL-00307-T1-T1236  --- This Function is only for Bulk Approval to ByPass the Errors for Multiple Selected Applications

        IF (RecHousingApp."Student No." = '') OR (RecHousingApp."Enrolment No." = '') OR (RecHousingApp."Room Category Code" = '')
            OR (RecHousingApp."Room No." = '') OR (RecHousingApp."Bed No." = '') OR (RecHousingApp."Start Date" = 0D) OR (RecHousingApp."End Date" = 0D) then
            exit(true);

        IF CheckHousingAlreadyAssigned(RecHousingApp) then
            exit(true);

        IF RecHousingApp."On Hold" then
            exit(true);
        if (RecHousingApp."Rejection Reason Code" <> '') or (RecHousingApp."Rejection Description" <> '') then
            exit(true);

        if RecHousingApp."Housing ID" = '' then
            exit(true); //Error('Any one out of three housing preferences must be selected');

        if RecHousingApp."Housing Cost" = 0 then
            exit(true); //Error('Housing Cost must have value in it, please check Apartment Category Fee Setup.');

        HousingChangeRequestRec.Reset();
        HousingChangeRequestRec.SetRange("New Application No.", RecHousingApp."Application No.");
        if HousingChangeRequestRec.FindFirst() then
            exit(true); //Error('You can only Approve this entry from housing change request page');

        HousingInventoryAllocationRec1.Reset();
        HousingInventoryAllocationRec1.SetRange("Housing ID", RecHousingApp."Housing ID");
        HousingInventoryAllocationRec1.SetRange("Room No.", RecHousingApp."Room No.");
        HousingInventoryAllocationRec1.SetFilter(Qunatity, '>%1', 0);
        if not HousingInventoryAllocationRec1.findfirst() then
            exit(true); //Error('There is no inventory available for Apartment no. : %1', HostelApplication."Room No.");

        exit(false);
    end;
}