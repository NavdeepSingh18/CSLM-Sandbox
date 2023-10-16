table 50211 "Requisition Header-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   19/05/2019       OnInsert()                                 Get No Series & "User Id" Values
    // 02    CSPL-00114   19/05/2019       OnModify()                                 Code added for Status Check validation
    // 03    CSPL-00114   19/05/2019       OnDelete()                                 Code added for Delete Requistion Line
    // 04    CSPL-00114   19/05/2019       Item Category Code - OnValidate()          Code Added for Line delete if category Chang
    // 05    CSPL-00114   19/05/2019       InitInsertCS() - Function                  No Series Generation
    // 06    CSPL-00114   19/05/2019       Dimension Set ID - OnLookup()              Code Added for Dimension
    // 07    CSPL-00114   19/05/2019       TestNoSeries() - Function                  Code Added for indent no series
    // 08    CSPL-00114   19/05/2019       GetNoSeriesCode() - Function               Code Added for no series
    // 09    CSPL-00114   19/05/2019       ExistReqLinesCS() - Function               Code added for Requistion Line Validation
    // 10    CSPL-00114   19/05/2019       AllLineDimUpdateCS- Function               Added for Update all lines with changed dimensions
    // 11    CSPL-00114   19/05/2019       ShowDocDimCS() - Function                  Added for Update all lines with changed dimensions
    // 12    CSPL-00114   19/05/2019       ValidateReqLineQtyCS() - Function          Code added for Requistion Line Quantity filed Validation
    // 13    CSPL-00114   19/05/2019       DeleteReqLineCS() - Function               Code added for all Delete Requistion Line

    Caption = 'Requisition Header-CS';
    DrillDownPageID = 50124;
    LookupPageID = 50124;

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            DataClassification = CustomerContent;
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(40; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = CustomerContent;
        }
        field(60; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(70; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(80; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(90; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = CustomerContent;
        }
        field(100; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Category";

            trigger OnValidate()
            begin
                //Code Added for Line delete if category Change::CSPL-00114::19052019: Start
                RequisitionLineCS.Reset();
                RequisitionLineCS.SETRANGE("Document No.", "No.");
                IF RequisitionLineCS.FINDFIRST() THEN
                    ERROR(Text001Lbl);
                //Code Added for Line delete if category Change::CSPL-00114::19052019: End
            end;
        }
        field(110; "User ID"; Code[50])
        {
            Editable = false;
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(120; Remarks; Text[100])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //Code Added for Dimension ::CSPL-00114::19052019: Start
                ShowDocDimCS();
                //Code Added for Dimension ::CSPL-00114::19052019: End
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Delete Requistion Line::CSPL-00114::19052019: Start
        DeleteReqLineCS();
        //Code added for Delete Requistion Line::CSPL-00114::19052019: End
    end;

    trigger OnInsert()
    begin
        //Get No Series & "User Id" Values::CSPL-00114::19052019: Start
        IF NOT InitializationSkipCS() THEN
            InitInsertCS();
        "User ID" := FORMAT(UserId());
        //Get No Series & "User Id" Values::CSPL-00114::19052019: End
    end;

    trigger OnModify()
    begin
        //Code added for Status Check validation::CSPL-00114::19052019: Start
        IF Status = Status::"Pending Approval" THEN
            ERROR(Text003Lbl);
        //Code added for Status Check validation::CSPL-00114::19052019: End
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";

        RequisitionLineCS: Record "Requisition Line-CS";
        RequisitionLineCS2: Record "Requisition Line-CS";
        DimMgt: Codeunit DimensionManagement;
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text001Lbl: Label 'You can not change category code,please delete the line items and try.';


        Text002Lbl: Label 'You may have changed a dimension.\\Do you want to update the lines?';
        Text003Lbl: Label 'Status must be open.';

    local procedure InitInsertCS()
    begin
        //Code Added no series Generation::CSPL-00114::19052019: Start
        "Posting Date" := WORKDATE();
        IF "No." = '' THEN BEGIN
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", "Posting Date", "No.", "No. Series");
        END;
        //Code Added no series Generation::CSPL-00114::19052019: End
    end;

    local procedure InitializationSkipCS(): Boolean
    begin
        IF "No." = '' THEN
            EXIT(FALSE);
    end;

    local procedure TestNoSeries(): Boolean
    begin
        //Code Added for indent no series::CSPL-00114::19052019: Start
        PurchSetup.GET();
        PurchSetup.TESTFIELD("Indent No.");
        //Code Added for indent no series::CSPL-00114::19052019: End
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        //Code Added for no series::CSPL-00114::19052019: Start
        PurchSetup.GET();
        EXIT(PurchSetup."Indent No.");
        //Code Added for no series ::CSPL-00114::19052019: End
    end;

    procedure ExistReqLinesCS(): Boolean
    begin
        //Code Added for req line Validation Check::CSPL-00114::19052019: Start
        RequisitionLineCS2.Reset();
        RequisitionLineCS2.SETRANGE("Document No.", "No.");
        EXIT(RequisitionLineCS2.FINDFIRST());
        //Code Added for req line Validation Check::CSPL-00114::19052019: End
    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin

        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF "No." <> '' THEN
            Modify();

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            Modify();
            IF ExistReqLinesCS() THEN
                AllLineDimUpdateCS("Dimension Set ID", OldDimSetID);
        END;
    end;

    local procedure AllLineDimUpdateCS(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;

    begin
        //Code Added for Update all lines with changed dimensions::CSPL-00114::19052019: Start
        IF NewParentDimSetID = OldParentDimSetID THEN
            EXIT;
        IF NOT CONFIRM(Text002Lbl) THEN
            EXIT;

        RequisitionLineCS.Reset();
        RequisitionLineCS.SETRANGE("Document No.", "No.");
        RequisitionLineCS.LOCKTABLE();
        IF RequisitionLineCS.FindFirst() THEN
            REPEAT
                NewDimSetID := DimMgt.GetDeltaDimSetID(RequisitionLineCS."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                IF RequisitionLineCS."Dimension Set ID" <> NewDimSetID THEN BEGIN
                    RequisitionLineCS."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                    RequisitionLineCS."Dimension Set ID", RequisitionLineCS."Shortcut Dimension 1 Code", RequisitionLineCS."Shortcut Dimension 2 Code");
                    RequisitionLineCS.Modify();
                END;
            UNTIL RequisitionLineCS.NEXT() = 0;
        //Code Added for Update all lines with changed dimensions::CSPL-00114::19052019: End
    end;

    procedure ShowDocDimCS()
    var
        OldDimSetID: Integer;
    begin
        //Code Added for Update all lines with changed dimensions::CSPL-00114::19052019: Start
        OldDimSetID := "Dimension Set ID";
        //CS-BLOCKED"Dimension Set ID" :=
        //CS-BLOCKEDDimMgt.EditDimensionSet2("Dimension Set ID", STRSUBSTNO('%1 %2', '', "No."),"Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY();
            IF ExistReqLinesCS() THEN
                AllLineDimUpdateCS("Dimension Set ID", OldDimSetID);
        END;
        //Code Added for Update all lines with changed dimensions::CSPL-00114::19052019: End
    end;

    local procedure "---Corp---"()
    begin
    end;

    procedure ValidateReqLineQtyCS()
    begin
        //Code Added for req line quantity field::CSPL-00114::19052019: Start
        RequisitionLineCS.Reset();
        RequisitionLineCS.SETRANGE("Document No.", "No.");
        IF RequisitionLineCS.FINDSET() THEN
            REPEAT
                RequisitionLineCS.TESTFIELD(RequisitionLineCS.Quantity);
            UNTIL RequisitionLineCS.NEXT() = 0;
        //Code Added for req line quantity field::CSPL-00114::19052019: End
    end;

    local procedure DeleteReqLineCS()
    begin
        //Code Added for all req line Delete::CSPL-00114::19052019: Start
        RequisitionLineCS.Reset();
        RequisitionLineCS.SETRANGE("Document No.", "No.");
        IF RequisitionLineCS.FINDSET() THEN
            RequisitionLineCS.DELETEALL();
        //Code Added for all req line Delete::CSPL-00114::19052019: End
    end;
}

