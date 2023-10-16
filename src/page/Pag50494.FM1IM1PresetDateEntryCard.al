page 50494 "FM1/IM1 Preset Date Entry Card"
{
    Caption = 'FM1/IM1 Preset Date Entry';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "FM1/IM1 Date Preset Entry";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Preset No."; Rec."Preset No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    ShowMandatory = true;
                }

                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;

                    trigger OnValidate()
                    begin
                        if Rec."Start Date" <> 0D then
                            AddInventoryLines();
                        InventoryVisible := true;
                        if Rec."Start Date" = 0D then
                            InventoryVisible := false;
                    end;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;
                    Editable = false;
                }
                field("Document Due Date"; Rec."Document Due Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Unfavorable;
                }
            }

            part("FM1_IM1 Hospital Inventory"; "FM1_IM1 Hospital Inventory")
            {
                ApplicationArea = All;
                SubPageLink = "Start Date" = field("Start Date"), "Course Code" = field("Course Code"), "Clerkship Type" = filter("FM1/IM1");
                Caption = 'FM1/IM1 Inventory Input';
                Visible = InventoryVisible;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Confirm")
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'F9';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Confirm;
                trigger OnAction()
                var
                    FM1IM1DatePresetEntry: Record "FM1/IM1 Date Preset Entry";
                    LGroup: Record Group;
                    CALE: Record "Clerkship Activity Log Entries";
                    GroupCode: Code[20];
                begin
                    if Confirm('Do you want to confirm the FM1/IM1 Rotation Preset %1 for the Period (%2 to %3)?', True, Rec."Preset No.", Rec."Start Date", Rec."End Date") then begin
                        FM1IM1DatePresetEntry.Reset();
                        FM1IM1DatePresetEntry.SetRange("Start Date", Rec."Start Date");
                        FM1IM1DatePresetEntry.SetFilter("Preset No.", '<>%1', Rec."Preset No.");
                        FM1IM1DatePresetEntry.SetRange("Course Code", Rec."Course Code");
                        if FM1IM1DatePresetEntry.FindFirst() then
                            Error('FM1/IM1 Preset date for the Start Date %1 already exist.\Please check Preset No. %2.', Rec."Start Date", FM1IM1DatePresetEntry."Preset No.");

                        Rec.TestField("Preset No.");
                        Rec.TestField("Academic Year");
                        Rec.TestField("Start Date");
                        Rec.TestField("Document Due Date");

                        if Rec."Document Due Date" <= WorkDate() then
                            Error('Document Due Date (i.e. %1) must be greater than %2.', Rec."Document Due Date", WorkDate());

                        GroupCode := 'FM1/IM1-' + FORMAT(Rec."Start Date", 0, '<Month>/<Day>/<Year4>');
                        LGroup.Init();
                        LGroup.Code := GroupCode;
                        LGroup.Description := 'FM1/IM1-' + FORMAT(Rec."Start Date", 0, '<Month>/<Day>/<Year4>') + ' Group';
                        LGroup."Group Type" := LGroup."Group Type"::Clinical;
                        LGroup."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                        if LGroup.Insert(true) then;

                        Rec."Group Code" := GroupCode;
                        Rec.Validate(Status, Rec.Status::Confirmed);

                        Rec.Modify();
                        CALE.InsertLogEntry(2, 1, Rec."Course Code", Rec."Course Description", Rec."Preset No.", '', '', '7015', 'Family Medicine I/Internal Medicine I');
                        Message('Status of FM1/IM1 Roster Preset No. %1 has been confirmed.', Rec."Preset No.");
                    end;
                end;
            }
        }
    }

    var
        InventoryVisible: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        SubjectMasterCS: Record "Subject Master-CS";
        EducationSetupCS: Record "Education Setup-CS";
        TextNoofWeeks: Text[20];
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetupCS.FindFirst() then
            EducationSetupCS.TestField("FM1/IM1 Subject Code");

        Rec."Global Dimension 1 Code" := '9000';
        Rec."Academic Year" := EducationSetupCS."Academic Year";
        InventoryVisible := false;

        SubjectMasterCS.Reset();
        SubjectMasterCS.SetRange(Code, EducationSetupCS."FM1/IM1 Subject Code");
        if SubjectMasterCS.FindFirst() then begin
            Rec."Course Code" := SubjectMasterCS.Code;
            Rec."Course Description" := SubjectMasterCS.Description;
            TextNoofWeeks := DelChr(Format(SubjectMasterCS.Duration), '=', 'DWMYQ');
            Evaluate(Rec."No. of Weeks", TextNoofWeeks);
        end;
    end;

    trigger OnOpenPage()
    begin
        InventoryVisible := false;

        if Rec."Start Date" <> 0D then
            InventoryVisible := true;
    end;

    procedure AddInventoryLines()
    var
        EducationSetupCS: Record "Education Setup-CS";
        HospitalInventory: Record "Hospital Inventory";
        Vendor: Record Vendor;
    begin
        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetupCS.FindFirst() then
            EducationSetupCS.TestField("FM1/IM1 Subject Code");

        HospitalInventory.Reset();
        HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::"FM1/IM1");
        HospitalInventory.SetRange("Course Code", Rec."Course Code");
        HospitalInventory.SetRange("Start Date", Rec."Start Date");
        if HospitalInventory.FindSet() then
            repeat
                HospitalInventory.Delete();
            until HospitalInventory.Next() = 0;

        Vendor.Reset();
        Vendor.SetRange("Vendor Sub Type", Vendor."Vendor Sub Type"::Hospital);
        Vendor.SetRange(Blocked, Vendor.Blocked::" ");
        Vendor.SetRange("FM1/IM1 Rotation Applicable", true);
        if Vendor.FindSet() then
            repeat
                HospitalInventory.Init();
                HospitalInventory."Academic Year" := EducationSetupCS."Academic Year";
                HospitalInventory.Validate("Hospital ID", Vendor."No.");
                HospitalInventory."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
                HospitalInventory."Clerkship Type" := HospitalInventory."Clerkship Type"::"FM1/IM1";
                HospitalInventory.Type := HospitalInventory.Type::Inventory;
                HospitalInventory."Start Date" := Rec."Start Date";
                HospitalInventory.Validate("Course Code", Rec."Course Code");
                HospitalInventory.Insert(true);
            until Vendor.Next() = 0;
    end;
}