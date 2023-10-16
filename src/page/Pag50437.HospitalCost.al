page 50437 "Hospital Cost"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hospital Cost Master";
    Caption = 'Hospital Cost';
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
            repeater(Cost)
            {
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Weekly Cost"; Rec."Weekly Cost")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        Vendor: Record Vendor;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        if Not UserSetup.Get(UserId) then
            Error('User Setup not found for the User ID %1.', UserId);

        if UserSetup."Bursar Clinical Administrator" = false then
            CurrPage.Editable := false;

        Vendor.Reset();
        if Vendor.Get(Rec."Hospital ID") then
            Rec."Hospital Name" := Vendor.Name;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        Vendor: Record Vendor;
    begin
        Vendor.Reset();
        if Vendor.Get(Rec."Hospital ID") then begin
            Rec."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
            Rec."Hospital Name" := Vendor.Name;
        end;
    end;
}