page 50130 "Insurance Waiver Card"
{ //CSPL-00307 - Insurance Waiver
    PageType = Card;
    // ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Student Rank-CS";

    layout
    {
        area(Content)
        {
            group("Student Details")
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                    trigger OnAssistEdit()
                    begin
                        Rec.OnAssistTrigger();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student ID field.';
                }

                field("Student No."; Rec."Student No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.';
                    Editable = False;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = False;
                }

                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Term field.';
                    Editable = False;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    Editable = False;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course field.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Institute Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }


            }
            Group("Insurance Details")
            {
                field("Policy No."; Rec."Policy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy No. field.';
                    Editable = False;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Carrier field.';
                    Editable = False;
                }
                field("Member ID"; Rec."Member ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member ID field.';
                    Editable = False;
                }
                field("Group Number"; Rec."Group Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Number field.';
                    Editable = False;
                }
                field("Insurance Valid From"; Rec."Insurance Valid From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Valid From field.';
                    Editable = False;
                }
                field("Insurance Valid To"; Rec."Insurance Valid To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Valid To field.';
                    Editable = False;
                }
                field("Reject Reason"; Rec."Reject Reason")
                {
                    ApplicationArea = All;
                }
                field("Entry From OLR Page"; Rec."Entry From OLR Page")
                {
                    ApplicationArea = All;
                }
                field("Entry From Dashboard"; Rec."Entry From Dashboard")
                {
                    ApplicationArea = All;
                }

            }
            // part(Documents; "Student Attachment Lines")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     SubPageLink = "SLcM Document No" = FIELD("No.");
            //     SubPageView = where("SLcM Document No" = filter(<> ''));


            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = (Rec.Status = Rec.Status::Pending);
                trigger OnAction()
                begin
                    If not confirm('Do you want to Approve the Insurance Document?', false) then
                        Exit;

                    Rec."Approved By" := UserId();
                    Rec."Approved On" := Today();
                    Rec.Status := Rec.Status::Approved;
                    Rec.Modify();
                    // ApprovalMail();
                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = (Rec.Status = Rec.Status::Pending);
                trigger OnAction()
                begin
                    Rec.TestField("Reject Reason");
                    If not confirm('Do you want to Reject the Insurance Document?', false) then
                        Exit;

                    Rec."Rejected By" := UserId();
                    Rec."Rejected On" := Today();
                    Rec.Status := Rec.Status::Rejected;
                    Rec.Modify();
                    // RejectMail();
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        IF Rec.Status in [Rec.Status::Approved, Rec.Status::Rejected] then
            CurrPage.Editable := False
        Else
            CurrPage.Editable := true;
    end;


    trigger OnAfterGetRecord()
    begin
        IF Rec.Status in [Rec.Status::Approved, Rec.Status::Rejected] then
            CurrPage.Editable := False
        Else
            CurrPage.Editable := true;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        IF Rec.Status in [Rec.Status::Approved, Rec.Status::Rejected] then
            CurrPage.Editable := False
        Else
            CurrPage.Editable := true;
    end;


}