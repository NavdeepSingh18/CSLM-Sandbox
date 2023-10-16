page 50707 "Housing Re-Registration Card"
{
    PageType = Card;
    Caption = 'Pending Housing Re-Registration Card';
    UsageCategory = None;
    SourceTable = "Housing Change Request";
    SourceTableView = sorting("Application No.")
                      order(ascending)
                      where(Status = filter("Pending for Approval"), Type = filter("Re-Registration"));
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = EditableBTNVfield;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;

                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = EditableBTNVfield;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;

                }
                Field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Original Application No."; Rec."Original Application No.")
                {
                    ApplicationArea = All;

                }

                Field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                field("Housing Address"; Rec."Housing Address")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                Field("Housing Address 2"; Rec."Housing Address 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field("Housing City"; Rec."Housing City")
                {
                    ApplicationArea = All;

                }
                field("Housing Country"; Rec."Housing Country")
                {
                    ApplicationArea = All;

                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;

                }
                field("Contact Number"; Rec."Contact Number")
                {
                    ApplicationArea = All;

                }

                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field("Approve/Reject Remarks"; Rec."Approve/Reject Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(Control50590; HousingRoomFactBox)
            {
                ApplicationArea = All;
                Caption = 'Availability';
                SubPageLink = "Housing ID" = Field("Housing ID");
            }
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
            action("&Approve")
            {
                ApplicationArea = All;
                Caption = '&Approve';
                Image = Approve;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM(Text001Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        Rec.Testfield("Original Application No.");

                        Rec.RenewApplication();
                        //RegistrationRequestApproved(Rec."Application No.");//GMCSCOM
                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved By" := UserId();
                        Rec."Approved On" := Today();
                        Rec."Approved In Days" := Today() - Rec."Application Date";
                        Rec.Posted := true;
                        Rec.Modify();
                        Message(Text003Lbl, Rec."Application No.");
                        CurrPage.Close();
                    END ELSE
                        exit;
                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = '&Reject';
                Image = Reject;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    IF CONFIRM(Text002Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        if Rec."Approve/Reject Remarks" = '' then
                            Error('Please enter Approve/Reject Remarks');
                        Rec.TestField(Status, Rec.Status::"Pending for Approval");
                        Rec."Rejected By" := UserId();
                        Rec."Rejected On" := Today();
                        Rec."Rejected In Days" := Today() - Rec."Application Date";
                        Rec.Status := Rec.Status::Rejected;
                        Rec."Approve/Reject Date" := WORKDATE();
                        Rec.Modify();
                        //RegistrationRequestRejected(Rec."Application No.");//GMCSCOM
                        Message(Text004Lbl, Rec."Application No.");
                    END ELSE
                        exit;
                end;
            }
            action("&Create Application")
            {
                ApplicationArea = All;
                Caption = '&Create Application';
                Image = Create;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM(Text007Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        if Rec.Type <> Rec.Type::"Change Request" then
                            Error('Request Type must be Change Request for Application No. %1', Rec."Application No.");
                        if Rec."New Application No." <> '' then
                            Error('Housing Alloment Application is already created');

                        Rec.TestField("Effective Date");
                        Rec.TestField("Original Application No.");
                        Rec.TestField("Housing Pref. 1");
                        Rec.CreateHostelApplication();
                    END ELSE
                        exit;
                end;
            }
            action("&Post")
            {
                ApplicationArea = All;
                Caption = '&Post';
                Image = Post;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF CONFIRM(Text005Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        Rec.TestField(Status, Rec.Status::Approved);
                        If Rec.Type = Rec.type::"Re-Registration" then
                            Rec.RenewApplication();
                        If Rec.Type = Rec.type::Vacate then begin
                            IF Rec."Room Keys Returned" = false then
                                Error('Apartment Key must be returned');
                            StudentRoomWiseInventoryRec.Reset();
                            StudentRoomWiseInventoryRec.SetRange("Application No.", Rec."Original Application No.");
                            if StudentRoomWiseInventoryRec.FINDSET() THEN
                                repeat
                                    StudentRoomWiseInventoryRec.TestField(StudentRoomWiseInventoryRec."Quantity Verified Vacate");
                                    StudentRoomWiseInventoryRec.Testfield(StudentRoomWiseInventoryRec."Verified Vacate Date");
                                Until StudentRoomWiseInventoryRec.NEXT() = 0;
                            Rec.PostApplication(Rec."Application No.");
                        end;
                        If Rec.Type = Rec.type::"Change Request" then begin
                            Rec.TestField("New Application No.");
                            Rec.TestField("Room Keys Returned");
                            StudentRoomWiseInventoryRec.Reset();
                            StudentRoomWiseInventoryRec.SetRange("Application No.", Rec."Original Application No.");
                            if StudentRoomWiseInventoryRec.FINDSET() THEN
                                repeat
                                    StudentRoomWiseInventoryRec.TestField(StudentRoomWiseInventoryRec."Quantity Verified Vacate");
                                    StudentRoomWiseInventoryRec.Testfield(StudentRoomWiseInventoryRec."Verified Vacate Date");
                                Until StudentRoomWiseInventoryRec.NEXT() = 0;
                            Rec.PostApplication(Rec."Application No.");
                            HousingApplicationRec.PostApplication(Rec."New Application No.", Rec."Application No.");

                        end;
                        Message(Text006Lbl, Rec."Application No.");
                    END ELSE
                        exit;
                end;
            }
            action("Housing Application Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Application Card';
                trigger OnAction()
                begin
                    HousingApplicationRec.RESET();
                    HousingApplicationRec.SETRANGE("Application No.", Rec."Original Application No.");
                    IF HousingApplicationRec.FINDFIRST() THEN
                        PAGE.RUN(50422, HousingApplicationRec);
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
                        RoomCategoryFeeSetup.SetRange("Housing ID", Rec."Housing ID");
                        If RoomCategoryFeeSetup.FindFirst() then
                            Report.Run(Report::"Housing Cost", True, False, RoomCategoryFeeSetup);
                    end;
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        IF Rec."Entry From Portal" THEN begin
            EditableBTNVfield := false;
            CurrPage.Update();
        end else begin
            EditableBTNVfield := true;
            CurrPage.Update();
        end;
        EditableBTNVDate := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    Begin
        Rec.Type := Rec.Type::"Re-Registration";
    End;

    trigger OnAfterGetRecord()
    begin
        IF Rec.Type = Rec.Type::"Re-Registration" THEN
            EditableBTNVDate := true
        else
            EditableBTNVDate := false;

        IF Rec.Type = Rec.Type::"Change Request" THEN
            EditableBTNHostel := true
        else
            EditableBTNHostel := false;

    end;

    var

        HousingApplicationRec: Record "Housing Application";
        StudentRoomWiseInventoryRec: Record "Student Room Wise Inventory";
        EditableBTNVfield: Boolean;
        EditableBTNVDate: Boolean;
        EditableBTNHostel: Boolean;
        Text001Lbl: Label 'Do you want to approve Application No. %1 ?';
        Text002Lbl: Label 'Do you want to reject Application No. %1 ?';
        Text003Lbl: Label 'Application No. %1 has been approved.';
        Text004Lbl: Label 'Application No. %1 has been rejected.';
        Text005Lbl: Label 'Do you want to post Application No. %1 ?';
        Text006Lbl: Label 'Application No. %1 has been posted.';
        Text007Lbl: Label 'Do you want to create housing application for Application No. %1';




}