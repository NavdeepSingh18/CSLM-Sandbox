page 50250 "Feedback Detail-CS"
{
    // version V.001-CS
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Feedback Detail';
    PageType = List;
    SourceTable = "Faculty Feedback-CS";
   // DeleteAllowed = false;
   // InsertAllowed = False;
   // Editable = False;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(SNo; Rec.SNo)
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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Question Description"; Rec."Question Description")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Rate; Rec.Rate)
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Faculty Code"; Rec."Faculty Code")
                {
                    ApplicationArea = All;
                }
                field(FeedbackFor; Rec.FeedbackFor)
                {
                    ApplicationArea = All;
                }
                field("Remarks By Student"; Rec."Remarks By Student")
                {
                    ApplicationArea = All;
                }
                field("Question Id"; Rec."Question Id")
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Type of Evaluation"; Rec."Type of Evaluation")
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
            action("Faculty Feedback")
            {
                Image = Report;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    UserSetup.GET(UserId());
                    FacultyFeedbackRec.RESET();
                    FacultyFeedbackRec.SETRANGE("Faculty Code", Rec."Faculty Code");
                    FacultyFeedbackRec.SETRANGE(Semester, Rec.Semester);
                    FacultyFeedbackRec.SETRANGE("Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                    FacultyFeedbackRec.SetRange("Subject Code", Rec."Subject Code");
                    FacultyFeedbackRec.SetRange("Academic Year", Rec."Academic Year");
                    IF FacultyFeedbackRec.FINDFIRST() THEN
                        REPORT.RunModal(50041, TRUE, TRUE, FacultyFeedbackRec);
                End;
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        FacultyFeedbackRec: Record "Faculty Feedback-CS";
}