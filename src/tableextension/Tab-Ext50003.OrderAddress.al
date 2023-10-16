tableextension 50003 OrderAddressExt extends "Order Address"
{ //CSPL-00307-ACGME
    fields
    {
        field(50000; "Program Director"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Accreditation Status"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Effective Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "ACGME No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'ACGME No.';
        }
        field(50004; Specialty; Text[80])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Temporary Hospital Name"; Text[200])
        {
            DataClassification = CustomerContent;
        }


    }

    // var
    //     myInt: Integer;

    // trigger OnInsert()
    // var
    //     OrderAddress: Record "Order Address";
    // begin
    //     OrderAddress.Reset();
    //     OrderAddress.SetRange("Vendor No.", Rec."Vendor No.");
    //     OrderAddress.SetRange("ACGME No.", Rec."ACGME No.");
    //     OrderAddress.SetFilter(Code, '<>%1', Rec.Code);
    //     IF OrderAddress.FindFirst() then
    //         Error('ACGME No. %1 Already Exist for Hospital %2 in Table Hospital Adresses', "ACGME No.", "Vendor No.");

    // end;

    trigger OnAfterInsert()
    var
        Vendor: Record Vendor;
    begin
        Vendor.Reset();
        if Vendor.Get("Vendor No.") then begin
            if (Vendor."Vendor Sub Type" = Vendor."Vendor Sub Type"::Hospital) then
                Name := '';
        end;

    end;
}