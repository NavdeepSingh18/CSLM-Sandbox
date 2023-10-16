page 50620 "Hospital Cost Factbox"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Hospital Cost Master";
    Caption = 'Hospital Cost Entries';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Cost)
            {

                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                }
                field("Weekly Cost"; Rec."Weekly Cost")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnOpenPage()
    var
        Vendor: Record Vendor;
    begin
        Vendor.Reset();
        if Vendor.Get(Rec."Hospital ID") then
            Rec."Hospital Name" := Vendor.Name;
    end;
}