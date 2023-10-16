page 50642 "FAid Roster Approved/Rejected"
{

    PageType = List;
    SourceTable = "Financial Aid Roster";
    Caption = 'Financial Aid Roster Approved/Rejected List';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Approved | Rejected));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Fund Type"; Rec."Fund Type")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Uploaded Amount"; Rec."Uploaded Amount")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Rejection Remarks"; Rec."Rejection Remarks")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
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
            action("Fee Generation")
            {
                ApplicationArea = All;
                Caption = 'Fee Generation';
                Image = Report;
                RunObject = report "Fee Generation New";
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;

            }
            action("Payment Journal")
            {
                ApplicationArea = All;
                Caption = 'Payment Journal';
                RunObject = Page "Payment Journal";
                Image = ViewPage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
            }
            action("General Journal")
            {
                ApplicationArea = All;
                Caption = 'General Journal';
                RunObject = Page "General Journal";
                Image = ViewPage;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
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