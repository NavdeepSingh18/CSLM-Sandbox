table 50376 "Requisition Line_"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Requisition,Indent';
            OptionMembers = Requisition,Indent;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Requisition Header"."No.";
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = Location;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(9; "Item Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                   "Account Type" = CONST(Posting),
                                                                                   Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Item)) Item WHERE(Blocked = FILTER(false))
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset" WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = FILTER('Charge (Item)')) "Item Charge";

            trigger OnValidate()
            begin

                RequisitionHeader.RESET();
                RequisitionHeader.SETFILTER(RequisitionHeader."Document Type", '%1..%2', RequisitionHeader."Document Type"::Requisition, RequisitionHeader."Document Type"::Indent);
                RequisitionHeader.SETRANGE(RequisitionHeader."No.", "Document No.");
                IF RequisitionHeader.FIND('-') THEN BEGIN
                    "Posting Date" := RequisitionHeader."Posting Date";
                    "Document Date" := RequisitionHeader."Document Date";
                    "Location Code" := RequisitionHeader."Location Code";
                    "Global Dimension 1 Code" := RequisitionHeader."Global Dimension 1 Code";
                    "Department Name" := RequisitionHeader."Department Name";
                    "Global Dimension 2 Code" := RequisitionHeader."Global Dimension 2 Code";
                    //"ShortcutDimCode[3]" := RequisitionHeader."ShortcutDimCode[3]";
                    "Requisition Type" := RequisitionHeader."Requisition Type";//CSPL-00307
                END ELSE BEGIN
                    "Posting Date" := 0D;
                    "Document Date" := 0D;
                    "Location Code" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    // "ShortcutDimCode[3]" := '';
                    "Requisition Type" := RequisitionHeader."Requisition Type";//CSPL-00307
                END;

                // IF "Document Type" = "Document Type"::Indent THEN BEGIN
                //     IF (Type = Type::Item) AND ("Item Code" <> '') THEN BEGIN
                //         RHeader.RESET();
                //         RHeader.GET("Document Type", "Document No.");
                //         IRec.RESET();
                //         IRec.SETRANGE(IRec."No.", "Item Code");
                //         //IRec.SETFILTER(IRec."Location Code", '%1|%2', RHeader."Location Code", '');
                //         IF NOT IRec.FIND('-') THEN
                //             ERROR('Do not Use Item code Other Location');
                //     END;
                // END;

                ItemRec.RESET();
                ItemRec.SETRANGE(ItemRec."No.", "Item Code");
                IF ItemRec.FIND('-') THEN BEGIN
                    //IF NOT (ItemRec."Item Status" = ItemRec."Item Status"::Approved) THEN
                    //    ERROR('%1 Should required to approve first in Item Card', ItemRec.Description);

                    ItemRec.TESTFIELD(ItemRec."Base Unit of Measure");
                    //ItemRec.TESTFIELD(ItemRec."Item Category Code");
                    ItemRec.TESTFIELD(ItemRec."Inventory Posting Group");
                    ItemRec.TESTFIELD(ItemRec."Gen. Prod. Posting Group");
                    Description := ItemRec.Description;
                    "Description 2" := ItemRec."Description 2";
                    "Unit of Measure Code" := ItemRec."Base Unit of Measure";
                    //"Equipment Used" := ItemRec."Equipment Master";
                    //"Item Subcategory" := FORMAT(ItemRec."Type Of Item");
                    //"Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(ItemRec,"Unit of Measure Code");
                END ELSE BEGIN
                    Description := '';
                    "Description 2" := '';
                    "Unit of Measure Code" := '';

                END;

                /*   PurchInvLine.RESET();
                   PurchInvLine.SETRANGE(PurchInvLine.Type, PurchInvLine.Type::Item);
                   PurchInvLine.SETRANGE("No.", "Item Code");
                   PurchInvLine.SETRANGE(PurchInvLine."Location Code", "Location Code");
                   PurchInvLine.SETRANGE("Document No.");
                   IF PurchInvLine.FIND('+') THEN BEGIN
                       "Last Quantity" := PurchInvLine.Quantity;
                       "Supplier's Code" := PurchInvLine."Buy-from Vendor No.";
                       "Last Rate" := PurchInvLine."Unit Cost (LCY)";
                       IF Vendor.GET("Supplier's Code") THEN
                           "Supplier's Name" := Vendor.Name
                       ELSE
                           "Supplier's Name" := '';
                   END ELSE BEGIN
                       "Last Quantity" := 0;
                       "Supplier's Code" := '';
                       "Last Rate" := 0;
                   END;*/

                IF Type = Type::"G/L Account" THEN BEGIN
                    GL.GET("Item Code");
                    Description := GL.Name;
                END;

                IF Type = Type::"Fixed Asset" THEN BEGIN
                    FA.GET("Item Code");
                    //IF NOT (FA."FA Status" = FA."FA Status"::Approved) THEN
                    //    ERROR('%1 Should required to approve first in Fixed Asset Card', FA.Description);
                    Description := FA.Description;
                    "Description 2" := FA."Description 2";
                END;
            end;
        }
        field(10; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(11; "Requested Quantity"; Decimal)
        {
            DataClassification = CustomerContent;


            trigger OnValidate()
            begin
                RequisitionHeader.RESET();
                RequisitionHeader.SETRANGE(RequisitionHeader."No.", "Document No.");
                IF RequisitionHeader.FIND('-') THEN BEGIN
                    IF RequisitionHeader.Status = RequisitionHeader.Status::Open THEN BEGIN
                        "Remaining Quantity to Issue" := "Requested Quantity";
                        CalcFields("Stock In Hand");
                        IF "Stock In Hand" > 0 THEN
                            "Remaining Purchase Quantity" := ("Requested Quantity" - "Stock In Hand")
                        else
                            "Remaining Purchase Quantity" := "Requested Quantity";
                        "Purchase Quantity" := "Remaining Quantity to Issue";
                    END ELSE
                        ERROR('You can not change the Requested Quantity');
                END;

            end;
        }
        field(12; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item Code"));

            trigger OnValidate()
            begin
                /* IF "Unit of Measure Code" = '' THEN
                    "Unit of Measure" := ''
                ELSE BEGIN
                    IF NOT UnitOfMeasure.GET("Unit of Measure Code") THEN
                        UnitOfMeasure.INIT;
                    "Unit of Measure" := UnitOfMeasure.Description;
                END;
                GetItem;
                "Qty. per Unit of Measure" := UOMMgt.GetQtyPerUnitOfMeasure(Item, "Unit of Measure Code"); */
            end;
        }
        field(13; "Unit of Measure"; Text[15])
        {
            DataClassification = CustomerContent;
        }

        field(20; "Supplier's Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor;
            trigger OnValidate()
            begin
                Vendor.get("Supplier's Code");
                "Supplier's Name" := Vendor.Name;
            end;
        }
        field(21; "Supplier's Name"; Text[100])
        {
            Editable = false;
            DataClassification = CustomerContent;

        }
        field(22; "Stock In Hand"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                                  "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Department Name"; Text[50])
        {
            editable = false;
            DataClassification = ToBeClassified;
        }

        field(25; Status; Option)
        {
            OptionCaption = 'Open,Send to Store,Pending For 1st Approval,Pending For 2nd Approval,Pending For 3rd Approval,Approved,Closed,Rejected';
            OptionMembers = Open,"Send to Store","Pending For 1st Approval","Pending For 2nd Approval","Pending For 3rd Approval",Approved,Closed,Rejected;
            DataClassification = CustomerContent;
        }

        field(28; "Quantity Issued"; Decimal)
        {
            Editable = true;
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //"Approved Quantity" := "Quantity Issued";
            end;
        }
        field(29; "Approved Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "Required Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(32; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Quantity To Issue"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                MinimumStockSetup: Record "Requisition Approval Setups";
            begin
                If "Remaining Quantity to Issue" < "Quantity To Issue" then
                    Error('Quantity To Issue must be less or equal to Remaining Quantity to Issue for Item Code %3', "Item Code");
                MinimumStockSetup.Reset();
                IF MinimumStockSetup.Get("Item Code", "Location Code") then begin
                    CalcFields("Stock In Hand");
                    IF ("Stock In Hand" > 0) AND (MinimumStockSetup."Minimum Stock Qty" > 0) then begin
                        IF ("Stock In Hand" - "Quantity To Issue") < MinimumStockSetup."Minimum Stock Qty" then
                            Error('You can not issue %1 Qty beacuse minimum Stock Qty is %2', "Quantity To Issue", MinimumStockSetup."Minimum Stock Qty");
                    end;
                end;
                "Purchase Quantity" := "Remaining Quantity to Issue";
            end;
        }
        field(36; "Issued Quantity"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(37; "Remaining Quantity to Issue"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Remaining Quantity';

            trigger OnValidate()
            begin
                "Remaining Quantity to Issue" := "Requested Quantity";
            end;
        }
        field(38; "Bin Stock In Hand"; Decimal)
        {
            CalcFormula = Sum("Warehouse Entry".Quantity WHERE("Item No." = FIELD("Item Code"),
                                                                 "Location Code" = FIELD("Location Code"),
                                                                 "Bin Code" = FIELD("Bin code")));
            Caption = 'Bin Stock In Hand';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Line Status"; Option)
        {
            CalcFormula = Lookup("Requisition Header".Status WHERE("Document Type" = FIELD("Document Type"),
                                                                  "No." = FIELD("Document No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Send To HO,Posted,Item Sended IJ,Closed,Send to HOD,Send to Store,Send to Station Head,Partially Closed,Purchase from Store,Purchase from HO';
            OptionMembers = Open,"Send To HO",Posted,"Item Sended IJ",Closed,"Send to HOD","Send to Store","Send to Station Head","Partially Closed","Purchase from Store","Purchase from HO";
        }
        field(41; "Quantity Issued (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = true;

            trigger OnValidate()
            begin
                //IF COMPANYNAME = 'GST GGI 27-06' THEN BEGIN
                //TESTFIELD("Qty. per Unit of Measure",1); //00092
                VALIDATE("Issued Quantity", "Quantity Issued (Base)"); ///00092
                //END;
            end;
        }
        field(42; "Quantity To Issue (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                IF "Quantity To Issue" > "Remaining Quantity to Issue" THEN
                    ERROR('Qty to issue not more than quantity');

                //TESTFIELD("Qty. per Unit of Measure",1); //00092
                VALIDATE("Quantity To Issue", "Quantity To Issue (Base)"); ///00092
            end;
        }
        field(43; "Requested Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin

            end;
        }
        field(44; "Remaining Qty to Issue (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            TableRelation = Bin.Code WHERE("Location Code" = FIELD("Location Code"));
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
            // WhseIntegrationMgt: Codeunit "Whse. Integration Management";
            begin
            end;
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
            Editable = true;
            InitValue = 1;

            trigger OnLookup()
            begin
                "Quantity (Base)" := "Requested Quantity" * "Qty. per Unit of Measure";
            end;
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(50000; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
            InitValue = Item;
        }

        field(50004; "Purchase Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            //FieldClass = Normal;
        }
        field(50005; "Purchase Line No."; Integer)
        {
            DataClassification = CustomerContent;
            //FieldClass = Normal;
        }

        field(50006; "Purchase Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            FieldClass = Normal;
            trigger OnValidate()
            begin
                // "Remaining Purchase Quantity" := "Purchase Quantity";

                // If "Remaining Purchase Quantity" < "Purchase Quantity" then
                //     Error('Purchase Quantity must be less or equal to Remaining Purchase Quantity for Item Code %1', "Item Code");

                IF "Purchase Quantity" < "Remaining Quantity to Issue" then
                    Error('Purchase Qty can not be Less then Remaining Qty');
            end;
        }
        field(50007; "Remaining Purchase Quantity"; Decimal)
        {
            Editable = False;
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }

        field(50008; "Purchased Order Quantity"; Decimal)
        {
            Editable = False;
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }


        field(50024; "Promised Date"; Date)
        {
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }

        field(50028; "Item Issued"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }

        field(50031; Approved; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }
        field(50032; "Requisition Last Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Description = 'Corporateserve';
        }

        field(50033; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(50034; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(50035; Selection; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Item Budget Name";
        }
        field(50048; "User Id"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50037; "1st Level Approval"; Boolean)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
        field(50038; "2nd Level Approval"; Boolean)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
        field(50039; "3rd Level Approval"; Boolean)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
        field(50040; "1st Level Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50041; "2nd Level Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50042; "3rd Level Approved Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50043; "1st Level Approver ID"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50044; "2nd Level Approver ID"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50045; "3rd Level Approver ID"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50046; "Reject User Id"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(50047; "PO No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(50049; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
        field(50050; "Purchase Budget"; Code[20])
        {
            //CSPL-00307
            // TableRelation = "Item Budget Name" where("Analysis Area" = filter(Purchase));
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            // myInt: Integer;
            begin
                Error('You can not enter Budget Code manually only selection is valid');
            end;

            trigger OnLookUp()
            var
                RecHeader: Record "Requisition Header";
                RecItemBudget: Record "Item Budget Name";
            begin
                RecHeader.Reset();
                IF RecHeader.Get(Rec."Document Type", Rec."Document No.") Then;
                RecItemBudget.Reset();
                RecItemBudget.SetRange("Analysis Area", RecItemBudget."Analysis Area"::Purchase);
                RecItemBudget.SetRange("Budget Type", RecHeader."Requisition Type");
                RecItemBudget.SetRange("Global Dimension 1 Code", RecHeader."Global Dimension 1 Code");
                RecItemBudget.SetRange("Global Dimension 2 Code", RecHeader."Global Dimension 2 Code");
                IF Page.RunModal(9373, RecItemBudget) = Action::LookupOK then begin
                    Rec."Purchase Budget" := RecItemBudget.Name;
                    Rec."Budget Description" := RecItemBudget.Description;
                end;

            end;
        }
        Field(50051; "Budget Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50052; Preferences; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(50053; "1st Level Approved Date_Dept"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50054; "2nd Level Approved Date_Dept"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50055; "3rd Level Approved Date_Dept"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50056; "1st Level Approver ID_Dept"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50057; "2nd Level Approver ID_Dept"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50058; "3rd Level Approver ID_Dept"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50059; "1st Level Approval_Dept"; Boolean)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
        field(50060; "2nd Level Approval_Dept"; Boolean)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
        field(50061; "3rd Level Approval_Dept"; Boolean)
        {
            editable = false;
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Document Type", "Document No.", "Supplier's Code")
        {

        }
    }

    var
        RequisitionHeader: Record "Requisition Header";
        ItemRec: Record Item;
        //PurchInvLine: Record "Purch. Inv. Line";
        Vendor: Record Vendor;
        // DimensionValue: Record "Dimension Value";
        // RequisitionHeader2: Record "Requisition Header";
        GL: Record "G/L Account";
        FA: Record "Fixed Asset";
        // IssueQTY: Decimal;
        // IssueLine: Record "Requisition Line_";
        // IssueHeader: Record "Requisition Header";
        // IssueQTYLeftCounter: Integer;
        // PLRec: Record "Purchase Line";
        // RequestInRec: Record "Requisition Line_";
        // RHeader: Record "Requisition Header";
        // IRec: Record Item;
        IHeader: Record "Requisition Header";
        // RecH: Record "Requisition Header";
        // RecPoH: Record "Purchase Header";
        // RecRCh: Record "Purch. Rcpt. Header";
        // VendorRec: Record Vendor;
        // RecJobHeader: Record "Requisition Header";
        // UnitOfMeasure: Record "Unit of Measure";
        // UOMMgt: Codeunit "Unit of Measure Management";
        Item: Record Item;
    // Text000: Label 'Item %1 not found in uniform setup.';
    // Text001: Label 'You cannot issue greater then %1 qty Line No. %2 Item No. %3';
    // // RequisitionHeader: Record "Requisition Header";
    // Text002: Label 'Please check Allowed Qty %1 Issued Qty %2 Line No. %3 Item No. %4';

    trigger OnInsert()
    begin
        //RAVINDER > START
        GetRequisitionHeader();
        "Location Code" := RequisitionHeader."Location Code";
        "Global Dimension 1 Code" := RequisitionHeader."Global Dimension 1 Code";
        "Global Dimension 2 Code" := RequisitionHeader."Global Dimension 2 Code";

        Inserted := true;
        //RAVINDER > END
        "User Id" := UserId();
    end;

    trigger OnModify()
    begin
        If xRec.Updated = Updated then
            Updated := true;
    end;

    trigger OnDelete()
    begin
        IF "Document Type" = "Document Type"::Requisition THEN BEGIN
            IHeader.RESET();
            IHeader.GET("Document Type", "Document No.");
            IF IHeader."Approval Status" <> IHeader."Approval Status"::Open THEN
                ERROR('Do Not Delete');
            // RequestInRec.RESET();
            // RequestInRec.SETRANGE(RequestInRec."Document Type", RequestInRec."Document Type"::Requisition);
            // RequestInRec.SETRANGE(RequestInRec."Indent No.", "Document No.");
            // RequestInRec.SETRANGE(RequestInRec."Indent Line No.", "Line No.");
            // IF RequestInRec.FIND('-') THEN BEGIN
            //     RequestInRec."Indent To Req. Status" := RequestInRec."Indent To Req. Status"::Open;
            //     RequestInRec."Indent No." := '';
            //     RequestInRec."Indent Line No." := 0;
            //     RequestInRec.MODIFY();
            // END;
        END;

        IF "Document Type" = "Document Type"::Requisition THEN BEGIN
            IHeader.RESET();
            IHeader.GET("Document Type", "Document No.");
            IF IHeader.Status <> IHeader.Status::Open THEN
                ERROR('Do Not Delete');
        END;

        GetRequisitionHeader();
        if RequisitionHeader.Status = RequisitionHeader.Status::Approved then
            Error('You can not delete lines from approved Documents.');
    end;

    trigger OnRename()
    begin

    end;



    local procedure CalcBaseQty(Qty: Decimal): Decimal
    begin
        TESTFIELD("Qty. per Unit of Measure");
        EXIT(ROUND(Qty * "Qty. per Unit of Measure", 0.00001));
    end;

    local procedure GetItem()
    begin
        TESTFIELD("Item Code");
        IF "Item Code" <> Item."No." THEN
            Item.GET("Item Code");
    end;

    local procedure GetRequisitionHeader()
    begin
        TESTFIELD("Document No.");
        IF ("Document Type" <> RequisitionHeader."Document Type") OR ("Document No." <> RequisitionHeader."No.") THEN
            RequisitionHeader.GET("Document Type", "Document No.");
    end;


}