page 50421 "Housing Application List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Housing Application";
    CardPageId = "Housing Application Card";
    SourceTableView = sorting("Created On")
                      order(descending)
                      where(Status = filter("Pending for Approval" | Assigned), Posted = filter(false));
    Caption = 'Pending Housing Application List';
    Editable = False;
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;

                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student ID field.';
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
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;

                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;

                }
                field("Housing Deposit Date"; Rec."Housing Deposit Date")
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
                Field("Room Mate Name Pref"; Rec."Room Mate Name Pref")
                {
                    ApplicationArea = All;
                }
                Field("Room Mate Email Pref"; Rec."Room Mate Email Pref")
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
                Field("Flight Arrival Date"; Rec."Flight Arrival Date")
                {
                    ApplicationArea = All;
                }
                Field("Flight Arrival Time"; Rec."Flight Arrival Time")
                {
                    ApplicationArea = All;
                }
                Field("Flight Number"; Rec."Flight Number")
                {
                    ApplicationArea = all;
                }
                Field("Airline/Carrier"; Rec."Airline/Carrier")
                {
                    ApplicationArea = All;
                }
                Field("Departure Date from Antigua"; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = All;
                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;

                }
                field("Rejection Description"; Rec."Rejection Description")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                }

            }
        }
        area(FactBoxes)
        {
            // part(Control50590; Rec.HousingRoomFactBox)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Availability';
            //     SubPageLink = "Housing ID" = Field("Housing ID");
            // }
        }
    }

    actions
    {
        area(Processing)
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
            action("Send OLR Email")
            {
                ApplicationArea = All;
                Caption = 'Send OLR Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    StudentMasterRec: Record "Student Master-CS";
                    HousingMailCod: Codeunit "Hosusing Mail";
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to send the OLR Email to Student No. %1 ?';
                    Text002Lbl: Label 'OLR Email has been sent to the Student No. %1 .';
                    Text017Lbl: Label 'Do you want to Send OLR Email for the selected Applications.';
                    Text018Lbl: Label 'OLR Email has been sent to the selected Applications.';
                begin
                    CurrPage.SetSelectionFilter(HousingApplicationRec);
                    HoldCount := HousingApplicationRec.Count();
                    IF HoldCount > 1 then begin
                        If CONFIRM(Text017Lbl, false) then begin
                            if HousingApplicationRec.FindSet() Then
                                repeat
                                    if HousingApplicationRec."On Hold" = false then
                                        Error('The Application No. %1 is not on Hold', HousingApplicationRec."Application No.");

                                    StudentMasterRec.Get(HousingApplicationRec."Student No.");

                                    if StudentMasterRec."Returning Student" then
                                        Error('The Student No. %1 is Returning Student', Rec."Student No.");

                                    if StudentMasterRec."OLR Email Sent" = false then begin
                                        HousingMailCod.ReturningStudentOnlineRegistrationEmail(HousingApplicationRec."Student No.");
                                    end else
                                        Error('OLR Email is already sent to Student No. %1', HousingApplicationRec."Student No.");
                                Until HousingApplicationRec.Next() = 0;
                            Message(Text018Lbl);
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text001Lbl, FALSE, Rec."Student No.") THEN BEGIN

                            if Rec."On Hold" = false then
                                Error('The Application No. %1 is not on Hold', Rec."Application No.");

                            StudentMasterRec.Get(Rec."Student No.");

                            if StudentMasterRec."Returning Student" then
                                Error('The Student No. %1 is Returning Student', Rec."Student No.");

                            if StudentMasterRec."OLR Email Sent" = false then begin
                                HousingMailCod.ReturningStudentOnlineRegistrationEmail(Rec."Student No.");
                                Message(Text002Lbl, Rec."Student No.");
                            end else
                                Error('OLR Email is already sent to Student No. %1', Rec."Student No.");

                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Hold")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to Hold the selected Applications?';
                    Text002Lbl: Label 'Do you want to Hold Application No. %1?';
                    Text003Lbl: Label 'Selected Applications are On Hold.';
                    Text004Lbl: Label 'Application No. %1 has been On Hold.';
                begin
                    CurrPage.SetSelectionFilter(HousingApplicationRec);
                    HoldCount := HousingApplicationRec.Count();
                    IF HoldCount > 1 then begin
                        If CONFIRM(Text001Lbl, false) then begin
                            if HousingApplicationRec.FindSet() Then
                                repeat
                                    if HousingApplicationRec."On Hold" = true then
                                        Error('The Application No. %1 is already on Hold', HousingApplicationRec."Application No.");

                                    // Rec.OLREmailSend();
                                    HousingApplicationRec."On Hold" := True;
                                    HousingApplicationRec.Modify();
                                Until HousingApplicationRec.Next() = 0;
                            Message(Text003Lbl);
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."Application No.") THEN BEGIN
                            if HousingApplicationRec."On Hold" = true then
                                Error('The Application No. %1 is already on Hold', HousingApplicationRec."Application No.");

                            // Rec.OLREmailSend();
                            Rec."On Hold" := True;
                            Rec.Modify();
                            Message(Text004Lbl, Rec."Application No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Un Hold")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    HoldCount: Integer;
                    Text001Lbl: Label 'Do you want to UnHold the selected Applications?';
                    Text002Lbl: Label 'Do you want to UnHold Application No. %1?';
                    Text003Lbl: Label 'Selected Applications are UnHold.';
                    Text004Lbl: Label 'Application No. %1 has been UnHold.';
                begin
                    CurrPage.SetSelectionFilter(HousingApplicationRec);
                    HoldCount := HousingApplicationRec.Count();
                    IF HoldCount > 1 then begin
                        If CONFIRM(Text001Lbl, false) then begin
                            if HousingApplicationRec.FindSet() Then
                                repeat
                                    if HousingApplicationRec."On Hold" = false then
                                        Error('The Application No. %1 is already Un Hold', HousingApplicationRec."Application No.");
                                    HousingApplicationRec."On Hold" := False;
                                    HousingApplicationRec.Modify();
                                Until HousingApplicationRec.Next() = 0;
                            Message(Text003Lbl);
                        end else
                            exit;
                    end else
                        IF CONFIRM(Text002Lbl, FALSE, Rec."Application No.") THEN BEGIN
                            if HousingApplicationRec."On Hold" = true then
                                Error('The Application No. %1 is already UN Hold', HousingApplicationRec."Application No.");
                            Rec."On Hold" := False;
                            Rec.Modify();
                            Message(Text004Lbl, Rec."Application No.");
                            CurrPage.Update();
                        end else
                            exit;
                end;
            }
            action("Bulk Check- In/Approve")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    RecHousingApp: Record "Housing Application";
                    RecTempHousingApp: Record "Housing Application" Temporary;
                    TotalCount: Integer;
                    Window: Dialog;
                    Text001Lbl: Label 'Do you want to Approve the selected Applications?';
                    Text002Lbl: Label 'Total %1 Applications have been Approved.';
                begin
                    //CSPL-00307-T1-T1236
                    Clear(TotalCount);
                    RecHousingApp.Reset();
                    CurrPage.SetSelectionFilter(RecHousingApp);
                    IF NOT Confirm(Text001Lbl, false) then
                        exit;
                    if RecHousingApp.FindSet(true) then begin
                        TotalCount := RecHousingApp.Count;
                        Window.Open('Please Wait.. ########1#######');
                        repeat
                            Window.Update(1, RecHousingApp."Application No.");
                            Rec.BulkApproved(RecHousingApp, RecTempHousingApp, True);
                            Commit();
                        until RecHousingApp.Next() = 0;
                        Window.Close();
                        Message(Text002Lbl, TotalCount - RecTempHousingApp.Count);
                        RecTempHousingApp.Reset();
                        if RecTempHousingApp.FindSet() then begin
                            Page.Run(50421, RecTempHousingApp);
                        end;
                        CurrPage.Update();
                    end;
                end;
            }
            action(Testing)
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                var
                    RecHousingApp: Record "Housing Application";
                    RecHousingLedger: Record "Housing Ledger";
                    RecStudentRoomWiseInventory: Record "Student Room Wise Inventory";
                begin
                    CurrPage.SetSelectionFilter(RecHousingApp);
                    IF RecHousingApp.FindSet() then
                        repeat
                            RecHousingLedger.Reset();
                            RecHousingLedger.SetRange("Application No.", RecHousingApp."Application No.");
                            IF RecHousingLedger.FindSet() then
                                RecHousingLedger.DeleteAll();

                            RecStudentRoomWiseInventory.Reset();
                            RecStudentRoomWiseInventory.SetRange("Application No.", RecHousingApp."Application No.");
                            IF RecStudentRoomWiseInventory.FindSet() then
                                RecStudentRoomWiseInventory.DeleteAll();

                            RecHousingApp.Delete(true);
                        until RecHousingApp.Next() = 0;
                    Message('Done');
                end;
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
    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Application Date" <> 0D then begin
            PendingDays := Today() - Rec."Application Date";
            Exit(PendingDays);
        end;
    end;

    var
        HousingApplicationRec: Record "Housing Application";

}