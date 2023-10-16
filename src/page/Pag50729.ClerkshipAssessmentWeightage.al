page 50729 "Clerkship Assessment Weightage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Clerkship Assessment Weightage";
    DelayedInsert = true;

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
                field("Course Credit"; Rec."Course Credit")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
                field("Clerkship Assessment Weightage"; Rec."Clerkship Assessment Weightage")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("CCSSE Weightage"; Rec."CCSSE Weightage")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Clerkship Grading")
            {
                Caption = 'Clerkship Grading';
                ApplicationArea = All;
                Image = AbsenceCategories;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    ClerkshipGrading: Record "Clerkship Grading";
                begin
                    ClerkshipGrading.Reset();
                    ClerkshipGrading.FilterGroup(2);
                    ClerkshipGrading.SetRange("Course Code", Rec."Course Code");
                    ClerkshipGrading.FilterGroup(0);
                    Page.RunModal(Page::"Clerkship Grading", ClerkshipGrading);
                end;
            }
            action("CCSSE Score Conversion")
            {
                Caption = 'CCSSE Score Conversion';
                ApplicationArea = All;
                Image = AbsenceCategories;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    CCSSEScoreConversion: Record "CCSSE Score Conversion";
                begin
                    CCSSEScoreConversion.Reset();
                    CCSSEScoreConversion.FilterGroup(2);
                    CCSSEScoreConversion.SetRange("Course Code", Rec."Course Code");
                    CCSSEScoreConversion.FilterGroup(0);
                    Page.RunModal(Page::"CCSSE Score Conversion", CCSSEScoreConversion);
                end;
            }
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