table 50264 "Indent L-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   07/01/2019       OnInsert()                                 Code added for "User Id" Values
    // 02    CSPL-00114   07/01/2019       No. - OnValidate()                         Code added for DimensionName & Status Related
    // 03    CSPL-00114   07/01/2019       Name - OnValidate()                        Code added for Status Related
    // 04    CSPL-00114   07/01/2019       Item No - OnValidate()                     Code added for Item  Related Values & Status Related
    // 05    CSPL-00114   07/01/2019       Description - OnValidate()                 Code added for Status Related
    // 06    CSPL-00114   07/01/2019       Quantity - OnValidate()                    Quantity Related & Status Related
    // 07    CSPL-00114   07/01/2019       Item No - OnValidate()                     Get Description & Status Related Code added
    // 08    CSPL-00114   07/01/2019       Indent Status - OnValidate()               Indent Header Status Modifed
    // 09    CSPL-00114   07/01/2019       Varient Code - OnValidate()                Status Modifed
    // 10    CSPL-00114   07/01/2019       Issue Qty - OnValidate()                   Indent Status Error Related

    Caption = 'Indent L-CS';

    fields
    {
        field(1; "Document No"; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for DimensionName & Status Related::CSPL-00114::07012019: Start
                IF Release = TRUE THEN
                    ERROR('Indent is already in process');
                GRecDeptCS.Reset();
                GRecDeptCS.SETFILTER("Global Dimension No.", '2');
                IF GRecDeptCS.FINDFIRST() THEN
                    REPEAT
                        IF "No." = GRecDeptCS.Code THEN
                            Name := GRecDeptCS.Name;
                    UNTIL GRecDeptCS.NEXT() = 0;
                //Code added for DimensionName & Status Related::CSPL-00114::07012019: End
            end;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Status Related::CSPL-00114::07012019: Start
                IF Release = TRUE THEN
                    ERROR('Indent is already in process');
                //Code added for Status Related::CSPL-00114::07012019: End
            end;
        }
        field(4; "Item No"; Code[20])
        {
            Caption = 'Item No';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";

            trigger OnValidate()
            begin
                //Code added for Item  Related Values & Status Related::CSPL-00114::07012019: Start
                IF GRecItemCS.GET("Item No") THEN BEGIN
                    Description := GRecItemCS.Description;
                    Quantity := GRecItemCS."Unit Price";
                    "Unit of Measure" := GRecItemCS."Base Unit of Measure";
                    Type := Type::Item;
                    "Gen. Prod. Posting Group" := GRecItemCS."Gen. Prod. Posting Group";
                    "Product Sub Group Code" := GRecItemCS."Product Sub group Code";
                    "Gen.Bus Posting Group" := 'DOMESTIC';
                END;

                IF "Item No" = '' THEN BEGIN
                    CLEAR(Description);
                    CLEAR(Quantity);
                    CLEAR("Unit of Measure");
                    CLEAR(Type);
                    CLEAR("Gen. Prod. Posting Group");
                    CLEAR("Product Sub Group Code");
                END;

                IF Release = TRUE THEN
                    ERROR('Indent is already in process');
                //Code added for Item  Related Values & Status Related::CSPL-00114::07012019: End
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Status Related::CSPL-00114::07012019: Start
                IF Release = TRUE THEN
                    ERROR('Indent is already in process');
                //Code added for Status Related::CSPL-00114::07012019: End
            end;
        }
        field(6; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            DataClassification = CustomerContent;
        }
        field(7; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
            FieldClass = Normal;

            trigger OnValidate()
            begin
                //Quantity Related & Status Related::CSPL-00114::07012019: Start
                IF Release = TRUE THEN
                    ERROR('Indent is already in process');
                IF Quantity > "Avl.Qty" THEN
                    ERROR(TXT0001Lbl);
                //Quantity Related & Status Related::CSPL-00114::07012019: End
            end;
        }
        field(8; "Serial No"; Integer)
        {
            Caption = 'Serial No';
            DataClassification = CustomerContent;
        }
        field(9; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(10; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = CustomerContent;
        }
        field(11; "Indent For"; Option)
        {
            Caption = 'Indent For';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = ' ,Department,Employee,Student';
            OptionMembers = " ",Department,Employee,Student;
        }
        field(12; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(13; "Issue Indent"; Boolean)
        {
            Caption = 'Issue Indent';
            DataClassification = CustomerContent;
        }
        field(14; Release; Boolean)
        {
            Caption = 'Release';
            DataClassification = CustomerContent;
        }
        field(15; Select; Boolean)
        {
            Caption = 'Select';
            DataClassification = CustomerContent;
        }
        field(16; Cancel; Boolean)
        {
            Caption = 'Cancel';
            DataClassification = CustomerContent;
        }
        field(17; "Indent Status"; Option)
        {
            Caption = 'Indent Status';
            DataClassification = CustomerContent;
            Editable = true;
            OptionCaption = ' ,Indent,Issue,Pending,Close';
            OptionMembers = " ",Indent,Issue,Pending,Close;

            trigger OnValidate()
            begin
                //Indent Header Status Modifed ::CSPL-00114::07012019: Start
                IF IndentHCS.GET("Document No") THEN
                    IF "Indent Status" = "Indent Status"::Issue THEN BEGIN
                        IndentHCS.Status := IndentHCS.Status::Released;
                        IndentHCS.Modify();
                    END;

                //Indent Header Status Modifed ::CSPL-00114::07012019: End
            end;
        }
        field(18; Location; Code[10])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
            NotBlank = false;
            TableRelation = Location.Code;
        }
        field(19; "Unit of Measure"; Code[10])
        {
            Caption = 'Unit Of Measure';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(20; "Avl.Qty"; Decimal)
        {
            Caption = 'Avl.Qty';

            CalcFormula = Sum ("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("Item No"),
                                                                  "Variant Code" = FIELD("Varient Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = ' ,G/L Account,Item';
            OptionMembers = " ","G/L Account",Item;
        }
        field(22; "Varient Code"; Code[10])
        {
            Caption = 'Varient Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No"));

            trigger OnValidate()
            begin
                //Status Modifed ::CSPL-00114::07012019: Start
                IF Release = TRUE THEN
                    ERROR('Indent is already in process');
                //Status Modifed ::CSPL-00114::07012019: End
            end;
        }
        field(23; "Rem.Qty"; Decimal)
        {
            Caption = 'Rem.Qty';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "User ID"; Code[50])
        {
            Caption = 'User id';
            DataClassification = CustomerContent;
        }
        field(25; Purpose; Text[50])
        {
            Caption = 'Purpose';
            DataClassification = CustomerContent;
        }
        field(26; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = CustomerContent;
        }
        field(27; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
        }
        field(28; "Issue Qty"; Decimal)
        {
            Caption = 'Issue Qty';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Indent Status Error ::CSPL-00114::07012019: Start
                IF ("Indent Status" = "Indent Status"::Pending) AND ("Issue Qty" > "Rem.Qty") THEN
                    ERROR('Wrong Entry for issue Quantity');

                IF "Issue Qty" < 0 THEN
                    ERROR('Enter Wrong Quantity');
                //Indent Status Error ::CSPL-00114::07012019: End
            end;
        }
        field(29; Remarks; Text[60])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }
        field(30; "Product Sub Group Code"; Code[20])
        {
            Caption = 'Product Sub Group Code';
            DataClassification = CustomerContent;
        }
        field(31; "Gen.Bus Posting Group"; Code[20])
        {
            Caption = 'Gen.Bus Posting Group';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Document No", "No.", "Indent For", "Item No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        //Code added for "User Id" Values::CSPL-00114::07012019: Start
        "User id" := FORMAT(UserId());
        //Code added for "User Id" Values::CSPL-00114::07012019: End
    end;

    var
        GRecDeptCS: Record "Dimension Value";
        GRecItemCS: Record "Item";
        IndentHCS: Record "Indent H-CS";
        TXT0001Lbl: Label 'Indent quantity should be less than inventory';

}

