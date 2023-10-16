page 50600 "Rotation Appl Approval List"
{
    PageType = List;
    Caption = 'Elective Rotation Applications Approvals';
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTable = "Rotation Offer Application";
    //SourceTableView = sorting("Elective Course Code", "Last Name", "Middle Name", "First Name") where(Status = filter(Confirmed), "Approval Status" = filter("Pending for Approval"), "Rotation Status" = filter(" "));
    SourceTableView = sorting("Offer No.", "Application No.") order(descending) where("Approval Status" = filter("Pending for Approval"), "Rotation Status" = filter(" "));
    CardPageId = "Rotation Offer Appl Card";
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
                    ShowMandatory = true;
                    Style = Strong;
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
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }
    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Approve")
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Approve';
    //             ShortcutKey = 'Ctrl+D';
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedOnly = true;
    //             PromotedIsBig = true;
    //             Image = Approve;
    //             trigger OnAction()
    //             var
    //                 CALE: Record "Clerkship Activity Log Entries";
    //             begin
    //                 TestField("Rotation Status", "Rotation Status"::" ");

    //                 if not Confirm('Do you want to Approve Elective Rotation Offer Application for the Student %1 (%2)?', true, Rec."Student No.", Rec."Student Name") then
    //                     exit;

    //                 Rec.Validate("Approval Status", Rec."Approval Status"::Approved);
    //                 Rec.Modify();
    //                 CALE.InsertLogEntry(7, 2, Rec."Student No.", Rec."Student Name", Rec."Application No.", '', '', Rec."Elective Course Code", Rec."Rotation Description");
    //                 Message('Elective Rotation Offer Application %1 for the Student %2 (%3) has Approved Successfully.', Rec."Application No.", Rec."Student No.", Rec."Student Name");
    //             end;
    //         }

    //         action("Reject")
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Reject';
    //             ShortcutKey = 'Ctrl+R';
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedOnly = true;
    //             PromotedIsBig = true;
    //             Image = Reject;
    //             trigger OnAction()
    //             var
    //                 RotationOfferApplication: Record "Rotation Offer Application";
    //             begin
    //                 Rec.TestField("Rotation Status", Rec."Rotation Status"::" ");
    //                 RotationOfferApplication.Reset();
    //                 RotationOfferApplication.FilterGroup(2);
    //                 RotationOfferApplication.SetRange("Offer No.", Rec."Offer No.");
    //                 RotationOfferApplication.SetRange("Line No.", Rec."Line No.");
    //                 RotationOfferApplication.SetRange("Application No.", Rec."Application No.");
    //                 RotationOfferApplication.FilterGroup(0);
    //                 Page.RunModal(Page::"Offer Appl Reject Card", RotationOfferApplication);
    //             end;
    //         }
    //         action("Future Rotation List")
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Future Rotation List';
    //             ShortcutKey = 'Ctrl+R';
    //             PromotedOnly = true;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             Image = LinesFromJob;

    //             trigger OnAction()
    //             var
    //                 RSL: Record "Roster Scheduling Line";
    //             begin
    //                 RSL.Reset();
    //                 RSL.SetRange("Student No.", Rec."Student No.");
    //                 RSL.SetFilter("Start Date", '>%1', Rec."End Date");
    //                 Page.RunModal(Page::"Roster Scheduling Lines", RSL);
    //             end;
    //         }
    //     }
    // }
}