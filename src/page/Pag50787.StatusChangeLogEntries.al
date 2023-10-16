page 50787 "Status Change Log Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Status Change Log entry";
    //SourceTableView = Sorting("Modified aOn") ORDER(Ascending);//GMCSCOM
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = False;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                //editable = EditList;

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Status change From"; Rec."Status change From")
                {
                    ApplicationArea = All;

                }
                field("Status change to"; Rec."Status change to")
                {
                    ApplicationArea = All;

                }
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = all;
                }
                field("Last Date Of Attendance"; Rec."Last Date Of Attendance")
                {
                    ApplicationArea = all;
                }
                field("Date Of Determination"; Rec."Date Of Determination")
                {
                    ApplicationArea = all;
                }
                field("NSLDS Withdrawal Date"; Rec."NSLDS Withdrawal Date")
                {
                    ApplicationArea = all;
                }
                Field("Dismissal Date"; Rec."Dismissal Date")
                {
                    ApplicationArea = ALL;
                    Editable = false;
                }

                field("Modified by"; Rec."Modified by")
                {
                    ApplicationArea = All;

                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;

                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = all;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = all;
                }
                field("Begin Date"; Rec."Begin Date")
                {
                    ApplicationArea = all;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = all;
                }

                field(AdEnrollStuNum; Rec.AdEnrollStuNum)
                {
                    ApplicationArea = all;
                }
                field(AdTermCode; Rec.AdTermCode)
                {
                    ApplicationArea = all;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;

                }
                Field("Current Semester"; Rec."Current Semester")
                {
                    ApplicationArea = All;
                }
                Field("Current Status"; Rec."Current Status")
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    trigger OnInit()
    begin
        EditList := false;
    end;

    trigger OnOpenPage()
    begin
        UserSetup.GET(UserId());
        IF UserSetup."Status Change Log Allowed" THEN
            EditList := true
        ELSE
            EditList := false;


    end;

    trigger OnAfterGetRecord()
    begin
        // UserSetup.GET(UserId());
        // IF UserSetup."Status Change Log Allowed" THEN
        //     EditList := true
        // ELSE
        //     EditList := false;
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        // UserSetup.GET(UserId());
        // IF not UserSetup."Status Change Log Allowed" THEN
        //     Error('Status change log deletion not allowed.');
    end;

    var
        UserSetup: Record "User Setup";
        EditList: Boolean;
}