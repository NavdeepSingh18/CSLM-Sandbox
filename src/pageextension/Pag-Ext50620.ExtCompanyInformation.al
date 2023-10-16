pageextension 50620 ExtCompanyInformation extends "Company Information"
{
    layout
    {
        addafter(Picture)
        {

            field("AUA Basic Science Img"; Rec."AUA Basic Science Img")
            {
                ApplicationArea = All;
            }
            field("AUA Image"; Rec."AUA Image")
            {
                ApplicationArea = All;
            }
            field("AICASA Image"; Rec."AICASA Image")
            {
                ApplicationArea = All;
            }
            field("Director Signature"; Rec."Director Signature")
            {
                ApplicationArea = All;
            }


        }
        addafter(Communication)
        {
            group(API)
            {
                field("Portal Api URL"; Rec."Portal Api URL")
                {
                    ToolTip = 'Portal Api URL';
                    ApplicationArea = all;
                }

                field("Portal Sync Enabled"; Rec."Portal Sync Enabled")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Portal Student Update Api URL"; Rec."Portal Student Update Api URL")
                {
                    ApplicationArea = all;
                }
                field("Portal Student Image Api URL"; Rec."Portal Student Image Api URL")
                {
                    ApplicationArea = all;
                }
                field("Salesforce API Base URL"; Rec."Salesforce API Base URL")
                {
                    ApplicationArea = all;
                }
                field("Salesforce Sync Enabled"; Rec."Salesforce Sync Enabled")
                {
                    ApplicationArea = all;
                }
                field("Salesforce Token URL"; Rec."Salesforce Token URL")
                {
                    ApplicationArea = all;
                }

                field("Salesforce Client Id"; Rec."Salesforce Client Id")
                {
                    ApplicationArea = all;
                }

                field("Salesforce Client Secret"; Rec."Salesforce Client Secret")
                {
                    ApplicationArea = all;
                }
                field("Send Email On/Off"; Rec."Send Email On/Off")
                {
                    ApplicationArea = all;
                }
                field("Salesforce Access Token"; Rec."Salesforce Access Token")
                {
                    ApplicationArea = all;
                    Editable = false;
                    MultiLine = true;
                    //SALESFORCE
                }
                field("SchoolDocs Documents Open Url"; Rec."SchoolDocs Documents Open Url")
                {
                    ApplicationArea = All;
                }
                field("SchoolDocs Download Url"; Rec."SchoolDocs Download Url")
                {
                    ApplicationArea = All;
                }
                field("Student Regis. Sync Enable"; Rec."Student Regis. Sync Enable")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        addafter("No. Series")
        {
            action("Get Salesforce Token")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    SalesforceInte: Codeunit "SalesForce Integration";
                begin
                    SalesforceInte.GetSalesforceToken(Rec."Salesforce Access Token");
                end;
            }
        }
    }
}