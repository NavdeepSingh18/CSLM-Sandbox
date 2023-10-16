table 50212 "Requisition Line-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/05/2019       OnModify()                                Code added for requistion header Status
    // 02    CSPL-00114   19/05/2019       Type - OnValidate()                       Code added for Requistion line field value from Requistion Header
    // 03    CSPL-00114   19/05/2019       No. - OnValidate()                        Code added for Requistion line field value from item
    Caption = 'Requisition Line-CS';

    fields
    {
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Requisition Header-CS"."No.";
        }
        field(20; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(25; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";

            trigger OnValidate()
            begin
                //Code added for Requistion line field value from Requistion Header::CSPL-00114::19052019: Start
                RequisitionHeaderCS.Reset();
                RequisitionHeaderCS.SETRANGE("No.", "Document No.");
                IF RequisitionHeaderCS.FINDFIRST() THEN BEGIN
                    "Item Category Code" := RequisitionHeaderCS."Item Category Code";
                    "Location Code" := RequisitionHeaderCS."Location Code";
                    "Shortcut Dimension 1 Code" := RequisitionHeaderCS."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := RequisitionHeaderCS."Shortcut Dimension 2 Code";
                    "Dimension Set ID" := RequisitionHeaderCS."Dimension Set ID";
                END;
                //Code added for Requistion line field value from Requistion Header::CSPL-00114::19052019: End
            end;
        }
        field(30; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST(Item)) Item."No." WHERE("Item Category Code" = FIELD("Item Category Code"))
            ELSE
            IF (Type = CONST("G/L Account")) "G/L Account"."No."
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"."No."
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"."No.";

            trigger OnValidate()
            var

            begin
                //Code added for Requistion line field value from item::CSPL-00114::19052019: Start
                ItemCS.GET("No.");
                Description := ItemCS.Description;
                "Description 2" := ItemCS."Description 2";
                "Unit of Measure" := ItemCS."Base Unit of Measure";
                //Code added for Requistion line field value from item::CSPL-00114::19052019: End
            end;
        }
        field(40; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
            ;
        }
        field(50; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(80; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;
        }
        field(90; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(100; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(120; "Issued Qty"; Decimal)
        {
            caption = 'Issued Qty';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(130; "Inventory Stock"; Decimal)
        {
            Caption = 'Inventory Stock';
            CalcFormula = Sum ("Item Ledger Entry"."Quantity" WHERE("Item No." = FIELD("No."),
                                                                  "Location Code" = FIELD("Location Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(140; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Item Category";
        }
        field(150; Status; Option)
        {
            CalcFormula = Lookup ("Requisition Header-CS"."Status" WHERE("No." = FIELD("Document No.")));
            Caption = 'Status';
            Editable = false;
            FieldClass = FlowField;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify()
    begin
        //Code added for requistion header Status::CSPL-00114::19052019: Start
        RequisitionHeaderCS.Reset();
        RequisitionHeaderCS.SETRANGE("No.", "Document No.");
        IF RequisitionHeaderCS.FINDFIRST() THEN
            IF (RequisitionHeaderCS.Status = RequisitionHeaderCS.Status::"Pending Approval") THEN
                ERROR(Text001Lbl);
        //Code added for requistion header Status::CSPL-00114::19052019: End
    end;

    var

        ItemCS: Record "Item";
        RequisitionHeaderCS: Record "Requisition Header-CS";
        DimMgt: Codeunit DimensionManagement;
        Text001Lbl: Label 'Status must be open.';

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

