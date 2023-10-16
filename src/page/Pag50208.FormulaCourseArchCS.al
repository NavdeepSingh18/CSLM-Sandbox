page 50208 "Formula Course Arch-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019      ShowEligibleFormula()       Code added for create finction show field .
    // 02    CSPL-00059   07/02/2019      ShowRankingFormula()        Code added for create function rank detail.

    AutoSplitKey = true;
    Caption = 'Course Formula History';
    PageType = CardPart;
    SourceTable = "Course Formula Details-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("List No."; Rec."List No.")
                {
                    ApplicationArea = All;
                }
                field("Stage1 Formula"; Rec."Stage1 Formula")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Stage2 Formula"; Rec."Stage2 Formula")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Interview Scheduled Date"; Rec."Interview Scheduled Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    procedure CSShowEligibleFormula()
    begin
        //Code added for create finction show field::CSPL-00059::07022019: Start
        Rec.ShowEligibleDetail();
        //Code added for create finction show field::CSPL-00059::07022019: End
    end;

    procedure CSShowRankingMetod()
    begin
        // Code added for create function rank detail::CSPL-00059::07022019: Start
        Rec.ShowRankingDetail();
        // Code added for create function rank detail::CSPL-00059::07022019: End
    end;
}

