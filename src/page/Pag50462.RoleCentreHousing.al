page 50462 "Housing Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            group(HousinglList)
            {
                Caption = 'Housing List';
                part("Housing Master Lists"; "Housing List RoleCentre")
                {
                    Caption = 'Housing Master List';
                    ApplicationArea = Basic, Suite;
                }
            }
            group(HousingApplication)
            {
                Caption = 'Housing Applications';
                part("Housing Application"; "Housing Application RoleCentre")
                {
                    Caption = 'Housing Application';
                    ApplicationArea = Basic, Suite;
                }
            }

        }
    }

    actions
    {
        area(Sections)
        {

            group("Housing Master")
            {

                action("Housing Group List")
                {
                    RunObject = Page "Housing Group List";
                    ApplicationArea = Basic, Suite;
                }
                action("Apartment Category List")
                {
                    RunObject = Page "Room Category List";
                    ApplicationArea = Basic, Suite;
                }
                action("Hostel List")
                {
                    RunObject = Page "Housing Master List";
                    ApplicationArea = Basic, Suite;
                }
                action("Hostel Inventory List")
                {
                    RunObject = Page "Housing Inventory List";
                    ApplicationArea = Basic, Suite;
                }


                action("Apartment Category Fee Setup")
                {
                    RunObject = Page "Room Category Fee Setup";
                    ApplicationArea = Basic, Suite;

                }
            }
            group("Housing Periodic Activities")
            {
                action("Housing Application List")
                {
                    RunObject = Page "Housing Application List";
                    ApplicationArea = Basic, Suite;
                }
                // action("Housing Application Approve/Reject List")
                // {
                //     RunObject = Page "Housing Application List";
                //     ApplicationArea = Basic, Suite;
                // }
                action("Housing Vacate/Change/Renew Request")
                {
                    RunObject = Page "Housing Change Request List";
                    ApplicationArea = Basic, Suite;
                }
                // action("Housing Vacate/Change/Renew Approve/Reject List")
                // {
                //     RunObject = Page "Housing Change Request List";
                //     ApplicationArea = Basic, Suite;
                // }
            }

            group("Housing Reports")
            {
                action("Bed Count")
                {
                    RunObject = Report "Bed Count";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Room Count';
                }
                action("Housing Roster")
                {
                    RunObject = Report "Housing Roster";
                    ApplicationArea = Basic, Suite;
                }
                action("Housing Cost")
                {
                    RunObject = Report "Housing Cost";
                    ApplicationArea = Basic, Suite;
                }

            }
            group("Housing Posted/History")
            {
                action("Housing New Application History")
                {
                    RunObject = Page "Posted Housing Application";
                    ApplicationArea = Basic, Suite;
                }
                // action("Housing Vacate/Change/Renew History")
                // {
                //     RunObject = page "Housing Change History List";
                //     ApplicationArea = Basic, Suite;
                // }
                action("Housing Ledger")
                {
                    RunObject = Page "Housing Ledger";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

}