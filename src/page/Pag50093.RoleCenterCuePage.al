page 50093 RoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "RoleCenterEduCueTable";
    Caption = 'Role Center';

    layout
    {
        area(Content)
        {
            cuegroup("Academic Cue")
            {
                field("Active Student"; Rec."Active Student")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Student List On Roll-CS";

                }

                field("Total Course"; Rec."Total Course")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Course Detail-CS";

                }
            }
            cuegroup("Housing Cue")
            {
                field("Total Housing"; Rec."Total Housing")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Housing Master List";
                }
                field("Total Room"; Rec."Total Room")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Room Master List";
                    Caption = 'Total Apartment';

                }
                field("Total Bed"; Rec."Total Bed")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Room Wise Bed List";
                    Caption = 'Total Room';

                }
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


    end;
}