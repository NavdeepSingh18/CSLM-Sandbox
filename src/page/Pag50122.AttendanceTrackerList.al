page 50122 "Attendance Tracking"
{ //CSPL-00307 T1-T1518
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "User Group Insititute-CS";
    SourceTableView = sorting("Entry No.") order(ascending);
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    Editable = false;
                }
                field("Start DateTime"; Rec."Start DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Start DateTime field.';
                }
                field("Completion DateTime"; Rec."Completion DateTime")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Completion DateTime field.';
                }
                field(Email; Rec.Email)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email field.';
                }
                field("User Name"; Rec."User Name")
                {
                    Editable = false;
                    Caption = 'Name';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Name field.';
                }
                field(Facilitator; Rec.Facilitator)
                {
                    Editable = false;
                    Caption = 'Name of Facilitator';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Facilitator field.';
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.';
                }
                field("Student ID"; Rec."Student ID")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student ID field.';
                }
                field(Semester; Rec.Semester)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Semester field.';
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Academic Year field.';
                }
                field(Term; Rec.Term)
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Term field.';
                }
                field(Activity; Rec.Activity)
                {
                    Editable = false;
                    Caption = 'Type of Activity';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity field.';
                }
                field("Other Activity Name"; Rec."Other Activity Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Other Activity Name field.';
                }
                field("Date of Absence"; Rec."Date of Absence")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date of Absence field.';
                }
                field("Type of Absence"; Rec."Type of Absence")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type of Absence field.';
                }
                field("Total Minutes Tardy"; Rec."Total Minutes Tardy")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Total Minutes Tardy field.';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.';
                }
                field("No. Absences Tardy"; Rec."No. Absences Tardy")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. Absences Tardy field.';
                }
                field("Administrative Comments"; Rec."Administrative Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Administrative Comments field.';
                }

                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Notes field.';
                }

                field("Email Receipt Required"; Rec."Email Receipt Required")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Email Receipt Required field.';
                }
                field("Created By"; Rec."Created By")
                {
                    Visible = False;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created On"; Rec."Created On")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Created On field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction();
    //             begin

    //             end;
    //         }
    //     }
    // }

    var
        UserSetup: Record "User Setup";


    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.Get(UserId);
        IF NOT UserSetup."View Attendance Tracking" Then
            Error('You Do not have permission to View');

        IF NOT UserSetup."Edit Attendance Tracking" Then
            CurrPage.Editable(false);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        UserSetup.Reset();
        UserSetup.Get(UserId);
        IF NOT UserSetup."View Attendance Tracking" Then
            Error('You Do not have permission to View');

        IF NOT UserSetup."Edit Attendance Tracking" Then
            CurrPage.Editable(false);
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.Reset();
        UserSetup.Get(UserId);
        IF NOT UserSetup."Edit Attendance Tracking" Then
            Error('You Do not have permission to Edit');
    end;


}