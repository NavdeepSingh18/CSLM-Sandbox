page 50907 GraduationRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueGraduation;
    Caption = 'Role Center Graduation';

    layout
    {
        area(Content)
        {
            cuegroup("Graduate Affairs Statistics")
            {
                field("Eligible Student List"; Rec."Eligible Student List")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("Total Degree List"; Rec."Total Degree List")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Degree Detail-CS";//50157
                }
                field("Assigned Task List"; Rec."Assigned Task List")
                {
                    ApplicationArea = Basic, Suite;
                    // DrillDownPageID = ;
                }
            }
            cuegroup("Pending Applications")
            {
                field("Degree Audit Count"; Rec."Degree Audit")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Degree Audit list";//50893
                }
                field("Degree/Transcript Printing Req."; Rec."Pdng Transcript Printing Req.")
                {
                    caption = 'Degree/Transcript Printing Request';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Certificates Application-CS";//50072
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
                        UserTaskList.Editable(False);
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
    end;

    var
        UserTaskManagement: Codeunit "User Task Management";
}