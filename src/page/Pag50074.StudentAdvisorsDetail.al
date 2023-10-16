page 50074 "Student Advisor Detail"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Advisor Details";
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field("Advisor No."; Rec."Advisor No.")
                {
                    ApplicationArea = All;
                }
                field("Advisor Name"; Rec."Advisor Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(StudentAdvisorDetails)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = XMLFileGroup;
                trigger OnAction();
                var
                    StudentAdvisorDetails: XmlPort "Student Advisor Details";
                begin
                    StudentAdvisorDetails.Run();
                end;
            }
        }
    }
}