page 50797 "Student Group Code"
{
    Caption = 'Student Group';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    SourceTable = "Student Group";
    // SourceTableView = order(ascending);
    RefreshOnActivate = true;
    ApplicationArea = all;
    UsageCategory = Lists;
    SourceTableView = order(ascending) WHERE("Hold Exists" = CONST(false), Blocked = CONST(false));


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
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                field("Groups Code"; Rec."Groups Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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