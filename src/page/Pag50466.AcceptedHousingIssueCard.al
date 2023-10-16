page 50466 "Housing Issue Card"
{
    Caption = 'Accepted Housing Issue Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report';
    RefreshOnActivate = true;
    SourceTable = "Housing Issue";
    ApplicationArea = All;
    UsageCategory = Administration;

    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Importance = Standard;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Housing Name"; Rec."Housing Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Housing Address"; Rec."Housing Address")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }
                field("Housing Address 2"; Rec."Housing Address 2")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Editable = false;
                }
                field("Housing City"; Rec."Housing City")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Housing Country"; Rec."Housing Country")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Code"; Rec."Issue Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issue Description"; Rec."Issue Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Resolution Remarks"; Rec."Resolution Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Accepted In Days"; Rec."Accepted In Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        // area(factboxes)
        // {
        //     part("Housing Issue FactBox"; "Housing Issue FactBox")
        //     {
        //         ApplicationArea = All;
        //         SubPageLink = "Housing ID" = FIELD("Housing ID")

        //     }

        // }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Housing Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Card';
                Runobject = page "Housing Master Card";
                RunPageLink = "Housing ID" = FIELD("Housing ID");
            }
            action("Resolved")
            {
                ApplicationArea = All;
                Caption = 'Resolved';
                Promoted = true;
                Promotedonly = True;

                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Close;
                trigger OnAction()
                begin
                    REc.TestField("Resolution Remarks");
                    If REc.Status = REc.Status::Accepted then begin
                        If REc."Rejection Description" = '' then begin
                            If Confirm(Txt006Lbl, false, REc."Document No.") then begin
                                REc.Updated := True;
                                REc."Resolution Mail" := true;
                                REc.Status := REc.Status::Resolved;
                                REc."Closed By" := UserId();
                                REc."Closed Date" := WorkDate();
                                REc."Resolved In Days" := REc."Closed Date" - REc."Accepted Date";
                                REc.Modify();
                                // ResolutionMail();
                                Message(FORMAT(Txt007Lbl), REc."Document No.");
                                CurrPage.Close();
                            end;
                        end else
                            Error('Rejection Description should be blank');
                    end else
                        Error(Txt004Lbl);
                end;
            }
        }
    }
    var
        Txt006Lbl: Label 'Do you want to resolve application No. %1  ?';
        Txt007Lbl: Label 'Issue Application No. %1 has been resolved.';
        Txt004Lbl: Label 'Status must be Accepted';
}