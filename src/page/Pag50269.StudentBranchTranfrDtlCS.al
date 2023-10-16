page 50269 "Student Branch Tranfr Dtl-CS"
{
    // version V.001-CS
    Caption = 'Student Transfer Detail';
    //CardPageID = "Branch Transfer Student-CS";
    PageType = List;
    SourceTable = "Branch Transfer-CS";
    SourceTableView = WHERE("Branch Transfered" = CONST(false));
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    Caption = 'Old Course Code';
                    Editable = false;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                    Caption = 'Old Year';
                    Editable = false;
                    Enabled = true;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                    Caption = 'Old Semester';
                    Editable = false;
                    Enabled = true;
                    //TableRelation = "Co-Curricular Activities-CS".Field1000;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    Caption = 'Old Section';
                    Editable = false;
                    Enabled = true;
                }
                field("Old Category"; Rec."Old Category")
                {
                    ApplicationArea = All;
                }
                field("Old Sub-Category"; Rec."Old Sub-Category")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Transfer To Course"; Rec."Transfer To Course")
                {
                    ApplicationArea = All;
                }
                field("Transfer To Section"; Rec."Transfer To Section")
                {
                    ApplicationArea = All;
                }
                field("Transfer To Semester"; Rec."Transfer To Semester")
                {
                    ApplicationArea = All;
                }
                field("Transfer To Year"; Rec."Transfer To Year")
                {
                    ApplicationArea = All;
                }
                field("Transfer to Category"; Rec."Transfer to Category")
                {
                    ApplicationArea = All;
                }
                field("Transfer to Sub-Category"; Rec."Transfer to Sub-Category")
                {
                    ApplicationArea = All;
                }
                field("Transfer to Institute"; Rec."Transfer to Institute")
                {
                    Caption = 'Transfer to Institute';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transfer to Department"; Rec."Transfer to Department")
                {
                    Caption = 'Transfer to Department';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}

