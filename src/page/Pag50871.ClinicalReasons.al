page 50871 "Clinical Reasons"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Reason Code";
    SourceTableView = where(Type = filter("Hospital Block" | "Inventory Block" | "Clerkship Documentation" | "Special Accommodation Rejection" | "FM1/IM1 Application Rejection" | "Elective Offer Application Rejection" | "Elective Offer Alternates Rejection" | "Non Affiliated Application Rejection" | "Rotation Cancellation" | "Clinical Hold"));
    Caption = 'Clinical Reasons';
    DelayedInsert = true;
    // CardPageId = "Clinical Reason";
    // Editable = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    OptionCaption = ' ,,,,,,Hospital Block,Inventory Block,Clerkship Documentation,Special Accommodation Rejection,FM1/IM1 Application Rejection,Elective Offer Application Rejection,Elective Offer Alternates Rejection,Non Affiliated Application Rejection,Rotation Cancellation,Clinical Hold';
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    trigger OnValidate()
                    begin
                        if Rec.Type = Rec.Type::" " then
                            Error('Type must not Blank.\Code= %1', Rec.Code);
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if Rec.Description = '' then
            Error('Description must not Blank.\Code= %1', Rec.Code);
    end;
}