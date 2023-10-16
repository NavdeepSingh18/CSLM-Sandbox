table 50400 "Financial AID"
{
    Caption = 'Financial AID';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Application No.", "Student Name";
    //LookupPageId = FinancialAIDApprovRejectList;
    //DrillDownPageId = FinancialAIDApprovRejectList;

    fields
    {
        field(1; "Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FeeSetup: Record "Fee Setup-CS";
            begin
                GetFeeSetup(FeeSetup);
                FeeSetup.TestField("Financial AID No.");
                NoSeriesMgmt_lCU.TestManual(FeeSetup."Financial AID No.");
                "No. Series" := '';
            end;


        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                FeeSetup: Record "Fee Setup-CS";
            begin
                GetFeeSetup(FeeSetup);

                if (StrLen(format(FeeSetup."Fin. Aid Exp. Date Formula")) <> 0) and ("Application Date" <> 0D) then
                    "Loan Expiry Date" := CalcDate(FeeSetup."Fin. Aid Exp. Date Formula", "Application Date")
                else
                    "Loan Expiry Date" := 0D;
            end;
        }
        field(3; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                RecFinanaceAID: Record "Financial AID";
                StudentMaster_lRec: Record "Student Master-CS";
                CourseMaster: Record "Course Master-CS";
                FeeSetup: Record "Fee Setup-CS";
            begin
                GetFeeSetup(FeeSetup);
                IF "Student No." <> '' then begin
                    StudentMaster_lRec.Reset();
                    If StudentMaster_lRec.Get("Student No.") then begin
                        if (StrLen(format(FeeSetup."Fin. Aid Exp. Date Formula")) <> 0) and ("Application Date" <> 0D) then
                            "Loan Expiry Date" := CalcDate(FeeSetup."Fin. Aid Exp. Date Formula", "Application Date")
                        else
                            "Loan Expiry Date" := 0D;

                        // CourseSem.Reset();
                        // CourseSem.SetRange("Course Code", StudentMaster_lRec."Course Code");
                        // CourseSem.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        // CourseSem.SetFilter("Semester Code", StudentMaster_lRec.Semester);
                        // if CourseSem.FindFirst() then
                        //     ReqSemSeq := CourseSem."Sequence No" - 1;
                        // if ReqSemSeq > 0 then begin
                        //     CourseSem.Reset();
                        //     CourseSem.SetRange("Course Code", StudentMaster_lRec."Course Code");
                        //     CourseSem.SetRange("Academic Year", StudentMaster_lRec."Academic Year");
                        //     CourseSem.SetRange("Sequence No", ReqSemSeq);
                        //     if CourseSem.FindFirst() then begin
                        //         RecFinanaceAID.Reset();
                        //         RecFinanaceAID.SetRange("Student No.", "Student No.");
                        //         RecFinanaceAID.SetRange(Semester, CourseSem."Semester Code");
                        //         RecFinanaceAID.SetRange(Type, Type);
                        //         RecFinanaceAID.SetRange(Status, Status::Approved);
                        //         IF RecFinanaceAID.FindFirst() then
                        //             if StrLen(format(EducationSetup_lRec."Fin. Aid Exp. Date Formula")) <> 0 then
                        //                 "Loan Expiry Date" := CalcDate(EducationSetup_lRec."Fin. Aid Exp. Date Formula");
                        //     end;
                        // end;

                        If Type = Type::"Financial Aid" then begin
                            CourseMaster.Reset();
                            CourseMaster.Get(StudentMaster_lRec."Course Code");
                            if not CourseMaster."Financial AID Applicable" then
                                Error('Student No. %1 has course %2 which is not applicable for Financial Aid.', StudentMaster_lRec."No.", StudentMaster_lRec."Course Code");
                        End;

                        "Student Name" := StudentMaster_lRec."Student Name";
                        "Academic Year" := StudentMaster_lRec."Academic Year";
                        Semester := StudentMaster_lRec.Semester;
                        "Enrollment No." := StudentMaster_lRec."Enrollment No.";
                        "Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := StudentMaster_lRec."Global Dimension 2 Code";
                        "Email Id" := StudentMaster_lRec."E-Mail Address";
                        "Date of Birth" := StudentMaster_lRec."Date of Birth";
                        "Phone No." := StudentMaster_lRec."Mobile Number";
                        "FSA ID" := StudentMaster_lRec."FSA ID";
                        Term := StudentMaster_lRec.Term;

                        RecFinanaceAID.Reset();
                        RecFinanaceAID.SetRange("Student No.", StudentMaster_lRec."No.");
                        RecFinanaceAID.SetRange("Academic Year", "Academic Year");
                        RecFinanaceAID.SetRange(Semester, Semester);
                        RecFinanaceAID.SetRange(Type, Type);
                        RecFinanaceAID.SetFilter(Status, '%1|%2', Status::"Pending for Approval", Status::Approved);
                        IF RecFinanaceAID.FindFirst() then
                            Error('%3 Application No. %1 already exist for Student No. %2', RecFinanaceAID."Application No.", StudentMaster_lRec."No.", RecFinanaceAID.Type);
                    end;
                end
                else
                    IF "Student No." = '' then begin
                        "Student Name" := '';
                        "Academic Year" := '';
                        Semester := '';
                        "Enrollment No." := '';
                        "Global Dimension 1 Code" := '';
                        "Global Dimension 2 Code" := '';
                        "Loan Expiry Date" := 0D;
                        "Email Id" := '';
                        "Date of Birth" := 0D;
                        "Phone No." := '';
                        "FSA ID" := '';
                    end;



            end;
        }
        field(4; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(6; "Academic Year"; Code[10])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(7; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = False;
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'CS Field Added 05-05-2019';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = False;
        }

        field(10; "Reason"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code".Code where(Type = filter("Financial AID"));
            trigger OnValidate()
            var
                ReasonCode_lRec: Record "Reason Code";
            begin
                IF Reason <> '' then Begin
                    ReasonCode_lRec.Reset();
                    If ReasonCode_lRec.Get(Reason) then BEGIN
                        // IF ReasonCode_lRec.Type = ReasonCode_lRec.Type::Reason then
                        "Reason Description" := ReasonCode_lRec.Description;
                    END;
                End ELSE
                    "Reason Description" := '';
            end;
        }
        field(11; "Reason Description"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Pending for Approval",Approved,Rejected;
            OptionCaption = 'Pending for Approval,Approved,Rejected';
            Editable = False;
        }

        field(13; "Approved/Rejected By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(14; "Approved/Rejected On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(15; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(16; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(17; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(18; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(19; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(21; "Entrance Counseling"; Option)
        {
            caption = 'Completed Entrance Counseling ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(22; "Unsubsidized Loan"; Option)
        {
            Caption = 'Completed Unsubsidized Loan ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckCasesBudgettedAmount();
                IF ("Unsubsidized Loan" = "Unsubsidized Loan"::" ") OR
                 ("Unsubsidized Loan" = "Unsubsidized Loan"::NO) then
                    "Unsubsidized Budgetted Amount" := 0;
            end;
        }
        field(23; "Direct Graduate plus loan"; Option)

        {
            Caption = 'Direct Graduate plus loan applied ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                CheckCasesBudgettedAmount();
                "Living expenses" := "Living expenses"::" ";
                IF ("Direct Graduate plus loan" = "Direct Graduate plus loan"::" ") OR
                ("Direct Graduate plus loan" = "Direct Graduate plus loan"::NO) then
                    "Graduate Plus Budgetted Amount" := 0;
            end;
        }
        field(24; "Living expenses"; Option)
        {
            Caption = 'Living expenses required ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Living expenses" = "Living expenses"::" " then begin
                    "Graduate Plus Budgetted Amount" := 0;
                    "Grad. Plus Transaction Amount" := 0;
                end;
                CheckCasesBudgettedAmount();
            end;
        }
        field(25; "Grad. Plus Transaction Amount"; Decimal)
        {
            Caption = 'Graduate Plus Transaction Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(26; "Unsubsidized Transation Amount"; Decimal)
        {
            Caption = 'Unsubsidized Transation Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(27; "Grad PLUS MPN"; Option)
        {
            Caption = 'Have you completed the Grad PLUS MPN ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(28; "Grad PLUS Denial"; Option)
        {
            Caption = 'If your credit was denied, are you appealing your Grad PLUS Denial ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(29; "Endorse"; Option)
        {
            Caption = 'If your credit was denied, do you have an Endorser ?';
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(30; "Loan Amount"; Decimal)
        {
            Caption = 'Loan Amount';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(31; "PLUS Counseling"; Option)
        {
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(32; "FSA ID"; Code[20])
        {

            DataClassification = CustomerContent;
        }

        field(33; "Loan Expiry Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(34; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(35; "Unsubsidized Budgetted Amount"; Decimal)
        {
            Caption = 'Unsubsidized Budgeted Amount';
            DataClassification = CustomerContent;
            Editable = false;
            MinValue = 0;
        }
        field(36; "Graduate Plus Budgetted Amount"; Decimal)
        {
            Caption = 'Graduate Plus Budgeted Amount';
            DataClassification = CustomerContent;
            Editable = false;
            MinValue = 0;
        }
        field(37; "Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Financial Aid","Payment Plan","Self Payment";
            OptionCaption = 'Financial Aid,Payment Plan,Self Payment';

        }
        field(50038; "Payment Plan Instalment"; Integer)
        {
            Caption = 'Payment Plan Instalment';
            MinValue = 2;
            MaxValue = 4;
            DataClassification = CustomerContent;

        }
        field(50039; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50040; "Email Id"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50041; "Visited FAFSA Website"; Option)
        {
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(50042; "Visited Student Loan Website"; Option)
        {
            OptionMembers = " ",YES,NO;
            DataClassification = CustomerContent;
        }
        field(50043; "Document Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50044; "Portal Entry"; Boolean)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(50045; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50046; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }

        field(50047; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

    }
    keys
    {
        key(PK; "Application No.")
        {
            Clustered = true;
        }
        key(key2; "Student No.", "Academic Year", Semester, Term)
        {
        }
        key(Key3; "Created On")
        {

        }
    }
    trigger OnInsert()
    var
        FeeSetup: Record "Fee Setup-CS";
        GlSetup: Record "General Ledger Setup";
    begin
        IF "Application No." = '' then begin
            IF Type = Type::"Financial Aid" Then begin
                GetFeeSetup(FeeSetup);
                FeeSetup.TestField("Financial AID No.");
                NoSeriesMgmt_lCU.InitSeries(FeeSetup."Financial AID No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
            end Else begin
                GlSetup.Get();
                GlSetup.TestField("Payment Plan No.");
                NoSeriesMgmt_lCU.InitSeries(GlSetup."Payment Plan No.", xRec."No. Series", 0D, "Application No.", Rec."No. Series");
            end;
        end;
        "Application Date" := WorkDate();
        "Document Date" := WorkDate();
        "Created By" := UserId();
        "Created On" := WorkDate();

        Inserted := true;
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    procedure AssistEdit(OldFinancialAID: Record "Financial AID"): Boolean
    var
        feeSetup: Record "Fee Setup-CS";
        SemesterRegstrationRec: Record "Financial AID";
        GlSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    begin
        with SemesterRegstrationRec do begin
            SemesterRegstrationRec := Rec;


            IF Type = Type::"Financial Aid" Then begin
                GetFeeSetup(FeeSetup);
                FeeSetup.TestField("Financial AID No.");
                if NoSeriesMgt.SelectSeries(FeeSetup."Financial AID No.", OldFinancialAID."No. Series", "No. Series") then begin
                    NoSeriesMgt.SetSeries("Application No.");
                    Rec := SemesterRegstrationRec;
                    exit(true);
                end Else begin
                    GlSetup.Get();
                    GlSetup.TestField("Payment Plan No.");
                    if NoSeriesMgt.SelectSeries(GlSetup."Payment Plan No.", OldFinancialAID."No. Series", "No. Series") then begin
                        NoSeriesMgt.SetSeries("Application No.");
                        Rec := SemesterRegstrationRec;
                        exit(true);
                    end;
                end;
            end;
        end;
    end;

    var
        NoSeriesMgmt_lCU: Codeunit NoSeriesManagement;
        WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];


    // procedure FinancialAIDRequestRejected(ApplicationNo: Code[20]; Type1: Option "Financial Aid","Payment Plan","Self Payment")
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
    //     Subject := Format(Type1) + ' ' + 'Request Rejected';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Application Number: ' + ApplicationNo);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that your' + ' ' + Format(Type1) + ' ' + 'request has been rejected. Kindly contact the');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('department office for the details and if you can reapply for it.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Financial AID Request', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Financial AID Request', 'Financial AID Request', Format(ApplicationNo), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);

    // end;

    procedure GetFeeSetup(var FeeSetup: Record "Fee Setup-CS")
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId());
        UserSetup.FindFirst();

        FeeSetup.Reset();
        //FeeSetup.SetRange("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
        FeeSetup.FindFirst();
    end;

    trigger OnDelete()
    begin
        if "Portal Entry" then
            Error('Application received from Student Portal cannot be deleted.');
    end;

    procedure CheckCasesBudgettedAmount()
    var
        FeeSetupRec: Record "Fee Setup-CS";
    begin
        FeeSetupRec.Reset();
        FeeSetupRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
        FeeSetupRec.FindFirst();

        //Case1
        IF ("Unsubsidized Loan" = "Unsubsidized Loan"::YES) then
            "Unsubsidized Budgetted Amount" := FeeSetupRec."Unsubsidized Budgetted Amount"
        else begin
            "Unsubsidized Budgetted Amount" := 0;
            "Unsubsidized Transation Amount" := 0;
        end;

        //Case2
        if ("Direct Graduate plus loan" = "Direct Graduate plus loan"::YES) AND
        (("Living expenses" = "Living expenses"::NO) or ("Living expenses" = "Living expenses"::" ")) then
            "Graduate Plus Budgetted Amount" := FeeSetupRec."Standard Cost";

        //Case3
        if ("Direct Graduate plus loan" = "Direct Graduate plus loan"::YES) AND
         ("Living expenses" = "Living expenses"::YES) then
            "Graduate Plus Budgetted Amount" := FeeSetupRec."Graduate Plus Budgetted Amount";

        //Case4
        if "Direct Graduate plus loan" in ["Direct Graduate plus loan"::No, "Direct Graduate plus loan"::" "] then begin
            "Graduate Plus Budgetted Amount" := 0;
            "Grad. Plus Transaction Amount" := 0;
        end;

    end;

}
