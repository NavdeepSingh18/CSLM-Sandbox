page 50862 "Hospital Contract"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Vendor Contract";
    Caption = 'Hospital Contract';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        Vendor: Record Vendor;
    begin
        Rec."Vendor Name" := '';
        if Vendor.Get(Rec."Vendor No.") then begin
            Rec."Vendor Name" := Vendor."Name";
            Rec."Global Dimension 1 Code" := Vendor."Global Dimension 1 Code";
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (Rec."Contract No." <> '') and ((Rec."Contract Start Date" = 0D) or (Rec."Contract End Date" = 0D)) then
            Error('You must fill all Mandatory fields.');
    end;
}