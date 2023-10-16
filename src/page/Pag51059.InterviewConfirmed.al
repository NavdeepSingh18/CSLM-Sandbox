page 51059 "Interview Confirmed"
{

    ApplicationArea = All;
    Caption = 'Interview Confirmation List';
    PageType = List;
    Editable = false;
    CardPageId = "Interview Confirmed Card";
    SourceTable = "Medical Scholar Program";
    UsageCategory = Lists;
    SourceTableView = where("Application Status" = filter("Interview Confirmed"));
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application Status"; Rec."Application Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field("First Time Applicant"; Rec."First Time Applicant")
                {
                    ApplicationArea = All;
                }
                field("Previously Medical Scholar"; Rec."Previously Medical Scholar")
                {
                    ApplicationArea = All;
                }
                field("Previous Role 1"; Rec."Previous Role 1")
                {
                    ApplicationArea = All;
                }
                field("Previous Role 2"; Rec."Previous Role 2")
                {
                    ApplicationArea = All;
                }
                field("Role Applying"; Rec."Role Applying")
                {
                    ApplicationArea = All;
                }
                field("Reference 1"; Rec."Reference 1")
                {
                    ApplicationArea = All;
                }
                field("Reference 2"; Rec."Reference 2")
                {
                    ApplicationArea = All;
                }
                field(Questions_comments; Rec.Questions_comments)
                {
                    ApplicationArea = All;
                }
                field("Interested in being lead"; Rec."Interested in being lead")
                {
                    ApplicationArea = All;
                }
                field("List of SO and affiliations"; Rec."List of SO and affiliations")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {

        area(Processing)
        {
            action(Selected)
            {
                // Visible = InterviewPage;
                ApplicationArea = All;
                Image = Approval;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    RecHead.Get(Rec."Application No");
                    RecHead.TestField("Role Offered New");
                    RecHead.Validate("Application Status", Rec."Application Status"::Selected);
                    RecHead.Modify();
                    IF RecHead."Interested in being lead" then
                        // LeadSelectedMail()//GMCSCOM
                        //else
                        //RegularSelectedMail();//GMCSCOM
                        Message('Document %1 is Selected', RecHead."Application No");
                    CurrPage.Update();
                end;
            }
            action("Not Selected")
            {
                // Visible = InterviewPage;
                ApplicationArea = All;
                Image = Reject;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecHead: Record "Medical Scholar Program";
                begin
                    RecHead.Get(Rec."Application No");
                    RecHead.Validate("Application Status", Rec."Application Status"::NotSelected);
                    RecHead.Modify();
                    Message('Document %1 is Not Selected', RecHead."Application No");
                    CurrPage.Update();
                end;
            }
        }
    }

}
