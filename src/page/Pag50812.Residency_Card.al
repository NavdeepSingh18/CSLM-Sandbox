page 50812 "Residency Card"
{
    Caption = 'Residency Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = Residency;
    //InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Residency No."; Rec."Residency No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    //    Style = Unfavorable;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                Field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                Field("Student Current Status"; Rec."Student Current Status")
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(ECFMG_ID; Rec.ECFMG_ID)
                {
                    ApplicationArea = All;

                }
                Field("E-mail Address"; Rec."E-mail Address")
                {
                    ApplicationArea = All;
                }
                field("Residency Effective Date"; Rec."Residency Effective Date")
                {
                    ApplicationArea = All;
                }
                field("MSPE Request Date"; Rec."MSPE Request Date")
                {
                    ApplicationArea = All;
                }
                field("Residency Year"; Rec."Residency Year")
                {
                    ApplicationArea = All;
                }
                field("Link to Hospital Branch"; Rec."Link to Hospital Branch")
                {
                    ApplicationArea = All;
                }
                field("Residency Status"; Rec."Residency Status")
                {
                    ApplicationArea = All;

                }
                field("NRMP Status"; Rec."NRMP Status")
                {
                    ApplicationArea = All;

                }
                field("CaRMS Status"; Rec."CaRMS Status")
                {
                    ApplicationArea = All;

                }
                field("San Francisco Status"; Rec."San Francisco Status")
                {
                    ApplicationArea = All;

                }
                field("Residency Placement Type"; Rec."Residency Placement Type")
                {
                    ApplicationArea = All;
                }
                field("Post Graduate Year"; Rec."Post Graduate Year")
                {
                    ApplicationArea = All;
                }
                field("Hospital Code"; Rec."Hospital Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;

                }
                field("Residency Specialty"; Rec."Residency Specialty")
                {
                    ApplicationArea = All;

                }
                field("Hospital City"; Rec."Hospital City")
                {
                    ApplicationArea = All;

                }
                field("Hospital State"; Rec."Hospital State")
                {
                    ApplicationArea = All;

                }
                field("Hospital Country"; Rec."Hospital Country")
                {
                    ApplicationArea = All;

                }
                field("Hospital Name1"; Rec."Hospital Name1")
                {
                    ApplicationArea = All;
                }
                field("Residency Specialty1"; Rec."Residency Specialty1")
                {
                    ApplicationArea = All;
                }
                field("Hospital City1"; Rec."Hospital City1")
                {
                    ApplicationArea = All;
                }
                field("Hospital State1"; Rec."Hospital State1")
                {
                    ApplicationArea = All;
                }
                field("Hospital Country1"; Rec."Hospital Country1")
                {
                    ApplicationArea = All;
                }

                field("Hospital Name2"; Rec."Hospital Name2")
                {
                    ApplicationArea = All;
                }
                field("Residency Specialty2"; Rec."Residency Specialty2")
                {
                    ApplicationArea = All;
                }
                field("Hospital City2"; Rec."Hospital City2")
                {
                    ApplicationArea = All;
                }
                field("Hospital State2"; Rec."Hospital State2")
                {
                    ApplicationArea = All;
                }
                field("Hospital Country2"; Rec."Hospital Country2")
                {
                    ApplicationArea = All;
                }
                field("File Complete"; Rec."File Complete")
                {
                    ApplicationArea = All;
                }
                field("RPR Rcvd"; Rec."RPR Rcvd")
                {
                    ApplicationArea = All;
                }
                field("Link to Contact"; Rec."Link to Contact")
                {
                    ApplicationArea = All;
                }

                field(nID; Rec.nID)
                {
                    ApplicationArea = All;
                }
                field("Residency ACGME No."; Rec."Residency ACGME No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {

            part("Residency Fact Box"; "Residency Fact Box")
            {
                ApplicationArea = All;
                SubPageLink = "Student No." = FIELD("Student No."), "Residency No." = field("Residency No.");
            }

            part("Residency Note"; "Residency Note")
            {
                ApplicationArea = All;
                SubPageLink = "Source No." = FIELD("Residency No.");
            }

        }


    }

    actions
    {
        area(Processing)
        {
            action("Residency Notes")
            {
                ApplicationArea = All;
                Caption = 'Residency Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InteractionTemplate: Record "Interaction Template";
                    InteractionGroup: Record "Interaction Group";
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                begin
                    Rec.TestField("Student No.");
                    InteractionTemplate.Reset();
                    InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Residency);
                    IF not InteractionTemplate.FindLast() then
                        Error('Interaction Template not found for Residency Type.');

                    InteractionGroup.Reset();
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Residency Note");
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Residency Type.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Residency No.");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    InterLogEntryCommentLine.SetRange("Original Student No.", Rec."Student No.");
                    Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                end;
            }

            action("Residency Employment Notes")
            {
                ApplicationArea = All;
                Caption = 'Residency Employment Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    InteractionTemplate: Record "Interaction Template";
                    InteractionGroup: Record "Interaction Group";
                    InterLogEntryCommentLine: Record "Interaction Log Entry";
                begin
                    Rec.TestField("Student No.");
                    InteractionTemplate.Reset();
                    InteractionTemplate.SetRange("Type", InteractionTemplate."Type"::Residency);
                    IF not InteractionTemplate.FindLast() then
                        Error('Interaction Template not found for Residency Type.');

                    InteractionGroup.Reset();
                    InteractionGroup.SetRange("Type", InteractionGroup."Type"::"Residency Employement Note");
                    IF not InteractionGroup.FindLast() then
                        Error('Interaction Group not found for Residency Employement Note Type.');

                    InterLogEntryCommentLine.Reset();
                    InterLogEntryCommentLine.SetRange("Source No.", Rec."Residency No.");
                    InterLogEntryCommentLine.SetRange("Interaction Template Code", InteractionTemplate.Code);
                    InterLogEntryCommentLine.SetRange("Interaction Group Code", InteractionGroup.Code);
                    InterLogEntryCommentLine.SetRange("Original Student No.", Rec."Student No.");
                    Page.RunModal(Page::"SLcM Notes List", InterLogEntryCommentLine);
                end;
            }
            action("Residency Ledger")
            {
                ApplicationArea = All;
                Caption = 'Residency Ledger';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Residency Ledger";
                RunPageLink = "Residency No." = field("Residency No."), "Student No." = field("Student No.");

            }
            action("Hospital List")
            {
                ApplicationArea = All;
                // Caption = 'Residency Employment Notes';
                Image = Notes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = Page "Hospital List";

            }
        }
    }
}