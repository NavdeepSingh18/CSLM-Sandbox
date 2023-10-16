page 50141 "Sch. (Placement) Card-CS"
{
    // version V.001-CS

    // Sr.No  Emp.ID      Date      Trigger                           Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  08-06-19   Schedule No. - OnAssistEdit()    Code added to generate No.Series.

    PageType = Card;
    UsageCategory = none;
    // ApplicationArea = All;
    SourceTable = "Stud Placement Schedule-CS";
    Caption = 'Sch. (Placement) Card';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Schedule No."; Rec."Schedule No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        //Code added to generate No.Series::CSPL-00174::080619: Start
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                        //Code added to generate No.Series::CSPL-00174::080619: End
                    end;
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
                field("From Time"; Rec."From Time")
                {
                    ApplicationArea = All;
                }
                field("To Time"; Rec."To Time")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Job description"; Rec."Job description")
                {
                    ApplicationArea = All;
                }
                field("Salary Package"; Rec."Salary Package")
                {
                    ApplicationArea = All;
                }
                field(Eligibilty; Rec.Eligibilty)
                {
                    ApplicationArea = All;
                }
                field("Date Of Drive"; Rec."Date Of Drive")
                {
                    ApplicationArea = All;
                }
                field("Date of Registration"; Rec."Date of Registration")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field(Link; Rec.Link)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Bond; Rec.Bond)
                {
                    ApplicationArea = All;
                }
                field("Job Location"; Rec."Job Location")
                {
                    ApplicationArea = All;
                }
                field("No of openings"; Rec."No of openings")
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

