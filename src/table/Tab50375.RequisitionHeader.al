table 50375 "Requisition Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            OptionCaption = 'Requisition,Indent';
            OptionMembers = Requisition,Indent;
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    PurchSetup.GET();
                    //NoSeriesMgt.TestManual(GetNoSeriesCode);
                    NoSeriesMgt.TestManual(PurchSetup."Requisition No.");
                    "No. Series" := '';
                END;
            end;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateRequisitionLines(FIELDCAPTION("Posting Date"), CurrFieldNo <> 0);
                //IF "Posting Date" <> 0D THEN
                //    GenJnlPostLine.TestbacklogEntry("Posting Date");
            end;
        }
        field(4; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                UpdateRequisitionLines(FIELDCAPTION("Document Date"), CurrFieldNo <> 0);
            end;
        }
        field(5; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Location WHERE("Requisition Type" = field("Requisition Type"));

            trigger OnValidate()
            var
                RecLoc: Record Location;
            begin
                //CSPL-00307 Starts 17-11-21
                //Cmnt 18-11-21 logic changed as per dushyant
                // IF RecLoc.Get(Rec."Location Code") then begin
                //     Rec.Validate("Global Dimension 1 Code", RecLoc."Global Dimension 1 Code");
                //     IF Rec."Location Code" = 'NEW YORK' then
                //         Rec.Validate("Requisition Type", Rec."Requisition Type"::"New York")
                //     else
                //         Rec.Validate("Requisition Type", Rec."Requisition Type"::Campus);
                // end;
                //CSPL-00307 Ends

                IF Rec."Global Dimension 1 Code" = '9100' then
                    TestField("Location Code", 'Antigua');
                UpdateRequisitionLines(FIELDCAPTION("Location Code"), CurrFieldNo <> 0);
            end;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

                IF Rec."Global Dimension 1 Code" IN ['9000', '9100'] then
                    Rec.Validate("Requisition Type", Rec."Requisition Type"::Campus)
                else
                    Rec.Validate("Requisition Type", Rec."Requisition Type"::"New York");

                //22-12-21
                "Location Code" := ' ';
                IF Rec."Global Dimension 1 Code" = '9100' then
                    Validate("Location Code", 'Antigua');
                IF Rec."Global Dimension 1 Code" = '8000' then
                    Validate("Location Code", 'NEW YORK');
                //22-12-21

                UpdateRequisitionLines(FIELDCAPTION("Global Dimension 1 Code"), CurrFieldNo <> 0);
            end;
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            // TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), "Dimension Value Type" = filter(Standard));
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                UpdateRequisitionLines(FIELDCAPTION("Global Dimension 2 Code"), CurrFieldNo <> 0);
            end;

            trigger OnLookup()
            var
                RecDimValue: Record "Dimension Value";
                FilterCode: Text;
            begin
                //CSPL-00307 Starts
                FilterCode := '@' + CopyStr("Global Dimension 1 Code", 1, 2) + '*';
                RecDimValue.Reset();
                RecDimValue.SetRange("Global Dimension No.", 2);
                RecDimValue.SetRange("Dimension Value Type", RecDimValue."Dimension Value Type"::Standard);
                RecDimValue.SetFilter(Code, FilterCode);
                IF Page.RunModal(537, RecDimValue) = ACTION::LookupOK Then;
                Validate("Global Dimension 2 Code", RecDimValue.Code);
                //CSPL-00307 Ends
            end;
        }
        field(8; "User Id"; Code[50])
        {
            Description = '//also use in job card create user id';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(9; "Date & Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(10; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(12; Status; Option)
        {
            OptionCaption = 'Open,Pending for Approval,Approved';
            OptionMembers = Open,"Pending for Approval",Approved;
            Editable = false;
            DataClassification = CustomerContent;
        }

        field(14; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }


        field(19; Closed; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(21; Approved; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
        }


        field(31; "Closed By"; Code[50])
        {
            DataClassification = CustomerContent;
            Description = '//also used in job card  Final closer GSE Head';
        }
        field(32; "Closed Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = '//also used in job card  Final closer GSE Head';
        }
        field(50019; "1st Level Approval"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // begin
            //     IF "Document Type" = "Document Type"::Requisition THEN BEGIN
            //         recusersetup.GET(USERID);
            //         IF "Approval Status" = "Approval Status"::Open THEN
            //             ERROR('User needs to Send approval request');
            //         IF NOT (recusersetup."1st level Approve") THEN
            //             ERROR('You are not authorize the approve')
            //         ELSE
            //             IF "1st Level Approval" THEN BEGIN
            //                 "1st Level Approver Date" := Today();
            //                 "1st Level Approver ID" := UserId();
            //                 "Approval Status" := "Approval Status"::"Pending For 2nd Approval";
            //             END ELSE BEGIN
            //                 "1st Level Approver Date" := 0D;
            //                 "1st Level Approver ID" := '';
            //                 "Approval Status" := "Approval Status"::"Pending For 1st Approval";
            //             END;
            //     END;
            // end;
        }
        field(50020; "2nd Level Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;

            // trigger OnValidate()
            // begin
            //     IF "Document Type" = "Document Type"::Requisition THEN BEGIN
            //         IF NOT "1st Level Approval" THEN
            //             ERROR('1st level approval required');

            //         recusersetup.GET(USERID);
            //         IF NOT recusersetup."2nd Level Approve" THEN
            //             ERROR('You are not authorize the approve')
            //         ELSE
            //             IF "2nd Level Approval" THEN BEGIN
            //                 "2nd Level Approver Date" := Today();
            //                 "2nd Level Approver ID" := UserId();
            //                 "Approval Status" := "Approval Status"::"Pending For 3Rd Approval";
            //             END ELSE begin
            //                 "2nd Level Approver Date" := 0D;
            //                 "2nd Level Approver ID" := '';
            //                 "Approval Status" := "Approval Status"::"Pending For 2nd Approval";
            //             END;
            //         //"Indent Status":="Indent Status"::"Pending For 2nd Approval";
            //     END;
            // end;
        }
        field(50021; "3rd Level Approval"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                // IF "Document Type" = "Document Type"::Requisition THEN BEGIN
                //     IF NOT "2nd Level Approval" THEN
                //         ERROR('2nd level approval required');
                //     recusersetup.GET(USERID);
                //     IF NOT recusersetup."3rd level Approve" THEN
                //         ERROR('You are not authorize the approve')
                //     ELSE
                //         IF "3rd Level Approval" THEN BEGIN
                //             // "Final Approve Date" := TODAY();
                //             "3rd Level Approver Date" := Today();
                //             "3rd Level Approver ID" := UserId();
                //             "Approval Status" := "Approval Status"::Approved;
                //         END ELSE BEGIN
                //             //"Final Approve Date" := 0D;
                //             "3rd Level Approver Date" := 0D;
                //             "3rd Level Approver ID" := '';
                //             "Approval Status" := "Approval Status"::"Pending For 3Rd Approval";
                //         END;
                //     // "Approval Status":="Approval Status"::"Pending For 3Rd Approval";
                // END;
            end;
        }
        field(50022; "1st Level Approver ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50023; "2nd Level Approver ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50024; "3rd Level Approver ID"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50025; "Rejection Status"; Option)
        {
            DataClassification = CustomerContent;

            OptionMembers = " ","1st Level Rejection","2nd Level Rejection","3rd Level Rejection";

        }
        field(50032; Remarks; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(50036; "Approval Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Send to Store,Pending For 1st Approval,Pending For 2nd Approval,Pending For 3rd Approval,Approved,Closed,Rejected';
            OptionMembers = Open,"Send to Store","Pending For 1st Approval","Pending For 2nd Approval","Pending For 3rd Approval",Approved,Closed,Rejected;
        }
        field(50037; "Send Approver ID"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50038; "1st Level Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50039; "2nd Level Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50040; "3rd Level Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50041; "Send for Approval Date"; Date)
        {
            DataClassification = CustomerContent;
        }


        field(50068; "Reason"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";

            trigger OnValidate()
            var
                ReasonCode_lRec: Record "Reason Code";

            begin
                IF Reason <> '' then
                    If ReasonCode_lRec.Get(Reason) then
                        "Reason Description" := ReasonCode_lRec.Description
                    ELSE
                        "Reason Description" := '';

            end;
        }
        field(50069; "Reason Description"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50070; "Created By"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50071; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50072; "Responsible Department"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Purchase,Store,Completed;
            Editable = false;
        }
        field(50073; Posted; Boolean)
        {
            Editable = False;
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }
        field(50074; Inserted; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Inserted';
        }

        field(50075; Updated; Boolean)
        {
            DataClassification = Customercontent;
            Caption = 'Updated';
        }
        field(50076; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Document Type", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

    end;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PurchSetup.get();
            PurchSetup.TestField("Requisition No.");
            NoSeriesMgt.InitSeries(PurchSetup."Requisition No.", xrec."No. Series", 0D, "No.", "No. Series");
        end;
        /*      TestNoSeriesPermission;
                PurchSetup.GET();
                 IF "Document No." = '' THEN BEGIN
                    IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
                        IF "Sub Document Type" = "Sub Document Type"::" " THEN BEGIN
                            Selection := STRMENU(Text00001, 1);
                            IF Selection = 1 THEN
                                "Sub Document Type" := "Sub Document Type"::GSE;
                            IF Selection = 2 THEN
                                "Sub Document Type" := "Sub Document Type"::Indigenous;
                            IF Selection = 3 THEN
                                "Sub Document Type" := "Sub Document Type"::Other;
                        END;
                        IF "Sub Document Type" = "Sub Document Type"::" " THEN
                            ERROR('Type Of Document Must be Selected');

                        TestNoSeries;
                        NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "Document No.", "No. Series");
                    END ELSE BEGIN 
                TestNoSeries;
                NoSeriesMgt.InitSeries(GetNoSeriesCode, xRec."No. Series", 0D, "Document No.", "No. Series");
                END;
                END; */

        "Document Date" := WORKDATE();
        "Posting Date" := WORKDATE();
        "User Id" := FORMAT(USERID());
        "Date & Time" := CURRENTDATETIME();

        Inserted := True;
        // NoSeries.RESET();
        // NoSeries.SETRANGE(NoSeries.Code, "No. Series");
        // IF NoSeries.FIND('-') THEN BEGIN
        //     "Location Code" := NoSeries."Location Code";
        //     "Global Dimension 1 Code" := NoSeries."Shortcut Dimension 1 Code";
        //     "Global Dimension 2 Code" := NoSeries."Shortcut Dimension 2 Code";
        // END;

        // IF "Document Type" = "Document Type"::Indent THEN BEGIN
        //     recnoseries.RESET();
        //     recnoseries.SETRANGE(recnoseries.Code, "No. Series");
        //     IF recnoseries.FIND('-') THEN
        //         "Location Code" := recnoseries."Location Code";
        //     "Global Dimension 1 Code" := recnoseries."Shortcut Dimension 1 Code";
        //     "Global Dimension 2 Code" := recnoseries."Shortcut Dimension 2 Code";
        //     VALIDATE("Global Dimension 1 Code");
        //     VALIDATE("Global Dimension 2 Code");

        // END;

        "User Id" := FORMAT(USERID());
        Status := Status::Open;

    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    trigger OnRename()
    begin
        // IF "Document Type" = "Document Type"::Job THEN
        //  ERROR('Rename is not allowed');
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        PurchSetup2: Record "Purchases & Payables Setup";

        // recusersetup: Record "User Setup";
        // recnoseries: Record "No. Series";
        // reqline: Record "Requisition Line_";

        // NoSeries: Record "No. Series";
        // RecFA: Record "Fixed Asset";
        // RecItem: Record Item;
        // RecFAL: Record "FA Depreciation Book";
        // RecFAL1: Record "FA Depreciation Book";
        // RecFA1: Record "Human Resource Unit of Measure";
        // DimensionValue: Record "Dimension Value";
        // USERSETUP: Record "User Setup";
        // VendorRec: Record Vendor;
        // RComment: Record "Comment Line";
        // RecPL: Record "Requisition Line_";
        RequisitionRec: Record "Requisition Header";
        RequisitionLineRec: Record "Requisition Line_";
        //RequisitionLine1: Record "Requisition Line_";
        NoSeriesMgt2: Codeunit NoSeriesManagement;
        // GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        //Text000: Label 'You have canceled the create process.';
        Text031Lbl: Label 'You have modified %1.\\';
        Text032Lbl: Label 'Do you want to update the lines?';
    // Text001: Label 'Replace existing attachment?';
    // Text002: Label 'You have canceled the import process.';
    // Text005: Label 'Export Attachment';

    // Selection: Integer;
    // Text00001: Label '&GSE,&Indigenous,&Others';

    // Duration1: Duration;
    // TempAge: Integer;
    // Age2: Integer;
    // Age1: Integer;
    // Months: Integer;

    procedure AssistEdit(OldRequisitionHeader: Record "Requisition Header"): Boolean
    begin
        WITH RequisitionRec DO BEGIN
            RequisitionRec := Rec;
            PurchSetup2.GET();
            PurchSetup2.TESTFIELD("Requisition No.");
            IF NoSeriesMgt2.SelectSeries(PurchSetup2."Requisition No.", OldRequisitionHeader."No. Series", "No. Series") THEN BEGIN
                PurchSetup2.GET();
                PurchSetup2.TESTFIELD("Requisition No.");
                NoSeriesMgt.SetSeries("No.");
                Rec := RequisitionRec;
                EXIT(TRUE);
            END;
        END;

        //TestNoSeriesPermission;
        /*         PurchSetup.GET();
                TestNoSeries;
                IF NoSeriesMgt.SelectSeries(GetNoSeriesCode, OldRequisitionHeader."No. Series", "No. Series") THEN BEGIN
                    PurchSetup.GET();
                    TestNoSeries;
                    IF NOT ("Document Type" = "Document Type"::Job) THEN BEGIN
                        IF "Sub Document Type" = "Sub Document Type"::" " THEN BEGIN
                            Selection := STRMENU(Text00001, 1);
                            IF Selection = 1 THEN
                                "Sub Document Type" := "Sub Document Type"::GSE;
                            IF Selection = 2 THEN
                                "Sub Document Type" := "Sub Document Type"::Indigenous;
                            IF Selection = 3 THEN
                                "Sub Document Type" := "Sub Document Type"::Other;
                        END;
                        IF "Sub Document Type" = "Sub Document Type"::" " THEN
                            ERROR('Type Of Document Must be Selected');
                        NoSeriesMgt.SetSeries("Document No.");
                    END ELSE
                        NoSeriesMgt.SetSeries("Document No.");
                    EXIT(TRUE);
                END; */

    end;

    procedure GetNoSeriesCode(): Code[20]
    begin
        CASE "Document Type" OF
            "Document Type"::Requisition:
                EXIT(PurchSetup."Requisition No.");
        //  "Document Type"::Indent:
        //  EXIT(PurchSetup."Req Indent No.");
        // "Document Type"::Job:
        //   EXIT(PurchSetup."Job Card No.");
        END;
    end;

    procedure TestNoSeries()
    begin
        CASE "Document Type" OF
            "Document Type"::Requisition:
                PurchSetup.TESTFIELD(PurchSetup."Requisition No.");
        //"Document Type"::Indent:
        //   PurchSetup.TESTFIELD(PurchSetup."Req Indent No.");
        // "Document Type"::Job:
        //   PurchSetup.TESTFIELD(PurchSetup."Job Card No.");
        END;
    end;

    procedure UpdateRequisitionLines(ChangedFieldName: Text; AskQuestion: Boolean)
    var
        DimensionValue: Record "Dimension Value";
        Question: Text[250];
        UpdateLines: Boolean;
    begin
        IF RequisitionLinesExist() AND AskQuestion THEN BEGIN
            Question := STRSUBSTNO(
              Text031Lbl +
              Text032Lbl, ChangedFieldName);
            IF GUIALLOWED() AND NOT DIALOG.CONFIRM(Question, TRUE) THEN
                EXIT
            ELSE
                UpdateLines := TRUE;
        END;

        DimensionValue.Reset();
        DimensionValue.SetRange(DimensionValue.Code, Rec."Global Dimension 2 Code");
        if DimensionValue.FindFirst() then begin
            rec.Validate("Department Name", DimensionValue.Name);
        end;

        RequisitionLineRec.RESET();
        RequisitionLineRec.SETRANGE(RequisitionLineRec."Document Type", "Document Type");
        RequisitionLineRec.SETRANGE(RequisitionLineRec."Document No.", "No.");
        IF RequisitionLineRec.FIND('-') THEN
            REPEAT
                RequisitionLineRec."Document Date" := "Document Date";
                RequisitionLineRec."Posting Date" := "Posting Date";
                RequisitionLineRec."Global Dimension 1 Code" := "Global Dimension 1 Code";
                RequisitionLineRec."Global Dimension 2 Code" := "Global Dimension 2 Code";
                RequisitionLineRec."Department Name" := "Department Name";
                RequisitionLineRec."Location Code" := "Location Code";
                RequisitionLineRec.MODIFY();
            UNTIL RequisitionLineRec.NEXT() = 0;
        /*
        //CS UT
        RequisitionLineRec.RESET();
        RequisitionLineRec.SETRANGE(RequisitionLineRec."Document Type",RequisitionLineRec."Document Type"::Indent);
        RequisitionLineRec.SETRANGE(RequisitionLineRec."Document No.","Document No.");
        IF RequisitionLineRec.FIND('-') THEN
          REPEAT
            RequisitionLineRec."Indent Status":="Indent Status";
            RequisitionLineRec.MODIFY();
          UNTIL RequisitionLineRec.NEXT=0;
        //CS UT
        */

    end;

    procedure RequisitionLinesExist(): Boolean
    begin
        RequisitionLineRec.RESET();
        RequisitionLineRec.SETRANGE(RequisitionLineRec."Document Type", RequisitionLineRec."Document Type"::Requisition);
        RequisitionLineRec.SETRANGE(RequisitionLineRec."Document No.", "No.");
        EXIT(RequisitionLineRec.FIND('-'));
    end;

    procedure AttachmentCode()
    begin
        /*         IF "Interaction Code"='' THEN BEGIN
                  PurchSetup.GET();
                  PurchSetup.TESTFIELD("Purchase Attachment Code");
                  "Interaction Code":=NoSeriesMgt.GetNextNo(PurchSetup."Purchase Attachment Code",0D,TRUE);
                  MODIFY();
                  COMMIT;
                END; */
    end;

    procedure TestNoSeriesPermission()
    begin
        /*
         IF ("Document Type" = "Document Type"::Job) THEN BEGIN
           USERSETUP.RESET();
           USERSETUP.SETRANGE(USERSETUP."User ID",UPPERCASE(USERID));
           IF  USERSETUP.FIND('-') THEN BEGIN
             IF (USERSETUP."MCJ Creater" = FALSE) THEN
               ERROR('Do you not have permission ');
           END;
         END; */
    end;



    procedure UpdateRequisitionLines(RequisitionHeader: Record "Requisition Header"; Boolean_pBool: Boolean)
    var
        RequisitionLine_lRec: Record "Requisition Line_";
    begin
        RequisitionLine_lRec.Reset();
        RequisitionLine_lRec.SetRange("Document Type", RequisitionHeader."Document Type");
        RequisitionLine_lRec.SetRange("Document No.", RequisitionHeader."No.");
        IF RequisitionLine_lRec.FindSet() then
            repeat
                RequisitionLine_lRec.Approved := Boolean_pBool;
                RequisitionLine_lRec.Modify();
            until RequisitionLine_lRec.Next() = 0;


    end;

    // procedure ApprovalMail(RecipientUserID: Text[2048]; SubjectMsg: Text[250]; BodyMsg: Text[250])
    // var
    //     // StudentMaster_lRec: Record "Student Master-CS";
    //     SmtpMailRec: record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[250];
    //     Recipients: List of [Text];
    //     Recipient: Text[2048];

    // begin
    //     SmtpMailRec.Get();
    //     Recipient := RecipientUserID;
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := SubjectMsg;

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Hi' + ', ');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(BodyMsg);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(CreateMailBody());
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();

    // end;

    // procedure RejectedMail(RecipientUserID: Text[2048]; SubjectMsg: Text[250]; BodyMsg: Text[250])
    // var
    //     // StudentMaster_lRec: Record "Student Master-CS";
    //     SmtpMailRec: record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[250];
    //     Recipients: List of [Text];
    //     Recipient: Text[2048];

    // begin
    //     SmtpMailRec.Get();
    //     Recipient := RecipientUserID;
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := SubjectMsg;
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Hi' + ', ');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(BodyMsg);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody(CreateMailBody());
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Thanking You');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('This Is System Generated Mail.Please Do Not Reply On This E-mail ID');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     Mail_lCU.Send();

    // end;


    procedure CreateMailBody(): Text
    var
        ReqLine: record "Requisition Line_";
        EmailText: Text;
    begin
        EmailText += '<table border ="1">';
        EmailText += '<tr>';
        EmailText += '<th> Requisition No. </th>';
        EmailText += '<th> Item Code </th>';
        EmailText += '<th> Description </th>';
        EmailText += '<th> Requested Quantity </th>';
        EmailText += '</tr>';
        ReqLine.RESET();
        ReqLine.SETRANGE("Document No.", "No.");
        ReqLine.SETRANGE("Document Type", "Document Type");
        IF ReqLine.FINDSET() THEN
            REPEAT
                EmailText += '<tr>';
                EmailText += '<td>' + FORMAT(ReqLine."Document No.") + '</td>';
                EmailText += '<td>' + FORMAT(ReqLine."Item Code") + '</td>';
                EmailText += '<td>' + FORMAT(ReqLine."Description") + '</td>';
                EmailText += '<td>' + FORMAT(ReqLine."Requested Quantity") + '</td>';
                EmailText += '</tr>';
            UNTIL ReqLine.NEXT() = 0;
        EmailText += '</table>';
        EXIT(EmailText);
    end;

    procedure SendRequisitionLastLine(RequisitionNo: Code[20]): Text[100]
    var
        recRqLine: Record "Requisition Line_";
        recRqHeader: Record "Requisition Header";
        StockCheck: Boolean;
    begin
        StockCheck := True;
        recRqLine.Reset();
        recRqLine.SetRange("Document No.", RequisitionNo);
        IF recRqLine.FindSet() then begin
            repeat
                recRqLine.CalcFields("Stock In Hand");
                IF (recRqLine."Requested Quantity") > (recRqLine."Stock In Hand") then
                    StockCheck := false;
            until recRqLine.Next() = 0;
            IF StockCheck = false then begin
                recRqHeader.reset();
                recRqHeader.SetRange("No.", RequisitionNo);
                IF recRqHeader.FindFirst() THEN begin
                    recRqHeader."Approval Status" := recRqHeader."Approval Status"::"Pending For 1st Approval";
                    recRqHeader."Responsible Department" := recRqHeader."Responsible Department"::Purchase;
                    recRqHeader.Status := recRqHeader.Status::"Pending for Approval";
                    recRqHeader.MODIFY();
                end;
            end else begin
                recRqHeader.reset();
                recRqHeader.SetRange("No.", RequisitionNo);
                IF recRqHeader.FindFirst() THEN begin
                    recRqHeader."Responsible Department" := "Responsible Department"::Store;
                    recRqHeader.Modify();
                end;
            end;
        end;
    end;

    procedure CreateItemJournalLine(var ReqLine: Record "Requisition Line_")
    var
        DocApproverUser: Record "Document Approver Users";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ItmJnlBatch: Record "Item Journal Batch";
        Item: Record Item;
        LineNo_Var: Integer;
        ItmJnl: Record "Item Journal Line";
    begin
        // if ReqLine.Get(Item."No.") then;
        item.Reset();
        item.SetRange(Item."No.", ReqLine."Item Code");
        if item.FindFirst() then;
        If ItmJnlBatch."No. Series" <> '' then begin
            Clear(NoSeriesMgt);
            ItmJnl."Document No." := NoSeriesMgt.TryGetNextNo(ItmJnlBatch."No. Series", WorkDate());
        end;
        ReqLine.SetRange("Document No.", rec."No.");
        ReqLine.SetRange("Document Type", ReqLine."Document Type"::Requisition);
        if ReqLine.FindSet() then
            repeat
                CLEAR(LineNo_Var);
                ItmJnl.Reset();
                ItmJnl.SetCurrentKey("Line No.");
                ItmJnl.SetRange("Journal Template Name", 'ITEM');
                ItmJnl.SetRange("Journal Batch Name", 'DEFAULT');
                if ItmJnl.FindLast() then
                    LineNo_Var := ItmJnl."Line No." + 10000
                else
                    LineNo_Var := 10000;
                ItmJnl.Init();
                ItmJnl.Validate("Journal Template Name", 'ITEM');
                ItmJnl.Validate("Journal Batch Name", 'DEFAULT');
                ItmJnl.Validate("Line No.", LineNo_Var);
                ItmJnl.Validate("Posting Date", Rec."Posting Date");
                ItmJnl.Validate("Entry Type", ItmJnl."Entry Type"::"Negative Adjmt.");
                ItmJnl.Validate("Item No.", ReqLine."Item Code");
                ItmJnl.Validate(Description, ReqLine.Description);
                ItmJnl.Validate("Location Code", ReqLine."Location Code");
                ItmJnl.Validate(Quantity, ReqLine."Quantity To Issue");
                ItmJnl.Validate("Unit of Measure Code", ReqLine."Unit of Measure Code");
                ItmJnl.Validate("Unit Cost", Item."Unit Cost");
                ItmJnl.Validate("Shortcut Dimension 1 Code", ReqLine."Global Dimension 1 Code");
                ItmJnl.Validate("Shortcut Dimension 2 Code", ReqLine."Global Dimension 2 Code");
                // ItmJnl.Validate(Amount, ItmJnl.Quantity *);
                ItmJnl.Insert();
            until ReqLine.Next() = 0;
    end;
}