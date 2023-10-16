pageextension 50085 EmployeeList extends "Employee List"
{
    layout
    {
        addafter("Job Title")
        {
            Field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
            field("Faculty Category"; Rec."Faculty Category")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addlast(processing)
        {
            // action("Course Wise Faculty List")
            // {
            //     ApplicationArea = All;
            //     Image = EntriesList;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     RunObject = Page "Faculty-Course Wise";
            //     RunPageLink = "Faculty Code" = FIELD("No.");
            // }
        }
        addafter(PayEmployee)
        {
            action("Employee Email Setup")
            {
                Caption = 'Email Alert Setup';
                ApplicationArea = Basic, Suite;
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                // RunObject = Page "Email Setup Lists";
                // RunPageLink = "Employee No." = field("No.");
            }
            action("Synch to Blackboard")//GAURAV//8.6.2022/////
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
                    WebServicesFunctionsCS.SynchFacultytoBlackboard(Rec);
                end;

            }
        }
    }
}