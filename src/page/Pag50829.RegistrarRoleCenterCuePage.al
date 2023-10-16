page 50829 RegistrarRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueRegistrar;
    Caption = 'Registrar Role Center ';

    layout
    {
        area(Content)
        {
            cuegroup("In-Person Registration")
            {
                field("Total Checked-In"; Rec."Total Checked-In")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "On-Ground Check-In List";
                    Visible = false;
                }

                field("Total Checked-Completed"; Rec."Total Checked-Completed")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "On-Ground Check-Completed List";

                }
                field("Total Registrar Signoff"; Rec."Total Registrar Signoff")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Registrar Sign off List";
                    Visible = False;
                }
            }
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

            cuegroup("Pending Applications")
            {
                // field("Total Pending Housing Apps";Rec."Total Pending Housing Apps")
                // {
                //     caption = 'Housing Applications';
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageID = "Housing Application List";
                // }
                // field("Total pndg Housing Waiver Apps";Rec."Total pndg Housing Waiver Apps")
                // {
                //     caption = 'Housing Waiver Applications';
                //     ApplicationArea = Basic, Suite;
                //     DrillDownPageID = "Pending Housing Wavier List";

                // }
                field("Total Pndg Clg Withdrawal Apps"; Rec."Total Pndg Clg Withdrawal Apps")
                {
                    caption = 'College Withdrawal Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pending College Withdrawal";
                }
                field("Total Pndng Course Withwl Apps"; Rec."Total Pndng Course Withwl Apps")
                {
                    Caption = 'Course Withdrawal Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Withdrawal Approvals";//"50855"
                    Visible = false;
                }
                field("SLOA Applicaitons"; Rec."Total SLOA Applicaitons")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Total SLOA Applications';
                    DrillDownPageId = "Pending Leaves Approvals";//50719
                }
                field("ELOA Applications"; Rec."Total ELOA Applications")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Leaves Approvals";//50719
                }
                field("CLOA Applications"; Rec."Total CLOA Applications")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Leaves Approvals";//50719
                    Visible = VisibleBool;
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
                field("CLOA Students"; Rec."CLOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }
                field("ELOA Students"; Rec."ELOA Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }
                field("SLOA Students"; Rec."SLOA Students")
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
            cuegroup("My User Tasks")
            {
                Caption = 'My User Tasks';
                field("UserTaskManagement.GetMyPendingUserTasksCount"; UserTaskManagement.GetMyPendingUserTasksCount)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pending User Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks;
                        UserTaskList.Editable(false);
                        UserTaskList.Run;
                    end;
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
        UserTaskManagement: Codeunit "User Task Management";
        VisibleBool: Boolean;
        CueVisible: Boolean;
}