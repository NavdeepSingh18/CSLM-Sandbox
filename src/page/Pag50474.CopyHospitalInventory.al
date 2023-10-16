page 50474 "Copy Hospital Inventory"
{
    PageType = Card;
    UsageCategory = None;
    Editable = true;

    layout
    {
        area(Content)
        {
            group("Copy Inputs")
            {
                field("Copy Options"; CopyOptions)
                {
                    ApplicationArea = All;
                    Caption = 'Copy Options';
                    OptionCaption = 'Copy Inventory in All Hospital,Copy Inventory in Current Hospital';
                    Style = Strong;
                    trigger OnValidate()
                    begin
                        VisibleDecisionCommon := true;
                        CurrPage.Update(true);
                    end;
                }
                field("Copy From Hospital ID"; CopyFromHospitalID)
                {
                    Caption = 'Copy From Hospital ID';
                    ApplicationArea = All;
                    TableRelation = Vendor."No." where("Vendor Sub Type" = const(Hospital));
                    Style = Unfavorable;
                    trigger OnValidate()
                    begin
                        CopyFromHospitalName := '';
                        CopyFromAcadmicYear := '';
                        Vendor.Reset();
                        if Vendor.Get(CopyFromHospitalID) then
                            CopyFromHospitalName := Vendor.Name;

                        HospitalInventory.Reset();
                        HospitalInventory.SetRange("Hospital ID", CopyFromHospitalID);
                        if HospitalInventory.FindLast() then begin
                            CopyFromAcadmicYear := HospitalInventory."Academic Year";
                            CopyToAcadmicYear := CopyFromAcadmicYear;
                        end;
                    end;
                }
                field("Copy-from Hospital Name"; CopyFromHospitalName)
                {
                    Caption = 'Copy From Hospital Name';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Copy To Hospital ID"; CopyToHospitalID)
                {
                    Caption = 'Copy To Hospital ID';
                    ApplicationArea = All;
                    Editable = false;
                    TableRelation = Vendor."No." where("Vendor Sub Type" = const(Hospital));
                    Style = Strong;
                    trigger OnValidate()
                    begin
                        CopytoHospitalName := '';
                        Vendor.Reset();
                        if Vendor.Get(CopyFromHospitalID) then
                            CopytoHospitalName := Vendor.Name;
                    end;
                }
                field("Copy-to Hospital Name"; CopytoHospitalName)
                {
                    Caption = 'Copy-to Hospital Name';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Copy-from Acadmic Year"; CopyFromAcadmicYear)
                {
                    Caption = 'Copy-from Acadmic Year';
                    ApplicationArea = All;
                    Editable = VisibleDecisionCommon;
                    TableRelation = "Academic Year Master-CS".Code;
                    Style = Unfavorable;
                }

                field("Copy-to Acadmic Year"; CopyToAcadmicYear)
                {
                    Caption = 'Copy-to Acadmic Year';
                    ApplicationArea = All;
                    Editable = VisibleDecisionCommon;
                    TableRelation = "Academic Year Master-CS".Code;
                    Style = Strong;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Copy)
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    HospitalInventoryIns: Record "Hospital Inventory";
                    Vendor: Record Vendor;
                begin
                    if CopyFromHospitalID = '' then
                        Error('Copy From Hospital ID must not be Blank.');
                    if CopyFromAcadmicYear = '' then
                        Error('Copy From Academic Year must not be Blank.');
                    if CopyToAcadmicYear = '' then
                        Error('Copy To Academic Year must not be Blank.');

                    if CopyOptions = CopyOptions::"Copy Inventory in All Hospital" then begin
                        HospitalInventory.Reset();
                        HospitalInventory.SetRange("Hospital ID", CopyFromHospitalID);
                        HospitalInventory.SetRange("Academic Year", CopyFromAcadmicYear);
                        if HospitalInventory.FindFirst() then
                            repeat
                                Vendor.Reset();
                                Vendor.SetFilter("No.", '<>%1', CopyFromHospitalID);
                                Vendor.SetRange("Vendor Sub Type", Vendor."Vendor Sub Type"::Hospital);
                                if Vendor.FindFirst() then begin
                                    HospitalInventoryIns.Init();
                                    HospitalInventoryIns."Hospital ID" := Vendor."No.";
                                    HospitalInventoryIns."Hospital Name" := Vendor.Name;
                                    HospitalInventoryIns."Academic Year" := CopyToAcadmicYear;
                                    HospitalInventoryIns."Clerkship Type" := HospitalInventory."Clerkship Type";
                                    HospitalInventoryIns."Course Code" := HospitalInventory."Course Code";
                                    HospitalInventoryIns."Course Description" := HospitalInventory."Course Description";
                                    HospitalInventoryIns."Course Rotation Week" := HospitalInventory."Course Rotation Week";
                                    HospitalInventoryIns.Validate(Seats, HospitalInventory.Seats);
                                    HospitalInventoryIns."Global Dimension 1 Code" := HospitalInventory."Global Dimension 1 Code";
                                    HospitalInventoryIns."Global Dimension 2 Code" := HospitalInventory."Global Dimension 2 Code";
                                    if HospitalInventoryIns.Insert() then;
                                end;
                            until HospitalInventory.Next() = 0;
                    end;

                    if CopyOptions = CopyOptions::"Copy Inventory in Current Hospital" then begin
                        if CopyToHospitalID = '' then
                            Error('Copy To Hospital ID must not be Blank.');
                        if CopyToAcadmicYear = '' then
                            Error('Copy To Academic Year must not be Blank.');

                        HospitalInventory.Reset();
                        HospitalInventory.SetRange("Hospital ID", CopyFromHospitalID);
                        HospitalInventory.SetRange("Academic Year", CopyFromAcadmicYear);
                        if HospitalInventory.FindSet() then
                            repeat
                                HospitalInventoryIns.Init();
                                HospitalInventoryIns."Hospital ID" := CopyToHospitalID;
                                HospitalInventoryIns."Hospital Name" := CopyToHospitalName;
                                HospitalInventoryIns."Academic Year" := CopyToAcadmicYear;
                                HospitalInventoryIns."Clerkship Type" := HospitalInventory."Clerkship Type";
                                HospitalInventoryIns."Course Code" := HospitalInventory."Course Code";
                                HospitalInventoryIns."Course Description" := HospitalInventory."Course Description";
                                HospitalInventoryIns."Course Rotation Week" := HospitalInventory."Course Rotation Week";
                                HospitalInventoryIns.Validate(Seats, HospitalInventory.Seats);
                                HospitalInventoryIns."Global Dimension 1 Code" := HospitalInventory."Global Dimension 1 Code";
                                HospitalInventoryIns."Global Dimension 2 Code" := HospitalInventory."Global Dimension 2 Code";
                                if HospitalInventoryIns.Insert() then;
                            until HospitalInventory.Next() = 0;
                    end;

                    Message('Copy action completed successfully.');
                    CurrPage.Close();
                end;
            }
        }
    }

    var
        Vendor: Record Vendor;
        HospitalInventory: Record "Hospital Inventory";
        CopyOptions: Option "Copy Inventory in All Hospital","Copy Inventory in Current Hospital";
        VisibleDecisionCommon: Boolean;
        CopyFromHospitalID: Code[20];
        CopyFromHospitalName: Text[100];
        CopyToHospitalID: Code[20];
        CopyToHospitalName: Text[100];
        CopyFromAcadmicYear: Code[20];
        CopyToAcadmicYear: Code[20];

    trigger OnOpenPage()
    begin
        CopyOptions := CopyOptions::"Copy Inventory in Current Hospital";
        VisibleDecisionCommon := true;
    end;

    /// <summary> 
    /// Description for SetVariables.
    /// </summary>
    /// <param name="LCopyToHospitalID">Parameter of type Code[20].</param>
    /// <param name="LCopyToHospitalName">Parameter of type Text[100].</param>
    procedure SetVariables(LCopyToHospitalID: Code[20]; LCopyToHospitalName: Text[100])
    begin
        CopyToHospitalID := LCopyToHospitalID;
        CopyToHospitalName := LCopyToHospitalName;
    end;
}