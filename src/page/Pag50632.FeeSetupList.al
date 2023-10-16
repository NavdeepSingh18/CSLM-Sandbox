page 50632 "Fee Setup List"
{

    PageType = List;
    SourceTable = "Fee Setup-CS";
    CardPageId = "Setup Fee-CS";
    Caption = 'Fee Setup List';
    ApplicationArea = All;
    Editable = false;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = EditList;

                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Fee Invoice No."; Rec."Fee Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Template Name"; Rec."Withdrawal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Batch Name"; Rec."Withdrawal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal G/L Account No."; Rec."Withdrawal G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Document No."; Rec."Withdrawal Document No.")
                {
                    ApplicationArea = All;
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

        IF UserSetup.GET(UserId()) THEN
            IF UserSetup."Fee Setup Allowed" THEN
                EditList := TRUE
            ELSE
                EditList := FALSE;
    end;
    //SD-SN-17-Dec-2020 -
    var
        UserSetup: Record "User Setup";
        EditList: Boolean;
}
