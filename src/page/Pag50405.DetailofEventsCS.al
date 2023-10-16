page 50405 "Detail of Events-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       OnOpenPage()                             Code added for open page user wise.

    DelayedInsert = true;
    PageType = List;
    SourceTable = "College Event-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Event"; Rec."Event")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(College; Rec.College)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(University; Rec.University)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        //Code added for open page user wise::CSPL-00059::07022019: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER(College, recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for open page user wise::CSPL-00059::07022019: End
    end;

    var
        recUserSetup: Record "User Setup";
}