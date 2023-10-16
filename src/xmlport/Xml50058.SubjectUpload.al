xmlport 50058 "Subject Upload"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Subject Master-CS"; "Subject Master-CS")
            {
                AutoUpdate = true;
                XmlName = 'Subject';
                fieldelement(Code; "Subject Master-CS".Code)
                {
                }
                fieldelement(Course; "Subject Master-CS".Course)
                {

                    trigger OnAfterAssignField()
                    begin
                        "Subject Master-CS".Course := FORMAT('0' + "Subject Master-CS".Course);
                    end;
                }
                fieldelement(Description; "Subject Master-CS".Description)
                {
                }
                fieldelement(ElectiveGroupCode; "Subject Master-CS"."Elective Group Code")
                {
                }
                fieldelement(Semester; "Subject Master-CS".Semester)
                {
                }
                fieldelement(Updated; "Subject Master-CS".Updated)
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
        MESSAGE('done');
    end;
}

