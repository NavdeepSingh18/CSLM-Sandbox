page 50132 "Exam Atdn Stud Ext. List-CS"
{
    //CSPL-00307-ACGME
    Caption = 'Hospital Branch Address';
    Editable = false;
    PageType = ListPart;
    UsageCategory = None;
    // ApplicationArea = All;
    SourceTable = "Order Address";

    layout
    {
        area(content)
        {
            group("Details")
            {

                field(TotalBranchAddress; TotalBranchAddress)
                {
                    ApplicationArea = All;
                    Caption = 'Total Address Count';
                    Editable = false;
                    // trigger OnDrillDown()
                    // var
                    //     OrderAddress: Record "Order Address";
                    //     OrderAddress_Page: Page "Order Address List";
                    // begin
                    //     OrderAddress.Reset();
                    //     OrderAddress.SetRange("Vendor No.", Rec."Vendor No.");
                    //     OrderAddress_Page.SetTableView(OrderAddress);
                    //     OrderAddress_Page.Editable := False;
                    //     OrderAddress_Page.Run();
                    // end;

                }
                repeater(General)
                {
                    field("Code"; Rec."Code")
                    {
                        Caption = 'Branch Code';
                        ApplicationArea = All;
                        ToolTip = 'Specifies an order-from address code.';
                    }
                    field(Name; Rec.Name)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the name of the company located at the address.';
                    }
                    field(Address; Rec.Address)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the street address.';
                    }
                }
            }
        }
    }

    var
        TotalBranchAddress: Integer;

    trigger OnOpenPage()
    begin
        CountAddress();
    end;

    trigger OnAfterGetRecord()

    begin
        CountAddress();
    end;

    local procedure CountAddress()
    var
        OrderAddress: Record "Order Address";
    begin
        Clear(TotalBranchAddress);
        OrderAddress.reset();
        OrderAddress.SetRange("Vendor No.", Rec."Vendor No.");
        IF OrderAddress.FindSet() then
            TotalBranchAddress := OrderAddress.Count;
    end;
}