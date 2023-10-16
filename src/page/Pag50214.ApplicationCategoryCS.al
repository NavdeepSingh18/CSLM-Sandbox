page 50214 "Application Category-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    PageType = List;
    SourceTable = "Application Cert. Cate-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Application Category Code"; Rec."Application Category Code")
                {
                    ApplicationArea = All;
                }
                field("App Category Classification"; Rec."App Category Classification")
                {
                    ApplicationArea = All;
                }
                field("Payment Required"; Rec."Payment Required")
                {
                    ApplicationArea = All;
                }
                field("Fee Code"; Rec."Fee Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}