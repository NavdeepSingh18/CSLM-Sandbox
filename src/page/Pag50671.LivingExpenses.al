page 50671 "Living Expense"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Living Expense Header";
    Caption = 'Living Expense';
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                    Editable = false;
                }
                field("Student ID"; Rec."Student ID")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    Editable = false;
                }
            }
            // group("GRP0001")
            // {
            //     Caption = 'Posted Details';
            part("Posted Details"; "Living Expense Posted Details")
            {
                ApplicationArea = All;
                //Editable = false;
                SubPageLink = "Document No." = field("No.");
            }
            part("Posting Entries"; "Living Expense Posting Entries")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(Factboxes)
        {
            part(Information; "Living Expenses FactBox")
            {
                ApplicationArea = All;
                Caption = 'Information';
                SubPageLink = "No." = field("Student ID");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Post Application Entries")
            {
                ApplicationArea = All;
                Caption = 'Post Application Entries';
                ShortcutKey = 'Alt+A';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostApplication;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    if not Confirm('Do you want to Post the Application?') then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student ID") then;

                    Rec.PostApplication(StudentMaster, Rec."No.", false);
                end;
            }
            action("Post Seat Deposit Entry")
            {
                ApplicationArea = All;
                Caption = 'Post Seat Deposit Entry';
                ShortcutKey = 'Alt+D';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostDocument;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    if not Confirm('Do you want to Post the Seat Deposit Entry?') then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student ID") then;

                    Rec.InitialiseSeatDepositRefundPostingEntry(StudentMaster, false, Rec."No.");
                end;
            }

            action("Post Housing Transfer Entries")
            {
                ApplicationArea = All;
                Caption = 'Post Housing Transfer Entries';
                ShortcutKey = 'Alt+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostBatch;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    if not Confirm('Do you want to Post the GV Tranfer Entries?') then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student ID") then;

                    Rec.InitialiseGVTransferRefundPostingEntry(StudentMaster, false, Rec."No.");
                end;
            }
            action("Post T4 Stipend Payment")
            {
                ApplicationArea = All;
                Caption = 'Post T4 Stipend Payment';
                ShortcutKey = 'Alt+F';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostBatch;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    if not Confirm('Do you want to Post the T4 Stipend Payment Entry ?') then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student ID") then;

                    Rec.InitialiseT4RefundPostingEntry(StudentMaster, false, Rec."No.");
                end;
            }

            action("Post Student Payment Refund")
            {
                ApplicationArea = All;
                Caption = 'Post Student Payment Refund';
                ShortcutKey = 'Alt+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostBatch;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                begin
                    if not Confirm('Do you want to Post the Student Payment Refund Entry ?') then
                        exit;

                    StudentMaster.Reset();
                    if StudentMaster.Get(Rec."Student ID") then;

                    Rec.InitialiseStudentPaymentRefundPostingEntry(StudentMaster, false, Rec."No.");
                end;
            }
            action("Delete")
            {
                ApplicationArea = All;
                Caption = 'Delete';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostBatch;
                Visible = DelButton;
                trigger OnAction();
                var
                    LivingExpenseLine: Record "Living Expense Line";
                begin
                    if not Confirm('Do you want to Delete Entry?') then
                        exit;

                    // LivingExpenseLine.Reset();
                    // LivingExpenseLine.SetCurrentKey("Student ID");
                    // LivingExpenseLine.SetRange("Document No.", "No.");
                    // LivingExpenseLine.SetRange("View Part", LivingExpenseLine."View Part"::"Application Entries");
                    // LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::Approved);
                    // if LivingExpenseLine.FindFirst() then
                    //     Error('Delete not allowed as some Approved Entries Exist.');

                    LivingExpenseLine.Reset();
                    LivingExpenseLine.SetCurrentKey("Student ID");
                    LivingExpenseLine.SetRange("Document No.", Rec."No.");
                    if LivingExpenseLine.FindSet() then
                        LivingExpenseLine.DeleteAll();
                end;
            }
        }
    }

    var
        DelButton: Boolean;

    trigger OnOpenPage()
    begin
        DelButton := false;
        if UserId() = 'CSPL\CORP3' then
            DelButton := true;
    end;
}