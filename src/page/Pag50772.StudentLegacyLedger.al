page 50772 "Studen Legacy Ledger"
{
    Caption = 'Student Legacy Ledger';
    Editable = false;
    ModifyAllowed = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Student Legacy Ledger";
    //SourceTableView = sorting("Post Date") order(descending);
    RefreshOnActivate = true;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }

                field("Student Number"; Rec."Student Number")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                field(SyCampusID; Rec.SyCampusID)
                {
                    ApplicationArea = All;
                }
                field(Enrollment; Rec.Enrollment)
                {
                    ApplicationArea = All;
                }
                field(TN; Rec.TN)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Bill Code"; Rec."Bill Code")
                {
                    ApplicationArea = All;
                }
                field("Bill Code Desc"; Rec."Bill Code Desc")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Post Date"; Rec."Post Date")
                {
                    ApplicationArea = All;
                }
                field(Reference; Rec.Reference)
                {
                    ApplicationArea = All;
                }
                field("Receipt #"; Rec."Receipt #")
                {
                    ApplicationArea = All;
                }
                field("Check Date"; Rec."Check Date")
                {
                    ApplicationArea = All;
                }
                field("Check #"; Rec."Check #")
                {
                    ApplicationArea = All;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }
                field("Running Balance"; Rec."Running Balance")
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
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                Field("1098-T Form"; Rec."1098-T Form")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}