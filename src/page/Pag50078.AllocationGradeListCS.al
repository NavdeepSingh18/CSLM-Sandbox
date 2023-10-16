page 50078 "Allocation Grade List-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  12-06-19   Calculate - OnAction()     Code added for Student cut of marks update.
Caption='Allocation Grade List';
    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Grade Cutoff Master-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Subject Type"; Rec."Subject Type")
                {
                    ApplicationArea = All;
                }
                field("Subject Code"; Rec."Subject Code")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                field("Standard Calculation Formula"; Rec."Standard Calculation Formula")
                {
                    ApplicationArea = All;
                }
                field("Revised Value"; Rec."Revised Value")
                {
                    ApplicationArea = All;
                }
                field("Count Std"; Rec."Count Std")
                {
                    ApplicationArea = All;
                }
                field("Count Revised"; Rec."Count Revised")
                {
                    ApplicationArea = All;
                }
                field("Count Std Per"; Rec."Count Std Per")
                {
                    ApplicationArea = All;
                }
                field("Count Revised Per"; Rec."Count Revised Per")
                {
                    ApplicationArea = All;
                }
                field("Type Of Course"; Rec."Type Of Course")
                {
                    ApplicationArea = All;
                }
                field(Year; Rec.Year)
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Standard Value"; Rec."Standard Value")
                {
                    ApplicationArea = All;
                }
                field("Grade Points"; Rec."Grade Points")
                {
                    ApplicationArea = All;
                }
                field("Max Percentage"; Rec."Max Percentage")
                {
                    ApplicationArea = All;
                }
                field("Min Percentage"; Rec."Min Percentage")
                {
                    ApplicationArea = All;
                }
                field("No of Candiates (Core)"; Rec."No of Candiates (Core)")
                {
                    ApplicationArea = All;
                }
                field("No of Candiates ( Elective)"; Rec."No of Candiates ( Elective)")
                {
                    ApplicationArea = All;
                }
                field("Program"; Rec."Program")
                {
                    ApplicationArea = All;
                }
                field("Total Core"; Rec."Total Core")
                {
                    ApplicationArea = All;
                }
                field("Total Elective"; Rec."Total Elective")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
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
            group(Option)
            {
                Caption = 'Option';
                action(Calculate)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    begin
                        //Code added for Student cut of marks update::CSPL-00174::120619: Start
                        IF REc."Subject Type" = 'CORE' THEN
                            REPEAT
                                GradeCutoffMasterCS.Reset();
                                GradeCutoffMasterCS.SETRANGE("Subject Code", Rec."Subject Code");
                                GradeCutoffMasterCS.SETRANGE(Grade, Rec.Grade);
                                GradeCutoffMasterCS.SETRANGE(Semester, REc.Semester);
                                GradeCutoffMasterCS.SETRANGE("Academic Year", Rec."Academic Year");
                                IF GradeCutoffMasterCS.FINDSET() THEN BEGIN
                                    GradeCutoffMasterCS.CALCFIELDS("No of Candiates (Core)");
                                    GradeCutoffMasterCS.CALCFIELDS("Total Core");
                                    IF Rec."Total Core" <> 0 THEN
                                        Rec.Percentage := GradeCutoffMasterCS."No of Candiates (Core)" * 100 / GradeCutoffMasterCS."Total Core";
                                END;
                                Rec.Modify();
                            UNTIL Rec.NEXT() = 0
                        ELSE
                            IF Rec."Subject Type" <> 'CORE' THEN
                                REPEAT
                                    GradeCutoffMasterCS.Reset();
                                    GradeCutoffMasterCS.SETRANGE("Subject Code", Rec."Subject Code");
                                    GradeCutoffMasterCS.SETRANGE(Grade, Rec.Grade);
                                    GradeCutoffMasterCS.SETRANGE(Semester, REc.Semester);
                                    GradeCutoffMasterCS.SETRANGE("Academic Year", Rec."Academic Year");
                                    IF GradeCutoffMasterCS.FINDSET() THEN BEGIN
                                        GradeCutoffMasterCS.CALCFIELDS("No of Candiates ( Elective)");
                                        GradeCutoffMasterCS.CALCFIELDS("Total Elective");
                                        IF Rec."Total Elective" <> 0 THEN
                                            Rec.Percentage := GradeCutoffMasterCS."No of Candiates ( Elective)" * 100 / GradeCutoffMasterCS."Total Elective";
                                    END;
                                    Rec.Modify();
                                UNTIL Rec.NEXT() = 0;

                        //Code added for Student cut of marks update::CSPL-00174::120619: End
                    end;
                }
            }
        }
    }

    var
        GradeCutoffMasterCS: Record "Grade Cutoff Master-CS";
}