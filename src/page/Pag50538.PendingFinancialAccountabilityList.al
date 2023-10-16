page 50538 "Pending Financial Account"
{

    PageType = List;
    SourceTable = "Financial Accountability";
    Caption = 'Pending Financial Accountability List';
    ApplicationArea = All;
    UsageCategory = Lists;
    // CardPageId = "Financial Accountability";
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    SourceTableView = sorting("Fine Application No.")
                      order(ascending) where(Status = filter("Pending for Approval"));
    Editable = False;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Fine Application No."; Rec."Fine Application No.")
                {
                    ApplicationArea = All;
                }
                field("Fine Date"; Rec."Fine Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Code"; Rec."Fine Category Code")
                {
                    ApplicationArea = All;
                }
                field("Fine Category Description"; Rec."Fine Category Description")
                {
                    ApplicationArea = All;
                }
                field("Applicable Amount"; Rec."Applicable Amount")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                    visible = Boolean_gBool;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
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
        }
    }

    var
        Boolean_gBool: Boolean;

    trigger OnAfterGetRecord()
    begin
        Boolean_gBool := true;
        If Rec.Status = Rec.Status::Open then begin
            Boolean_gBool := false;
        end;


    end;

    trigger OnOpenPage()
    var
        StudentsInfoCSCSLM: codeunit StudentsInfoCSCSLM;
    begin
        Boolean_gBool := true;
        If Rec.Status = Rec.Status::Open then begin
            Boolean_gBool := false;
        end;
        //SD-SN-17-Dec-2020 +
        Rec.FilterGroup(2);
        Rec.SetFilter("Global Dimension 1 Code", StudentsInfoCSCSLM.GetuserSetupInstitudeCode());
        Rec.FilterGroup(0);
        //SD-SN-17-Dec-2020 -
    end;

    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        PendingDays := Today() - Rec."Fine Date";
        Exit(PendingDays);
    end;



}
