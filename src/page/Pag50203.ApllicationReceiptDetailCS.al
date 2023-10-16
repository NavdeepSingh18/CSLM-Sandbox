page 50203 "Apllication Receipt Detail-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00130   07/01/2019       OnOpenPage()                              Code add for user wise page open
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Apllication Receipt Detail-CS';
    CardPageID = "Application Receipt-CS";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Application-CS";
    SourceTableView = SORTING("No.")
                      WHERE("Application Status" = FILTER(>= Sold));

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
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                }
                field("Registration Cost"; Rec."Registration Cost")
                {
                    ApplicationArea = All;
                }
                field("Date of Sale"; Rec."Date of Sale")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Recieve")
            {
                Caption = '&Recieve';
                action("C&ard")
                {
                    Caption = 'C&ard';
                    Image = EditLines;
                    RunObject = Page 50205;
                    RunPageOnRec = true;
                    ShortCutKey = 'Shift+F7';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        //Code added for user wise page open::CSPL-00059::07012019: Start

        IF recUserSetup.GET(UserId()) THEN BEGIN
            Rec.FILTERGROUP(2);
            IF recUserSetup."Global Dimension 1 Code" <> '' THEN
                Rec.SETFILTER("Global Dimension 1 Code", recUserSetup."Global Dimension 1 Code");
            Rec.FILTERGROUP(0);
        END;
        //Code added for user wise page open::CSPL-00059::07012019: End
    end;

    var
        recUserSetup: Record "User Setup";
}

