page 50313 "Stage Attendance Pr Setup-CS"
{
    // version V.001-CS

    Caption = 'Stage Attendance Pr Setup';
    PageType = List;
    SourceTable = "Fee Component Master-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Fine';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Check Duplication"; Rec."Check Duplication")
                {
                    ApplicationArea = All;
                }
                field("No Of Months"; Rec."No Of Months")
                {
                    ApplicationArea = All;
                }
                // field(MARK; 'MARK')
                // {
                //     Caption = 'Mark';
                //     ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
    }
}

