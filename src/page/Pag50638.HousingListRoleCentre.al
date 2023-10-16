page 50638 "Housing List RoleCentre"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Housing Master";
    Editable = false;
    CardPageId = "Housing Master Card";
    Caption = 'Housing List RoleCentre';
    DeleteAllowed = False;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        HousingMaster.Reset();
                        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
                        HousingCard.SetTableView(HousingMaster);
                        HousingCard.Editable := false;
                        HousingCard.Run();
                    end;
                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("Housing Group"; Rec."Housing Group")
                {
                    ApplicationArea = All;

                }
                field("Owned By University"; Rec."Owned By University")
                {
                    ApplicationArea = All;

                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;

                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;

                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;

                }
                field("Contact Number"; Rec."Contact Number")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;

                }

                field("Off Campus"; Rec."Off Campus")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    var

        HousingMaster: Record "Housing Master";
        HousingCard: Page "Housing Master Card";
}