page 50170 "Status Change Log Entry Logs"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Status Change Log Entry Log";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Log Entry No."; Rec."Log Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Log Type"; Rec."Log Type")
                {
                    ApplicationArea = all;
                }
                field("Log Entry Created By"; Rec."Log Entry Created By")
                {
                    ApplicationArea = All;
                }
                field("Log Entry Created On"; Rec."Log Entry Created On")
                {
                    ApplicationArea = All;
                }
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

            }
        }

    }
}