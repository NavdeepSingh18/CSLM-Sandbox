page 50422 "Housing Application Card"
{
    PageType = Card;
    Caption = 'Pending Housing Application Card';
    SourceTable = "Housing Application";
    UsageCategory = None;
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
                Field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                Field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                Field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = true;

                }
                Field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                Field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                Field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                Field("1st Time Island"; Rec."1st Time Island")
                {
                    ApplicationArea = All;
                    Caption = 'Are you first time on the Island?';
                }
                field("With Spouse"; Rec."With Spouse")
                {
                    ApplicationArea = All;


                }

                field("Deposit Amount"; Rec."Deposit Amount")
                {
                    ApplicationArea = All;

                }
                field("Housing Deposit Date"; Rec."Housing Deposit Date")
                {
                    ApplicationArea = All;

                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 1"; Rec."Housing Pref. 1")
                {
                    ApplicationArea = All;

                }
                field("Housing Pref. 1 Name"; Rec."Housing Pref. 1 Name")
                {
                    ApplicationArea = All;

                }
                field("Housing Group Pref.1"; Rec."Housing Group Pref.1")
                {
                    ApplicationArea = All;

                }
                field("Room Category Pref.1"; Rec."Room Category Pref.1")
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
                field("Housing Pref. 2 Name"; Rec."Housing Pref. 2 Name")
                {
                    ApplicationArea = All;

                }
                field("Housing Group Pref.2"; Rec."Housing Group Pref.2")
                {
                    ApplicationArea = All;

                }
                field("Room Category Pref.2"; Rec."Room Category Pref.2")
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
                field("Housing Pref. 3 Name"; Rec."Housing Pref. 3 Name")
                {
                    ApplicationArea = All;

                }
                field("Housing Group Pref.3"; Rec."Housing Group Pref.3")
                {
                    ApplicationArea = All;

                }
                field("Room Category Pref.3"; Rec."Room Category Pref.3")
                {
                    ApplicationArea = All;
                }
                field("Pref. 3 Selected"; Rec."Pref. 3 Selected")
                {
                    ApplicationArea = All;

                }
                field("Room Mate Name Pref"; Rec."Room Mate Name Pref")
                {
                    ApplicationArea = All;

                }
                field("Room Mate Email Pref"; Rec."Room Mate Email Pref")
                {
                    ApplicationArea = All;

                }
                Field("Special Roommate Preference"; Rec."Special Roommate Preference")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Housing Cos"; Rec."Housing Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Cost';
                }
                field("Accepted for Previous Housing"; Rec."Accepted for Previous Housing")
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
                field("Bed Size"; Rec."Bed Size")
                {
                    ApplicationArea = All;


                }

                field("Preference Remarks"; Rec."Preference Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;

                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;

                }
                field("Rejection Reason Code"; Rec."Rejection Reason Code")
                {
                    ApplicationArea = All;
                    Caption = 'Cancellation Reason Code';
                }
                field("Rejection Description"; Rec."Rejection Description")
                {
                    ApplicationArea = All;
                    Caption = 'Cancellation Description';
                    MultiLine = true;

                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
                Field("Flight Arrival Date"; Rec."Flight Arrival Date")
                {
                    ApplicationArea = all;
                }
                Field("Flight Arrival Time"; Rec."Flight Arrival Time")
                {
                    ApplicationArea = all;
                }
                Field("Flight Number"; Rec."Flight Number")

                {
                    ApplicationArea = all;
                }
                Field("Airline/Carrier"; Rec."Airline/Carrier")
                {
                    ApplicationArea = all;
                }
                Field("Departure Date from Antigua"; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;


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

                field("Temporary Housing Name"; Rec."Temporary Housing Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Upcoming Housing Name';
                }
                Field("Temporary Apartment No."; Rec."Temporary Apartment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Upcoming Apartment No';
                }
                Field("Temporary Room No."; Rec."Temporary Room No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Upcoming Room No';
                }
                Field("Room Category Code"; Rec."Room Category Code")
                {
                    ApplicationArea = All;
                    Editable = False;
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
            action("Send OLR Email")
            {
                ApplicationArea = All;
                Caption = 'Send OLR Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                //Enabled = (Not ShowVisibility) and (Status = Status::Assigned);
                Enabled = (Not ShowVisibility);
                trigger OnAction()
                var
                    StudentMasterRec: Record "Student Master-CS";
                    HousingMailCod: Codeunit "Hosusing Mail";
                    Text001Lbl: Label 'Do you want to send the OLR Email to Student No. %1 ?';
                    Text002Lbl: Label 'OLR Email has been sent to the Student No. %1 .';
                begin
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
            action("&Approve")
            {
                ApplicationArea = All;
                Caption = 'Check- In/Approve';
                //Visible = Status <> Status::"Pending for Approval";
                Image = Approve;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                //Enabled = (Not ShowVisibility) and (Status = Status::Assigned);
                Enabled = (Not ShowVisibility);
                PromotedCategory = Process;

                trigger OnAction()
                var
                    usersetupapprover: Record "Document Approver Users";
                    OptOut_lRec: Record "Opt Out";
                    StudentTimeLineRec: Record "Student Time Line";
                    HousingApplication: Record "Housing Application";
                    StudentRec: REcord "Student Master-CS";
                    SalesForceCodeunit: Codeunit SLcMToSalesforce;
                    HousingType: Integer;
                begin
                    usersetupapprover.Reset();
                    usersetupapprover.setrange("User ID", UserId());
                    usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
                    IF not usersetupapprover.FindFirst() then
                        Error('You do not have permission to Approve the Application');

                    if Rec."On Hold" then
                        Error('Application No. %1 is on Hold', Rec."Application No.");
                    // if UserSetup.Get(UserId()) then
                    //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Residential Services" then
                    //         Error('You do not have permission to Approve the Application');

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    EducationSetup.SetRange("Pre Housing App. Allowed", false);
                    if EducationSetup.FindFirst() then begin
                        if EducationSetup."Even/Odd Semester" <> Rec.Term then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                        if EducationSetup."Academic Year" <> Rec."Academic Year" then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                    end;

                    if (Rec."Rejection Reason Code" <> '') or (Rec."Rejection Description" <> '') then
                        Error('Rejection reason code & Rejection description must be blank.');

                    HousingApplication.Reset();
                    HousingApplication.SetRange("Student No.", Rec."Student No.");
                    HousingApplication.SetRange("Academic Year", Rec."Academic Year");
                    HousingApplication.SetRange(Term, Rec.Term);
                    HousingApplication.SetRange(Semester, Rec.Semester);
                    HousingApplication.SetRange(Status, HousingApplication.Status::Approved);
                    If HousingApplication.FindFirst() then
                        Error('Housing Application already approved for %1-%2', Format(HousingApplication.Term), HousingApplication."Academic Year");

                    StudentRec.Reset();
                    StudentRec.Get(Rec."Student No.");
                    if StudentRec.HostelRoomBedAssigned(Rec."Student No.", 2) <> '' then
                        Error('Housing is already assigned to Student No. %1', Rec."Student No.");

                    if Rec.CheckHousingAlreadyAssigned(Rec) = True then
                        Error('Room No %1 is already assigned to other student', Rec."Bed No."); //CSPL-00307-T1-T1236
                    //HosusingMailCod.CheckHousingWaiver(Rec);

                    IF CONFIRM(Text001Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        IF NOT (Rec.Status IN [Rec.Status::"Pending for Approval", Rec.Status::Assigned]) then//CSPL-00307-T1-T1236
                            Error('Status must not be %1', Rec.Status);
                        Rec.Testfield("Student No.");
                        Rec.TestField("Start Date");
                        Rec.TestField("End Date");
                        Rec.TestField("Room No.");
                        Rec.TestField("Bed No.");
                        if Rec."Housing ID" = '' then
                            Error('Any one out of three housing preferences must be selected');

                        if Rec."Housing Cost" = 0 then
                            Error('Housing Cost must have value in it, please check Apartment Category Fee Setup.');


                        // //SD-SN-22-Dec-2020 +
                        // SalesForceCodeunit.HousingAllomentInformationSFInsert(OptOut_lRec, Rec, 0);
                        // //SD-SN-22-Dec-2020 -
                        HousingChangeRequestRec.Reset();
                        HousingChangeRequestRec.SetRange("New Application No.", Rec."Application No.");
                        if HousingChangeRequestRec.FindFirst() then
                            Error('You can only Approve this entry from housing change request page');

                        HosusingMailCod.StudentHousingTypeUpdate(Rec."Student No.", Rec."Housing ID", Rec."Room No.", Rec."Bed No.");
                        Rec.PostApplication(Rec."Application No.", '');
                        // StudentHostelAssignMail(Rec."Application No.");
                        StudentTimeLineRec.InsertRecordFun(Rec."Student No.", Rec."Student Name", 'Housing Hold Disable', UserId(), Today());


                        Rec.Status := Rec.Status::Approved;
                        Rec.Posted := True;
                        Rec."Approved By" := UserId();
                        Rec."Approved On" := Today();
                        Rec."Approved In Days" := Today() - Rec."Application Date";
                        Rec.Modify();
                        //SD-SN-22-Dec-2020 +
                        SalesForceCodeunit.HousingAllomentInformationSFInsert(OptOut_lRec, Rec, 0);
                        SalesForceCodeunit.HousingWaiverAndApplicationAPI(Rec, OptOut_lRec, 0);
                        //SD-SN-22-Dec-2020 -

                        Message(Text003Lbl, Rec."Application No.");
                        CurrPage.Close();
                    END ELSE
                        exit;
                end;
            }
            action("&Reject")
            {
                ApplicationArea = All;
                Caption = '&Cancel';
                Image = Reject;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                //Enabled = (Not ShowVisibility) and (Status = Status::Assigned);
                Enabled = (Not ShowVisibility);
                trigger OnAction()
                var
                    usersetupapprover: Record "Document Approver Users";
                    OptOut_lRec: Record "Opt Out";
                    SalesForceCodeunit: Codeunit SLcMToSalesforce;

                begin
                    // if "Housing ID" = '' then
                    //     Error('Any one out of three housing preferences must be selected');
                    usersetupapprover.Reset();
                    usersetupapprover.setrange("User ID", UserId());
                    usersetupapprover.SetFilter(usersetupapprover."Department Approver Type", '%1', usersetupapprover."Department Approver Type"::"Residential Services");
                    IF not usersetupapprover.FindFirst() then
                        Error('You do not have permission to Cancel the Application');
                    // if UserSetup.Get(UserId()) then
                    //     if UserSetup."Department Approver" <> UserSetup."Department Approver"::"Residential Services" then
                    //         Error('You do not have permission to Reject the Application');

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    EducationSetup.SetRange("Pre Housing App. Allowed", false);
                    if EducationSetup.FindFirst() then begin
                        if EducationSetup."Even/Odd Semester" <> Rec.Term then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                        if EducationSetup."Academic Year" <> Rec."Academic Year" then
                            Error('No action can be taken in the Application No.%1 as it is not from current Term or Academic Year.', Rec."Application No.");
                    end;

                    if Rec."Room No." <> '' then
                        Error('Apartment No. must be blank.');

                    if Rec."Bed No." <> '' then
                        Error('Room No. must be blank.');

                    IF CONFIRM(Text002Lbl, FALSE, Rec."Application No.") THEN BEGIN
                        IF NOT (Rec.Status IN [Rec.Status::"Pending for Approval", Rec.Status::Assigned]) then//CSPL-00307-T1-T1236
                            Error('Status must not be %1', Rec.Status);

                        if Rec."Rejection Description" = '' then
                            Error('Cancellation Description must have value in it.');

                        SalesForceCodeunit.HousingAllomentInformationSFInsert(OptOut_lRec, Rec, 0);

                        // HousingRejectionMail();
                        Rec.Status := Rec.Status::Rejected;
                        Rec."Rejected By" := UserId();
                        Rec."Rejected On" := Today();
                        Rec."Rejected In Days" := Today() - Rec."Application Date";
                        Rec.Modify();
                        SalesForceCodeunit.HousingWaiverAndApplicationAPI(Rec, OptOut_lRec, 0);
                        Message(Text004Lbl, Rec."Application No.");
                        CurrPage.Close();
                    END ELSE
                        exit;
                end;
            }
            action("Housing Ledger")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Ledger';
                Runobject = page "Housing Ledger";
                RunPageLink = "Student No." = FIELD("Student No.");
            }
            action("&Post")
            {
                ApplicationArea = All;
                Caption = '&Post';
                Image = Post;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin

                    If CONFIRM(Text005Lbl, false, Rec."Application No.") then begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        HousingChangeRequestRec.Reset();
                        HousingChangeRequestRec.SetRange("New Application No.", Rec."Application No.");
                        if HousingChangeRequestRec.FindFirst() then
                            Error('You can only Approve this entry from housing change request page');
                        Rec.PostApplication(Rec."Application No.", '');
                        // StudentHostelAssignMail(Rec."Application No.");
                        Message(Text006Lbl, Rec."Application No.");
                    END ELSE
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
                //Enabled = (Not ShowVisibility) and (Status = Status::Assigned);
                Enabled = (Not ShowVisibility);
                trigger OnAction()
                var

                begin
                    If CONFIRM(Text007Lbl, false, Rec."Application No.") then begin
                        // Rec.OLREmailSend();
                        Rec."On Hold" := True;
                        Rec.Modify();
                        Message(Text009Lbl, Rec."Application No.");
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
                //Enabled = (Not ShowVisibility) and (Status = Status::Assigned);
                Enabled = (Not ShowVisibility);
                trigger OnAction()
                var

                begin
                    If CONFIRM(Text008Lbl, false, Rec."Application No.") then begin
                        Rec."On Hold" := False;
                        Rec.Modify();
                        Message(Text010Lbl, Rec."Application No.");
                    end else
                        exit;
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

    trigger OnOpenPage()
    begin
        IF Rec."Entry From Portal" THEN begin
            EditableBTNVfield := false;
            CurrPage.Update();
        end else begin
            EditableBTNVfield := true;
            CurrPage.Update();
        end;
        IF Rec."Flight Arrival Date" < 20000101D then begin //CSPL-00307-T1-T1236
            Rec."Flight Arrival Date" := 0D;
            Rec."Flight Arrival Time" := 0T;
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        If Rec.Status = Rec.Status::"Pending for Approval" then
            CurrPage.Caption := 'Pending Housing Application Card';

        If Rec.Status = Rec.Status::Assigned then
            CurrPage.Caption := 'Assigned Housing Application Card';

        IF Rec."Flight Arrival Date" < 20000101D then begin //CSPL-00307-T1-T1236
            Rec."Flight Arrival Date" := 0D;
            Rec."Flight Arrival Time" := 0T;
        end;
    end;

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
        HousingChangeRequestRec: Record "Housing Change Request";
        EducationSetup: Record "Education Setup-CS";

        UserSetup: Record "User Setup";
        HosusingMailCod: Codeunit "Hosusing Mail";
        EditableBTNVfield: Boolean;
        Text001Lbl: Label 'Do you want to approve application No. %1 ?';
        Text002Lbl: Label 'Do you want to cancel application No. %1 ?';
        Text003Lbl: Label 'Application No. %1 has been approved.';
        Text004Lbl: Label 'Application No. %1 has been cancelled.';
        Text005Lbl: Label 'Do you want to post application No. %1 ?';
        Text006Lbl: Label 'Application No. %1 has been posted.';
        Text007Lbl: Label 'Do you want to Hold application No. %1 ?';
        Text008Lbl: Label 'Do you want to UnHold application No. %1 ?';
        Text009Lbl: Label 'Application No. %1 has been OnHold.';
        Text010Lbl: Label 'Application No. %1 has been UnHold.';
        ShowVisibility: Boolean;




    procedure CurrUpcomingPer(_pVisibilty: Boolean)
    begin
        ShowVisibility := _pVisibilty;


    end;

}
