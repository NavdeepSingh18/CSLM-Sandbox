page 50230 "Course Subject H Detail-CS"
{
    // version V.001-CS
    Caption = 'Course Subject List';
    CardPageID = "Course Subject Hdr-CS";
    Editable = false;
    PageType = List;
    SourceTable = "Course Wise Subject Head-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
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
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
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
            group("&Course Subject ")
            {
                Caption = '&Course Subject ';
                action("&Card")
                {
                    Caption = '&Card';
                    Image = EditLines;
                    RunObject = Page 50299;
                    RunPageLink = "Course" = FIELD(Course), Semester = FIELD(Semester), "Academic Year" = FIELD("Academic Year");
                    ApplicationArea = All;
                }
            }
            action("Synch to Blackboard")//GAURAV//
                {
                    Caption = 'Synch to Blackboard';
                    Image = EntriesList;
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    var
                        
                        WebServicesFunctionsCS: codeunit 50034;
                    begin
                        CleaR(WebServicesFunctionsCS);
                        WebServicesFunctionsCS.SynchOnlyCoursetoBlackBoard();
                        
                    end;
                }
        }
    }
}