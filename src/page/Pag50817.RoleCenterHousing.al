page 50817 "Housing Role Center."
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Part1; RoleCenterHeadlineHousing)
            {
                ApplicationArea = All;
            }
            part(Activities; HousingRoleCenterCuepage)
            {
                ApplicationArea = Basic, Suite;
            }
            //SD-SN-04-Dec-2020 +
            part(Chart1; "Housing Occupy by Insti. Code")
            {
                Caption = 'Housing occupied by AUA & AICASA students';
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Chart2; "Housing Occupy per semester")
            {
                caption = 'Housing occupancy per semester';
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part(Chart3; "Housing Occupy Per Year")
            {
                caption = 'Housing occupancy per year';
                ApplicationArea = Basic, Suite;
                Visible = true;
            }

            part(Chart4; "Housing Occupy Gndr wise Chart")
            {
                caption = 'Gender Based Housing occupancy';
                ApplicationArea = Basic, Suite;
                visible = true;
            }

            //SD-SN-04-Dec-2020 -

            part(ReportInbox; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
                visible = true;
            }

            part("Housing List01"; "Housing Listpart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'Housing List';
            }
            part("Apartment Category List01"; "Room Listpart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'Apartment Category List';
            }
            part("Apartment Category FeeS"; "Room Category Fee Listpart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
                Caption = 'Apartment Category Fee Setup';
            }
            systempart(Control1901377608; MyNotes)
            {
                Caption = 'My Notes';
                ApplicationArea = Basic, Suite;
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
                    RunObject = page "Housing Group List";//50415
                    ApplicationArea = Basic, Suite;
                }

                action("Housing Inventory List")
                {
                    RunObject = page "Housing Inventory List";//"50427"
                    ApplicationArea = Basic, Suite;
                }
                action("Housing List")
                {
                    RunObject = page "Housing Master List"; //"50413"
                    ApplicationArea = Basic, Suite;
                }
                action("Apartment Category List")
                {
                    RunObject = page "Room Category List";//"50416"
                    ApplicationArea = Basic, Suite;
                }

                action("Apartment Category Fee Set-up")
                {
                    RunObject = page "Room Category Fee Setup";//"50418"
                    ApplicationArea = Basic, Suite;
                }
                action("Financial Accountability Category List")
                {
                    RunObject = page "Financial Account Category";//"50689"
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Housing Periodic Activities")
            {
                group("Housing Periodic Activites")
                {
                    group("Housing Application")
                    {
                        action("Pending Housing Application List")
                        {
                            RunObject = Page "Housing Application List";//50421
                            ApplicationArea = Basic, Suite;
                            RunPageLink = Status = filter("Pending for Approval"), Posted = filter(false);
                        }
                        action("Assigned Housing Application List")
                        {
                            RunObject = Page "Housing Application List";//50421
                            ApplicationArea = Basic, Suite;
                            RunPageLink = Status = filter(Assigned), Posted = filter(false);
                        }
                    }
                    group("Houisn C/V/R Applications")
                    {
                        caption = 'Housing Change/Vacate/Re-Registration Applications';
                        action("Pending Housing Change List")
                        {
                            RunObject = page "Housing Change Request List";//50423
                            ApplicationArea = Basic, Suite;
                        }
                        action("Pending Housing Vacate List")
                        {
                            RunObject = page "Housing Vacate Request List";//50428
                            ApplicationArea = Basic, Suite;
                        }
                        action("Pending Housing Re-Registration List")
                        {
                            RunObject = page "Housing Re-Registration List";//"50706" //50711
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("Housing Issue")
                    {
                        action("Pending Housing Issue List")
                        {
                            RunObject = page "Housing Issue Pending List";//"50468"
                            ApplicationArea = Basic, Suite;
                        }
                        action("Accepted Housing Issue List")
                        {
                            RunObject = page "Housing Issue Accepted List";//"50469"
                            ApplicationArea = Basic, Suite;
                        }
                        action("Resolved Housing Issue List")
                        {
                            RunObject = page "Closed Housing Issue List";//"50470"
                            RunPageLink = Status = filter(Resolved);
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("Financial Accountability")
                    {
                        action("Financial Accountability List")
                        {
                            RunObject = page "Financial Accountability List"; //"50536"
                            ApplicationArea = Basic, Suite;
                        }
                        action("Pending Housing Financial Accountability")
                        {
                            RunObject = page "Housing Fin Account List";//50711
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group(Parking)
                    {
                        action("Pending Parking Sticker Assignment List")
                        {
                            RunObject = page "Housing Parking Details List";//"50523"
                            ApplicationArea = Basic, Suite;
                        }
                        action("Assigned Parking Sticker List")
                        {
                            RunObject = page "Housing Parking Assigned List";//"50525"
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("Housing Waiver")
                    {
                        Visible = False;
                        action("Pending Housing Waiver List")
                        {
                            RunObject = page "Pending Housing Wavier List";//"50573"
                            ApplicationArea = Basic, Suite;
                        }
                    }
                    group("Immigration")
                    {
                        action("Pending Immigration List")
                        {
                            RunObject = page "Immigration list";//"50693"
                            RunPageLink = "Document Status" = filter("Pending for Verification");
                            ApplicationArea = Basic, Suite;
                        }
                    }
                }
            }
            group("Housing Reports")
            {
                action("Bed Count")
                {
                    RunObject = report "Bed Count";//"50160"
                    ApplicationArea = Basic, Suite;
                    Caption = 'Room Count';
                }
                action("Housing Roster")
                {
                    RunObject = report "Housing Roster";//"50161"
                    ApplicationArea = Basic, Suite;
                }
                action("Housing Cost")
                {
                    RunObject = report "Housing Cost";//"50162"
                    ApplicationArea = Basic, Suite;
                }
                action("Extension of Time Application")
                {
                    RunObject = report "Extension of Time Application";//"50165"
                    ApplicationArea = Basic, Suite;
                }
                action("First Time Applicant")
                {
                    RunObject = report "First Time Applicants";//"50164"
                    ApplicationArea = Basic, Suite;
                }
                action("View Student Group")
                {
                    Caption = 'View Student Group';
                    RunObject = page "View Students Group New";
                    ApplicationArea = Basic, Suite;
                }
                action("Student Group Detail")
                {
                    Caption = 'Student Group Detail';
                    RunObject = page "Student Group Detail";
                    ApplicationArea = Basic, Suite;
                }
                action("Broadcast E-Mail")
                {
                    Caption = 'Broadcast E-Mail';
                    RunObject = page "Broadcast E-Mail";
                    ApplicationArea = Basic, Suite;
                }
                action("E-Mail Notification List")
                {
                    Caption = 'E-Mail Notification List';
                    RunObject = page "E-Mail Notification List";
                    ApplicationArea = Basic, Suite;
                }
                Action("Student List")
                {
                    Caption = 'Student List';
                    RunObject = Page "Student Details-CS";
                    ApplicationArea = All;
                }
                Action("Current & Upcoming Housing Comparison")
                {
                    RunObject = Page PendingHousingApplicationList;
                    ApplicationArea = All;
                }
            }
            group("Approved Rejected Housing List")
            {
                group("Approved/Rejected Housing List")
                {

                    action("Approved/Rejected Housing Application")
                    {
                        RunObject = Page "Posted Housing Application";//"50432"
                        RunPageLink = Status = filter(Approved | Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Change Request")
                    {
                        RunObject = page "Approve Reject Housing Change";//"50426"
                        RunPageLink = type = filter("Change Request");
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Vacate Request")
                    {
                        RunObject = page "Approve Reject Housing Change";
                        RunPageLink = type = filter(Vacate), "Mid Sem Break" = const(true);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Vacated Housing Application List")
                    {
                        RunObject = page "Approve Reject Housing Change";
                        RunPageLink = type = filter(Vacate), "Mid Sem Break" = const(False);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Re-Registration Request")
                    {
                        RunObject = page "Approve Reject Housing Change";//"50426"
                        RunPageLink = type = filter("Re-Registration");
                        ApplicationArea = Basic, Suite;
                    }

                    action("Approved/Rejected Financial Accountability")
                    {
                        RunObject = Page "Approve/Reject Fin Account";//"50701"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Approved/Rejected Housing Waiver List")
                    {
                        RunObject = Page "Housing Wavier Approved List";//"50571"
                        ApplicationArea = Basic, Suite;
                        Visible = False;
                    }
                    action("Approved/Rejected Immigration List")
                    {
                        RunObject = Page "Immigration Approved list";//"50713"
                        ApplicationArea = Basic, Suite;
                    }
                    action("Rejected Housing Issue List")
                    {
                        RunObject = Page "Closed Housing Issue List";//"50470"
                        RunPageLink = Status = filter(Rejected);
                        ApplicationArea = Basic, Suite;
                    }
                    action("Housing Ledger")
                    {
                        RunObject = page "Housing Ledger";//"50420"
                        ApplicationArea = Basic, Suite;
                    }
                }

            }
            group(Bursar)
            {
                action("Pending Financial Accountability List")
                {
                    RunObject = page "Pending Financial Account";//"50538"
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Admission Master")
            {
                action("Group Master")
                {
                    RunObject = Page "Group Detail-CS";
                    ApplicationArea = Basic, Suite;
                }
                action("Student Group")
                {
                    RunObject = Page "Group(Student)-CS";
                    ApplicationArea = Basic, Suite;
                }
            }

        }
    }
}