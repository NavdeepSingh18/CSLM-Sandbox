page 50512 "Recommendation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Recommendations";
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(Entry)
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                Field("Academic SAP"; Rec."Academic SAP")
                {
                    ApplicationArea = All;
                }
                field("Min. Percentage"; Rec."Min. Percentage")
                {
                    ApplicationArea = All;
                }
                field("Max Percentage"; Rec."Max Percentage")
                {
                    ApplicationArea = All;
                }
                field("Range Percentage"; Rec."Range Percentage")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Min Percentage")
                {
                    ApplicationArea = All;
                }

                field(Repeating; Rec.Repeating)
                {
                    ToolTip = 'Specifies the value of the Repeating field.';
                    ApplicationArea = All;
                }
                field("CBSE Min"; Rec."CBSE Min")
                {
                    ToolTip = 'Specifies the value of the CBSE Min field.';
                    ApplicationArea = All;
                }
                field("CBSE Max"; Rec."CBSE Max")
                {
                    ToolTip = 'Specifies the value of the CBSE Max field.';
                    ApplicationArea = All;
                }
                field(Recommendation; Rec.Recommendation)
                {
                    ApplicationArea = All;
                }
                field(Communications; Rec.Communications)
                {
                    ToolTip = 'Specifies the value of the Communications field.';
                    ApplicationArea = All;
                }

            }
        }
        area(Factboxes)
        {

        }
    }
}