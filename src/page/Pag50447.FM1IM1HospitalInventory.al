page 50447 "FM1_IM1 Hospital Inventory"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Hospital Inventory";
    DelayedInsert = true;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater("Hospital Inventory")
            {
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Rotation Week"; Rec."Course Rotation Week")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Seats; Rec.Seats)
                {
                    ApplicationArea = All;
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
        }
    }
    var

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
        Vendor: Record Vendor;
        EducationSetupCS: Record "Education Setup-CS";
    begin
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
    end;

    trigger OnAfterGetRecord()
    begin
    end;
}