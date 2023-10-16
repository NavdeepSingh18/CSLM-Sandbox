page 50937 "Rotation Grade Updation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Roster Ledger Entry";
    SourceTableView = where("Rotation Grade" = filter('X'));
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Entries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rotation ID"; Rec."Rotation ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Type"; Rec."Course Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total No. of Weeks"; Rec."Total No. of Weeks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                // field("Actual Rotation Cost";Rec."Actual Rotation Cost")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Total Actual Rotation Cost";Rec."Total Actual Rotation Cost")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Estimated Rotation Cost";Rec."Estimated Rotation Cost")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Total Estd. Rotation Cost";Rec."Total Estd. Rotation Cost")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                field("Rotation Grade"; Rec."Rotation Grade")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Cancelled By"; Rec."Cancelled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cancelled On"; Rec."Cancelled On")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Cancelled")
            {
                ApplicationArea = All;
                Caption = 'Student Cancelled';
                Image = CancelAttachment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Student Cancelled';
                trigger OnAction()
                begin
                    if Confirm('Do you want to change the Grade to SC?') then begin
                        Rec.Validate("Rotation Grade", 'SC');
                        Rec.Modify();
                    end;
                    Message('Rotation Grade Updated Successfully to "SC".');
                end;
            }
            action("University Cancelled")
            {
                ApplicationArea = All;
                Caption = 'University Cancelled';
                Image = CancelledEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'University Cancelled';
                trigger OnAction()
                begin
                    if Confirm('Do you want to change the Grade to UC?') then begin
                        Rec.Validate("Rotation Grade", 'UC');
                        Rec.Modify();
                    end;
                    Message('Rotation Grade Updated Successfully to "UC".');
                end;
            }
        }
    }
}