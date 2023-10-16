page 50506 "STD Spl Accommodation Category"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Std Spl Accommodation Category";

    layout
    {
        area(Content)
        {
            group("References")
            {
                field(ClinicalRefNo; ClinicalRefNo)
                {
                    Caption = 'Clinical Reference No.';
                    Editable = false;
                }
                field(ApplnNo; ApplnNo)
                {
                    Caption = 'Application No.';
                    Editable = false;
                }
            }
            repeater(General)
            {
                field("Accommodation Category Code"; Rec."Accommodation Category Code")
                {
                    ApplicationArea = All;
                    Editable = EditAllow;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Application No." := ApplnNo;
        Rec."Clinical Reference No." := ClinicalRefNo;
        EditAllow := true;
        SpclAccommodationApplication.Reset();
        if SpclAccommodationApplication.Get(Rec."Application No.") then begin
            EditAllow := not SpclAccommodationApplication."Send for Approval";
            CurrPage.Editable(EditAllow);
        end;
    end;

    trigger OnAfterGetRecord()

    begin
        EditAllow := true;
        SpclAccommodationApplication.Reset();
        if SpclAccommodationApplication.Get(Rec."Application No.") then begin
            EditAllow := not SpclAccommodationApplication."Send for Approval";
            CurrPage.Editable(EditAllow);
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        SpclAccommodationApplication.Reset();
        if SpclAccommodationApplication.Get(Rec."Application No.") then
            if SpclAccommodationApplication."Send for Approval" then
                Error('Delete not Allowed as you have sent the Special Accommodation Application for Approval.');
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SpclAccommodationApplication.Reset();
        if SpclAccommodationApplication.Get(Rec."Application No.") then
            if SpclAccommodationApplication."Send for Approval" then
                Error('Delete not Allowed as you have sent the Special Accommodation Application for Approval.');
    end;
    /// <summary> 
    /// Description for SetVariables.
    /// </summary>
    /// <param name="LClinicalRefNo">Parameter of type Code[20].</param>
    /// <param name="LApplnNo">Parameter of type Code[20].</param>
    procedure SetVariables(LClinicalRefNo: Code[20]; LApplnNo: Code[20])
    begin
        ClinicalRefNo := LClinicalRefNo;
        ApplnNo := LApplnNo;
    end;

    var
        SpclAccommodationApplication: Record "Spcl Accommodation Application";
        ClinicalRefNo: Code[20];
        ApplnNo: Code[20];
        EditAllow: Boolean;
}