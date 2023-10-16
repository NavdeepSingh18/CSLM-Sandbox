page 50041 AttendanceRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueDeans;
    Caption = 'Attendance Role Center ';

    layout
    {
        area(Content)
        {
            cuegroup("Admission Cue")
            {
                field("Total Students"; Rec."Total Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("Total Course"; Rec."Total Course")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Course Detail-CS";//50291
                }
            }
            cuegroup("Pending Applications Cue")
            {
                field("Course Withdrawal Apps"; Rec."Course Withdrawal Apps")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pending Withdrawal Approvals";//50592
                    Visible = false;
                }

                // field("ELOA Applications"; Rec."ELOA Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageId = "Pending Leaves Approvals"; //50719
                // }
                // field("CLOA Applications"; Rec."CLOA Applications")
                // {
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageId = "Pending Leaves Approvals"; //50719
                // }
                // field("College Withdrawal Apps"; Rec."College Withdrawal Apps")
                // {
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageID = "Pending College Withdrawal";//50858
                // }
            }

            cuegroup("Status Cue")
            {
                field("Active Students"; Rec."Active Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("Probation Students"; Rec."Probation Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("CLOA Students"; Rec."CLOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("ELOA Students"; Rec."ELOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Student Details-CS";//50296
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
                Rec.SetFilter("Global Dimension 1 Filter", Format(UserSetup."Global Dimension 1 Code"));
                EducationSetup.reset();
                EducationSetup.SetRange(EducationSetup."Global Dimension 1 Code", UserSetup."Global Dimension 1 Code");
                if EducationSetup.FindFirst() then
                    Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
            end else begin
                EducationSetup.reset();
                if EducationSetup.FindFirst() then
                    Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
            end Else begin
            EducationSetup.reset();
            if EducationSetup.FindFirst() then
                Rec.SetFilter("Academic Year Filter", EducationSetup."Academic Year");
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