page 50594 "Approved College Withdrawal"
{
    // version V.001-CS

    Caption = 'Approved College Withdrawal List';
    CardPageID = "Approved Withdrawal Card";
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = False;
    SourceTable = "Withdrawal Student-CS";
    SourceTableView = WHERE("Type of Withdrawal" = filter("College-Withdrawal"));

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
                field("Student No."; Rec."Student No.")
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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Student Ledger Entries")
            {
                ApplicationArea = All;
                Image = CustomerLedger;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CustomerLedEntries: Record "Cust. Ledger Entry";
                    StudentMasterRec: Record "Student Master-CS";
                begin
                    StudentMasterRec.Get(Rec."Student No.");
                    CustomerLedEntries.FilterGroup(0);
                    CustomerLedEntries.reset();
                    CustomerLedEntries.SetRange("Customer No.", StudentMasterRec."Original Student No.");
                    CustomerLedEntries.SetRange(Semester, StudentMasterRec.Semester);
                    CustomerLedEntries.SetFilter("Enrollment No.", StudentMasterRec."Enrollment No.");
                    if CustomerLedEntries.FindFirst() then begin
                        page.Run(25, CustomerLedEntries);
                        CustomerLedEntries.FilterGroup(2);
                    end;
                end;
            }
        }
    }
    //SD-SN-17-Dec-2020 +
    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;

    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
    end;
    //SD-SN-17-Dec-2020 -
}

