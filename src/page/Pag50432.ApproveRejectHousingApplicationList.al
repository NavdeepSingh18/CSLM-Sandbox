page 50432 "Posted Housing Application"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Housing Application";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    CardPageId = "Posted Housing Appln Card";
    Caption = 'Approved/Rejected Housing Application List';
    SourceTableView = sorting("Application No.")
                      order(descending)
                       where(Status = filter(Approved | Rejected | Vacated), Posted = filter(true | false));
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student ID field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                Field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Housing Deposit Date"; Rec."Housing Deposit Date")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 1"; Rec."Housing Pref. 1")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Pref. 1 Selected"; Rec."Pref. 1 Selected")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Housing Pref. 2"; Rec."Housing Pref. 2")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Pref. 2 Selected"; Rec."Pref. 2 Selected")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Housing Pref. 3"; Rec."Housing Pref. 3")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Pref. 3 Selected"; Rec."Pref. 3 Selected")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                Field("Room Mate Name Pref"; Rec."Room Mate Name Pref")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Room Mate Email Pref"; Rec."Room Mate Email Pref")
                {
                    ApplicationArea = all;
                    Editable = False;
                }
                field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                Field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;
                }
                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Bed No."; Rec."Bed No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Preference Remarks"; Rec."Preference Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                Field("Flight Arrival Date"; Rec."Flight Arrival Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Flight Arrival Time"; Rec."Flight Arrival Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Flight Number"; Rec."Flight Number")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                Field("Airline/Carrier"; Rec."Airline/Carrier")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Departure Date from Antigua"; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ledger Entry No."; Rec."Ledger Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
                field("Housing Cos"; Rec."Housing Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Cost';
                }
                field("Inventory Verified"; Rec."Inventory Verified")
                {
                    ApplicationArea = All;
                    Editable = True;

                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;

                }

                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = All;

                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;

                }
                field("Rejected On"; Rec."Rejected On")
                {
                    ApplicationArea = All;
                }
                field("Lease Status Code"; Rec."Lease Status Code")
                {
                    ApplicationArea = All;
                }
                field("Bill Code"; Rec."Bill Code")
                {
                    ApplicationArea = All;
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
            action("Housing Vacate")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    HousingApplication_lRec: Record "Housing Application";
                    UserSetup: Record "User Setup";
                    HousingMailCod: Codeunit "Hosusing Mail";
                    ApplicationCount: Integer;
                begin
                    UserSetup.Reset();
                    UserSetup.SetRange("User ID", UserId());
                    If UserSetup.FindFirst() then
                        IF not UserSetup."Housing Vacate Permission" then
                            Error('You do not have permission for doing Housing Vacate!');

                    If not Confirm('Do you want to Vacate Housing for selected student/s?', false) then
                        exit;

                    HousingApplication_lRec.Reset();
                    CurrPage.SetSelectionFilter(HousingApplication_lRec);
                    HousingApplication_lRec.SetRange(Status, HousingApplication_lRec.Status::Approved);
                    ApplicationCount := HousingApplication_lRec.Count();
                    IF ApplicationCount > 1 then begin
                        IF HousingApplication_lRec.FindSet() then begin
                            repeat
                                HousingMailCod.HousingAutomaticVacateNew(HousingApplication_lRec);
                            until HousingApplication_lRec.Next() = 0;
                        end;
                    end Else begin
                        IF Rec.Status = Rec.Status::Approved then       // 09Dec2022 Navdeep Spring2023
                            HousingMailCod.HousingAutomaticVacateNew(Rec);
                    end;
                end;
            }

            action("Sent Email to Vacate")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;
                Caption = 'Sent Email to Vacate';
                // Runobject = page "Housing Master Card";
                // RunPageLink = "Housing ID" = FIELD("Housing ID");
                trigger OnAction()
                var
                    HousingApplication_lRec: Record "Housing Application";
                    HousingMailCod: Codeunit "Hosusing Mail";
                begin
                    IF Not Confirm('Do you want to send Housing Vacate Email Alert?', false) then
                        exit;
                    HousingApplication_lRec.Reset();
                    CurrPage.SetSelectionFilter(HousingApplication_lRec);
                    IF HousingApplication_lRec.FindSet() then begin
                        repeat
                            HousingApplication_lRec.TestField(Status, HousingApplication_lRec.Status::Approved);
                        // HousingMailCod.SendEmailtoVacateAllStudents(HousingApplication_lRec);
                        until HousingApplication_lRec.Next() = 0;
                    end;
                end;
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
            action("Housing Ledger")
            {
                Caption = '&Housing Ledger';
                ApplicationArea = All;
                PromotedCategory = process;
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
                action("Housing Cost")
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
                            Report.Run(Report::"Housing Cost", True, False, HousingMaster);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        HousingApp: Record "Housing Application";
        studentMaster: Record "Student Master-CS";
    begin
        HousingApp.reset();
        HousingApp.SetFilter("Student No.", '<>%1', '');
        HousingApp.SetFilter("Gender Text", '%1', '');
        if HousingApp.findset() then begin
            repeat
                if studentMaster.get(HousingApp."Student No.") then begin
                    HousingApp.validate(Gender, studentMaster.Gender);
                    if HousingApp.Gender = HousingApp.Gender::" " then
                        HousingApp."Gender Text" := '';

                    if HousingApp.Gender = HousingApp.Gender::Female then
                        HousingApp."Gender Text" := 'Female';

                    if HousingApp.Gender = HousingApp.Gender::Male then
                        Rec."Gender Text" := 'Male';

                    if HousingApp.Gender = HousingApp.Gender::"Not Specified" then
                        HousingApp."Gender Text" := 'Not Specified';
                    HousingApp.Modify();
                end;
            until HousingApp.next() = 0;
        end
    end;
    //end;
}