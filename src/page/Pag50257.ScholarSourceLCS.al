page 50257 "Scholar. Source L-CS"
{
    // version V.001-CS
    Caption = 'Scholar. Source L-CS';
    PageType = List;
    SourceTable = "Source Scholarship-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Discount Type"; Rec."Discount Type")
                {
                    ApplicationArea = All;
                }
                field("SAP Code"; Rec."SAP Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
            action("Scholarship/Grant List")
            {
                ApplicationArea = All;
                Image = List;
                Visible = VisibleAction;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Runobject = page "Scholarshpt List-CS";
                RunPageLink = "Source Code" = FIELD(Code), "Global Dimension 1 Code" = field("Global Dimension 1 Code");
            }
        }
    }
    var
        VisibleAction: Boolean;

    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;
    begin
        VisibleAction := true;
        if Rec."Discount Type" = Rec."Discount Type"::Waiver then
            VisibleAction := false;

        //SD-SN-17-Dec-2020 +
        begin
            Rec.FilterGroup(2);
            Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
            Rec.FilterGroup(0);
        end;
        //SD-SN-17-Dec-2020 -
    end;

    trigger OnAfterGetRecord()
    begin
        VisibleAction := true;
        if Rec."Discount Type" = Rec."Discount Type"::Waiver then
            VisibleAction := false;
    end;

}