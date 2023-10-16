page 50798 "Student Group Line"
{
    Caption = 'Student Group Line';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    PageType = ListPart;
    //PromotedActionCategories = 'New,Process,Navigate';//GMCSCOM
    SourceTable = "Student Group";
    SourceTableView = order(ascending);
    RefreshOnActivate = true;
    UsageCategory = None;
    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Groups Code"; Rec."Groups Code")
                {
                    ApplicationArea = All;


                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                field(Term; Rec.Term)
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
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;

                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;

                }
                field("Modified On"; Rec."Modified On")
                {
                    ApplicationArea = All;

                }
                field("Modified By"; Rec."Modified By")
                {
                    ApplicationArea = All;

                }

                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("OLR Hold Group"; Rec."OLR Hold Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

        }
    }
}