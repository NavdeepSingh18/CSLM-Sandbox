page 50973 "FA Academic Year Setup List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Financial Aid Academic Year";
    Caption = 'Financial Aid Academic Year Setup List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("FA Academic Year"; Rec."FA Academic Year")
                {
                    ApplicationArea = All;

                }
                field("FA Academic Year Description"; Rec."FA Academic Year Description")
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
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;

                }
            }
        }

    }

}