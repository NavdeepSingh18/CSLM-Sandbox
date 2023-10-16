xmlport 50012 "EmployeeCS"
{
    // version V.001-CS

    FieldSeparator = ',';
    Format = VariableText;
    Caption = 'Employee';

    schema
    {
        textelement(Root)
        {
            tableelement("Employee"; "Employee")
            {
                AutoUpdate = true;
                XmlName = 'Student';
                fieldelement(a; Employee."No.")
                {
                }
                fieldelement(b; Employee."First Name")
                {
                }
                fieldelement(c; Employee.Initials)
                {
                }
                fieldelement(d; Employee."Search Name")
                {
                }
                fieldelement(e; Employee."Mobile Phone No.")
                {
                }
                fieldelement(f; Employee."E-Mail")
                {
                }
                fieldelement(g; Employee."Global Dimension 1 Code")
                {
                }
                fieldelement(h; Employee."Global Dimension 2 Code")
                {
                }
                fieldelement(i; Employee."Designation Code")
                {
                }
                fieldelement(j; Employee."Deparment Name")
                {
                }
                fieldelement(k; Employee."Employee Group")
                {
                }
                fieldelement(l; Employee."Web Portal Password")
                {
                }
                fieldelement(m; Employee."Web Portal Type")
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

        MESSAGE('Completed.');
    end;

    var
}

