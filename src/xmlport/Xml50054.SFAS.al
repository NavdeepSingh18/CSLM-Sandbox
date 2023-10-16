xmlport 50054 "SFAS"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Ledger SFAS-CS"; "Ledger SFAS-CS")
            {
                XmlName = 'SFAS';
                fieldelement("ApplicationNo."; "Ledger SFAS-CS"."Roll No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(FirstName; "Ledger SFAS-CS".Name)
                {
                }
                fieldelement(MiddleName; "Ledger SFAS-CS"."Class Code")
                {
                }
                fieldelement(LastName; "Ledger SFAS-CS".InstID)
                {
                }
                fieldelement(Semester; "Ledger SFAS-CS"."Batch Code")
                {
                }
                fieldelement(AcademicYear; "Ledger SFAS-CS"."Inst ID")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DOB; "Ledger SFAS-CS".CatgCode)
                {
                }
                fieldelement(Gender; "Ledger SFAS-CS".Rsdl)
                {
                }
                fieldelement(CategoryofAdmission; "Ledger SFAS-CS"."Journal ID")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EntranceTestRank; "Ledger SFAS-CS"."Journal Line")
                {
                }
                fieldelement(CourseCode; "Ledger SFAS-CS"."Journal Date")
                {
                }
                fieldelement(Category; "Ledger SFAS-CS".Narration)
                {
                }
                fieldelement(Mobileno; "Ledger SFAS-CS".DebitCredit)
                {
                }
                fieldelement(Email; "Ledger SFAS-CS"."Amount Dollar")
                {
                }
                fieldelement(Group; "Ledger SFAS-CS"."Amount Rs")
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

    var

}

