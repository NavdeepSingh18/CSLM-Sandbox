page 50268 "Requisition Approval Setup"
{
    PageType = List;
    Caption = 'Requisition Approval Setup';
    UsageCategory = Lists;
    SourceTable = "Requisition Approval Setup";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Setup Type"; Rec."Setup Type")
                {
                    ToolTip = 'Specifies the value of the Setup Type field.';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    caption = 'Department Code';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Requisition Approver 1"; Rec."Requisition Approver 1")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Requisition Approver 2"; Rec."Requisition Approver 2")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
                field("Requisition Approver 3"; Rec."Requisition Approver 3")
                {
                    ApplicationArea = All;
                    // Visible = false;
                }
            }
        }
    }
    // trigger OnOpenPage()
    // begin
    //     Reset();
    //     IF NOT GET() THEN BEGIN
    //         INIT();
    //         INSERT();
    //     END;
    // end;
}