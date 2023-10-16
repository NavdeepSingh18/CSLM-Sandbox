xmlport 50060 "Subject Wise  Batch & Lab"
{
    // version V.001-CS

    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Batch&Lab Subject Wise-CS"; "Batch&Lab Subject Wise-CS")
            {
                XmlName = 'SubjectwiseBatchLab';
                fieldelement(SubjectCode; "Batch&Lab Subject Wise-CS"."Subject Code")
                {
                }
                fieldelement(Description; "Batch&Lab Subject Wise-CS".Description)
                {
                }
                fieldelement(Batch; "Batch&Lab Subject Wise-CS".Batch)
                {
                }
                fieldelement(NumberofLab; "Batch&Lab Subject Wise-CS"."Number of Lab")
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

