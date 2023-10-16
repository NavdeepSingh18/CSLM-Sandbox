page 50828 AdmissionRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueAdmission;
    Caption = 'Role Center Admission';

    layout
    {
        area(Content)
        {
            cuegroup("Academic")
            {
                field("Total Students"; Rec."Total Students")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student Details-CS";
                }

                field(Courses; Rec.Courses)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Course Detail-CS";
                }
                field("Portal User List"; Rec."Portal User List")
                {
                    Visible = false;
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Portal Users-CS";//50040
                }
                field("Re-entry Students"; Rec."Re-entry Students")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
                field("Re-admit Students"; Rec."Re-admit Students")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Student Details-CS";//50296
                }
            }
            cuegroup("Pending Housing Applications")
            {
                field("Housing Applications"; Rec."Housing Applications")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Application List";
                }
                field("Housing Waiver App"; Rec."Housing Waiver App")
                {
                    Caption = 'Housing Waiver Applications';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pndg Housing Wavier List";//50911
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
}