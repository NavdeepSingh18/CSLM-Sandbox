xmlport 50050 "Import SectionCS"
{
    // version V.001-CS

    Caption = 'Import Bank Payment Voucher';
    Direction = Both;
    FieldDelimiter = '"';
    FieldSeparator = ',';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("Section Master-CS"; "Section Master-CS")
            {
                XmlName = 'Section';
                fieldelement(SectionCode; "Section Master-CS".Code)
                {
                }
                fieldelement(Descrpition; "Section Master-CS".Description)
                {
                }
                fieldelement(InstituteCode; "Section Master-CS"."Global Dimension 1 Code")
                {
                }
                fieldelement(DeptId; "Section Master-CS"."Global Dimension 2 Code")
                {
                }
                fieldelement(Group; "Section Master-CS".Group)
                {
                }
                fieldelement(SequenceNo; "Section Master-CS"."Sequence No")
                {
                }
                fieldelement(Updated; "Section Master-CS".Updated)
                {
                }
                fieldelement(TimeTable; "Section Master-CS"."Time Table Generated")
                {
                }
                fieldelement(TemplateNo; "Section Master-CS"."Template No.")
                {
                }
                fieldelement(UserId; "Section Master-CS"."User ID")
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
        MESSAGE('Uploaded')
    end;

    var

        DocNO: Code[20];

    procedure GetDocNo(NO: Code[20])
    begin
        DocNO := NO;
    end;
}

