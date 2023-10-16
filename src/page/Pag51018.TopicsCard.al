page 51018 "Topics card"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Topic Master";
    Caption = 'Topic Card';


    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Adviser Id"; Rec."Adviser Id")
                {
                    ApplicationArea = All;
                }
                Field("Advisor Name"; Rec."Advisor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Last Name Char."; Rec."Student Last Name Char.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
