page 50730 "Clerkship Grading"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Clerkship Grading";
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
                field("Hospital Category"; Rec."Hospital Category")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Clerkship Type"; Rec."Clerkship Type")
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
                field("Grade Code"; Rec."Grade Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Grade Description"; Rec."Grade Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quality Point"; Rec."Quality Point")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Cut-off Start"; Rec."Cut-off Start")
                {
                    ApplicationArea = All;
                    MaxValue = 100;
                }
                field("Cut-off End"; Rec."Cut-off End")
                {
                    ApplicationArea = All;
                    MaxValue = 100;
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