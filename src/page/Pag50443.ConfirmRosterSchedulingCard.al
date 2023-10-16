page 50443 "Confirm Roster Scheduling Card"
{
    Caption = 'Confirmed Roster Scheduling';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Roster Scheduling Header";
    //Editable = false;
    InsertAllowed = false;
    //ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }

                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    MultiLine = true;
                }
                field("Umbrella Rotation"; Rec."Umbrella Rotation")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Umbrella Rotation';
                }
                field("Elective Mandatory"; Rec."Elective Mandatory")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Elective Mandatory';
                }
                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    trigger OnValidate()
                    var
                        HospitalInventory: Record "Hospital Inventory";
                    begin
                        Rec.CalcFields("No. of Students Published", "No. of Students Schedule");
                        if Rec."No. of Seats" < Rec."No. of Students Published" + Rec."No. of Students Schedule" then
                            Error('No. of Seats can not be less than ("No. of Students Published" / "No. of Students Schedule" - i.e. %1).',
                            Rec."No. of Students Published" + Rec."No. of Students Schedule");

                        HospitalInventory.Reset();
                        HospitalInventory.SetRange("Hospital ID", Rec."Hospital ID");
                        HospitalInventory.SetRange("Clerkship Type", HospitalInventory."Clerkship Type"::Core);
                        HospitalInventory.SetRange("Course Code", Rec."Course Code");
                        HospitalInventory.SetFilter("Start Date", '<=%1', Rec."Start Date");
                        if HospitalInventory.FindLast() then begin
                            HospitalInventory.Seats := Rec."No. of Seats";
                            HospitalInventory.Modify();
                        end;
                    end;
                }
                field("Maximum Waitlist Students"; Rec."Maximum Waitlist Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
                field("Total No. of Seats"; Rec."Total No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'Total No. of Seats';
                    DecimalPlaces = 0;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Published"; Rec."No. of Students Published")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Schedule"; Rec."No. of Students Schedule")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Completed"; Rec."No. of Students Completed")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students Cancelled"; Rec."No. of Students Cancelled")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("No. of Students In-Review"; Rec."No. of Students In-Review")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
            }

            part(Lines; "Confirm Roster Scheduling SP")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Rotation ID" = field("Rotation ID");
            }
            group("Miscellaneous Details")
            {
                field("DME Contact No."; Rec."DME Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("DME Name"; Rec."DME Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("DME Phone No."; Rec."DME Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("DME Recipient"; Rec."DME Recipient")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }

                field("Preceptor Contact No."; Rec."Preceptor Contact No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Preceptor Name"; Rec."Preceptor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Preceptor Phone No."; Rec."Preceptor Phone No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Preceptor Recipient"; Rec."Preceptor Recipient")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled On"; Rec."Scheduled On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Scheduled By"; Rec."Scheduled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published On"; Rec."Published On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Published By"; Rec."Published By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}

// actions
// {
//     area(Processing)
//     {
//         action("Get Students")
//         {
//             ApplicationArea = All;
//             Caption = 'Get Students';
//             ShortcutKey = 'Ctrl+F6';
//             PromotedOnly = true;
//             Promoted = true;
//             PromotedCategory = Process;
//             PromotedIsBig = true;
//             Image = Customer;
//             Visible = false;
//             trigger OnAction()
//             begin
//                 GetStudents();
//             end;
//         }

//         action("Cancel Rotation")
//         {
//             ApplicationArea = All;
//             Caption = 'Cancel Rotation';
//             ShortcutKey = 'Ctrl+T';
//             PromotedOnly = true;
//             Promoted = true;
//             PromotedCategory = Process;
//             PromotedIsBig = true;
//             Image = CancelAllLines;
//             Enabled = not CancelledRotation;
//             trigger OnAction()
//             var
//                 RosterSchedulingHeader: Record "Roster Scheduling Header";
//             begin
//                 RosterSchedulingHeader.Reset();
//                 RosterSchedulingHeader.FilterGroup(2);
//                 RosterSchedulingHeader.SetRange("Rotation ID", "Rotation ID");
//                 RosterSchedulingHeader.FilterGroup(0);
//                 Page.RunModal(Page::"Rotation Cancellation", RosterSchedulingHeader);
//             end;
//         }
//         action("Add Student")
//         {
//             ApplicationArea = All;
//             Caption = 'Add Student';
//             ShortcutKey = 'Ctrl+S';
//             PromotedOnly = true;
//             Promoted = true;
//             PromotedCategory = Process;
//             PromotedIsBig = true;
//             Image = AddToHome;
//             trigger OnAction()
//             var
//                 RosterSchedulingHeader: Record "Roster Scheduling Header";
//             begin
//                 RosterSchedulingHeader.Reset();
//                 RosterSchedulingHeader.FilterGroup(2);
//                 RosterSchedulingHeader.SetRange("Rotation ID", "Rotation ID");
//                 RosterSchedulingHeader.FilterGroup(0);
//                 Page.RunModal(Page::"Add Student in Rotation", RosterSchedulingHeader);
//             end;
//         }
//         action("Update DME and Preceptor Details")
//         {
//             ApplicationArea = All;
//             Caption = 'Update DME and Preceptor Details';
//             ShortcutKey = 'Ctrl+T';
//             PromotedOnly = true;
//             Promoted = true;
//             PromotedCategory = Process;
//             PromotedIsBig = true;
//             Image = DefaultDimension;
//             trigger OnAction()
//             var
//                 RosterSchedulingHeader: Record "Roster Scheduling Header";
//             begin
//                 TestField("Course Code");
//                 TestField("Hospital ID");
//                 TestField("Start Date");

//                 RosterSchedulingHeader.Reset();
//                 RosterSchedulingHeader.FilterGroup(2);
//                 RosterSchedulingHeader.SetRange("Rotation ID", "Rotation ID");
//                 RosterSchedulingHeader.FilterGroup(0);
//                 Page.RunModal(Page::"DME and Preceptor Update", RosterSchedulingHeader);
//             end;
//         }
//     }

// trigger OnAfterGetRecord()
// begin
//     CancelledRotation := false;
//     // if Status = Status::Cancelled then
//     //     CancelledRotation := true;
// end;

// trigger OnDeleteRecord(): Boolean
// var
//     UserSetup: Record "User Setup";
//     CALE: Record "Clerkship Activity Log Entries";
// begin
//     CalcFields("No. of Students", "No. of Students Cancelled");
//     if "No. of Students" > "No. of Students Cancelled" then
//         Error('Rotation deletion not allowed as (Scheduled/Published) students exists in Rotation Lines');

//     UserSetup.Reset();
//     if UserSetup.Get(UserId) then
//         if UserSetup."Rotation Deletion Allowed" = false then
//             Error('You are not allowed to Delete a Rotation.');

//     CALE.InsertLogEntry(5, 9, '', '', "Rotation ID", 'BCRD', 'Core Rotation Header Delete', '', '');
// end;

// var
//     CancelledRotation: Boolean;
