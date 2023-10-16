page 50885 RoleCenterExamAICASACuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterExaminationCueTable;
    Caption = 'Role Center';

    layout
    {
        area(Content)
        {
            cuegroup("Exam Cue")
            {
                field("Total Students"; Rec."Total Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";
                }
                field("Total Courses"; Rec."Total Courses")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Course Detail-CS";
                }
                field("Published Internal Exams"; Rec."Published Internal Exams")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Internal Exam Published List";
                }
                field("Published External Exams"; Rec."Published External Exams")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "External Exam Published List";
                }
                // /*                 field("BSIC Student";Rec."BSIC Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AUAShow_gBool;
                //                 }
                //                 field("MED 1 Student";Rec."MED 1 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AUAShow_gBool;
                //                 }
                //                 field("MED 2 Student";Rec."MED 2 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AUAShow_gBool;
                //                 }
                //                 field("MED 3 Student";Rec."MED 3 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AUAShow_gBool;
                //                 }
                //                 field("MED 4 Student";Rec."MED 4 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AUAShow_gBool;
                //                 }
                //                 field("PREMED 1 Student";Rec."PREMED 1 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AICASAShow_gBool;
                //                 }
                //                 field("PREMED 2 Student";Rec."PREMED 2 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AICASAShow_gBool;
                //                 }
                //                 field("PREMED 3 Student";Rec."PREMED 3 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AICASAShow_gBool;
                //                 }
                //                 field("PREMED 4 Student";Rec."PREMED 4 Student")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Student Details-CS";
                //                     Visible = AICASAShow_gBool;
                //                 }
                //                 field("Exam Room";Rec."Exam Room")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Room Detail-CS";
                //                 }
                //                 field("Course Subject";Rec."Course Subject")
                //                 {
                //                     ApplicationArea = Basic, Suite;
                //                     DrillDownPageId = "Stud. Course Subject List-CS";
                //                 } */
            }

        }

    }

    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
        RoleCenterEduCueTable1: Record "RoleCenterEduCueTable";
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        UserSetup.Get(UserId());
        RoleCenterEduCueTable1.Get();
        RoleCenterEduCueTable1."Institute Code" := UserSetup."Global Dimension 1 Code";
        RoleCenterEduCueTable1.Modify();
        if UserSetup."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup."Global Dimension 1 Code") < 6 then
                Rec.SetFilter("Institute Code", '%1', Format(UserSetup."Global Dimension 1 Code"));

        AICASAShow_gBool := false;
        IF StrPos(UserSetup."Global Dimension 1 Code", '9100') <> 0 then
            AICASAShow_gBool := true;

        AUAShow_gBool := false;
        IF StrPos(UserSetup."Global Dimension 1 Code", '9000') <> 0 then
            AUAShow_gBool := true;
    end;

    var
        AICASAShow_gBool: Boolean;
        AUAShow_gBool: Boolean;
}