page 50980 "Exam Passing Criteria"
{

    PageType = List;
    SourceTable = "Exam Passing";
    Caption = 'Exam Passing Criteria List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                }
                field("Passing Marks"; Rec."Passing Marks")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
