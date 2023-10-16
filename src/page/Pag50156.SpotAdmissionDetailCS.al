page 50156 "Spot Admission Detail-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // ----------------------------------------------------------------------------------------
    // 01    CSPL-00059   07/02/2019       OnOpenPage()                Code added for open page user wise.

    Caption = 'Spot Admission Detail-CS';
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      WHERE("Application Status" = FILTER(' '));

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
                field("Applicant Name"; Rec."Applicant Name")
                {
                    ApplicationArea = All;
                }
                field(Recommended; Rec.Recommended)
                {
                    ApplicationArea = All;
                }
                field("Recommend By"; Rec."Recommend By")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Admitted; Rec.Admitted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Alloted; Rec.Alloted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Alloted Date"; Rec."Alloted Date")
                {
                    ApplicationArea = All;
                }
                field("Admission Date"; Rec."Admission Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Admission")
            {
                Caption = '&Admission';
                action("C&ard")
                {
                    Caption = 'C&ard';
                    Image = EditLines;
                    RunObject = Page 50099;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
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
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for open page user wise::CSPL-00059::07022019: End
    end;

    var
        recUserSetup: Record "User Setup";
}

