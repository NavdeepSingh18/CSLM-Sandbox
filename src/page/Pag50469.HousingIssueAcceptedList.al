page 50469 "Housing Issue Accepted List"
{
    Caption = 'Accepted Housing Issue List';
    PageType = List;
    CardPageId = "Housing Issue Card";
    ApplicationArea = all;
    InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    Editable = false;
    SourceTable = "Housing Issue";
    SourceTableView = Sorting("Document Date") Order(Descending) where(Status = filter(Accepted));
    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
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
                field("Student Name"; Rec."Student Name")
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
                }
                field("Resolution Remarks"; Rec."Resolution Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Style = strong;
                    StyleExpr = ColorStyle;
                    Editable = false;
                    ToolTip = 'No. of days are calendar Days';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Remarks By Student"; Rec."Remarks By Student")
                {
                    ApplicationArea = All;
                    Caption = 'Remarks';
                    Editable = False;
                }
            }
        }
        // area(factboxes)
        // {
        //     part("Housing Issue FactBox"; "Housing Issue FactBox")
        //     {
        //         ApplicationArea = All;
        //         SubPageLink = "Housing ID" = FIELD("Housing ID");

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
            action("Send Mail Resolution")
            {
                ApplicationArea = All;
                Caption = 'Send Mail Resolution';
                Promoted = true;
                Promotedonly = True;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Close;
                Visible = false;
                trigger OnAction()
                begin
                    IF REc."Resolution Mail" = true then
                        Error(Txt008Lbl);

                    If REc.Status = REc.Status::Accepted then begin
                        If REc."Rejection Description" = '' then begin
                            If Confirm(Txt006Lbl, false, REc."Document No.") then begin
                                REc.Updated := True;
                                // ResolutionMail();
                                REc."Resolution Mail" := true;
                                REc.Status := REc.Status::Resolved;
                                REc.Modify();
                                Message(FORMAT(Txt007Lbl), REc."Document No.");
                            end;
                        end else
                            Error('Rejection Description should  be blank');
                    end else
                        Error(Txt004Lbl);
                end;
            }
        }
    }
    var
        ColorStyle: text;
        Txt006Lbl: Label 'Do you want to resolve application No. %1  ?';
        Txt007Lbl: Label 'Resolution Mail has been sent';
        Txt004Lbl: Label 'Status must be Accepted';
        Txt008Lbl: Label 'Resolution Email already sent';

    trigger OnAfterGetRecord()
    var
        EducationSetupRec: Record "Education Setup-CS";

    begin
        EducationSetupRec.Reset();
        EducationSetupRec.SetRange("Global Dimension 1 Code", REc."Shortcut Dimension 1 Code");
        if EducationSetupRec.FindFirst() then begin
            if REc."Accepted In Days" > EducationSetupRec."Max Days Issue Accepted" then
                ColorStyle := 'Unfavorable'
            else
                ColorStyle := 'favorable';

        end;
    end;



}