page 50253 "Scholarshpt List-CS"
{
    // version V.001-CS

    Caption = 'Scholarship List';
    CardPageID = "Scholar. H Card-CS";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Scholarship Header-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Source Name"; Rec."Source Name")
                {
                    ApplicationArea = All;
                }
                field("Fee Classification Code"; Rec."Fee Classification Code")
                {
                    ApplicationArea = All;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
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
                        CopyScholarshipPage.VariablePassing('');
                        CopyScholarshipPage.RunModal();
                    end;

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