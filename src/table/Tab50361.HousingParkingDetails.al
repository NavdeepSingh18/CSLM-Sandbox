table 50361 "Housing Parking Details"
{
    Caption = 'Housing Parking Details';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Parking Application No.", "Student Name";

    fields
    {
        field(1; "Parking Application No."; Code[20])
        {
            Caption = 'Parking Application No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Parking Application No." <> xRec."Parking Application No." THEN BEGIN
                    // UserSetupRec.get(UserId());
                    // EducationSetup.Reset();
                    // EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
                    if Glsetup.get() then begin
                        NoSeriesMgt.TestManual(Glsetup."Housing Parking No.");
                        "No. Series" := '';
                    end;
                END;
            end;
        }
        field(2; "Application Date"; Date)
        {
            Caption = 'Application Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate()
            begin
                If ("Student No." <> '') and (xRec."Student No." <> Rec."Student No.") then begin
                    HousingParkingRec.Reset();
                    HousingParkingRec.SetRange("Student No.", "Student No.");
                    HousingParkingRec.SetRange("Academic Year", "Academic Year");
                    HousingParkingRec.SetRange(Semester, Semester);
                    HousingParkingRec.SetRange(Status, HousingParkingRec.Status::"Pending for Approval");
                    if HousingParkingRec.findfirst() then
                        error('Parking Application of student No. %1 for this semester %2 and academic year %3 is already pending'
                        , "Student No.", Semester, "Academic Year");
                    If StudentMasterRec.Get("Student No.") then begin
                        "Student Name" := StudentMasterRec."Student Name";
                        "Enrolment No." := StudentMasterRec."Enrollment No.";
                        Semester := StudentMasterRec.Semester;
                        "Academic Year" := StudentMasterRec."Academic Year";
                        "Global Dimension 1 Code" := StudentMasterRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMasterRec."Global Dimension 2 Code";
                        "Vehicle Number" := '';
                        "Issued From" := 0D;
                        "Issued Upto" := 0D;
                    end;
                end else begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    Semester := '';
                    "Academic Year" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Vehicle Number" := '';
                    "Issued From" := 0D;
                    "Issued Upto" := 0D;

                end;
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(5; "Enrolment No."; Code[20])
        {
            Caption = 'Enrolment No.';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(6; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(7; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(8; "Vehicle Number"; Text[30])
        {
            Caption = 'Vehicle Number';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                HousingParkingRec.Reset();
                HousingParkingRec.SetRange("Student No.", "Student No.");
                HousingParkingRec.SetRange("Academic Year", "Academic Year");
                HousingParkingRec.SetRange(Semester, Semester);
                HousingParkingRec.SetRange(Status, HousingParkingRec.Status::Approved);
                if HousingParkingRec.findfirst() then
                    error('Parking is already assigned to student No. %1 for this semester %2 and academic year %3'
                    , "Student No.", Semester, "Academic Year");
                If "Vehicle Number" <> '' Then begin
                    StudentMasterRec.Get("Student No.");
                    EducationSetupCS.RESET();
                    EducationSetupCS.SETRANGE("Global Dimension 1 Code", StudentMasterRec."Global Dimension 1 Code");
                    IF EducationSetupCS.FINDFIRST() THEN
                        IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::SPRING THEN BEGIN
                            EducationMultiEventCalCS.RESET();

                            EducationMultiEventCalCS.Setfilter("Event Code", '%1', Format(EducationSetupCS."Even/Odd Semester"::SPRING));
                            EducationMultiEventCalCS.SETRANGE("Academic Year", StudentMasterRec."Academic Year");
                            IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                                "Issued From" := EducationMultiEventCalCS."Start Date";
                                "Issued Upto" := EducationMultiEventCalCS."Revised End Date";
                            END;
                        END ELSE
                            IF EducationSetupCS."Even/Odd Semester" = EducationSetupCS."Even/Odd Semester"::FALL THEN BEGIN
                                EducationMultiEventCalCS.RESET();
                                EducationMultiEventCalCS.Setfilter("Event Code", '%1', Format(EducationSetupCS."Even/Odd Semester"::FALL));
                                EducationMultiEventCalCS.SETRANGE("Academic Year", StudentMasterRec."Academic Year");
                                IF EducationMultiEventCalCS.FINDFIRST() THEN BEGIN
                                    "Issued From" := EducationMultiEventCalCS."Start Date";
                                    "Issued Upto" := EducationMultiEventCalCS."Revised End Date";
                                END;
                            END;
                end else begin
                    "Issued From" := 0D;
                    "Issued Upto" := 0D;
                end;
            end;
        }
        field(9; "Sticker Number"; Code[20])
        {
            Caption = 'Sticker Number';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(10; "Issued From"; Date)
        {
            Caption = 'Issued From';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(11; "Issued Upto"; Date)
        {
            Caption = 'Issued Upto';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Code = filter(9300 | 9500));
            DataClassification = CustomerContent;
            ValuesAllowed = '9300;9500';
        }
        field(14; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(15; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(16; "Modified By"; Code[50])
        {
            Caption = 'Modified By';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(17; "Modified On"; Date)
        {
            Caption = 'Modified On';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(18; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(19; Inserted; Boolean)
        {
            Caption = 'Inserted';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Pending for Approval,Approved';
            OptionMembers = "Pending for Approval",Approved;
            Editable = false;
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(22; Make; Text[50])
        {
            Caption = 'Make';
            DataClassification = CustomerContent;
        }
        field(23; Model; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(24; Colour; Text[30])
        {
            Caption = 'Colour';
            DataClassification = CustomerContent;
        }
        field(25; "Name of Vehicle Owner"; Text[100])
        {
            Caption = 'Name of Vehicle Owner';
            DataClassification = CustomerContent;
        }
        field(26; "Number of Vehicle Owner"; Text[30])
        {
            Caption = 'Number of Vehicle Owner';
            DataClassification = CustomerContent;
        }
        field(27; "Registration Number"; Text[30])
        {
            Caption = 'Registration Number';
            DataClassification = CustomerContent;
        }
        field(28; "Driver License Number"; Text[30])
        {
            Caption = 'Driver License Number';
            DataClassification = CustomerContent;
        }
        field(29; "License Expiration Date"; Date)
        {
            Caption = 'License Expiration Date';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                If "License Expiration Date" <= "Application Date" then
                    Error('License Expiration Date should be greated than Application Date');
            end;
        }
        field(30; "Comment"; Text[250])
        {
            Caption = 'Comment';
            DataClassification = CustomerContent;
        }
        field(31; "Sticker Assigned Date"; Date)
        {
            Caption = 'Sticker Assigned Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "Approved In Days"; Integer)
        {
            Caption = 'Approved In Days';
            DataClassification = CustomerContent;
            Editable = false;
        }

    }
    keys
    {
        key(PK; "Parking Application No.")
        {
            Clustered = true;
        }
        key(Key2; "Created On")
        {

        }
    }
    Var
        StudentMasterRec: Record "Student Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        EducationMultiEventCalCS: Record "Education Multi Event Cal-CS";
        EducationSetup: Record "Education Setup-CS";
        HousingParkingRec: Record "Housing Parking Details";
        UserSetupRec: Record "User Setup";
        Glsetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];


    trigger OnInsert()
    begin
        // UserSetupRec.get(UserId());
        // EducationSetup.Reset();
        // EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
        if Glsetup.get() then;
        IF "Parking Application No." = '' THEN BEGIN
            Glsetup.TESTFIELD(Glsetup."Housing Parking No.");
            NoSeriesMgt.InitSeries(Glsetup."Housing Parking No.", xRec."No. Series", 0D, "Parking Application No.", "No. Series");
        end;

        "Created By" := Format(USERID());
        "Created On" := TODAY();
        Inserted := true;
        "Application Date" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(USERID());
        "Modified On" := TODAY();
        Updated := true;
    end;

    procedure AssistEdit(OldHousingParking: Record "Housing Parking Details"): Boolean
    var
        HousingParkingDetails: Record "Housing Parking Details";
        GlSetup: Record "General Ledger Setup";
    begin
        WITH HousingParkingDetails DO BEGIN
            HousingParkingDetails := Rec;
            // UserSetupRec.get(UserId());
            // EducationSetup.Reset();
            // EducationSetup.SetRange("Global Dimension 1 Code", UserSetupRec."Global Dimension 1 Code");
            if GlSetup.get() then;
            GlSetup.TESTFIELD("Housing Parking No.");
            IF NoSeriesMgt.SelectSeries(GlSetup."Housing Parking No.", OldHousingParking."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("Parking Application No.");
                Rec := HousingParkingDetails;
                EXIT(TRUE);

            end;
        END;

    End;

    procedure ParkingAlloment() ParkingNo: Code[20]
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        if EducationSetup.FindFirst() then begin
            IF not ("Global Dimension 1 Code" IN ['9000', '9100']) then
                Error('Institute Code must be "9000" or "9100". Current value is %1', "Global Dimension 1 Code");

            If ("Global Dimension 1 Code" = '9000') AND (Semester = 'BSIC') then begin
                EducationSetup.TestField(EducationSetup."Parking BSIC No.");
                ParkingNo := NoSeriesMgt.GetNextNo(EducationSetup."Parking BSIC No.", 0D, TRUE)
            end else begin
                EducationSetup.TestField(EducationSetup."Parking AICASA/AUA No.");
                ParkingNo := NoSeriesMgt.GetNextNo(EducationSetup."Parking AICASA/AUA No.", 0D, TRUE);
            end;

        end;
    End;

    // procedure ParkingStickerAssignmentMail(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     DimensionValuesRec: Record "Dimension Value";
    //     CompanyInformationRec: Record "Company Information";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.GET();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");

    //     DimensionValuesRec.Reset();
    //     DimensionValuesRec.SetRange("Dimension Code", 'INSTITUTE');
    //     DimensionValuesRec.SetRange(Code, "Global Dimension 1 Code");
    //     if DimensionValuesRec.FindFirst() then;

    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := (Format("Parking Application No.") + ' ' + 'Parking Sticker Number');

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + "Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We are pleased to inform you that your application for Parking has been completed and Parking Sticker Number has been generated. Below are the Parking details for this semester:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Parking Application Number:' + ' ' + "Parking Application No.");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Vehicle Number:' + ' ' + "Vehicle Number");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Name of Vehicle Owner:' + ' ' + "Name of Vehicle Owner");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Vehicle Owner Contact Number:' + ' ' + "Number of Vehicle Owner");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Model:' + ' ' + Model);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Make:' + ' ' + Make);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Color:' + ' ' + Colour);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Registration Number:' + ' ' + "Registration Number");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Driver License Number:' + ' ' + "Driver License Number");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('License Expiration Date:' + ' ' + Format("License Expiration Date"));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Sticker Number:' + ' ' + "Sticker Number");
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Parking Issue Date:' + ' ' + Format("Sticker Assigned Date"));
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Comment:' + ' ' + Comment);
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Status:' + ' ' + Format(Status));
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Parking Sticker', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Parking Sticker', 'Housing Parking Sticker', '', '',
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;
}
