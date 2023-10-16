page 50046 "Edu. Calender-CS"
{
    // version V.001-CS

    Caption = 'Education Calender List';
    PageType = List;
    CardPageId = "Edu Calendar-CS";
    UsageCategory = Administration;
    ApplicationArea = All;
    Editable = false;
    SourceTable = "Education Calendar-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

