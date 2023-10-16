table 50340 "Housing Contract"
{
    DataClassification = CustomerContent;
    Caption = 'Housing Contract';
    DataCaptionFields = "Housing ID", "Contract No.";

    fields
    {
        field(1; "Housing ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hostel ID';
            Editable = false;
            trigger OnValidate()
            begin
                if HousingMaster.Get("Housing ID") then
                    "Housing Name" := HousingMaster."Housing Name";
            End;


        }
        field(2; "Contract No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract No.';
            trigger OnValidate()
            begin
                HousingMaster.Get("Housing ID");
                If HousingMaster."Owned By University" then
                    Error("Housing ID", '%1 is currently Owned By University,you can not enter the Contract Details');
            End;


        }
        field(3; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            trigger OnValidate()
            begin
                TestField("Contract No.");
                HousingContratRec.Reset();
                HousingContratRec.SetRange("Housing ID", "Housing ID");
                HousingContratRec.SetFilter("End Date", '<>%1', rec."End Date");
                HousingContratRec.SetCurrentKey(HousingContratRec."End Date");
                If HousingContratRec.FindLast() then
                    IF "Start Date" <= HousingContratRec."End Date" then
                        Error(Text0003Lbl, HousingContratRec."End Date");

                IF "End Date" <> 0D Then
                    IF "Start Date" >= "End Date" then
                        Error(Text0001Lbl);
                "End Date" := 0D;

            end;

        }
        field(4; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            trigger OnValidate()
            begin
                TestField("Contract No.");
                Testfield("Start Date");
                IF "Start Date" >= "End Date" then
                    Error(Text0002Lbl);

                HousingContratRec.Reset();
                HousingContratRec.SetRange("Housing ID", "Housing ID");
                HousingContratRec.SetFilter("Start Date", '>%1', rec."Start Date");
                HousingContratRec.SetCurrentKey(HousingContratRec."Start Date");
                If HousingContratRec.FindSet() then
                    Repeat
                        IF HousingContratRec."Start Date" <> 0D THEN
                            IF "End Date" >= HousingContratRec."Start Date" then
                                Error(Text0004Lbl, HousingContratRec."Start Date");

                    Until HousingContratRec.NEXT() = 0;

            end;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            DataClassification = CustomerContent;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            DataClassification = CustomerContent;
        }
        field(7; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Created By';
            Editable = false;

        }
        field(8; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Created On';
            Editable = false;

        }
        Field(9; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            Editable = false;

        }
        Field(10; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Modified On';
            Editable = False;

        }
        Field(11; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
            Editable = False;

        }
        Field(12; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
            Editable = False;

        }
        Field(13; "Housing Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Housing Name';
            Editable = false;

        }
        Field(14; code; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'code';


        }

    }

    keys
    {
        key(key1; "Housing ID", "Contract No.")
        {
            Clustered = true;
        }
    }

    var

        HousingContratRec: Record "Housing Contract";
        HousingLedger: Record "Housing Ledger";
        HousingMaster: Record "Housing Master";
        Text0001Lbl: Label 'Start date must be smaller than End date';
        Text0002Lbl: Label 'End date must be greater than Start date';
        Text0003Lbl: Label 'Start date must be greater than %1 End date';
        Text0004Lbl: Label 'End date must be less than %1 Start date';

    trigger OnInsert()
    begin
        "Created By" := FORMAT(UserId());
        "Created On" := WORKDATE();
        Inserted := true;
    end;

    trigger OnModify()
    begin
        "Modified By" := FORMAT(UserId());
        "Modified On" := WORKDATE();
        Updated := true;
        HousingLedger.Reset();
        HousingLedger.SetRange("Contract No.", "Contract No.");
        IF HousingLedger.FindFirst() then
            Error('You can not modify the record,Ledger entry already exist');


    end;

    trigger OnDelete()
    begin
        HousingLedger.Reset();
        HousingLedger.SetRange("Contract No.", "Contract No.");
        IF HousingLedger.FindFirst() then
            Error('You can not delete the record,Ledger entry already exist');
    end;

}