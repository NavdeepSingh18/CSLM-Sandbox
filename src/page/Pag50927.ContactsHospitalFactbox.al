page 50927 "Contacts Hospital Factbox"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Business Contact Relation";
    DelayedInsert = true;
    Caption = 'Contacts Hospital';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater("Contacts")
            {
                field(SourceName; SourceName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    Caption = 'Name';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                    Caption = 'No.';
                }
            }
        }
    }

    var
        Vendor: Record Vendor;
        StudentMaster: Record "Student Master-CS";
        SourceName: Text[100];

    trigger OnAfterGetRecord()
    begin
        SourceName := '';
        if Rec."Relation Type" = Rec."Relation Type"::Vendor then begin
            Vendor.Reset();
            if Vendor.Get(Rec."No.") then
                SourceName := Vendor.Name;
        end;
        if Rec."Relation Type" = Rec."Relation Type"::Student then begin
            StudentMaster.Reset();
            if StudentMaster.Get(Rec."No.") then
                SourceName := StudentMaster."Student Name";
        end;
    end;
}