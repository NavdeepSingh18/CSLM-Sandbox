pageextension 50086 EmployeeCard extends "Employee Card"
{
    layout
    {
        addafter("No.")
        {
            Field(Title; Rec.Title)
            {
                ApplicationArea = All;
            }
        }
        addafter("Company E-Mail")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Designation Code"; Rec."Designation Code")
            {
                ApplicationArea = All;
            }
            field("Employee Group"; Rec."Employee Group")
            {
                ApplicationArea = All;
            }
            field("Faculty Category"; Rec."Faculty Category")
            {
                ApplicationArea = All;
            }
            field(Department; Rec.Department)
            {
                ApplicationArea = All;
            }
            Field("Clinical Chair"; Rec."Clinical Chair")
            {
                ApplicationArea = All;
            }
            Field("Cancel Class Allowed"; Rec."Cancel Class Allowed")
            {
                ApplicationArea = All;
            }
            Field("Reschedule Class Allowed"; Rec."Reschedule Class Allowed")
            {
                ApplicationArea = All;
            }
            Field("Delete Class Allowed"; Rec."Delete Class Allowed")
            {
                ApplicationArea = all;
            }
            Field("Azure Service Link"; Rec."Azure Service Link")
            {
                ApplicationArea = All;
            }
            Field("Blackboard Synch Status"; Rec."Blackboard Synch Status")//GAURAV//8.6.22//START
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Synch to Blackboard"; Rec."Synch to Blackboard")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    IF Rec."Synch to Blackboard" then
                        Rec."Blackboard Synch Status" := Rec."Blackboard Synch Status"::Pending
                    else
                        Rec."Blackboard Synch Status" := Rec."Blackboard Synch Status"::" ";//END//
                end;
            }
        }

        addafter("Privacy Blocked")
        {

            field("Administrative Assistant"; Rec."Administrative Assistant")
            {
                ToolTip = 'Specifies the value of the Administrative Assistant field';
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
            //     PromotedOnly = true;
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
        }
    }
}