page 50704 "Housing Issue FactBox"
{
    PageType = CardPart;
    Caption = 'Housing Issue FactBox';
    SourceTable = "Housing Issue";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {

            group("Housing Issues")
            {
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;
                    Caption = 'Housing ID';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingMasterRec.Reset();
                        HousingMasterRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingMasterPag.SetTableView(HousingMasterRec);
                        HousingMasterPag.Editable := false;
                        HousingMasterPag.Run();
                    end;
                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;
                    Caption = 'Housing Name';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingMasterRec.Reset();
                        HousingMasterRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingMasterPag.SetTableView(HousingMasterRec);
                        HousingMasterPag.Editable := false;
                        HousingMasterPag.Run();
                    end;
                }
                field(HoldCount2; TotalCount())
                {
                    ApplicationArea = All;
                    Caption = 'Total Issues';
                    Style = Strong;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingIssueRec.Reset();
                        HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingIssueFactPag.SetTableView(HousingIssueRec);
                        HousingIssueFactPag.Editable := false;
                        HousingIssueFactPag.Run();
                    end;
                }

                field("Pending Issues"; IssuesPending())
                {
                    ApplicationArea = All;
                    Caption = 'Pending Issues';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingIssueRec.Reset();
                        HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingIssueRec.SetRange(Status, HousingIssueRec.Status::"Pending for Approval");
                        HousingIssueFactPag.SetTableView(HousingIssueRec);
                        HousingIssueFactPag.Editable := false;
                        HousingIssueFactPag.Run();
                    end;
                }
                field("Accepted Issues"; IssuesAccepted())
                {
                    ApplicationArea = All;
                    Caption = 'Accepted Issues';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingIssueRec.Reset();
                        HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingIssueRec.SetRange(Status, HousingIssueRec.Status::Accepted);
                        HousingIssueFactPag.SetTableView(HousingIssueRec);
                        HousingIssueFactPag.Editable := false;
                        HousingIssueFactPag.Run();
                    end;
                }
                field("Resolved Issues"; IssuesResolved())
                {
                    ApplicationArea = All;
                    Caption = 'Resolved Issues';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingIssueRec.Reset();
                        HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingIssueRec.SetRange(Status, HousingIssueRec.Status::Resolved);
                        HousingIssueFactPag.SetTableView(HousingIssueRec);
                        HousingIssueFactPag.Editable := false;
                        HousingIssueFactPag.Run();
                    end;
                }
                field("Rejected Issues"; IssuesRejected())
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Issues';
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        HousingIssueRec.Reset();
                        HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
                        HousingIssueRec.SetRange(Status, HousingIssueRec.Status::Rejected);
                        HousingIssueFactPag.SetTableView(HousingIssueRec);
                        HousingIssueFactPag.Editable := false;
                        HousingIssueFactPag.Run();
                    end;
                }
            }


        }
    }

    var
        HousingIssueRec: Record "Housing Issue";
        HousingMasterRec: Record "Housing Master";
        HousingIssueFactPag: page "Housing Issue Fact";
        HousingMasterPag: Page "Housing Master Card";
        PendingIssue: Integer;
        IssueAccept: Integer;
        IssueResolve: Integer;
        IssueReject: Integer;
        TotalIssue: Integer;

    trigger OnAfterGetRecord()
    begin
        // PendingIssue := 0;
        // PendingIssue := IssuesPending();
    end;

    procedure IssuesPending(): Integer
    begin
        if Rec."Housing ID" <> '' then begin
            HousingIssueRec.Reset();
            HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
            HousingIssueRec.SetRange(HousingIssueRec.Status, HousingIssueRec.Status::"Pending for Approval");
            IF HousingIssueRec.FindSet() then begin
                PendingIssue := HousingIssueRec.Count();
                Exit(PendingIssue);
            end;
        end;
    end;

    procedure IssuesAccepted(): Integer
    begin
        if Rec."Housing ID" <> '' then begin
            HousingIssueRec.Reset();
            HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
            HousingIssueRec.SetRange(HousingIssueRec.Status, HousingIssueRec.Status::Accepted);
            IF HousingIssueRec.FindSet() then begin
                IssueAccept := HousingIssueRec.Count();
                Exit(IssueAccept);
            end;
        end;
    end;

    procedure IssuesResolved(): Integer
    begin
        if Rec."Housing ID" <> '' then begin
            HousingIssueRec.Reset();
            HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
            HousingIssueRec.SetRange(HousingIssueRec.Status, HousingIssueRec.Status::Resolved);
            IF HousingIssueRec.FindSet() then begin
                IssueResolve := HousingIssueRec.Count();
                Exit(IssueResolve);
            end;
        end;
    end;

    procedure IssuesRejected(): Integer
    begin
        if Rec."Housing ID" <> '' then begin
            HousingIssueRec.Reset();
            HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
            HousingIssueRec.SetRange(HousingIssueRec.Status, HousingIssueRec.Status::Rejected);
            IF HousingIssueRec.FindSet() then begin
                IssueReject := HousingIssueRec.Count();
                Exit(IssueReject);
            end;
        end;
    end;

    procedure TotalCount(): Integer
    begin
        if Rec."Housing ID" <> '' then begin
            HousingIssueRec.Reset();
            HousingIssueRec.SetRange("Housing ID", Rec."Housing ID");
            IF HousingIssueRec.FindSet() then begin
                TotalIssue := HousingIssueRec.Count();
                Exit(TotalIssue);
            end;
        end;
    end;

}