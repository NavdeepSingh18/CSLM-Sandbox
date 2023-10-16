page 51060 NotSelected
{

    ApplicationArea = All;
    Caption = 'Suspended/ Rejected Medical Scholar Program List';
    PageType = List;
    Editable = false;
    SourceTable = "Medical Scholar Program";
    UsageCategory = Lists;
    SourceTableView = where("Application Status" = filter(NotSelected | Suspended | Rejected));

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

}
