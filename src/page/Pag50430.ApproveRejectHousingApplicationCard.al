page 50430 "Posted Housing Appln Card"
{
    UsageCategory = None;
    PageType = Card;
    SourceTable = "Housing Application";
    SourceTableView = sorting("Application No.")
                      order(ascending)
                      where(Status = filter(Approved | Rejected | Vacated));
    DeleteAllowed = False;
    InsertAllowed = false;
    Editable = False;
    caption = 'Approved/Rejected Housing Application Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                Field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                Field("1st Time Island"; Rec."1st Time Island")
                {
                    ApplicationArea = All;
                    Caption = 'Are you first time on the Island?';
                    Editable = False;
                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Deposit Date"; Rec."Housing Deposit Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Pref. 1"; Rec."Housing Pref. 1")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Pref. 1 Name"; Rec."Housing Pref. 1 Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Pref. 1 Selected"; Rec."Pref. 1 Selected")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Pref. 2"; Rec."Housing Pref. 2")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Pref. 2 Name"; Rec."Housing Pref. 2 Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Pref. 2 Selected"; Rec."Pref. 2 Selected")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Pref. 3"; Rec."Housing Pref. 3")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Housing Pref. 3 Name"; Rec."Housing Pref. 3 Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Pref. 3 Selected"; Rec."Pref. 3 Selected")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Room Mate Name Pref"; Rec."Room Mate Name Pref")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                field("Room Mate Email Pref"; Rec."Room Mate Email Pref")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                field("Special Roommate Preference"; Rec."Special Roommate Preference")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Preference Remarks"; Rec."Preference Remarks")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Inventory Verified"; Rec."Inventory Verified")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = False;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Ledger Entry No."; Rec."Ledger Entry No.")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Applied to Continue"; Rec."Applied to Continue")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Approved In Days"; Rec."Approved In Days")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Caption = 'Cancellation Reason Code';
                }
                field("Rejection Description"; Rec."Rejection Description")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Caption = 'Cancellation Description';
                }
                field("Rejected In Days"; Rec."Rejected In Days")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Caption = 'Cancelled In Days';
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Caption = 'Cancelled By';
                }
                field("Rejected On"; Rec."Rejected On")
                {
                    ApplicationArea = all;
                    Editable = False;
                    Caption = 'Cancelled On';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = False;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Lease Status Code"; Rec."Lease Status Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill Code"; Rec."Bill Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Flight Arrival Date"; Rec."Flight Arrival Date")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                Field("Flight Arrival Time"; Rec."Flight Arrival Time")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                Field("Flight Number"; Rec."Flight Number")

                {
                    ApplicationArea = all;
                    Editable = False;
                }
                Field("Airline/Carrier"; Rec."Airline/Carrier")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                Field("Departure Date from Antigua"; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                Field("Housing Cost"; Rec."Housing Cost")
                {
                    ApplicationArea = All;
                }
            }
            Group("Special Accomodation")
            {
                Field("Medical Condition"; Rec."Medical Condition")
                {
                    ApplicationArea = All;
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                }
                field("Traveling With Spouse"; Rec."Traveling With Spouse")
                {
                    ApplicationArea = All;
                }
                field("Travel Spouse & Child"; Rec."Travel Spouse & Child")
                {
                    ApplicationArea = All;
                }
                field("Travel Ser. Animal"; Rec."Travel Ser. Animal")
                {
                    ApplicationArea = All;
                }
                field(Other; Rec.Other)
                {
                    ApplicationArea = All;
                }
                field("Other Description"; Rec."Other Description")
                {
                    ApplicationArea = All;
                }
            }
            group("Upcoming Semester Housing")
            {
                Editable = False;
                field("Temporary Housing Name"; Rec."Temporary Housing Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Temporary Apartment No."; Rec."Temporary Apartment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Temporary Room No."; Rec."Temporary Room No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Housing Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Card';
                Runobject = page "Housing Master Card";
                RunPageLink = "Housing ID" = FIELD("Housing ID");
            }
            action("Student Room Wise Inventory")
            {
                Caption = '&Student Apartment Wise Inventory';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = Page "Student Room Wise Inventory";
                RunPageLink = "Application No." = field("Application No.");

            }
            Action("Email Notification List")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "E-Mail Notification List";
                RunPageLink = ReceiverId = Field("Student No."), Subject = filter('*Housing*');

            }
            action("Housing Ledger")
            {
                Caption = '&Housing Ledger';
                ApplicationArea = All;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = Page "Housing Ledger";
                RunPageLink = "Entry No." = FIELD("Ledger Entry No."), "Application No." = field("Application No.");

            }
            action("Room Category Fee Setup")
            {
                Caption = '&Apartment Category Fee Setup';
                ApplicationArea = All;
                Image = SetupPayment;
                Promoted = true;
                PromotedCategory = Process;
                Promotedonly = True;
                PromotedIsBig = true;
                RunObject = Page "Room Category Fee Setup";
                RunPageLink = "Housing ID" = FIELD("Housing ID");

            }
            Group("Housing Reports")
            {
                action("Bed Count")
                {
                    Caption = 'Room Count';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        HousingMaster: Record "Housing Master";
                    begin
                        HousingMaster.Reset();
                        HousingMaster.SetRange("Housing Group", Rec."Housing Group");
                        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
                        If HousingMaster.FindFirst() then
                            Report.Run(Report::"Bed Count", True, False, HousingMaster);

                    end;
                }
                action("Housing Roster")
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        HousingMaster: Record "Housing Master";
                    begin
                        HousingMaster.Reset();
                        HousingMaster.SetRange("Housing Group", Rec."Housing Group");
                        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
                        If HousingMaster.FindFirst() then
                            Report.Run(Report::"Housing Roster", True, False, HousingMaster);

                    end;
                }
                action("Housing Costs")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Cost';
                    trigger OnAction()
                    var
                        RoomCategoryFeeSetup: Record "Room Category Fee Setup";
                    begin
                        RoomCategoryFeeSetup.Reset();
                        RoomCategoryFeeSetup.SetRange("Housing Group", Rec."Housing Group");
                        RoomCategoryFeeSetup.SetRange("Housing ID", Rec."Housing ID");
                        If RoomCategoryFeeSetup.FindFirst() then
                            Report.Run(Report::"Housing Cost", True, False, RoomCategoryFeeSetup);
                    end;
                }
            }
        }
    }
    var
        EditBool: Boolean;

    trigger OnOpenPage()
    var
    // myInt: Integer;
    begin
        IF Rec."Flight Arrival Date" < 20000101D then begin //CSPL-00307-T1-T1236
            Rec."Flight Arrival Date" := 0D;
            Rec."Flight Arrival Time" := 0T;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        EditBool := true;
        if (Rec.status = Rec.status::Approved) or (Rec.status = Rec.status::Rejected) then
            EditBool := false;

        IF Rec."Flight Arrival Date" < 20000101D then begin //CSPL-00307-T1-T1236
            Rec."Flight Arrival Date" := 0D;
            Rec."Flight Arrival Time" := 0T;
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        EditBool := true;
        if (Rec.status = Rec.status::Approved) or (Rec.status = Rec.status::Rejected) then
            EditBool := false;

        IF Rec."Flight Arrival Date" < 20000101D then begin //CSPL-00307-T1-T1236
            Rec."Flight Arrival Date" := 0D;
            Rec."Flight Arrival Time" := 0T;
        end;
    end;
}