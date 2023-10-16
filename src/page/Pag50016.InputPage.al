page 50016 "Input Data"
{
    //Caption = 'Enter NMI Authorization Password';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group(Control4)
            {
                ShowCaption = false;
                field(EmailAddressField; EmailAddress)
                {
                    ApplicationArea = Basic, Suite, Invoicing;
                    Caption = 'NMI Authorization Password';
                    ToolTip = 'Specifies the Password.';
                    ExtendedDatatype = Masked;
                    Visible = ResponseOpt = ResponseOpt::Password;

                }

                // field(FilePAth; FilePAth)
                // {
                //     ApplicationArea = Basic, Suite, Invoicing;
                //     Caption = 'Requested Folder Path';
                //     ToolTip = 'Specifies the Folder Path.';
                //     Visible = ResponseOpt = ResponseOpt::Transcript;

                // }
                Field("Academic Year"; AcadYear)
                {
                    ApplicationArea = Basic, Suite, Invoicing;
                    ToolTip = 'Specifies the Academic Year.';
                    Visible = ResponseOpt = ResponseOpt::Transcript;
                    TableRelation = "Academic Year Master-CS";
                }


            }
        }
    }

    var
        EmailAddress: Text[250];
        FilePAth: Text[250];
        AcadYear: Code[20];
        ResponseOpt: Option " ","Password","Transcript";

    Procedure GetPasswordInput(): Text[20]
    begin
        exit(EmailAddress);
    end;

    procedure GetRequestedPAth(): Text[250]
    begin

        exit(FilePAth);
    end;

    Procedure GetAcadYear(): Code[20]
    begin
        exit(AcadYear);
    end;

    Procedure SetInputValue(Response: Option " ","Password","Transcript")
    begin
        ResponseOpt := Response;
    end;


}
