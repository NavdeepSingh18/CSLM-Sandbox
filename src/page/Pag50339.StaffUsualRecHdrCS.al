page 50339 "Staff Usual Rec Hdr-CS"
{
    // version V.001-CS

    Caption = 'Staff Usual Rec Hdr';
    PageType = Card;
    SourceTable = "Course Plan Head Faculty-CS";
    SourceTableView = WHERE("Plan Status" = FILTER(Approved));
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Week Hours"; Rec."Total Week Hours")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Perc Completed"; Rec."Perc Completed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part("Staff Usual Rec Line-CS"; "Staff Usual Rec Line-CS")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("F&aculty Daily Record")
            {
                Caption = 'F&aculty Daily Record';
                action("&List")
                {
                    Caption = '&List';
                    RunObject = Page "Stage Attendance Pr Setup-CS";
                    ShortCutKey = 'Shift+Ctrl+L';
                    ApplicationArea = All;
                }
            }
        }
    }

}