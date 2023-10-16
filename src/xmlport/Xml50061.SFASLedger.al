xmlport 50061 "SFAS Ledger"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Ledger SFAS-CS"; "Ledger SFAS-CS")
            {
                AutoUpdate = true;
                XmlName = 'SFASLedger';
                fieldelement(EntryNo; "Ledger SFAS-CS"."Entry No.")
                {
                }
                fieldelement(RollNo; "Ledger SFAS-CS"."Roll No.")
                {
                }
                fieldelement(Name; "Ledger SFAS-CS".Name)
                {
                }
                fieldelement(ClassCode; "Ledger SFAS-CS"."Class Code")
                {
                }
                fieldelement(Instid; "Ledger SFAS-CS".InstID)
                {
                }
                fieldelement(Instid2; "Ledger SFAS-CS"."Inst ID")
                {
                }
                fieldelement(Catagory; "Ledger SFAS-CS".CatgCode)
                {
                }
                fieldelement(Rsdl; "Ledger SFAS-CS".Rsdl)
                {
                }
                fieldelement(JournalID; "Ledger SFAS-CS"."Journal ID")
                {
                }
                fieldelement(jOURNALDate; "Ledger SFAS-CS"."Journal Date")
                {
                }
                fieldelement(Narration; "Ledger SFAS-CS".Narration)
                {
                }
                fieldelement(DebitCredit; "Ledger SFAS-CS".DebitCredit)
                {
                }
                fieldelement(Dollar; "Ledger SFAS-CS"."Amount Dollar")
                {
                }
                fieldelement(AmountRs; "Ledger SFAS-CS"."Amount Rs")
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE('Done');
    end;
}

