page 50465 "Payment Plan"
{

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Cust. Ledger Entry";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(Contents)
            {
                field("Due Date From"; DueDateFrom)
                {
                    Caption = 'Due Date From';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;

                }
                field("Due Date To"; DueDateTo)
                {
                    Caption = 'Due Date To';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;

                }
                field(PendingInstallment; PendingInstallment)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Installments';
                }
                field("Posting Date From"; PostingDateFrom)
                {
                    Caption = 'Posting Date From';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;
                }
                field("Posting Date To"; PostingDateTo)
                {
                    Caption = 'Posting Date To';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;
                }

                field("Student No."; StudentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Student No.';
                    TableRelation = Customer."No.";
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;

                }
                field("Enrolment No."; EnrolmentNo)
                {
                    ApplicationArea = All;
                    Caption = 'Enrollment No.';
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        StudentMasterCS.Reset();
                        if StudentNo <> '' then
                            StudentMasterCS.SetRange("Original Student No.", StudentNo);
                        StudentMasterCS.findset();
                        IF PAGE.RUNMODAL(0, StudentMasterCS) = ACTION::LookupOK THEN
                            EnrolmentNo := StudentMasterCS."Enrollment No.";
                    end;

                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;
                }
                field("Global Dimension 1 Code1"; GlobalDimension1Code)
                {
                    Caption = 'Global Dimension 1 Code';
                    ApplicationArea = All;
                    CaptionClass = '1,1,1';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;
                }
                field("Global Dimension 2 Code1"; GlobalDimension2Code)
                {
                    Caption = 'Global Dimension 2 Code';
                    ApplicationArea = All;
                    CaptionClass = '1,1,2';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(2), Code = filter('9300|9500'));
                    trigger OnValidate()
                    begin
                        Rec.Reset();
                    end;
                }

            }
            repeater(Group)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; CustomerName)
                {
                    ApplicationArea = All;
                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Plan Instalment"; Rec."Payment Plan Instalment")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; DepartmentName)
                {
                    Caption = 'Department Name';
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
            action("Apply Filter")
            {
                ApplicationArea = All;
                Caption = 'Apply Filter';
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var

                begin
                    ApplyFilter();
                end;
            }
            action("Clear Filters")
            {
                ApplicationArea = All;
                Caption = 'Clear Filters';
                Image = ShowMatrix;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    DueDateFrom := 0D;
                    DueDateTo := 0D;
                    GlobalDimension1Code := '';
                    GlobalDimension2Code := '';
                    PostingDateFrom := 0D;
                    PostingDateTo := 0D;
                    StudentNo := '';
                    EnrolmentNo := '';
                    // Reset();
                    Rec.FilterGroup(2);
                    Rec.SetRange("Customer No.", StudentNo);
                    Rec.FilterGroup(0);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        PendingInstallment := true;
        DueDateFrom := 0D;
        DueDateTo := 0D;
        GlobalDimension1Code := '';
        GlobalDimension2Code := '';
        PostingDateFrom := 0D;
        PostingDateTo := 0D;
        StudentNo := '';
        EnrolmentNo := '';
        // if StudentNo = '' then;
        Rec.SetRange("Customer No.", StudentNo);
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(DepartmentName);
        DimensionValue.Reset();
        DimensionValue.SetRange(Code, Rec."Global Dimension 2 Code");
        if DimensionValue.FindFirst() then
            DepartmentName := DimensionValue.Name;

        Clear(CustomerName);
        StudentMasterCS.Reset();
        StudentMasterCS.SetRange("Original Student No.", Rec."Customer No.");
        if StudentMasterCS.FindFirst() then
            CustomerName := StudentMasterCS."Student Name";

    end;

    var
        StudentMasterCS: Record "Student Master-CS";
        DueDateFrom: Date;
        DueDateTo: Date;
        PostingDateFrom: Date;
        PostingDateTo: Date;

        StudentNo: Code[20];
        EnrolmentNo: Code[20];
        GlobalDimension1Code: Code[20];
        GlobalDimension2Code: Code[20];

        DepartmentName: Text[100];
        DimensionValue: Record "Dimension Value";
        CustomerName: Text[100];
        PendingInstallment: Boolean;

    procedure ApplyFilter()
    begin

        //Reset();
        Rec.FilterGroup(2);
        if (DueDateFrom <> 0D) and (DueDateTo <> 0D) then
            Rec.SetRange("Due Date", DueDateFrom, DueDateTo);
        if GlobalDimension1Code <> '' then
            Rec.SetFilter("Global Dimension 1 Code", GlobalDimension1Code);
        if GlobalDimension2Code <> '' then
            Rec.SetFilter("Global Dimension 2 Code", GlobalDimension2Code);
        if (PostingDateFrom <> 0D) and (PostingDateTo <> 0D) then
            Rec.SetRange("Posting Date", PostingDateFrom, PostingDateTo);
        if StudentNo <> '' then
            Rec.SetFilter("Customer No.", StudentNo);
        if PendingInstallment then
            Rec.SetFilter("Remaining Amount", '<>%1', 0);
        if EnrolmentNo <> '' then
            Rec.SetFilter("Enrollment No.", EnrolmentNo);

        Rec.SetRange("Payment Plan Applied", true);

        Rec.FilterGroup(0);
    end;
}