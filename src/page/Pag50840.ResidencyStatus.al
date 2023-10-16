page 50840 "Residency Status List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Residency Status";
    Caption = 'Residency Status';
    CardPageId = "Residency Status Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Sub Type"; Rec."Sub Type")
                {
                    ApplicationArea = All;
                }
                field("Chart Code"; Rec."Chart Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}