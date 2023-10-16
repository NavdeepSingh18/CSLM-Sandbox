page 50334 "Calendar Generation List-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   14/02/2019       OnOpenPage()                Code added for open page college wise.

    Caption = 'Calendar Generation List';
    CardPageID = "Course Faculty Generation-CS";
    PageType = List;
    SourceTable = "Generated Time Table-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Visible = false;
                    ApplicationArea = ALl;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = ALl;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = ALl;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = ALl;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = ALl;
                }
                field("Day No"; Rec."Day No")
                {
                    ApplicationArea = ALl;
                }
                field("Hour No"; Rec."Hour No")
                {
                    ApplicationArea = ALl;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = ALl;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = ALl;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = ALl;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = ALl;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = ALl;
                }
                field("Attendance Date"; Rec."Attendance Date")
                {
                    ApplicationArea = ALl;
                }
                field("Room Allocation"; Rec."Room Allocation")
                {
                    ApplicationArea = ALl;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = ALl;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        //Code added for open page college wise::CSPL-00059::14022019: Start
        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for open page college wise::CSPL-00059::14022019: End
    end;

    var
        recUserSetup: Record "User Setup";
}

