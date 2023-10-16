page 50438 "Hospital Inventory"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hospital Inventory";
    DelayedInsert = true;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(Information)
            {
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
            }
            repeater("Hospital Inventory")
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        NonEditInCaseofCoreClerkShip := true;
                        if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                            NonEditInCaseofCoreClerkShip := false;

                        FM1_IM1Inventory := true;
                        if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
                            FM1_IM1Inventory := true
                        else
                            FM1_IM1Inventory := false;
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = FM1_IM1Inventory;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        NonEditInCaseofCoreClerkShip := true;
                        if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
                            NonEditInCaseofCoreClerkShip := false;
                    end;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    Editable = NonEditInCaseofCoreClerkShip;
                    ApplicationArea = All;
                }
                field("Course Rotation Week"; Rec."Course Rotation Week")
                {
                    Editable = NonEditInCaseofCoreClerkShip;
                    ApplicationArea = All;
                }
                field(Seats; Rec.Seats)
                {
                    ApplicationArea = All;
                }
                field("Elective Mandatory"; Rec."Elective Mandatory")
                {
                    Editable = Not NonEditInCaseofCoreClerkShip;
                    ApplicationArea = All;
                }

                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Block Reason Code"; Rec."Block Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Block Reason"; Rec."Block Reason")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Block)
            {
                ApplicationArea = All;
                Caption = 'Block';
                Image = CancelLine;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'To Block Hospital Inventory.';

                trigger OnAction();
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    Rec.TestField("Block Reason");
                    if Confirm('Do you want to block Inventory of Hospital %1 (%2) %3 Clerkship, %4 (%5) ?', true,
                    Rec."Hospital ID", Rec."Hospital Name", Rec."Clerkship Type", Rec."Course Code", Rec."Course Description") then begin
                        Rec.Status := Rec.Status::Blocked;
                        Rec."Blocked By" := UserId;
                        Rec."Blocked On" := Today;
                        Rec.Modify();
                        CALE.InsertLogEntry(1, 8, Rec."Hospital ID", Rec."Hospital Name", 'NA', Rec."Block Reason Code", Rec."Block Reason", '', '');
                        Message('Inventory of Hospital %1 (%2) %3 Clerkship, %4 (%5) is blocked.',
                        Rec."Hospital ID", Rec."Hospital Name", Rec."Clerkship Type", Rec."Course Code", Rec."Course Description");
                    end;
                end;
            }
            action("Unblock")
            {
                ApplicationArea = All;
                Caption = 'Unblock';
                Image = Approval;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'To Unblock Hospital Inventory.';

                trigger OnAction();
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to unblock Inventory of Hospital %1 (%2) %3 Clerkship, %4 (%5) ?', true,
                    Rec."Hospital ID", Rec."Hospital Name", Rec."Clerkship Type", Rec."Course Code", Rec."Course Description") then begin
                        Rec.Status := Rec.Status::Allowed;
                        Rec."Unblock By" := UserId;
                        Rec."Unblock On" := Today;
                        Rec."Block Reason Code" := '';
                        Rec."Block Reason" := '';
                        Rec.Modify();
                        CALE.InsertLogEntry(1, 7, Rec."Hospital ID", Rec."Hospital Name", 'NA', '', '', '', '');
                        Message('Inventory of Hospital %1 (%2) %3 Clerkship, %4 (%5) is unblocked.',
                        Rec."Hospital ID", Rec."Hospital Name", Rec."Clerkship Type", Rec."Course Code", Rec."Course Description");
                    end;
                end;
            }

            action("Copy Inventory")
            {
                ApplicationArea = All;
                Caption = 'Copy Inventory';
                Image = Copy;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'To Copy the Inventory';
                RunPageMode = Edit;
                trigger OnAction()
                var
                    CopyHospitalInventory: Page "Copy Hospital Inventory";
                begin
                    CopyHospitalInventory.SetVariables(Rec."Hospital ID", Rec."Hospital Name");
                    CopyHospitalInventory.RunModal();
                end;
            }
        }
    }
    var
        NonEditInCaseofCoreClerkShip: Boolean;
        FM1_IM1Inventory: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
        Vendor: Record Vendor;
        EducationSetupCS: Record "Education Setup-CS";
        VendorContract: Record "Vendor Contract";
    begin
        FM1_IM1Inventory := true;

        UserSetup.Reset();
        if UserSetup.Get(UserId) then;

        Vendor.Reset();
        if Vendor.Get(Rec."Hospital ID") then begin
            Rec."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
            Rec."Hospital Name" := Vendor.Name;
        End;

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetupCS.FindFirst() then
            Rec."Academic Year" := EducationSetupCS."Academic Year";

        VendorContract.Reset();
        VendorContract.SetRange("Vendor No.", Rec."Hospital ID");
        if VendorContract.FindLast() then begin
            Rec."Contract Start Date" := VendorContract."Contract Start Date";
            Rec."Contract End Date" := VendorContract."Contract End Date";
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        NonEditInCaseofCoreClerkShip := true;
        if Rec."Clerkship Type" = Rec."Clerkship Type"::Core then
            NonEditInCaseofCoreClerkShip := false;

        if Rec."Clerkship Type" = Rec."Clerkship Type"::"FM1/IM1" then
            FM1_IM1Inventory := true
        else
            FM1_IM1Inventory := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.TestField("Consumed Seats", 0);
    end;
}