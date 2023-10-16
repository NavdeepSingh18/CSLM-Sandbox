page 50195 "Fee Components Detail-CS"
{
    // version V.001-CS

    Caption = 'Fee Components List';
    DeleteAllowed = true;
    Editable = true;
    PageType = List;
    SourceTable = "Fee Component Master-CS";
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
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Fee Category"; Rec."Fee Category")
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
                field("SAP Code"; Rec."SAP Code")
                {
                    ApplicationArea = All;
                }

                field("Type Of Fee"; Rec."Type Of Fee")
                {
                    ApplicationArea = All;
                }
                field("Fee Group"; Rec."Fee Group")
                {
                    ApplicationArea = All;
                }
                field("Check Duplication"; Rec."Check Duplication")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;

                }
                Field("1098-T From"; Rec."1098-T From")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
    var
        FeeComp: Record "Fee Component Master-CS";

    trigger OnClosePage()
    begin
        FeeComp.Reset();
        FeeComp.SetRange("SAP Code", '');
        If FeeComp.FindFirst() Then
            Error('SAP Code must not be blank for fee Component %1', FeeComp.Code);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        FeeComp.Reset();
        FeeComp.SetRange("SAP Code", '');
        If FeeComp.FindFirst() Then
            Error('SAP Code must not be blank for fee Component %1', FeeComp.Code);

    end;

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

