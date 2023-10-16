page 50550 "Spl Accommodation Approved CRD"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Spcl Accommodation Application";
    Caption = 'Special Accommodation Applications';
    Editable = false;
    ModifyAllowed = false;
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
                }
                field("Application Type"; Rec."Application Type")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = EditAllow;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = EditAllow;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = EditAllow;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
                field("Send_for_Approval"; Rec."Send for Approval")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Send for Approval';
                }
                field("Send for Approval On"; Rec."Send for Approval On")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Approval Status On"; Rec."Approval Status On")
                {
                    ApplicationArea = All;
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
        }
    }

    var
        EditAllow: Boolean;

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
        if Rec."Send for Approval" then
            CurrPage.Editable := false;

        EditAllow := not Rec."Send for Approval";
    end;

}