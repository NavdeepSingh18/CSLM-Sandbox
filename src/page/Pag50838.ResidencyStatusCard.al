page 50838 "Residency Status Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Residency Status";
    Caption = 'Residency Status';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field("Sub Type"; Rec."Sub Type")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    NotBlank = True;

                    trigger OnValidate()
                    begin
                        Rec.TestField(Type);
                        Rec.TestField("Sub Type");
                    end;
                }
                field("Char Code"; Rec."Chart Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }
        }
    }
}