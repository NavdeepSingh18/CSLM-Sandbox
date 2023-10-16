page 50052 "Promotion Student List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id      Date      Trigger            Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  10-05-19   OnOpenPage()     Code added for college wise page filter.
    // 02.   CSPL-00174  10-05-19   OnOpenPage()     Code added for report run.

    CardPageID = "Promotion Stud Hdr-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Promotion Header-CS";
    Caption='Promotion Student List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Create Promotion Details")
            {
                Image = GetLines;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                RunObject = Page "Selection Academic Year-CS";
                ApplicationArea = All;
            }
            action("Student Promotion Check")
            {
                Image = "Report";
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = "Report";
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //Code added for report run::CSPL-00174::100519: Start
                    CurrPage.SETSELECTIONFILTER(PromotionHeaderCS);
                    REPORT.RUN(50012, TRUE, TRUE, PromotionHeaderCS);
                    //Code added for report run::CSPL-00174::100519: End
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for college wise page filter::CSPL-00174::100519: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for college wise page filter::CSPL-00174::100519: End
    end;

    var
        recUserSetup: Record "User Setup";
        PromotionHeaderCS: Record "Promotion Header-CS";
}

