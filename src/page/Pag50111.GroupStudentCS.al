page 50111 "Group(Student)-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger          Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  12-05-19   OnOpenPage()     Code added for college wise page filter.

    CardPageID = "Group(Student) Card-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Group Student-CS";
    Caption = 'Group(Student)';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Group Code Description"; Rec."Group Code Description")
                {
                    ApplicationArea = All;
                }
                field("No. Of Student"; Rec."No. Of Student")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for college wise page filter::CSPL-00174::120519: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for college wise page filter::CSPL-00174::120519: End
    end;

    var
        recUserSetup: Record "User Setup";
}

