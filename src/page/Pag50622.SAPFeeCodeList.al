page 50622 "SAP Fee Code List"
{

    PageType = List;
    SourceTable = "SAP Fee Code";
    Caption = 'SAP Fee Code List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SAP Code"; Rec."SAP Code")
                {
                    ApplicationArea = All;
                }
                field("SAP G/L Account"; Rec."SAP G/L Account")
                {
                    ApplicationArea = All;
                }
                field("SAP Assignment Code"; Rec."SAP Assignment Code")
                {
                    ApplicationArea = All;
                }
                field("SAP Description"; Rec."SAP Description")
                {
                    ApplicationArea = All;
                }
                field("SAP Cost Centre"; Rec."SAP Cost Centre")
                {
                    ApplicationArea = All;
                }
                field("SAP Profit Centre"; Rec."SAP Profit Centre")
                {
                    ApplicationArea = All;
                }
                field("SAP Company Code"; Rec."SAP Company Code")
                {
                    ApplicationArea = All;
                }
                field("SAP Bus. Area"; Rec."SAP Bus. Area")
                {
                    ApplicationArea = All;
                }
                field("Fee Group"; Rec."Fee Group")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
