page 50166 "Semester Detail-CS"
{
    // version V.001-CS

    Caption = 'Semester List';
    //Editable = false;
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Semester Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
                field(Graduation; Rec.Graduation)
                {
                    ApplicationArea = All;
                }
                field("Temporary Grade"; Rec."Temporary Grade")
                {
                    ApplicationArea = all;
                }
                field("Total Weightage"; Rec."Total Weightage")
                {
                    ApplicationArea = all;
                }
                field("Internal Total Weightage"; Rec."Internal Total Weightage")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Start Date Not Applicable"; Rec."Start Date Not Applicable")
                {
                    ApplicationArea = All;
                }
                field("Type Of Repeat"; Rec."Type Of Repeat")
                {
                    ApplicationArea = All;
                }
                field("Immigration Applicable"; Rec."Immigration Applicable")
                {
                    ApplicationArea = All;
                }
                field("OLR Applicable"; Rec."OLR Applicable")
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Show Cue in Exam RoleCenter "; Rec."Show Cue in Exam RoleCenter ")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
        }
    }
}

