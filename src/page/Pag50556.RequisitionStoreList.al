page 50556 "Requisition Store List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    SourceTableView = Sorting("Document Type", "No.") order(descending) WHERE("Document Type" = FILTER(Requisition), "Approval Status" = filter("Send to Store"), "Responsible Department" = filter(Store), Posted = filter(false));
    CardPageId = "Requisition Store Card";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater("Requisition Store")

            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                Field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;


                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;


                }
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ToolTip = 'Specifies the value of the Requisition Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Requisition Report")
            {
                ApplicationArea = all;
                Image = Report;

                trigger OnAction()
                begin
                    RecReqHeader.RESET();
                    RecReqHeader.SETRANGE(RecReqHeader."Document Type", Rec."Document Type");
                    RecReqHeader.SETRANGE(RecReqHeader."No.", Rec."No.");
                    IF RecReqHeader.FIND('-') THEN
                        REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
                end;
            }
        }

    }
    var
        RecReqHeader: Record "Requisition Header";

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        DocumentApprover: Record "Document Approver Users";
    begin
        if UserSetup.Get(UserId()) then begin
            DocumentApprover.Reset();
            DocumentApprover.SetRange("User ID", UserSetup."User ID");
            DocumentApprover.SetRange("Department Approver Type", DocumentApprover."Department Approver Type"::Store);
            If DocumentApprover.FindFirst() then begin
                Rec.Reset();
                Rec.FilterGroup(4);
                Rec.SetRange("Responsible Department", Rec."Responsible Department"::Store);
                Rec.SetRange("Approval Status", Rec."Approval Status"::"Send to Store");
                Rec.SetRange("Document Type", Rec."Document Type"::Requisition);
                Rec.SetRange(Posted, false);
                //Rec.SetRange("Location Code", '');
                Rec.FilterGroup(5);
                if Rec.FindSet() then;
            end;
        end;

    end;

    trigger OnAfterGetRecord()
    var
        ReqHeader: Record "Requisition Header";
        ReqLine: Record "Requisition Line_";
        UpdateRecord: Boolean;
        WithFilterCount: integer;
        WithoutFilterCount: integer;
    begin
        if ReqHeader.get(Rec."Document Type", Rec."No.") then begin
            UpdateRecord := false;
            WithFilterCount := 0;
            WithoutFilterCount := 0;
            if ReqLine.findset then begin
                ReqLine.reset();
                ReqLine.SetRange("Document Type", Rec."Document Type");
                ReqLine.SetRange("Document No.", Rec."No.");
                if ReqLine.FindSet() then begin
                    repeat
                        WithoutFilterCount := WithoutFilterCount + 1;
                        if (ReqLine.Status = ReqLine.Status::Closed) or (ReqLine.Status = reqline.Status::Rejected) then
                            WithFilterCount := WithFilterCount + 1;
                    until ReqLine.Next() = 0;
                end;
                if WithFilterCount + WithoutFilterCount > 0 then
                    if WithoutFilterCount = WithFilterCount then begin
                        ReqHeader."Approval Status" := ReqHeader."Approval Status"::Closed;
                        ReqHeader.Posted := true;
                        ReqHeader.Modify();
                    end;
            end
        end;
    end;
}
