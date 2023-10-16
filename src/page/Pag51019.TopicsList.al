page 51019 "Topics List"
{
    PageType = List;
    SourceTable = "Topic Master";
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Topic List';
    CardPageId = "Topics card";
    editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Student Last Name Char."; Rec."Student Last Name Char.")
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
                    Editable = False;
                }
            }
        }
    }
}
