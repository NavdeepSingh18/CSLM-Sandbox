page 50285 "Details List-RTGS-CS"
{
    // version V.001-CS
    Caption = 'Pending Wire Transfer List';
    PageType = List;
    SourceTable = "RTGS Payment Summary-CS";
    CardPageId = "Details Card-RTGS-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;
    SourceTableView = Where(Status = filter("Pending for Approval"));
    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Request No."; Rec."Request No.")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Number"; Rec."Transaction Number")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; Rec."Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Fee Amount"; Rec."Fee Amount")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Remitter Name"; Rec."Remitter Name")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Rejected By"; Rec."Rejected By")
                {
                    ApplicationArea = All;
                }
                field("Rejected Date"; Rec."Rejected Date")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
            }
        }
    }

    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
    
}

