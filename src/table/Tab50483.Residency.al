table 50483 Residency
{
    DataClassification = CustomerContent;
    Caption = 'Residency';
    DataCaptionFields = "Residency No.", "Student Name";

    fields
    {
        field(1; "Residency No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency No.';
            trigger OnValidate()
            begin
                IF "Residency No." <> xRec."Residency No." THEN BEGIN
                    EducationSetupRec.Reset();
                    EducationSetupRec.FindFirst();
                    NoSeriesMgt.TestManual(EducationSetupRec."Residency Nos.");
                END;
            end;

        }
        field(2; "Residency Effective Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Residency Effective Date';
        }
        field(3; "MSPE Request Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'MSPE Request Date';
        }
        field(4; "Residency Year"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency Year';
            trigger OnValidate()
            begin
                StudentResidency.Reset();
                StudentResidency.SetRange("Student No.", Rec."Student No.");
                StudentResidency.SetRange("Residency Year", Rec."Residency Year");
                if StudentResidency.Findlast() then
                    "Entry No." := StudentResidency."Entry No." + 1
                else
                    "Entry No." := 1;
            end;
        }
        field(5; "Link to Hospital Branch"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Link to Hospital Branch';
            TableRelation = "Order Address".Code where("ACGME No." = Field("Residency ACGME No."));
        }
        field(6; "Residency Status"; Code[20])
        {
            Caption = 'Residency Status';
            TableRelation = "Residency Status".Code;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                // if "Residency Status" = 'MATCHED' then
                //     CongratulatoryEmailnotification(Rec);

                if "Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED', 'OPTED-OUT'] then
                    "Residency Type" := 'No';

                if not ("Residency Status" in ['WITHDRAWN', 'OPTEDOUT', 'PENDING', 'INCOMPLETE', 'NO MATCHED', 'OPTED-OUT']) then
                    "Residency Type" := 'Yes';
            end;
        }
        field(7; "NRMP Status"; Code[20])
        {
            Caption = 'NRMP Status';
            TableRelation = "Residency Status".Code where("Sub Type" = filter("NRMP Status"));
            DataClassification = CustomerContent;

        }
        field(8; "CaRMS Status"; Code[20])
        {
            TableRelation = "Residency Status".Code where("Sub Type" = filter("CaRMS Status"));
            DataClassification = CustomerContent;
            Caption = 'CaRMS Status';

        }
        field(9; "San Francisco Status"; Code[20])
        {
            TableRelation = "Residency Status".Code where("Sub Type" = filter("San Francisco Status"));
            DataClassification = CustomerContent;
            Caption = 'San Francisco Status';

        }
        field(10; "Residency Placement Type"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency Placement Type';
        }
        field(11; "Post Graduate Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Graduate Year';
        }
        field(12; "Hospital State"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital State';
            TableRelation = "State SLcM CS".Code;

        }
        field(13; "Hospital Country"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Country';
            TableRelation = "Country/Region".Code;

        }
        field(14; "File Complete"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'File Complete';
        }
        field(15; "RPR Rcvd"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'RPR Rcvd';
        }
        field(16; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";

            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                "Enrollment No." := '';
                "Student Name" := '';
                StudentMaster.Reset();
                if StudentMaster.Get("Student No.") then begin
                    "First Name" := StudentMaster."First Name";
                    "Last Name" := StudentMaster."Last Name";
                    "Student Name" := StudentMaster."Student Name";
                    "Enrollment No." := StudentMaster."Enrollment No.";
                    "Student Status" := StudentMaster.Status;
                    "E-mail Address" := StudentMaster."E-Mail Address";
                end;
            end;
        }
        field(17; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(18; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
            trigger OnValidate()
            var
                StudentMaster: Record "Student Master-CS";
            begin
                "Student No." := '';
                "Student Name" := '';
                StudentMaster.Reset();
                StudentMaster.SetRange("Enrollment No.", "Enrollment No.");
                if StudentMaster.FindLast() then begin
                    "Student No." := StudentMaster."No.";
                    "Student Name" := StudentMaster."Student Name";
                end;
            end;
        }
        field(19; "Link to Contact"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Link to Contact';
        }
        field(20; "Hospital Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Code';
            TableRelation = Vendor."No." where("Vendor Sub Type" = filter(Hospital));
            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.Reset();
                if Vendor.Get("Hospital Code") then begin
                    "Hospital Name" := Vendor.Name;
                    "Hospital City" := Vendor.City;
                    // "Hospital State" := Vendor."State Code";
                    "Hospital Country" := Vendor."Country/Region Code";
                end;
            end;
        }
        field(21; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';

        }
        field(22; "Hospital City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital City';

        }
        field(23; "Residency Specialty"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency Specialty';

        }

        field(50; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
        }
        field(51; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Created On';
        }
        field(53; "nID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'nID';
        }
        field(54; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(55; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(56; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(57; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            //Editable = false;

        }
        field(58; "Hospital Name1"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY1-Hospital Name';
        }
        field(59; "Residency Specialty1"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY1-Residency Specialty';
        }
        field(60; "Hospital Country1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY1-Hospital Country';
            TableRelation = "Country/Region".Code;
        }
        field(61; "Hospital State1"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY1-Hospital State';
            TableRelation = "State SLcM CS".Code;
        }
        field(62; "Hospital City1"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY1-Hospital City';
        }
        field(63; "Hospital Name2"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY2-Hospital Name';
        }
        field(64; "Residency Specialty2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY2-Residency Specialty';
        }
        field(65; "Hospital Country2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY2-Hospital Country';
            TableRelation = "Country/Region".Code;
        }
        field(66; "Hospital State2"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY2-Hospital State';
            TableRelation = "State SLcM CS".Code;
        }
        field(67; "Hospital City2"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'PGY2-Hospital City';
        }
        field(68; "Residency ACGME No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Residency ACGME No.';
            Trigger OnValidate()
            var
                HospitalBranch: Record "Order Address";
            Begin
                If "Residency ACGME No." <> '' then begin
                    HospitalBranch.Reset();
                    HospitalBranch.SetRange("ACGME No.", Rec."Residency ACGME No.");
                    If HospitalBranch.FindFirst() then
                        "Link to Hospital Branch" := HospitalBranch.Code;
                end Else
                    "Link to Hospital Branch" := '';
            End;
        }
        field(69; "ECFMG_ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'USMLE ID';
        }
        field(70; "No.Series"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.Series';
            TableRelation = "No. Series";

        }
        field(71; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(72; "Student Status"; Code[20])
        {
            Caption = 'Student Status';
            DataClassification = CustomerContent;
            TableRelation = "Student Status";
            Editable = false;
        }
        Field(73; "Residency Type"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        Field(74; "E-mail Address"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        Field(75; "Student Current Status"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS".Status where("Enrollment No." = field("Enrollment No.")));
            Caption = 'Student Current Status';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Residency No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        EducationSetupRec.Reset();
        EducationSetupRec.FindFirst();
        IF "Residency No." = '' THEN BEGIN
            EducationSetupRec.TESTFIELD(EducationSetupRec."Residency Nos.");
            NoSeriesMgt.InitSeries(EducationSetupRec."Residency Nos.", xRec."No.Series", 0D, "Residency No.", "No.Series");
        end;

        "Created By" := UserId();
        "Created On" := Today();

    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
        InsertResidencyLedger(Rec);
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure Assistedit(OldResidency: Record Residency): Boolean
    begin
        WITH OldResidency DO BEGIN
            OldResidency := Rec;
            EducationSetupRec.Reset();
            EducationSetupRec.FindFirst();
            EducationSetupRec.TESTFIELD("Residency Nos.");
            IF NoSeriesMgt.SelectSeries(EducationSetupRec."Residency Nos.", OldResidency."No.Series", "No.Series") then begin
                NoSeriesMgt.SetSeries("Residency No.");
                Rec := OldResidency;
                EXIT(TRUE);
            END;
        END;
    end;

    // procedure CongratulatoryEmailnotification(StudentResidency: Record Residency)
    // var
    //     StudentMasterRec: Record "Student Master-CS";
    //     SMTPMailSetup: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;


    // Begin
    //     SMTPMailSetup.Get();
    //     StudentMasterRec.Get(StudentResidency."Student No.");
    //     SMTPMail.Create('MEA', SmtpMailSetup."Email Address", StudentMasterRec."E-Mail Address", 'Congratulations! You are selected in the MATCH', '', TRUE);
    //     SMTPMail.AppendtoBody('Dear ' + StudentMasterRec."First Name" + ' ' + StudentMasterRec."Middle Name" + ' ' + StudentMasterRec."Last Name");
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('This is to inform you that you are selected in the Match. Congratulations on your well-deserved success!');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Should you require any assistance with State Medical Licensing and documentation for post-graduate endeavors, please fill and submit “Post-Graduate');
    //     SMTPMail.AppendtoBody('<br>');
    //     SMTPMail.AppendtoBody('Documentation Request Form” on your SLcM student portal.');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('You are also required to fill and submit “Residency Placement Results Form” on your SLcM student portal, for our records.');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Forms submitted will be assessed by Graduate Affairs team and you will be notified accordingly.');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('For any clarifications, please contact Graduate Affairs team at graduateaffairs@mea.com or call on  01234567.');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Regards,');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('Graduate Affairs Team');
    //     SMTPMail.AppendtoBody('<br><Br>');
    //     SMTPMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL].');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Residency', 'MEA', SmtpMailSetup."Email Address", Format("Student Name"),
    //     StudentResidency."Student No.", 'Congratulations! You are selected in the MATCH', BodyText, 'Residency Application', 'Residency Application', "Residency No.", Format("Residency Effective Date", 0, 9),
    //     StudentMasterRec."E-Mail Address", 1, StudentMasterRec."Mobile Number", '', 1);
    // End;

    procedure InsertResidencyLedger(StudentResidency: Record Residency)
    var
        ResidencyLedger: Record "Residency Ledger";
        ResidencyLedger1: Record "Residency Ledger";
        LastNo: Integer;

    Begin
        ResidencyLedger1.Reset();
        if ResidencyLedger1.FINDLAST() then
            LastNo := ResidencyLedger1."Entry No." + 1
        else
            LastNo := 1;

        ResidencyLedger.Init();
        ResidencyLedger."Entry No." := LastNo;
        ResidencyLedger."Residency No." := StudentResidency."Residency No.";
        ResidencyLedger."Student No." := StudentResidency."Student No.";
        ResidencyLedger."Hospital Name" := StudentResidency."Hospital Name";
        ResidencyLedger."Hospital Country" := StudentResidency."Hospital Country";
        ResidencyLedger."Hospital State" := StudentResidency."Hospital State";
        ResidencyLedger."Hospital City" := StudentResidency."Hospital City";
        ResidencyLedger."CaRMS Status" := StudentResidency."CaRMS Status";
        ResidencyLedger."Residency Status" := StudentResidency."Residency Status";
        ResidencyLedger."NRMP Status" := StudentResidency."NRMP Status";
        ResidencyLedger."San Francisco Status" := StudentResidency."San Francisco Status";
        ResidencyLedger."Modified By" := UserId();
        ResidencyLedger."Modified On" := Today();
        ResidencyLedger.Insert();
    End;

    Var
        EducationSetupRec: Record "Education Setup-CS";
        StudentResidency: Record Residency;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];


}