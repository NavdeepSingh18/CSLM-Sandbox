page 50889 RoleCenterGradAffairsCuePage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterGraduateAffairsCue;
    Caption = 'Role Center';
    layout
    {
        area(Content)
        {
            Cuegroup("Graduate Affairs Statistics")
            {
                field("Total Matched Students"; Rec."Total Matched Students")
                {
                    ApplicationArea = Basic, Suite;
                    //DrillDownPageID = "Student Residency Status List";//50805
                    trigger OnDrillDown()
                    var
                        StudentResidencyStatusList: Page "Residency List";//
                        StudentResidencyStatusRec: Record Residency;
                    begin
                        StudentResidencyStatusRec.reset();
                        StudentResidencyStatusRec.SetRange(StudentResidencyStatusRec."Residency Status", 'MATCHED');
                        if StudentResidencyStatusRec.findset then begin
                            StudentResidencyStatusList.SETTABLEVIEW(StudentResidencyStatusRec);
                            StudentResidencyStatusList.SETRECORD(StudentResidencyStatusRec);
                            StudentResidencyStatusList.RUN;
                        end
                    end;
                }
                field("Completed MSPE Apps"; Rec."Completed MSPE Apps")
                {
                    caption = 'MSPE Applications';
                    DrillDownPageId = "Completed MSPE App List";//50918
                    ApplicationArea = Basic, Suite;
                }
            }
            cuegroup("Pending Applications")
            {
                field("MSPE Applications"; Rec."MSPE Applications")
                {
                    DrillDownPageId = "Pending MSPE Application List";//50807
                    ApplicationArea = Basic, Suite;
                }
                field("In-Review MSPE Apps"; Rec."In-Review MSPE Apps")
                {
                    DrillDownPageId = "In-Review MSPE App List";//50809
                    ApplicationArea = Basic, Suite;
                }
                field("Review Req MSPE Apps"; Rec."Review Req MSPE Apps")
                {
                    DrillDownPageId = "Review Required MSPE App List";//50917
                    ApplicationArea = Basic, Suite;
                }
                field("Licensing Request Form"; Rec."Licensing Request Form")
                {
                    caption = 'Post-Graduate Request Form';
                    // DrillDownPageId = ;
                    ApplicationArea = Basic, Suite;
                }
                field("Transcript Request List"; Rec."Transcript Request List")
                {
                    Caption = 'Transcript Request List';
                    // DrillDownPageId = ;
                    ApplicationArea = Basic, Suite;
                }

            }
        }
    }

    trigger OnOpenPage();
    var
        UserSetup_lRec: Record "User Setup";
        RolecenterGraduateAffairsCue_lRec: Record RoleCenterGraduateAffairsCue;
        StudentResidencyStatusList_lRrec: Record Residency;
        MSPE_lRec: Record MSPE;
    begin
        Rec.RESET();
        if Rec.FindSet() then
            Rec.Deleteall();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
        UserSetup_lRec.Get(UserId());
        RolecenterGraduateAffairsCue_lRec.Get();
        RolecenterGraduateAffairsCue_lRec."Institute Code" := UserSetup_lRec."Global Dimension 1 Code";
        RolecenterGraduateAffairsCue_lRec.Modify();
        if UserSetup_lRec."Global Dimension 1 Code" <> '' then
            if Strlen(UserSetup_lRec."Global Dimension 1 Code") < 6 then
                Rec.SetFilter("Institute Code", '%1', Format(UserSetup_lRec."Global Dimension 1 Code"));

        MSPE_lRec.Reset();
        MSPE_lRec.SetRange("Processing Status", MSPE_lRec."Processing Status"::Pending);
        if MSPE_lRec.FindSet() then
            Rec."MSPE Applications" := MSPE_lRec.Count();
        Rec.Modify();

        MSPE_lRec.Reset();
        MSPE_lRec.SetRange("Processing Status", MSPE_lRec."Processing Status"::Completed);
        if MSPE_lRec.FindSet() then
            Rec."Completed MSPE Apps" := MSPE_lRec.Count();

        MSPE_lRec.Reset();
        MSPE_lRec.SetRange("Processing Status", MSPE_lRec."Processing Status"::"In-Review");
        if MSPE_lRec.FindSet() then
            Rec."In-Review MSPE Apps" := MSPE_lRec.Count();

        MSPE_lRec.Reset();
        MSPE_lRec.SetRange("Processing Status", MSPE_lRec."Processing Status"::"Review Required");
        if MSPE_lRec.FindSet() then
            Rec."Review Req MSPE Apps" := MSPE_lRec.Count();

        StudentResidencyStatusList_lRrec.Reset();
        StudentResidencyStatusList_lRrec.SetRange("Residency Status", 'MATCHED');
        if StudentResidencyStatusList_lRrec.FindSet() then
            Rec."Total Matched Students" := StudentResidencyStatusList_lRrec.Count();


        Rec.Modify();
    end;

}