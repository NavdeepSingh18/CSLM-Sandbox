page 50922 "Residency Fact Box"
{
    PageType = CardPart;
    Caption = 'Residency Fact Box';
    SourceTable = Residency;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    // SourceTableView = where("Sign-off" = Filter(false), "Hold Type" = FILTER(<> Registrar));


    layout
    {
        area(Content)
        {
            group("Residency List")
            {
                Caption = 'Residency Details';
                field(HoldCount2; HoldCount)
                {
                    ApplicationArea = All;
                    Caption = 'Total Residency Count';
                    Style = Strong;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        ResidencyRec.Reset();
                        ResidencyRec.SetRange("Student No.", Rec."Student No.");
                        //ResidencyRec.SetRange("Residency No.", "Residency No.");
                        ResidencyListPage.SetTableView(ResidencyRec);
                        ResidencyListPage.Editable := false;
                        ResidencyListPage.Run();
                    end;
                }

                repeater(Residency)
                {

                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Hospital Name';
                        Style = Strong;
                        Editable = false;
                    }
                    field("Residency Specialty"; Rec."Residency Specialty")
                    {
                        ApplicationArea = All;
                        Caption = 'Residency Specialty';
                        Editable = false;
                    }

                }

            }
        }
    }

    var
        ResidencyRec: Record Residency;

        ResidencyListPage: Page "Residency List";
        HoldCount: Integer;


    trigger OnAfterGetRecord()
    begin
        ResidencyRec.Reset();
        ResidencyRec.SetRange("Student No.", Rec."Student No.");
        //ResidencyRec.SetRange("Residency No.", "Residency No.");
        IF ResidencyRec.FindSet() then
            HoldCount := ResidencyRec.Count();

    end;

}