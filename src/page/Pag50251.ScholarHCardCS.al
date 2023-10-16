page 50251 "Scholar. H Card-CS"
{
    // version V.001-CS

    Caption = 'Scholarship';
    //DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Scholarship Header-CS";
    UsageCategory = None;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Scholarship Code"; Rec."Scholarship Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Scholarship Name"; Rec."Scholarship Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                }
                field("Discount Type"; Rec."Discount Type")
                {
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Grant Criteria"; Rec."Grant Criteria")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("SAP Code"; Rec."SAP Code")
                {
                    ApplicationArea = All;
                }
            }
            part("Scholar. L SubPage-CS"; 50252)
            {
                SubPageLink = "Document No." = FIELD("No.");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(creation)
        {
            group("Scholarship Copy")
            {
                Caption = 'Scholarship Copy';
                action("Copy Scholarship")
                {
                    Caption = 'Copy Scholarship';
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        CopyScholarshipPage: Page "Copy Scholarship Document";
                    begin
                        CopyScholarshipPage.VariablePassing(Rec."No.");
                        CopyScholarshipPage.RunModal();
                    end;

                }
            }
        }
    }
    var
        ScholarshipHeader: Record "Scholarship Header-CS";

    trigger OnClosePage()
    begin
        ScholarshipHeader.Reset();
        ScholarshipHeader.SetRange("No.", Rec."No.");
        ScholarshipHeader.SetRange("SAP Code", '');
        If ScholarshipHeader.FindFirst() Then
            Error('SAP Code must not be Blank for fee Component %1', ScholarshipHeader."No.");

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        ScholarshipHeader.Reset();
        ScholarshipHeader.SetRange("No.", Rec."No.");
        ScholarshipHeader.SetRange("SAP Code", '');
        If ScholarshipHeader.FindFirst() Then
            Error('SAP Code must not be Blank for fee Component %1', ScholarshipHeader."No.");

    end;

}

