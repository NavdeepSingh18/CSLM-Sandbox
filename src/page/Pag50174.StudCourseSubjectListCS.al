page 50174 "Stud. Course Subject List-CS"
{
    // version V.001-CS

    CardPageID = "Course Subject Hdr-CS";
    ModifyAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Course Wise Subject Head-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Course; Rec.Course)
                {
                    ApplicationArea = all;
                }
                field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = all;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = all;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = all;
                }

                field(Year; Rec.Year)
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }

            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Copy Course Subject")
            {
                Caption = 'Copy Course Subject';
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CourseSubjectRec: Record "Course Wise Subject Head-CS";
                begin
                    CourseSubjectRec.Reset();
                    CourseSubjectRec.SetRange(Course, Rec.Course);
                    CourseSubjectRec.SetRange("Academic Year", Rec."Academic Year");
                    If CourseSubjectRec.FindFirst() then
                        Report.Run(Report::"Copy Course Subject", True, False, CourseSubjectRec);

                end;

            }
            action("Course Wise Faculty List")
            {
                ApplicationArea = All;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Faculty-Course Wise";
                RunPageLink = "Course Code" = FIELD(Course);
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