page 50603 "Rotation Offer Card"
{
    Caption = 'Elective Rotation Offer';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Rotation Offers";

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
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Vendor: Record Vendor;
                    begin
                        Vendor.Reset();
                        if Vendor.Get(Rec."Hospital ID") then
                            if Vendor."Non-Affiliated Hospital" then
                                Error('Hospital ID %1 (%2) has marked as Non-Affiliated Hospital.\It is not allowed to select on Elective Offer.');
                    end;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    MultiLine = true;
                    Editable = false;
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
                    MultiLine = true;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    MultiLine = true;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }

                field("No. of Seats"; Rec."No. of Seats")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    BlankNumbers = BlankZero;
                }
                field("Maximum Waitlist Students"; Rec."Maximum Waitlist Students")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Visible = false;
                    Enabled = false;
                }
                field("Total No. of Seats"; Rec."Total No. of Seats")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                    Caption = 'Total No. of Seats';
                    DecimalPlaces = 0;
                    Visible = false;
                    Enabled = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = true;
                    Style = Strong;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Strong;
                }
                field("Visible on Portal"; Rec."Visible on Portal")
                {
                    ApplicationArea = All;
                }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                    Style = Unfavorable;
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
                Image = Confirm;
                trigger OnAction()
                var
                    CALE: Record "Clerkship Activity Log Entries";
                begin
                    if Confirm('Do you want to Confirm Offer No. %1 for the Elective Rotation %2', True, Rec."Offer No.", Rec."Rotation Description") then begin
                        Rec.Validate(Status, Rec.Status::Confirmed);
                        Rec.Modify();
                        CALE.InsertLogEntry(6, 1, 'NA', 'NA', Rec."Offer No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
                        Message('Offer No. %1 is Confirmed.', Rec."Offer No.");
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        EducationSetupCS: Record "Education Setup-CS";
    begin
        Rec."Global Dimension 1 Code" := '9000';
        Rec."Cordination ID" := UserId;
        Rec."Visible on Portal" := false;

        EducationSetupCS.Reset();
        EducationSetupCS.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if EducationSetupCS.FindFirst() then
            Rec."Academic Year" := EducationSetupCS."Academic Year";

        GetCoreSubjectsCode();
    end;

    trigger OnAfterGetRecord()
    begin
        GetCoreSubjectsCode();
    end;

    procedure GetCoreSubjectsCode()
    var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        if EducationSetup.FindFirst() then
            EducationSetup.TestField("Core Subjects for Elective");

        Rec.SetFilter("Core Subjects for Elective", EducationSetup."Core Subjects for Elective");
    end;
}