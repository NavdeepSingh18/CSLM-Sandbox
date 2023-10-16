page 50639 "Housing Application RoleCentre"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Housing Application";
    CardPageId = "Housing Application Card";
    SourceTableView = sorting("Application No.")
                      order(ascending)
                      where(Status = filter("Pending for Approval"), Posted = filter(false));
    Caption = 'Housing Application RoleCentre';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        HousingApplication.Reset();
                        // HousingApplication.SetRange("Application No.", "Application No.");
                        HousingApplicationCard.SetTableView(HousingApplication);
                        HousingApplicationCard.Editable := false;
                        HousingApplicationCard.Run();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;

                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;

                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 1"; Rec."Housing Pref. 1")
                {
                    ApplicationArea = All;

                }
                field("Pref. 1 Selected"; Rec."Pref. 1 Selected")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 2"; Rec."Housing Pref. 2")
                {
                    ApplicationArea = All;

                }
                field("Pref. 2 Selected"; Rec."Pref. 2 Selected")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 3"; Rec."Housing Pref. 3")
                {
                    ApplicationArea = All;

                }
                field("Pref. 3 Selected"; Rec."Pref. 3 Selected")
                {
                    ApplicationArea = All;

                }
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;

                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;

                }
                field("Preference Remarks"; Rec."Preference Remarks")
                {
                    ApplicationArea = All;

                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;

                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
            }
        }
    }

    var
        HousingApplication: Record "Housing Application";
        HousingApplicationCard: Page "Housing Application Card";

}