pageextension 50001 ConfiPage extends "Config. Package Fields"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Mapping)
        {
            Action(RemoveValidatetigger)
            {
                ApplicationArea = Basic, Suite;
                PromotedCategory = Process;
                Promoted = true;
                PromotedIsBig = True;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ConfiPackageField: Record "Config. Package Field";
                begin
                    ConfiPackageField.Reset();
                    ConfiPackageField.SetRange("Package Code", Rec."Package Code");
                    ConfiPackageField.SetRange("Table ID", Rec."Table ID");
                    ConfiPackageField.ModifyAll("Validate Field", false);
                end;
            }
        }
    }

    var
        myInt: Integer;
}