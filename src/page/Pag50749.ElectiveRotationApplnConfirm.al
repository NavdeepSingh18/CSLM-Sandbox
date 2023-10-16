page 50749 "Elective Appln Confirmation"
{
    PageType = List;
    Caption = 'Elective Rotation Application Confirmation';
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    SourceTableView = sorting("Offer No.", "Application No.") order(descending) where(Status = filter(Open | "In-Review"), "Approval Status" = filter(<> Rejected));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Unfavorable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Alternate Start Date"; Rec."Alternate Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Alternate End Date"; Rec."Alternate End Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Confirm")
            {
                ApplicationArea = All;
                Caption = 'Confirm';
                ShortcutKey = 'Ctrl+M';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Confirm;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                    CALE: Record "Clerkship Activity Log Entries";
                    StudentStatus: Record "Student Status";
                    StudentMaster: Record "Student Master-CS";
                    StatusOK: Boolean;
                    T: Integer;
                    C: Integer;
                    I: Integer;
                    AlternateApplNo: Text;
                    Char10: Char;
                    Char13: Char;
                    NewLine: Text[10];
                    Text001Lbl: Label 'Total Applications      ############1################\';
                    Text002Lbl: Label 'Application in Progress      ############2################\';
                    W: Dialog;
                begin
                    Char10 := 10;
                    Char13 := 13;
                    NewLine := format(Char10) + format(Char13);
                    AlternateApplNo := '';
                    RotationOfferApplication.Reset();
                    CurrPage.SetSelectionFilter(RotationOfferApplication);
                    T := RotationOfferApplication.Count;
                    C := 0;
                    I := 0;

                    if not Confirm('Do you want to confirm the %1 selected Elective Rotation Application(s)?', true, T) then
                        exit;

                    W.Open('Updating Elective Rotation Applications...\' + Text001Lbl + Text002Lbl);
                    W.Update(1, T);

                    RotationOfferApplication.Reset();
                    CurrPage.SetSelectionFilter(RotationOfferApplication);
                    if RotationOfferApplication.FindFirst() then
                        repeat
                            StatusOK := true;
                            StudentMaster.Reset();
                            if StudentMaster.Get(RotationOfferApplication."Student No.") then;

                            StudentStatus.Reset();
                            if StudentStatus.Get(StudentMaster.Status, StudentMaster."Global Dimension 1 Code") then;

                            if (StudentStatus.Status in
                            [StudentStatus.Status::Withdrawn]) then begin
                                Message('Please check the Status of Student No. %1 (%2).', StudentMaster."No.", StudentMaster."Student Name");
                                StatusOK := false;
                            end;

                            C += 1;
                            W.Update(2, C);
                            if RotationOfferApplication."Alternate Start Date" = 0D then begin
                                if StatusOK = true then begin
                                    I += 1;
                                    RotationOfferApplication.Validate(Status, RotationOfferApplication.Status::Confirmed);
                                    RotationOfferApplication.Modify(true);
                                    CALE.InsertLogEntry(7, 1, RotationOfferApplication."Student No.", RotationOfferApplication."Student Name", RotationOfferApplication."Application No.", '', '', RotationOfferApplication."Elective Course Code", RotationOfferApplication."Rotation Description");
                                end;
                            end
                            else
                                if AlternateApplNo = '' then
                                    AlternateApplNo := 'Application No.: ' + RotationOfferApplication."Application No." + ' Student No.: ' + RotationOfferApplication."Student No." + ' Name: ' + RotationOfferApplication."Student Name"
                                else
                                    AlternateApplNo := AlternateApplNo + NewLine + 'Application No.: ' + RotationOfferApplication."Application No." + ' Student No.: ' + RotationOfferApplication."Student No." + ' Name: ' + RotationOfferApplication."Student Name";
                        until RotationOfferApplication.Next() = 0;

                    Message('%1 Elective Rotation Application(s) confirmed successfully.', I);

                    if AlternateApplNo <> '' then
                        Message('Please check Below Application Details that are not Confirmed due to Alternate Date assigned but not Accepted by the Student.\\\%1', AlternateApplNo);
                end;
            }

            action("In-Review")
            {
                ApplicationArea = All;
                Caption = 'In-Review';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ReverseRegister;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                    CALE: Record "Clerkship Activity Log Entries";
                    T: Integer;
                    C: Integer;
                    I: Integer;
                    Char10: Char;
                    Char13: Char;
                    NewLine: Text[10];
                    Text001Lbl: Label 'Total Applications      ############1################\';
                    Text002Lbl: Label 'Application in Progress      ############2################\';
                    W: Dialog;
                begin
                    Char10 := 10;
                    Char13 := 13;
                    NewLine := format(Char10) + format(Char13);
                    RotationOfferApplication.Reset();
                    CurrPage.SetSelectionFilter(RotationOfferApplication);
                    T := RotationOfferApplication.Count;
                    C := 0;
                    I := 0;

                    if not Confirm('Do you want to put %1 Elective Rotation Application(s) under review?', true, T) then
                        exit;

                    W.Open('Updating Elective Rotation Applications...\' + Text001Lbl + Text002Lbl);
                    W.Update(1, T);

                    RotationOfferApplication.Reset();
                    CurrPage.SetSelectionFilter(RotationOfferApplication);
                    if RotationOfferApplication.FindFirst() then
                        repeat
                            C += 1;
                            W.Update(2, C);
                            I += 1;
                            RotationOfferApplication.Validate(Status, RotationOfferApplication.Status::"In-Review");
                            RotationOfferApplication.Modify(true);
                            CALE.InsertLogEntry(7, 14, RotationOfferApplication."Student No.", RotationOfferApplication."Student Name", RotationOfferApplication."Application No.", '', '', RotationOfferApplication."Elective Course Code", RotationOfferApplication."Rotation Description");
                        until RotationOfferApplication.Next() = 0;

                    Message('%1 Elective Rotation Application(s) confirmed successfully.', I);
                end;
            }
            action("Assign Rotation Alternate Date")
            {
                ApplicationArea = All;
                Caption = 'Assign Rotation Alternate Date';
                ShortcutKey = 'Ctrl+I';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = InteractionLog;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.SetRange("Line No.", Rec."Line No.");
                    Page.RunModal(Page::"Rotation Appl Alternate Date", RotationOfferApplication)
                end;
            }

            action("Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                ShortcutKey = 'Ctrl+R';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                trigger OnAction()
                var
                    RotationOfferApplication: Record "Rotation Offer Application";
                begin
                    Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
                    RotationOfferApplication.Reset();
                    RotationOfferApplication.FilterGroup(2);
                    RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
                    RotationOfferApplication.SetRange("Student No.", Rec."Student No.");
                    RotationOfferApplication.FilterGroup(0);
                    page.RunModal(Page::"Rotation Application Rejection", RotationOfferApplication);
                end;
            }
            action("Future Rotation List")
            {
                ApplicationArea = All;
                Caption = 'Future Rotation List';
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = LinesFromJob;

                trigger OnAction()
                var
                    RSL: Record "Roster Scheduling Line";
                begin
                    RSL.Reset();
                    RSL.SetRange("Student No.", Rec."Student No.");
                    RSL.SetFilter("Start Date", '>%1', Rec."End Date");
                    Page.RunModal(Page::"Roster Scheduling Lines", RSL);
                end;
            }
        }
    }
}