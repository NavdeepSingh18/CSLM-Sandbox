table 50116 "RTGS Payment Summary-CS"
{
    // version V.001-CS

    Caption = 'RTGS Payment Summary-CS';
    DataCaptionFields = "Request No.", "Student Name";
    fields
    {
        field(1; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UserSetup.Get(UserId());
                IF "Request No." <> xRec."Request No." THEN BEGIN
                    FeeSetupRec.Reset();
                    "FeeSetupRec".SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                    IF FeeSetupRec.FindFirst() then begin
                        NoSeriesMgt.TestManual(FeeSetupRec."Wired Transfer Nos.");
                        "No. Series" := '';
                    End;
                END;
            end;
        }
        field(2; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";
            begin
                IF "Student No." <> '' then begin
                    StudentMaster_lRec.Reset();
                    If StudentMaster_lRec.Get("Student No.") then begin
                        "Student Name" := Format(StudentMaster_lRec."First Name" + ' ' + StudentMaster_lRec."Middle Name" + ' ' + StudentMaster_lRec."Last Name");
                        "Academic Year" := StudentMaster_lRec."Academic Year";
                        Semester := StudentMaster_lRec.Semester;
                        "Enrolment No." := StudentMaster_lRec."Enrollment No.";
                        "Email ID" := StudentMaster_lRec."E-Mail Address";
                        "Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                    end;
                end else begin
                    "Student Name" := '';
                    "Enrolment No." := '';
                    "Academic Year" := '';
                    Semester := '';
                    "Email ID" := '';
                    "Global Dimension 1 Code" := '';
                end;
            end;
        }

        field(3; "Transaction Number"; Code[35])
        {
            Caption = 'Transaction Number';
            DataClassification = CustomerContent;
        }
        field(4; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            DataClassification = CustomerContent;
        }
        field(5; "Fee Amount"; Decimal)
        {
            Caption = 'Fee Amount';
            DataClassification = CustomerContent;
        }
        field(6; "Bank Name"; Text[80])
        {
            Caption = 'Bank Name';
            DataClassification = CustomerContent;
        }
        field(7; "Remitter Name"; Text[80])
        {
            Caption = 'Remitter Name';
            DataClassification = CustomerContent;
        }
        field(8; Remarks; Text[500])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(9; "Requested Date"; Date)
        {
            Caption = 'Requested Date';
            DataClassification = CustomerContent;
        }
        field(10; "Requested By"; Text[50])
        {
            Caption = 'Requested By';
            DataClassification = CustomerContent;
        }
        field(12; "Approved By"; Text[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(13; "Approved Date"; Date)
        {
            Caption = 'Approved Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "Approved Time"; Time)
        {
            Caption = 'Approved Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Rejected By"; Text[50])
        {
            Caption = 'Reject By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "Rejected Date"; Date)
        {
            Caption = 'Rejected Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "Rejected Time"; Time)
        {
            Caption = 'Rejected Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; Updated; Boolean)
        {
            Caption = 'Updated';
            DataClassification = CustomerContent;
        }
        field(19; "Mobile no."; Text[20])
        {
            Caption = 'Mobile No.';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(20; "Email ID"; Text[80])
        {
            Caption = 'Email ID';
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
            Editable = false;
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(23; "Fee Type"; Text[100])
        {
            Caption = 'Fee Type';
            DataClassification = CustomerContent;
        }
        field(24; "Recipt No."; Code[11])
        {
            Caption = 'Recipt No.';
            DataClassification = CustomerContent;
        }
        field(25; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(26; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(27; "Enrolment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(28; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS".Code;
            Editable = False;
        }
        field(29; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code;
            Editable = False;
        }
        field(30; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionCaption = 'Pending for Approval,Approved,Rejected';
            OptionMembers = "Pending for Approval",Approved,Rejected;
            Editable = false;
        }

    }

    keys
    {
        key(Key1; "Request No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        IF "Request No." = '' THEN BEGIN
            UserSetup.Get(UserId());
            FeeSetupRec.Reset();
            FeeSetupRec.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            FeeSetupRec.FindFirst();
            FeeSetupRec.TestField(FeeSetupRec."Wired Transfer Nos.");
            NoSeriesMgt.InitSeries(FeeSetupRec."Wired Transfer Nos.", xRec."No. Series", 0D, "Request No.", "No. Series");
        END;
    End;

    var
        UserSetup: Record "User Setup";
        FeeSetupRec: Record "Fee Setup-CS";
        RTGSPaymentCSRec: Record "RTGS Payment Summary-CS";
        RTGSLineRec: Record "RTGS Line";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        GenJournalWebCod: Codeunit "Gen. Web  Journal -CS";
        DocNo: Code[20];
        Amt: Decimal;
        AppliedBy: Option Invoice,Receipt;
        ReturnText: Text[100];
        Text003_gTxt: Label 'Do you want to Approve Request No. %1?';
        Text004_gTxt: Label 'Request No. %1 Successfully Approved..!';
        Text005_gTxt: Label 'Do you want to Reject Request No. %1?';
        Text006_gTxt: Label 'Request No. %1 Successfully Rejected..!';


    procedure AssistEdit(OldRTGSPaymentCS: Record "RTGS Payment Summary-CS"): Boolean
    var
    begin
        UserSetup.Get(UserId());
        WITH RTGSPaymentCSRec DO BEGIN
            RTGSPaymentCSRec := Rec;
            FeeSetupRec.Reset();
            FeeSetupRec.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
            IF FeeSetupRec.FindFirst() then begin
                FeeSetupRec.TESTFIELD(FeeSetupRec."Wired Transfer Nos.");
                IF NoSeriesMgt.SelectSeries(FeeSetupRec."Wired Transfer Nos.", OldRTGSPaymentCS."No. Series", "No. Series") THEN BEGIN
                    NoSeriesMgt.SetSeries("Request No.");
                    Rec := RTGSPaymentCSRec;
                    EXIT(TRUE);
                END;
            end;
        END;
    end;

    procedure Approve()
    begin
        // Create Function for Approval::CSPL-00114::07012019: Start
        IF CONFIRM(Text003_gTxt, FALSE, "Request No.") THEN BEGIN
            RTGSLineRec.Reset();
            RTGSLineRec.SetRange("Document No.", "Request No.");
            RTGSLineRec.SetCurrentKey("Last Line");
            if RTGSLineRec.FindSet() then
                repeat
                    Amt += RTGSLineRec."Applied Amount";
                until RTGSLineRec.Next() = 0;

            if "Fee Amount" <> Amt then
                Error('Fee Amount and Applied Amount must be same.');

            FeeSetupRec.Reset();
            FeeSetupRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
            FeeSetupRec.FindFirst();

            ReturnText := GenJournalWebCod.WEBAPIInsertPayment(FeeSetupRec."Wired Transfer Template Name", FeeSetupRec."Wired Transfer Batch Name"
            , "Student No.", "Fee Amount", '', '', '', '', '', "Global Dimension 2 Code");
            DocNo := CopyStr(ReturnText, 5, StrLen(ReturnText));
            if DocNo <> '' then begin
                RTGSLineRec.Reset();
                RTGSLineRec.SetRange("Document No.", "Request No.");
                RTGSLineRec.SetCurrentKey("Last Line");
                if RTGSLineRec.FindSet() then
                    repeat
                        GenJournalWebCod.WEBAPIEntryApplied(FeeSetupRec."Wired Transfer Template Name", FeeSetupRec."Wired Transfer Batch Name", RTGSLineRec."Invoice No."
                        , RTGSLineRec."Applied Amount", '', AppliedBy::Invoice, DocNo, RTGSLineRec."Last Line");
                    until RTGSLineRec.Next() = 0;
                IF UserSetup.GET(UserId()) THEN
                    "Approved Date" := Today();
                "Approved By" := FORMAT(UserId());
                Status := Status::Approved;
                Updated := TRUE;
                Modify();
            end else
                Error('There is nothing to apply.');
            MESSAGE(Text004_gTxt, "Request No.");
        END;
        // Create Function for Approval::CSPL-00114::07012019: End
    end;

    procedure Reject()
    begin
        // Create Function for Reject::CSPL-00114::07012019: Start
        IF CONFIRM(Text005_gTxt, FALSE, "Request No.") THEN BEGIN
            IF UserSetup.GET(UserId()) THEN
                "Rejected Date" := Today();
            "Rejected By" := FORMAT(UserId());
            Status := Status::Rejected;
            Updated := TRUE;
            MESSAGE(Text006_gTxt, "Request No.");
            Modify();
        END;
        // Create Function for Reject::CSPL-00114::07012019: End
    end;
}

