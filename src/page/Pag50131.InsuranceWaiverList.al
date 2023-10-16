page 50131 "Pending Insurance Waiver List"
{ //CSPL-00307 - Insurance Waiver
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Rank-CS";
    CardPageId = "Insurance Waiver Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Application Date field.';
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student ID field.';
                }
                field("Student No."; Rec."Student No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.';
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Term field.';
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                    Editable = false;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Course field.';
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Institute Code';
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field.';
                    Editable = false;
                }
                field("Policy No."; Rec."Policy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy No. field.';
                    Editable = false;
                }
                field("Member ID"; Rec."Member ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member ID field.';
                    Editable = false;
                }
                field(Carrier; Rec.Carrier)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Carrier field.';
                    Editable = false;
                }
                field("Group Number"; Rec."Group Number")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Group Number field.';
                }
                field("Insurance Valid From"; Rec."Insurance Valid From")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Valid From field.';
                }
                field("Insurance Valid To"; Rec."Insurance Valid To")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Insurance Valid To field.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Approved On"; Rec."Approved On")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved On field.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approved By field.';
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}