page 50453 "Rotation Offer Appln Card"
{
    Caption = 'Elective Rotation Offer Application';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Rotation Offer Application";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    ShowMandatory = true;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    MultiLine = true;
                    Editable = false;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    MultiLine = true;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                    ShowMandatory = true;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    MultiLine = true;
                    Editable = false;
                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Style = Strong;
                    Editable = StartDateEditable;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Strong;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Unfavorable;
                }
                group("Input")
                {
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
                ShortcutKey = 'Ctrl+F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ApplicationWorksheet;
                trigger OnAction()
                var
                    RotationOffers: Record "Rotation Offers";
                    EducationSetup: Record "Education Setup-CS";
                    CALE: Record "Clerkship Activity Log Entries";
                    ClinicalNotification: Codeunit "Clinical Notification";
                begin
                    if not Confirm('Do You want to Confirm the Elective Rotation Application?') then
                        exit;

                    Rec.TestField("Start Date");
                    Rec.TestField("Student No.");
                    ActionTaken := false;

                    if Rec."Same Rotation Applied" = false then begin
                        Rec.Validate("Approval Status", Rec."Approval Status"::"Not Applicable");
                        Rec."Approved Status By" := 'NOT APPLICABLE';
                    end;

                    EducationSetup.Reset();
                    EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
                    if EducationSetup.FindFirst() then begin
                        EducationSetup.TestField("Elective Application No.");
                        EducationSetup.TestField("Minimum Clinical Weeks Allowed");
                        EducationSetup.TestField("Maximum Clinical Weeks Allowed");

                        if (Rec."No. of Weeks" < EducationSetup."Minimum Clinical Weeks Allowed") or (Rec."No. of Weeks" > EducationSetup."Maximum Clinical Weeks Allowed") then
                            Rec.Validate("Approval Status", Rec."Approval Status"::"Pending for Approval")
                        else begin
                            Rec.Validate("Approval Status", Rec."Approval Status"::"Not Applicable");
                            Rec."Approved Status By" := 'NOT APPLICABLE';
                        end;
                    end;

                    Rec."Application Date" := WorkDate();
                    Rec.Validate(Status, Rec.Status::Confirmed);

                    Rec.Modify();
                    // ClinicalNotification.NewElectiveRequest(Rec);

                    RotationOffers.Reset();
                    if RotationOffers.Get(Rec."Offer No.") then begin
                        RotationOffers.CalcFields("No. of Students Applied");
                        if RotationOffers."No. of Students Applied" = RotationOffers."Total No. of Seats" then begin
                            RotationOffers.Validate(Status, RotationOffers.Status::Completed);
                            RotationOffers.Modify();
                        end;
                    end;

                    CALE.InsertLogEntry(7, 1, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                    Message('Elective Rotation Application confirmed successfully.');
                    ActionTaken := true;
                    CurrPage.Close();
                end;
            }

            action("Discard")
            {
                ApplicationArea = All;
                Caption = 'Discard';
                ShortcutKey = 'Ctrl+D';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = ApplicationWorksheet;
                trigger OnAction()
                begin
                    ActionTaken := false;
                    if Confirm('Do you want to discard the Elective Rotation Application?') then
                        Rec.Delete(true);
                    ActionTaken := true;
                    CurrPage.Close();
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
    var
        StartDateEditable: Boolean;
        ActionTaken: Boolean;


    trigger OnOpenPage()
    begin
        GetElectiveSemester();

        StartDateEditable := true;
        if Rec."Start Date" <> 0D then
            StartDateEditable := false;

        ActionTaken := false;
    end;

    trigger OnAfterGetRecord()
    begin
        GetElectiveSemester();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if (ActionTaken = false) and (Rec."Student No." <> '') then
            Error('You must confirm or discard the application.');

        if Rec."Student No." = '' then
            IF Rec.Delete(true) then;
    end;

    procedure GetElectiveSemester()
    var
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
    begin
        UserSetup.Reset();
        IF not UserSetup.Get(UserId) then
            Error('User Setup not found for the User ID %1.', UserId);

        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Elective Semester Filter");

        Rec.SetFilter("Clerkship Semester Filter", EducationSetup."Elective Semester Filter");
    end;
}