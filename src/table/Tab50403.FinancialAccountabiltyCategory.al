table 50403 "Financial Account Category"
{
    DataClassification = CustomerContent;
    Caption = 'Financial Accountabilty Category';
    DataCaptionFields = "Category Code", "Category Description";
    LookupPageId = "Financial Account Category";
    DrillDownPageId = "Financial Account Category";


    fields
    {
        field(1; "Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Code';
        }
        field(2; "Category Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Category Description';

        }
        field(3; "Fee Component Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Component Code';
            TableRelation = "Fee Component Master-CS";
            trigger OnValidate()
            begin
                if FeeComponentRec.Get("Fee Component Code") then begin
                    "Fee Component Description" := FeeComponentRec.Description;
                    "Global Dimension 1 Code" := FeeComponentRec."Global Dimension 1 Code";
                    Validate("Global Dimension 2 Code", FeeComponentRec."Global Dimension 2 Code");
                end else begin
                    "Fee Component Description" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                end;
            end;
        }
        field(4; "Fee Component Description"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fee Component Description';
            Editable = false;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            Editable = false;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            Editable = false;
            trigger Onvalidate()
            var
                DimensionValueRec: Record "Dimension Value";
            begin
                DimensionValueRec.Reset();
                DimensionValueRec.SetRange("Global Dimension No.", 2);
                DimensionValueRec.SetRange(Code, "Global Dimension 2 Code");
                if DimensionValueRec.FindFirst() then
                    "Department Descritpion" := DimensionValueRec.Name
                else
                    "Department Descritpion" := '';
            end;
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Created On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Updated"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Department Descritpion"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Category Code")
        {
            Clustered = true;
        }

    }
    fieldgroups
    {
        fieldgroup(DropDown; "Category Code", "Category Description")
        {

        }
    }


    var

        FeeComponentRec: Record "Fee Component Master-CS";

    trigger OnInsert()
    begin
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
        Updated := true;
    end;


}