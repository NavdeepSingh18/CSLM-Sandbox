page 50839 "Reason Program List"
{

    ApplicationArea = All;
    Caption = 'Reason Program List';
    PageType = List;
    SourceTable = "Reason Program";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Department Type"; Rec."Department Type")
                {
                    ToolTip = 'Specifies the value of the Department Type field';
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ToolTip = 'Specifies the value of the Semester field.';
                    ApplicationArea = All;
                }

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;
                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;
                }
                Field("Azure Service Link"; Rec."Azure Service Link")
                {
                    ApplicationArea = All;
                }
                field("Booking Link to Display"; Rec."Booking Link to Display")
                {
                    ToolTip = 'Specifies the value of the Booking Link to Display field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Advisor)
            {
                caption = 'Request Reason-Advisor Mapping';
                ApplicationArea = Basic, Suite;
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Reason Request List";
                RunPageLink = Code = field(Code);
                Visible = ReasonwiseAdvisorBool;
            }
        }
    }

    trigger OnOpenPage()
    var
        AdvisingRequest: Record "Advising Request";
        IntOption: Integer;
        NotAuthLbl: Label 'You are not authorized to access this page.';
    begin
        Rec.FilterGroup(2);
        IntOption := AdvisingRequest.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    Rec.SetFilter("Department Type", format(Rec."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    Rec.SetFilter("Department Type", format(Rec."Department Type"::"EED Clinical"));
                end;
            3:
                begin
                    Rec.SetFilter("Department Type", '%1|%2', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical");
                end;
            4:
                begin
                    Rec.Setfilter("Department Type", '%1|%2|%3', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical", Rec."Department Type"::" ");
                end;
            0:
                begin
                    Error(NotAuthLbl);
                end;
        end;
        Rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    begin
        DocApprRec.Reset();
        DocApprRec.SetRange("User ID", UserId());
        DocApprRec.SetRange("Department Approver Type", DocApprRec."Department Approver Type"::"EED Pre-Clinical");
        if DocApprRec.FindFirst() then
            ReasonwiseAdvisorBool := true
        else
            ReasonwiseAdvisorBool := false;
    end;

    Var
        DocApprRec: Record "Document Approver Users";
        ReasonwiseAdvisorBool: Boolean;
}
