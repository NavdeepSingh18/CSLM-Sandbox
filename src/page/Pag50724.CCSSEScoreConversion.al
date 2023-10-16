page 50724 "CCSSE Score Conversion"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CCSSE Score Conversion";
    DelayedInsert = true;
    //MultipleNewLines = true;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Effective Date"; Rec."Effective Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Score Value"; Rec."Score Value")
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
            action(Copy)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Message('Copying');
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        EducationSetup: Record "Education Setup-CS";
    begin
        EducationSetup.Reset();
        EducationSetup.SetRange("Global Dimension 1 Code", '9000');
        if EducationSetup.FindFirst() then
            Rec.SetFilter("Group Filter", EducationSetup."Core Subject Group Code");
    end;
}