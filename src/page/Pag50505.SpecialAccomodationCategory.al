page 50505 "Special Accommodation Category"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Special Accommodation Category";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.TestField(Code);
                    end;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
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
            action("Block")
            {
                ApplicationArea = All;
                Caption = 'Block';
                Image = Cancel;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Do you want to block the Special Accommodation Category %1?', true, Rec.Code) then
                        exit;

                    Rec.Status := Rec.Status::Blocked;
                    Rec."Blocked By" := UserId;
                    Rec."Blocked On" := Today;
                    Rec.Modify();
                    Message('Special Accommodation Category - %1 has been blocked', Rec.Code);
                end;
            }
            action("Allow")
            {
                ApplicationArea = All;
                Caption = 'Allow';
                Image = Allocate;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('Do you want to Unblock the Special Accommodation Category - %1?', true, Rec.Code) then
                        exit;

                    Rec.Status := Rec.Status::Allowed;
                    Rec."Allowed By" := UserId;
                    Rec."Allowed On" := Today;
                    Rec.Modify();
                    Message('Special Accommodation Category - %1 is now active', Rec.Code);
                end;
            }
        }
    }
}