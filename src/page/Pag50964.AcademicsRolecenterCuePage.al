page 50964 AcademicsRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueRegistrar;
    Caption = 'Academics Role Center ';

    layout
    {
        area(Content)
        {
            cuegroup("Admission")
            {
                field("Total Students"; Rec."Total Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }

                field("Total Courses"; Rec."Total Courses")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Course Detail-CS";
                }
            }

            cuegroup("Status")
            {
                field("Active Students"; Rec."Active Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }

                field("Probation Students"; Rec."Probation Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }
                field("Pending for Graduate Students"; Rec."Pending for Graduate Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }

            }
        }

    }

    trigger OnOpenPage();
    var
        UserSetup: Record "User Setup";
        EducationSetup: Record "Education Setup-CS";
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        UserSetup.Get(UserId());
        //Rec.Reset();
        Rec.setfilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
        if UserSetup."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup."Global Dimension 1 Code") < 6 then begin
                Rec.SetFilter(Rec."Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
                EducationSetup.reset();
                EducationSetup.SetRange(EducationSetup."Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then
                    Rec.SetFilter(Rec."Academic Year Filter", EducationSetup."Academic Year");
            end else begin
                EducationSetup.reset();
                if EducationSetup.FindFirst() then
                    Rec.SetFilter(Rec."Academic Year Filter", EducationSetup."Academic Year");
            end Else begin
            EducationSetup.reset();
            if EducationSetup.FindFirst() then
                Rec.SetFilter(Rec."Academic Year Filter", EducationSetup."Academic Year");
        end;

        if Rec.FindFirst() then;

        UserSetup.Get(UserId());
        if (UserSetup."Global Dimension 1 Code" = '9000') or
        (UserSetup."Global Dimension 1 Code" = '9100|9000') or
        (UserSetup."Global Dimension 1 Code" = '9000|9100') then
            VisibleBool := true
        else
            VisibleBool := false;

        // if (UserSetup."Global Dimension 1 Code" = '9000') then
        //     CueVisible := false
        // else
        //     CueVisible := true;
    end;

    var
        VisibleBool: Boolean;
        CueVisible: Boolean;
}