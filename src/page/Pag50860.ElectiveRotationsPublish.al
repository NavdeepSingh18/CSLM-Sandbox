page 50860 "Elective Rotation Publish"
{
    Caption = 'Elective Rotations Publish';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Scheduling Header";
    SourceTableView = where("Clerkship Type" = filter(Elective), "Entry Type" = filter(Clerkship), Status = filter(Scheduled));
    CardPageId = "Elective Rotation Card";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                    LookupPageId = "Hospital Inventory Lookup";
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
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
                field("No. of Students"; Rec."No. of Students")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                }
            }
        }
        area(FactBoxes)
        {
            part("Rotation Facts"; "All Rotation Factbox")
            {
                ApplicationArea = All;
                Caption = 'Elective Rotation Facts';
                SubPageLink = "Rotation ID" = field("Rotation ID");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Update DME and Preceptor Details")
            {
                ApplicationArea = All;
                Caption = 'Update DME and Preceptor Details';
                ShortcutKey = 'Ctrl+T';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DefaultDimension;
                Visible = false;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                begin
                    Rec.TestField("Elective Course Code");
                    Rec.TestField("Hospital ID");
                    Rec.TestField("Start Date");

                    RosterSchedulingHeader.Reset();
                    RosterSchedulingHeader.FilterGroup(2);
                    RosterSchedulingHeader.SetRange("Rotation ID", Rec."Rotation ID");
                    RosterSchedulingHeader.FilterGroup(0);
                    Page.RunModal(Page::"DME and Preceptor Update", RosterSchedulingHeader);
                end;
            }
            action("Publish Rotation")
            {
                ApplicationArea = All;
                Caption = 'Publish Rotation';
                ShortcutKey = 'Ctrl+U';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PutAwayWorksheet;
                trigger OnAction()
                var
                    RosterSchedulingHeader: Record "Roster Scheduling Header";
                    RosterSchedulingLine: Record "Roster Scheduling Line";
                    RosterLedgerEntry: Record "Roster Ledger Entry";
                    Text001Lbl: Label 'Total Rotations      ############1################\';
                    Text002Lbl: Label 'Rotation in Progress      ############2################\';
                    Text003Lbl: Label 'Action      ############3################\';
                    LastEntryNo: Integer;
                    W: Dialog;
                    T: Integer;
                    C: Integer;
                begin
                    T := 0;
                    C := 0;

                    RosterSchedulingHeader.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingHeader);
                    T := RosterSchedulingHeader.Count;

                    if not Confirm('Do you want to Publish %1 Selected Elective Rotation(s)?', true, T) then
                        exit;

                    W.Open('Publishing Rotations..\' + Text001Lbl + Text002Lbl + Text003Lbl);

                    RosterLedgerEntry.Reset();
                    if RosterLedgerEntry.FindLast() then
                        LastEntryNo := RosterLedgerEntry."Entry No.";

                    RosterSchedulingHeader.Reset();
                    CurrPage.SetSelectionFilter(RosterSchedulingHeader);
                    if RosterSchedulingHeader.FindSet() then begin
                        T := RosterSchedulingHeader.Count;
                        C := 0;
                        repeat
                            C += 1;
                            W.Update(1, T);
                            W.Update(2, C);
                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.SetRange("Rotation ID", RosterSchedulingHeader."Rotation ID");
                            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                            if RosterSchedulingLine.FindSet() then
                                repeat
                                    LastEntryNo := LastEntryNo + 1;
                                    RosterSchedulingLine.PublishRotation(RosterSchedulingLine, LastEntryNo);
                                until RosterSchedulingLine.Next() = 0;

                            RosterSchedulingLine.Reset();
                            RosterSchedulingLine.SetRange("Rotation ID", RosterSchedulingHeader."Rotation ID");
                            RosterSchedulingLine.SetRange(Status, RosterSchedulingLine.Status::Scheduled);
                            if not RosterSchedulingLine.FindFirst() then begin
                                RosterSchedulingHeader.Status := RosterSchedulingHeader.Status::Published;
                                RosterSchedulingHeader."Published By" := UserId;
                                RosterSchedulingHeader."Published On" := Today;
                                RosterSchedulingHeader.Modify();
                            end;
                        until RosterSchedulingHeader.Next() = 0;

                        //RosterSchedulingLine.CheckNotificationToHospital(Rec);
                        W.Close();
                        Message('%1 Elective Rotation(s) Published Sucessfully..', C);
                    end;
                end;
            }
        }
    }
}