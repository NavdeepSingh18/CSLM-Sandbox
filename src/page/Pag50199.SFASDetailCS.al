page 50199 "SFAS Detail-CS"
{
    // version V.001-CS

    PageType = ListPart;
    SourceTable = "Ledger SFAS-CS";

    layout
    {
        area(content)
        {

            repeater(Group)
            {

                field("Roll No."; Rec."Roll No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Class Code"; Rec."Class Code")
                {
                    ApplicationArea = All;
                }
                field(InstID; Rec.InstID)
                {
                    ApplicationArea = All;
                }
                field("Batch Code"; Rec."Batch Code")
                {
                    ApplicationArea = All;
                }
                field("Inst ID"; Rec."Inst ID")
                {
                    ApplicationArea = All;
                }
                field(CatgCode; Rec.CatgCode)
                {
                    ApplicationArea = All;
                }
                field(Rsdl; Rec.Rsdl)
                {
                    ApplicationArea = All;
                }
                field("Journal ID"; Rec."Journal ID")
                {
                    ApplicationArea = All;
                }
                field("Journal Line"; Rec."Journal Line")
                {
                    ApplicationArea = All;
                }
                field("Journal Date"; Rec."Journal Date")
                {
                    ApplicationArea = All;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                }
                field(DebitCredit; Rec.DebitCredit)
                {
                    ApplicationArea = All;
                }
                field("Amount Dollar"; Rec."Amount Dollar")
                {
                    ApplicationArea = All;
                }
                field("Amount Rs"; Rec."Amount Rs")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

