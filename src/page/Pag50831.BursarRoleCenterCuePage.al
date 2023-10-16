page 50831 BursarRoleCenterCuepage
{
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = RoleCenterCueBursar;
    Caption = 'Role Center';

    layout
    {
        area(Content)
        {
            cuegroup("Bursar Cue")
            {
                field("Pndg Payment Plan Apps"; Rec."Pndg Payment Plan Apps")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pending Payment Plan List";
                }

                field("Pendg Fin. Accountability List"; Rec."Pendg Fin. Accountability List")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Pending Financial Account";//50538
                }
                field("Pending Financial Aid Roster"; Rec."Pending Financial Aid Roster")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Pending Financial Aid Roster";
                }
                field("Pending Withwal Approval List"; Rec."Pending Withwal Approval List")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Pending Withdrawal Approvals";
                }
                field("Pending Wire Transfer List"; Rec."Pending Wire Transfer List")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Details List-RTGS-CS";
                }
                field("Pending Financial Aid Application"; Rec."Pending Financial Aid App")
                {
                    ApplicationArea = basic, suite;
                    DrillDownPageId = "Financial AID Pending List";
                }
            }

        }
    }
    trigger OnOpenPage();
    begin
        Rec.RESET();
        if not Rec.get() then begin
            Rec.INIT();
            Rec.INSERT();
        end;
    end;
}