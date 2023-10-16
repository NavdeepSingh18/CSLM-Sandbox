page 50322 "Aptitude Topic(Sub.) list-CS"
{
    // version V.001-CS

    // 
    // No   Date        Sign       Trigger          Description
    // -----------------------------------------------------------------------------------------------
    // 01   30/10/09    Vandhana   Edit-OnPush()    To make the form editable.

    Caption = 'Aptitude Topic(Sub.) list';
    CardPageID = "Subject Faculty Card-CS";
    PageType = List;
    SourceTable = "Faculty Detail Subj Wise-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Name"; Rec."Faculty Name")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Subject Description"; Rec."Subject Description")
                {
                    ApplicationArea = All;
                }
                field("Semester Code"; Rec."Semester Code")
                {
                    ApplicationArea = All;
                }
                field("Section Code"; Rec."Section Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Course Master"; Rec."Course Master")
                {
                    ApplicationArea = All;
                }
                field("Weekly Hours"; Rec."Weekly Hours")
                {
                    ApplicationArea = All;
                }
                field("Alloted Hours"; Rec."Alloted Hours")
                {
                    ApplicationArea = All;
                }
                field("Theory Load"; Rec."Theory Load")
                {
                    ApplicationArea = All;
                }
                field("Practical Load"; Rec."Practical Load")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

