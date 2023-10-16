page 50030 "Stud. College Withdrawal List"
{
    // version V.001-CS

    Caption = 'Stud. College Withdrawal List';
    // CardPageID = "Stud. College Withdrawal-CS";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    Editable = False;
    SourceTable = "Withdrawal Student-CS";
    SourceTableView = WHERE("Withdrawal Status" = FILTER(Open | "Pending for Approval"), "Type of Withdrawal" = filter("College-Withdrawal"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
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
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field("Course Name"; Rec."Course Name")
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
                field("Withdrawal date"; Rec."Withdrawal date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Reason for Leaving"; Rec."Reason for Leaving")
                {
                    ApplicationArea = All;
                }
                field("Withdrawal Status"; Rec."Withdrawal Status")
                {
                    ApplicationArea = All;
                }
                field("Type of Withdrawal"; Rec."Type of Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                // field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                // {
                //     ApplicationArea = All;
                // }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                // RunPageLink = "No." = FIELD("Student No.");
            }
            action("Send for Approval")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Send for Approval';
                Visible = False;

                trigger OnAction()
                begin
                    REc.TestField("Withdrawal date");
                    IF CONFIRM(Text001Lbl, FALSE, Rec."No.") THEN BEGIN
                        if Rec.Course = '' then
                            Error('Course must have a value in it');

                        Rec."Withdrawal Status" := Rec."Withdrawal Status"::"Pending for Approval";
                        REc.Modify();
                        Rec.PostStudentWithdrawalApprovalEntries(Rec."Type of Withdrawal");
                        Message(Text002Lbl, Rec."No.");
                    END ELSE
                        exit;
                end;
            }


        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Type of Withdrawal" := Rec."Type of Withdrawal"::"Course-Withdrawal";
    end;

    var
        Text001Lbl: Label 'Do you want to send Application No. %1 for approval?';
        Text002Lbl: Label 'Application No. %1 has been sent for approval.';

}

