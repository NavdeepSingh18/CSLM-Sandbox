page 50380 "Fee Line Discount-CS"
{
    // version V.001-CS

    AutoSplitKey = true;
    DeleteAllowed = true;
    PageType = CardPart;
    SourceTable = "Fee Discount Line-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Course; Rec.Course)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Discount%"; Rec."Discount%")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Parents Income"; Rec."Parents Income")
                {
                    ApplicationArea = All;
                }
                field("Income Discount"; Rec."Income Discount")
                {
                    ApplicationArea = All;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}