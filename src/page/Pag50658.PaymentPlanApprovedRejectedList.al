page 50658 "Payment Plan Approved/Rejected"
{

    PageType = List;
    SourceTable = "Financial AID";
    Caption = 'Payment Plan Approved/Rejected List';
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    SourceTableView = Where(Status = filter(Approved | Rejected), "Type" = filter("Self Payment" | "Payment Plan"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';


                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Application Date';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Type';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Enrollment No.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Academic Year';
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Semester';
                }

                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Caption = 'Reason';

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Caption = 'Reason Description';

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected By';
                    Editable = False;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected On';
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("FSA ID"; Rec."FSA ID")
                {
                    ApplicationArea = All;

                }
                field("Entrance Counseling"; Rec."Entrance Counseling")
                {
                    ApplicationArea = All;
                }
                field("Unsubsidized Loan"; Rec."Unsubsidized Loan")
                {
                    ApplicationArea = All;
                }
                field("Direct Graduate plus loan"; Rec."Direct Graduate plus loan")
                {

                    ApplicationArea = All;

                }
                field("Living expenses"; Rec."Living expenses")
                {
                    ApplicationArea = All;
                }


                field("Grad PLUS Denial"; Rec."Grad PLUS Denial")
                {

                    ApplicationArea = All;
                }

                field(Endorse; Rec.Endorse)
                {

                    ApplicationArea = All;
                }

                field("Loan Amount"; Rec."Loan Amount")
                {

                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Card")
            {
                ApplicationArea = All;
                Caption = 'Card';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                Var
                    RecFinancialAID: Record "Financial AID";
                    SelfPaymentPlanPage: Page "Payment Plan Application";

                begin
                    RecFinancialAID.Reset();
                    RecFinancialAID.SetRange("Application No.", Rec."Application No.");
                    IF RecFinancialAID.FindFirst() then BEGIN
                        SelfPaymentPlanPage.SetTableView(RecFinancialAID);
                        SelfPaymentPlanPage.Editable := False;
                        SelfPaymentPlanPage.Run();
                    END;

                end;
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
