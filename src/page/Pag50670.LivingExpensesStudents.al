page 50670 "Living Expenses Students"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Student Master-CS";
    SourceTableView = where("Financial Aid Approved" = filter(true));
    Editable = true;
    //CardPageId = "Student Detail Card-CS";
    InsertAllowed = false;
    //ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("T4 Authorization"; Rec."T4 Authorization")
                {
                    Caption = 'T4 Authorization';
                    ApplicationArea = All;
                }
                field("Financial Aid Approved"; Rec."Financial Aid Approved")
                {
                    Caption = 'Financial Aid Approved';
                    ApplicationArea = All;
                    // Editable = false;
                    // Visible = false;
                }
            }
        }
        area(Factboxes)
        {
            part(Information; "Living Expenses FactBox")
            {
                ApplicationArea = All;
                Caption = 'Information';
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Entries")
            {
                ApplicationArea = All;
                Caption = 'Create and View Entries';
                ShortcutKey = 'Ctrl+R';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ViewCheck;
                trigger OnAction();
                var
                    LivingExpenseHeader: Record "Living Expense Header";
                    LNo: Code[20];
                begin
                    LNo := '';
                    LivingExpenseHeader.InsertLivingExpsHeader(Rec, LNo);
                    LivingExpenseHeader.InsertLivingExpsDetails(Rec, LNo, false);
                    LivingExpenseHeader.Reset();
                    LivingExpenseHeader.FilterGroup(2);
                    LivingExpenseHeader.SetRange("Student ID", Rec."No.");
                    LivingExpenseHeader.SetRange("No.", LNo);
                    LivingExpenseHeader.FilterGroup(0);
                    Page.Run(Page::"Living Expense", LivingExpenseHeader);
                end;
            }
            action("Create Entries Bulk")
            {
                ApplicationArea = All;
                Caption = 'Create Entries Bulk';
                ShortcutKey = 'Ctrl+S';
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = SaveasStandardJournal;
                trigger OnAction();
                var
                    StudentMaster: Record "Student Master-CS";
                    LivingExpenseHeader: Record "Living Expense Header";
                    T: Integer;
                    C: Integer;
                    W: Dialog;
                    Text001Lbl: Label 'Students In Progress....      ##################1################\';
                    LNo: Code[20];
                begin
                    T := 0;
                    C := 0;
                    StudentMaster.Reset();
                    CurrPage.SetSelectionFilter(StudentMaster);
                    T := StudentMaster.Count;

                    if not Confirm('You have Selected %1 Students.\\\\Do you want to create Entries for Selected Students?', true, T) then
                        exit;

                    W.Open('Creating Entries\' + Text001Lbl);

                    if StudentMaster.Findset() then
                        repeat
                            C := C + 1;
                            LNo := '';
                            LivingExpenseHeader.InsertLivingExpsHeader(StudentMaster, LNo);
                            LivingExpenseHeader.InsertLivingExpsDetails(StudentMaster, LNo, false);
                        until StudentMaster.Next() = 0;

                    Message('Process of Entry Creation is Completed Successfully.');
                end;

            }
            action("Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Ledger E&ntries';
                Image = CustomerLedger;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F7';
                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    CustomerLedgerEntries: Page "Customer Ledger Entries";
                begin
                    CLE.Reset();
                    CLE.SetCurrentKey("Customer No.");
                    CLE.FilterGroup(2);
                    CLE.SetRange("Customer No.", Rec."No.");
                    CLE.FilterGroup(0);
                    CustomerLedgerEntries.Editable := false;
                    CustomerLedgerEntries.SetTableView(CLE);
                    CustomerLedgerEntries.RunModal();
                end;
            }

            action("Student Card")
            {
                ApplicationArea = All;
                Caption = 'Student Card';
                Image = Card;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F5';
                trigger OnAction()
                var
                    StudentMaster: Record "Student Master-CS";
                    StudentDetailCard: Page "Student Detail Card-CS";
                begin
                    StudentMaster.Reset();
                    StudentMaster.FilterGroup(2);
                    StudentMaster.SetRange("No.", Rec."No.");
                    StudentMaster.FilterGroup(0);
                    StudentDetailCard.SetTableView(StudentMaster);
                    StudentDetailCard.Editable(false);
                    StudentDetailCard.RunModal();
                end;
            }
            action("Delete All")
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
                    LivingExpenseHeader: Record "Living Expense Header";
                    LivingExpenseLine: Record "Living Expense Line";
                begin
                    if not Confirm('Do you want to Delete Entry?') then
                        exit;

                    LivingExpenseHeader.Reset();
                    if LivingExpenseHeader.FindSet() then
                        repeat
                            LivingExpenseLine.Reset();
                            LivingExpenseLine.SetCurrentKey("Student ID", "Document No.");
                            LivingExpenseLine.SetRange("Document No.", LivingExpenseHeader."No.");
                            LivingExpenseLine.SetRange(Status, LivingExpenseLine.Status::Approved);
                            if not LivingExpenseLine.FindFirst() then
                                LivingExpenseHeader.Delete(True);
                        until LivingExpenseHeader.Next() = 0;
                end;
            }
        }
    }
    var
        DelButton: Boolean;

    trigger OnOpenPage()
    begin
        DelButton := false;
        if UserId = 'CSPL\CORP3' then
            DelButton := true;
    end;
}