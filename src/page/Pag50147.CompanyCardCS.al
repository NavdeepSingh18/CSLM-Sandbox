page 50147 "Company Card-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  06-09-19   Company Code - OnAssistEdit()     Code added to generate No.Series.

    PageType = Card;
    UsageCategory = None;
    SourceTable = "Stud Placement Company-CS";
    Caption = 'Company Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        //Code added to generate No.Series::CSPL-00174::060919: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added to generate No.Series::CSPL-00174::060919: End
                    end;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Company Address"; Rec."Company Address")
                {
                    ApplicationArea = All;
                }
                field("Company Address1"; Rec."Company Address1")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Company Phone"; Rec."Company Phone")
                {
                    ApplicationArea = All;
                }
                field("Company Website"; Rec."Company Website")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("Contact person Designation"; Rec."Contact person Designation")
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

