table 50424 "Requisition Approval entries"
{
    Caption = 'Requisition Approval entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Approval User ID"; Code[50])
        {
            Caption = 'Approval User ID';
            DataClassification = ToBeClassified;
        }
        field(3; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "Open","Approved","Rejected";

        }
        field(4; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Location Code"; Code[20])
        {
            Caption = 'Location Code.';
            DataClassification = ToBeClassified;
        }
        field(7; "Global Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), "Dimension Value Type" = filter(Standard));
            DataClassification = CustomerContent;
        }
        field(8; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Budget Name".Name where("Analysis Area" = filter(Purchase), "Global Dimension 1 Code" = field("Global Dimension 1 Code"), "Global Dimension 2 Code" = field("Global Dimension 2"));
            Trigger OnValidate()
            var
                ItemBudgetName: REcord "Item Budget Name";
            begin
                If "Budget Code" <> '' then begin
                    ItemBudgetName.Reset();
                    ItemBudgetName.SetRange("Analysis Area", ItemBudgetName."Analysis Area"::Purchase);
                    ItemBudgetName.SetRange(Name, "Budget Code");
                    ItemBudgetName.Setrange("Global Dimension 2 Code", Rec."Global Dimension 2");
                    If ItemBudgetName.FindFirst() then
                        "Budget Description" := ItemBudgetName.Description;
                end Else
                    "Budget Description" := '';
            end;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(10; "Item code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Unit of Meassure Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Requested Qty."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Requested User"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Budget Edit"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
        field(20; "Purchase Budget"; Code[20])
        {
            //CSPL-00307
            TableRelation = "Item Budget Name" where("Analysis Area" = const(Purchase));
            DataClassification = ToBeClassified;
            Trigger OnValidate()
            var
                ItemBudgetName: REcord "Item Budget Name";
            begin
                If "Purchase Budget" <> '' then begin
                    ItemBudgetName.Reset();
                    ItemBudgetName.SetRange("Analysis Area", ItemBudgetName."Analysis Area"::Purchase);
                    ItemBudgetName.SetRange(Name, "Purchase Budget");
                    If ItemBudgetName.FindFirst() then
                        "Budget Description" := ItemBudgetName.Description;
                end Else
                    "Budget Description" := '';
            end;
        }
        Field(21; "Budget Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(22; DepartmentApproval; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Stock In Hand"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                                  "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; Preferences; Code[10])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    procedure RequestApproveEntry(var ReqApprovalentries: Record "Requisition Approval entries")
    var
        ReqLine: Record "Requisition Line_";
        RequisitionHeader: record "Requisition Header";
        ReqApprovalUserSetUp: Record "Requisition Approval Setup";
        NewReqApprovalentries: Record "Requisition Approval entries";
        LastReqApprovalentries: Record "Requisition Approval entries";
        DepartmentApproverSetup: Record "Requisition Approval Setup";
        i: Integer;
        BudgetError: Label 'Budget code must have value.';

        SMTPSetup: Record "Email Account";
        CompanyInformation: Record "Company Information";
        StudentMaster: Record "Student Master-CS";

        User: Record User;
        UserSetup: Record "User Setup";
        SMTPMail: codeunit "Email Message";
        Mail_lCU: Codeunit Mail;
        Recipient: Text[100];
        Recipients: List of [Text];
        CCRecipient: Text[100];
        CCRecipients: List of [Text];
        MailSubject: Text[500];
        Body: Text;
        WindowDialog: Dialog;

        ReqHeader: Record "Requisition Header";
    begin
        if ReqApprovalentries."Budget Code" = '' then
            Error(BudgetError);

        IF ReqApprovalentries.DepartmentApproval = false then begin
            ReqLine.reset();
            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
            if ReqLine.FindFirst() then begin
                if NOT reqline."3rd Level Approval" then
                    I := 3;
                if NOT reqline."2nd Level Approval" then
                    I := 2;
                if NOT reqline."1st Level Approval" then
                    I := 1;
            end;
            ReqApprovalUserSetUp.Reset();
            ReqApprovalUserSetUp.SetRange("Location Code", ReqApprovalentries."Location Code");
            ReqApprovalUserSetUp.SetRange("Global Dimension 2 Code", ReqApprovalentries."Global Dimension 2");
            ReqApprovalUserSetUp.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Purchase);
            if NOT ReqApprovalUserSetUp.Findfirst() then
                error('No Approval Setup found for Selected Location and Department Code');

            if I = 1 then begin
                ReqApprovalUserSetUp.Reset();
                ReqApprovalUserSetUp.SetRange("Location Code", ReqApprovalentries."Location Code");
                ReqApprovalUserSetUp.SetRange("Global Dimension 2 Code", ReqApprovalentries."Global Dimension 2");
                ReqApprovalUserSetUp.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Purchase);
                if ReqApprovalUserSetUp.Findfirst() then begin
                    if ReqApprovalUserSetUp."Requisition Approver 2" <> '' then begin
                        NewReqApprovalentries.init();
                        NewReqApprovalentries.validate("Document No.", ReqApprovalentries."Document No.");
                        NewReqApprovalentries.validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                        NewReqApprovalentries.validate("Location Code", ReqApprovalentries."Location Code");
                        NewReqApprovalentries.validate(Status, NewReqApprovalentries.status::Open);
                        NewReqApprovalentries.validate("Budget Edit", false);
                        NewReqApprovalentries.validate("Document Line No.", ReqApprovalentries."Document Line No.");
                        NewReqApprovalentries.Validate("Approval User ID", ReqApprovalUserSetUp."Requisition Approver 2");
                        NewReqApprovalentries.Validate("Item code", ReqApprovalentries."Item Code");
                        NewReqApprovalentries.Validate(Description, ReqApprovalentries.Description);
                        NewReqApprovalentries.Validate("Location Code", ReqApprovalentries."Location Code");
                        NewReqApprovalentries.Validate(Remarks, ReqApprovalentries.Remarks);
                        NewReqApprovalentries.Validate("Unit of Meassure Code", ReqApprovalentries."Unit of Meassure Code");
                        NewReqApprovalentries.Validate("Requested Qty.", ReqApprovalentries."Requested Qty.");
                        NewReqApprovalentries.Validate("Global Dimension 1 Code", ReqApprovalentries."Global Dimension 1 Code");
                        NewReqApprovalentries.Validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                        NewReqApprovalentries.Validate("Budget Code", ReqApprovalentries."Budget Code");
                        NewReqApprovalentries.Validate("Requested User", ReqApprovalentries."Requested User");
                        NewReqApprovalentries.Validate("Document Date", ReqApprovalentries."Document Date");
                        NewReqApprovalentries.Validate("Requisition Type", ReqApprovalentries."Requisition Type");//CSPL-00307
                        NewReqApprovalentries."Budget Description" := ReqApprovalentries."Budget Description";
                        LastReqApprovalentries.reset();
                        if LastReqApprovalentries.FindLast() then;
                        NewReqApprovalentries."Entry No." := LastReqApprovalentries."Entry No." + 1;
                        NewReqApprovalentries.insert(true);
                        ReqLine.reset();
                        reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                        reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                        ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                        if ReqLine.FindFirst() then begin
                            ReqLine."1st Level Approval" := true;
                            ReqLine."1st Level Approved Date" := Today();
                            ReqLine."1st Level Approver ID" := UserId();
                            ReqLine.Status := Reqline.Status::"Pending For 2nd Approval";
                            ReqLine.modify();
                        end;
                    End else begin
                        ReqLine.reset();
                        reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                        reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                        ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                        if ReqLine.FindFirst() then begin
                            ReqLine."1st Level Approval" := true;
                            ReqLine."1st Level Approved Date" := Today();
                            ReqLine."1st Level Approver ID" := UserId();
                            ReqLine."2nd Level Approval" := true;
                            ReqLine."2nd Level Approved Date" := Today();
                            ReqLine."2nd Level Approver ID" := UserId();
                            ReqLine."3rd Level Approval" := true;
                            ReqLine."3rd Level Approved Date" := Today();
                            ReqLine."3rd Level Approver ID" := UserId();
                            ReqLine.Status := Reqline.Status::Approved;
                            ReqLine."Purchase Budget" := ReqApprovalentries."Budget Code";
                            ReqLine."Budget Description" := ReqApprovalentries."Budget Description";
                            ReqLine.modify();
                        end;
                    end;
                end;
            end;

            if I = 2 then begin
                ReqApprovalUserSetUp.Reset();
                ReqApprovalUserSetUp.SetRange("Location Code", ReqApprovalentries."Location Code");
                ReqApprovalUserSetUp.SetRange("Global Dimension 2 Code", ReqApprovalentries."Global Dimension 2");
                ReqApprovalUserSetUp.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Purchase);
                if ReqApprovalUserSetUp.Findfirst() then begin
                    if ReqApprovalUserSetUp."Requisition Approver 3" <> '' then begin
                        NewReqApprovalentries.init();
                        NewReqApprovalentries.validate("Document No.", ReqApprovalentries."Document No.");
                        NewReqApprovalentries.validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                        NewReqApprovalentries.validate("Location Code", ReqApprovalentries."Location Code");
                        NewReqApprovalentries.validate(Status, NewReqApprovalentries.status::Open);
                        NewReqApprovalentries.Validate("Budget Edit", false);
                        NewReqApprovalentries.validate("Document Line No.", ReqApprovalentries."Document Line No.");
                        NewReqApprovalentries.Validate("Approval User ID", ReqApprovalUserSetUp."Requisition Approver 3");
                        NewReqApprovalentries.Validate("Item code", ReqApprovalentries."Item Code");
                        NewReqApprovalentries.Validate(Description, ReqApprovalentries.Description);
                        NewReqApprovalentries.Validate("Location Code", ReqApprovalentries."Location Code");
                        NewReqApprovalentries.Validate(Remarks, ReqApprovalentries.Remarks);
                        NewReqApprovalentries.Validate("Unit of Meassure Code", ReqApprovalentries."Unit of Meassure Code");
                        NewReqApprovalentries.Validate("Requested Qty.", ReqApprovalentries."Requested Qty.");
                        NewReqApprovalentries.Validate("Global Dimension 1 Code", ReqApprovalentries."Global Dimension 1 Code");
                        NewReqApprovalentries.Validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                        NewReqApprovalentries.Validate("Budget Code", ReqApprovalentries."Budget Code");
                        NewReqApprovalentries.Validate("Requested User", ReqApprovalentries."Requested User");
                        NewReqApprovalentries.Validate("Document Date", ReqApprovalentries."Document Date");
                        NewReqApprovalentries.Validate("Requisition Type", ReqApprovalentries."Requisition Type");//CSPL-00307
                        LastReqApprovalentries.reset();
                        if LastReqApprovalentries.FindLast() then;
                        NewReqApprovalentries."Entry No." := LastReqApprovalentries."Entry No." + 1;
                        NewReqApprovalentries.insert(true);
                        ReqLine.reset();
                        reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                        reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                        ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                        if ReqLine.FindFirst() then begin
                            ReqLine."2nd Level Approval" := true;
                            ReqLine."2nd Level Approved Date" := Today();
                            ReqLine."2nd Level Approver ID" := UserId();
                            ReqLine.Status := Reqline.Status::"Pending For 3rd Approval";
                            ReqLine.modify();
                        end;
                    end Else begin
                        ReqLine.reset();
                        reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                        reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                        ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                        if ReqLine.FindFirst() then begin
                            ReqLine."2nd Level Approval" := true;
                            ReqLine."2nd Level Approved Date" := Today();
                            ReqLine."2nd Level Approver ID" := UserId();
                            ReqLine."3rd Level Approval" := true;
                            ReqLine."3rd Level Approved Date" := Today();
                            ReqLine."3rd Level Approver ID" := UserId();
                            ReqLine.Status := Reqline.Status::Approved;
                            ReqLine."Purchase Budget" := ReqApprovalentries."Budget Code";
                            ReqLine.modify();
                        end;
                    end;
                end;
            end;

            if I = 3 then begin
                ReqLine.reset();
                ReqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                if ReqLine.FindFirst() then begin
                    ReqLine."3rd Level Approval" := true;
                    ReqLine."3rd Level Approved Date" := Today();
                    ReqLine."3rd Level Approver ID" := UserId();
                    ReqLine.Status := Reqline.Status::Approved;
                    ReqLine."Budget Code" := ReqApprovalentries."Budget Code";
                    ReqLine.modify();
                end;
            end;
        end else
            IF ReqApprovalentries.DepartmentApproval = true then begin
                ReqLine.reset();
                reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                if ReqLine.FindFirst() then begin
                    if NOT reqline."3rd Level Approval_Dept" then
                        I := 3;
                    if NOT reqline."2nd Level Approval_Dept" then
                        I := 2;
                    if NOT reqline."1st Level Approval_Dept" then
                        I := 1;
                end;
                DepartmentApproverSetup.Reset();
                DepartmentApproverSetup.SetRange("Location Code", ReqApprovalentries."Location Code");
                DepartmentApproverSetup.SetRange("Global Dimension 2 Code", ReqApprovalentries."Global Dimension 2");
                DepartmentApproverSetup.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Requisition);
                if NOT DepartmentApproverSetup.Findfirst() then
                    error('No Approval Setup found for Selected Location and Department Code');

                if I = 1 then begin
                    DepartmentApproverSetup.Reset();
                    DepartmentApproverSetup.SetRange("Location Code", ReqApprovalentries."Location Code");
                    DepartmentApproverSetup.SetRange("Global Dimension 2 Code", ReqApprovalentries."Global Dimension 2");
                    DepartmentApproverSetup.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Requisition);
                    if DepartmentApproverSetup.Findfirst() then begin
                        if DepartmentApproverSetup."Requisition Approver 2" <> '' then begin
                            NewReqApprovalentries.init();
                            NewReqApprovalentries.validate("Document No.", ReqApprovalentries."Document No.");
                            NewReqApprovalentries.validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                            NewReqApprovalentries.validate("Location Code", ReqApprovalentries."Location Code");
                            NewReqApprovalentries.validate(Status, NewReqApprovalentries.status::Open);
                            NewReqApprovalentries.validate("Budget Edit", false);
                            NewReqApprovalentries.validate("Document Line No.", ReqApprovalentries."Document Line No.");
                            NewReqApprovalentries.Validate("Approval User ID", DepartmentApproverSetup."Requisition Approver 2");
                            NewReqApprovalentries.Validate("Item code", ReqApprovalentries."Item Code");
                            NewReqApprovalentries.Validate(Description, ReqApprovalentries.Description);
                            NewReqApprovalentries.Validate("Location Code", ReqApprovalentries."Location Code");
                            NewReqApprovalentries.Validate(Remarks, ReqApprovalentries.Remarks);
                            NewReqApprovalentries.Validate("Unit of Meassure Code", ReqApprovalentries."Unit of Meassure Code");
                            NewReqApprovalentries.Validate("Requested Qty.", ReqApprovalentries."Requested Qty.");
                            NewReqApprovalentries.Validate("Global Dimension 1 Code", ReqApprovalentries."Global Dimension 1 Code");
                            NewReqApprovalentries.Validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                            NewReqApprovalentries.Validate("Budget Code", ReqApprovalentries."Budget Code");
                            NewReqApprovalentries.Validate("Requested User", ReqApprovalentries."Requested User");
                            NewReqApprovalentries.Validate("Document Date", ReqApprovalentries."Document Date");
                            NewReqApprovalentries.Validate("Requisition Type", ReqApprovalentries."Requisition Type");//CSPL-00307
                            NewReqApprovalentries."Budget Description" := ReqApprovalentries."Budget Description";
                            NewReqApprovalentries.DepartmentApproval := ReqApprovalentries.DepartmentApproval;
                            LastReqApprovalentries.reset();
                            if LastReqApprovalentries.FindLast() then;
                            NewReqApprovalentries."Entry No." := LastReqApprovalentries."Entry No." + 1;
                            NewReqApprovalentries.insert(true);
                            ReqLine.reset();
                            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                            if ReqLine.FindFirst() then begin
                                ReqLine."1st Level Approval_Dept" := true;
                                ReqLine."1st Level Approved Date_Dept" := Today();
                                ReqLine."1st Level Approver ID_Dept" := UserId();
                                ReqLine.Status := Reqline.Status::"Pending For 2nd Approval";
                                ReqLine.Preferences := ReqApprovalentries.Preferences;
                                ReqLine.modify();
                            end;
                        End else begin
                            ReqLine.reset();
                            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                            if ReqLine.FindFirst() then begin
                                ReqLine."1st Level Approval_Dept" := true;
                                ReqLine."1st Level Approved Date_Dept" := Today();
                                ReqLine."1st Level Approver ID_Dept" := UserId();
                                ReqLine."2nd Level Approval_Dept" := true;
                                ReqLine."2nd Level Approved Date_Dept" := Today();
                                ReqLine."2nd Level Approver ID_Dept" := UserId();
                                ReqLine."3rd Level Approval_Dept" := true;
                                ReqLine."3rd Level Approved Date_Dept" := Today();
                                ReqLine."3rd Level Approver ID_Dept" := UserId();
                                ReqLine.Status := Reqline.Status::"Send to Store";
                                ReqLine."Purchase Budget" := ReqApprovalentries."Budget Code";
                                ReqLine."Budget Description" := ReqApprovalentries."Budget Description";
                                ReqLine.Preferences := ReqApprovalentries.Preferences;
                                ReqLine.modify();
                            end;
                            ReqLine.reset();
                            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                            ReqLine.SetFilter(Status, '<>%1', Reqline.Status::"Send to Store");
                            if ReqLine.IsEmpty then begin
                                ReqHeader.Reset();
                                If ReqHeader.Get(ReqLine."Document Type", ReqLine."Document No.") then begin
                                    ReqHeader.Validate("Approval Status", ReqHeader."Approval Status"::"Send to Store");
                                    ReqHeader.validate("Responsible Department", ReqHeader."Responsible Department"::Store);
                                    ReqHeader.Modify();
                                end;
                            end;
                        end;
                    end;
                end;

                if I = 2 then begin
                    DepartmentApproverSetup.Reset();
                    DepartmentApproverSetup.SetRange("Location Code", ReqApprovalentries."Location Code");
                    DepartmentApproverSetup.SetRange("Global Dimension 2 Code", ReqApprovalentries."Global Dimension 2");
                    DepartmentApproverSetup.SetRange("Setup Type", ReqApprovalUserSetUp."Setup Type"::Requisition);
                    if DepartmentApproverSetup.Findfirst() then begin
                        if DepartmentApproverSetup."Requisition Approver 3" <> '' then begin
                            NewReqApprovalentries.init();
                            NewReqApprovalentries.validate("Document No.", ReqApprovalentries."Document No.");
                            NewReqApprovalentries.validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                            NewReqApprovalentries.validate("Location Code", ReqApprovalentries."Location Code");
                            NewReqApprovalentries.validate(Status, NewReqApprovalentries.status::Open);
                            NewReqApprovalentries.Validate("Budget Edit", false);
                            NewReqApprovalentries.validate("Document Line No.", ReqApprovalentries."Document Line No.");
                            NewReqApprovalentries.Validate("Approval User ID", DepartmentApproverSetup."Requisition Approver 3");
                            NewReqApprovalentries.Validate("Item code", ReqApprovalentries."Item Code");
                            NewReqApprovalentries.Validate(Description, ReqApprovalentries.Description);
                            NewReqApprovalentries.Validate("Location Code", ReqApprovalentries."Location Code");
                            NewReqApprovalentries.Validate(Remarks, ReqApprovalentries.Remarks);
                            NewReqApprovalentries.Validate("Unit of Meassure Code", ReqApprovalentries."Unit of Meassure Code");
                            NewReqApprovalentries.Validate("Requested Qty.", ReqApprovalentries."Requested Qty.");
                            NewReqApprovalentries.Validate("Global Dimension 1 Code", ReqApprovalentries."Global Dimension 1 Code");
                            NewReqApprovalentries.Validate("Global Dimension 2", ReqApprovalentries."Global Dimension 2");
                            NewReqApprovalentries.Validate("Budget Code", ReqApprovalentries."Budget Code");
                            NewReqApprovalentries.Validate("Requested User", ReqApprovalentries."Requested User");
                            NewReqApprovalentries.Validate("Document Date", ReqApprovalentries."Document Date");
                            NewReqApprovalentries.Validate("Requisition Type", ReqApprovalentries."Requisition Type");//CSPL-00307
                            NewReqApprovalentries.DepartmentApproval := ReqApprovalentries.DepartmentApproval;
                            LastReqApprovalentries.reset();
                            if LastReqApprovalentries.FindLast() then;
                            NewReqApprovalentries."Entry No." := LastReqApprovalentries."Entry No." + 1;
                            NewReqApprovalentries.insert(true);
                            ReqLine.reset();
                            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                            if ReqLine.FindFirst() then begin
                                ReqLine."2nd Level Approval_Dept" := true;
                                ReqLine."2nd Level Approved Date_Dept" := Today();
                                ReqLine."2nd Level Approver ID_Dept" := UserId();
                                ReqLine.Status := Reqline.Status::"Pending For 3rd Approval";
                                ReqLine.Preferences := ReqApprovalentries.Preferences;
                                ReqLine.modify();
                            end;
                        end Else begin
                            ReqLine.reset();
                            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                            if ReqLine.FindFirst() then begin
                                ReqLine."2nd Level Approval_Dept" := true;
                                ReqLine."2nd Level Approved Date_Dept" := Today();
                                ReqLine."2nd Level Approver ID_Dept" := UserId();
                                ReqLine."3rd Level Approval_Dept" := true;
                                ReqLine."3rd Level Approved Date_Dept" := Today();
                                ReqLine."3rd Level Approver ID_Dept" := UserId();
                                ReqLine.Status := Reqline.Status::"Send to Store";
                                ReqLine."Purchase Budget" := ReqApprovalentries."Budget Code";
                                ReqLine."Budget Description" := ReqApprovalentries."Budget Description";
                                ReqLine.Preferences := ReqApprovalentries.Preferences;
                                ReqLine.modify();
                            end;
                            ReqLine.reset();
                            reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                            reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                            ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                            ReqLine.SetFilter(Status, '<>%1', Reqline.Status::"Send to Store");
                            if ReqLine.IsEmpty then begin
                                ReqHeader.Reset();
                                If ReqHeader.Get(ReqLine."Document Type", ReqLine."Document No.") then begin
                                    ReqHeader.Validate("Approval Status", ReqHeader."Approval Status"::"Send to Store");
                                    ReqHeader.validate("Responsible Department", ReqHeader."Responsible Department"::Store);
                                    ReqHeader.Modify();
                                end;
                            end;
                        end;
                    end;
                end;

                if I = 3 then begin
                    ReqLine.reset();
                    ReqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                    reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                    ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                    if ReqLine.FindFirst() then begin
                        ReqLine."3rd Level Approval_Dept" := true;
                        ReqLine."3rd Level Approved Date_Dept" := Today();
                        ReqLine."3rd Level Approver ID_Dept" := UserId();
                        ReqLine.Status := Reqline.Status::"Send to Store";
                        ReqLine."Purchase Budget" := ReqApprovalentries."Budget Code";
                        ReqLine."Budget Description" := ReqApprovalentries."Budget Description";
                        ReqLine.Preferences := ReqApprovalentries.Preferences;
                        ReqLine.modify();
                        ReqLine.reset();
                        reqLine.setrange(ReqLine."Document No.", ReqApprovalentries."Document No.");
                        reqLine.setrange(ReqLine."Line No.", ReqApprovalentries."Document Line No.");
                        ReqLine.setrange(reqLine."Document Type", reqLine."Document Type"::Requisition);
                        ReqLine.SetFilter(Status, '<>%1', Reqline.Status::"Send to Store");
                        if ReqLine.IsEmpty then begin
                            ReqHeader.Reset();
                            If ReqHeader.Get(ReqLine."Document Type", ReqLine."Document No.") then begin
                                ReqHeader.Validate("Approval Status", ReqHeader."Approval Status"::"Send to Store");
                                ReqHeader.validate("Responsible Department", ReqHeader."Responsible Department"::Store);
                                ReqHeader.Modify();
                            end;
                        end;
                    end;
                end;
            end;
        //
        CompanyInformation.Reset();
        if CompanyInformation.Get() then;
        SMTPSetup.reset;
        if SMTPSetup.Get() then;
        ReqHeader.reset();
        ReqHeader.SetRange("No.", ReqApprovalentries."Document No.");
        if ReqHeader.FindFirst() then begin
            UserSetup.Reset();
            if UserSetup.Get(ReqHeader."User Id") then
                if UserSetup."E-Mail" = '' then
                    Error('E-Mail does not updated on User Setup for the ID %1.', ReqHeader."User Id");

            //UserSetup.Reset();
            //if UserSetup.Get(ReqHeader."User Id") then
            //    if UserSetup."E-Mail" = '' then
            //        Error('E-Mail does not updated on User Setup for the ID %1.', Rec."User Id");

            MailSubject := 'Approval of Requsition';
            clear(Body);
            //if Recipient <> '' then begin

            // SMTPMail.Create(CompanyName, SMTPSetup."User ID", UserSetup."E-Mail", MailSubject, Body, true);
            // if CCRecipients.Count > 0 then
            //     SMTPMail.AddCC(CCRecipients);

            // SMTPMail.AppendtoBody('Dear ' + ReqHeader."User Id" + ',');
            // SMTPMail.AppendtoBody('<br><br>');
            // SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody('Approver Approved Requsition No. ' + ReqApprovalentries."Document No.");
            // SMTPMail.AppendtoBody('<br><br>');
            // SMTPMail.AppendtoBody('Regards,');
            // SMTPMail.AppendtoBody('<br>');
            // SMTPMail.AppendtoBody(CompanyName);
            // SMTPMail.AppendtoBody('<br><br>');
            // SMTPMail.AppendtoBody('[THIS IS AN  AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
            // Body := SmtpMail.GetBody();
            // Mail_lCU.Send();
            // //end;
        end;
        //
        ReqApprovalentries.Status := ReqApprovalentries.Status::Approved;
        ReqApprovalentries.modify();
    end;
}
