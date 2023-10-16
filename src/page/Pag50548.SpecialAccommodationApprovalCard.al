page 50548 "Spl Accommodation Approval CRD"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Spcl Accommodation Application";
    Caption = 'Special Accommodation Application Approval';

    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Reject Reason Code"; Rec."Reject Reason Code")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Reject Reason Description"; Rec."Reject Reason Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Send_for_Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Send for Approval';
                    Editable = false;
                }
                field("Send for Approval On"; Rec."Send for Approval On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approval Status On"; Rec."Approval Status On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(FactBoxes)
        {
            part("Accommodation Categories"; "Std Spcl Acc. Category FactBox")
            {
                ApplicationArea = All;
                Caption = 'Accommodation Categories';
                SubPageLink = "Application No." = field("Application No.");
            }
            // part("SPCL Accommodation Attachment"; "SPCL Accommodation Attachment")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Attachments';
            //     SubPageLink = "SLcM Document No" = field("Application No."), "Document Category" = filter('CLINICAL'), "Document Sub Category" = filter('SPECIAL ACCOMMODATION APPLICATION');
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Accommodation Category")
            {
                ApplicationArea = All;
                Caption = 'Accommodation Category';
                ShortcutKey = 'Ctrl+M';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = AbsenceCategories;
                trigger OnAction();
                var
                    StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
                    PageSTDSplAccommodationCategory: Page "STD Spl Accommodation Category";
                begin
                    StdSplAccommodationCategory.Reset();
                    StdSplAccommodationCategory.SetRange("Student ID", Rec."Student No.");
                    Clear(PageSTDSplAccommodationCategory);
                    PageSTDSplAccommodationCategory.SetVariables(Rec."Clinical Reference No.", Rec."Application No.");
                    PageSTDSplAccommodationCategory.SetTableView(StdSplAccommodationCategory);
                    if Rec."Send for Approval" then
                        PageSTDSplAccommodationCategory.Editable(false);
                    PageSTDSplAccommodationCategory.RunModal();
                end;
            }
            action("Approve")
            {
                ApplicationArea = All;
                Caption = 'Approve';
                ShortcutKey = 'F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Approve;
                Enabled = ApprovalActionEnabled;
                trigger OnAction();
                var
                    StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
                    SDA: Record "Student Document Attachment";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to approve the Special Considration Application for the Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then begin
                        Rec."Reject Reason Code" := '';
                        Rec."Reject Reason Description" := '';
                        StdSplAccommodationCategory.Reset();
                        StdSplAccommodationCategory.SetRange("Application No.", Rec."Application No.");
                        if StdSplAccommodationCategory.FindSet() then
                            repeat
                                StdSplAccommodationCategory."Approval Status" := StdSplAccommodationCategory."Approval Status"::Approved;
                                StdSplAccommodationCategory.Modify();
                            until StdSplAccommodationCategory.Next() = 0;

                        SDA.Reset();
                        SDA.SetRange("SLcM Document No", Rec."Application No.");
                        if SDA.FindSet() then
                            repeat
                                SDA."Document Status" := SDA."Document Status"::Verified;
                                SDA.Modify();
                            until SDA.Next() = 0;

                        Rec.Validate("Approval Status", Rec."Approval Status"::Approved);
                        Rec.Modify(true);
                        CALE.InsertLogEntry(4, 2, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', '', '');
                        Message('Special Accommodation Application Approved for the Student %1 (%2).', Rec."Student No.", Rec."Student Name");
                    end;
                end;
            }
            action("Reject")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                ShortcutKey = 'Ctrl+F9';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Reject;
                Enabled = ApprovalActionEnabled;
                trigger OnAction();
                var
                    StdSplAccommodationCategory: Record "Std Spl Accommodation Category";
                    SDA: Record "Student Document Attachment";
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to Reject the Special Accommodation Application for the Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then begin
                        Rec.TestField("Reject Reason Code");
                        Rec.TestField("Reject Reason Description");
                        StdSplAccommodationCategory.Reset();
                        StdSplAccommodationCategory.SetRange("Application No.", Rec."Application No.");
                        if StdSplAccommodationCategory.FindSet() then
                            repeat
                                StdSplAccommodationCategory."Approval Status" := StdSplAccommodationCategory."Approval Status"::Rejected;
                                StdSplAccommodationCategory.Modify();
                            until StdSplAccommodationCategory.Next() = 0;

                        SDA.Reset();
                        SDA.SetRange("SLcM Document No", Rec."Application No.");
                        if SDA.FindSet() then
                            repeat
                                SDA."Document Status" := SDA."Document Status"::Rejected;
                                SDA.Modify();
                            until SDA.Next() = 0;
                        Rec.Validate("Approval Status", "Approval Status"::Rejected);
                        Rec.Modify(true);
                        CALE.InsertLogEntry(4, 5, Rec."Student No.", Rec."Student Name", Rec."Application No.", Rec."Reject Reason Code", Rec."Reject Reason Description", '', '');
                        Message('Special Accommodation Application Rejected for the Student %1 (%2).', Rec."Student No.", Rec."Student Name");
                    end;
                end;
            }
        }
    }

    var
        ApprovalActionEnabled: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        if not UserSetup.Get(UserId) then
            Error('User Setup for User ID %1 not found.', UserId);

        Rec."Global Dimension 1 Code" := '9000';
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Editable := true;
        if Rec."Approval Status" in [Rec."Approval Status"::Approved, Rec."Approval Status"::Rejected] then
            CurrPage.Editable := false;

        ApprovalActionEnabled := true;
        if Rec."Approval Status" IN [Rec."Approval Status"::Approved, Rec."Approval Status"::Rejected] then
            ApprovalActionEnabled := false;
    end;
}