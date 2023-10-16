page 50110 PendingHousingApplicationList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Housing Application";
    //CardPageId = "Housing Application Card";
    Caption = 'Current & Upcoming Housing Comparison';
    SourceTableView = sorting("Application Date") order(descending);
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;

                }
                Field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                Field("Student Status"; Rec."Student Status")
                {
                    ApplicationArea = All;
                }
                Field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                }
                Field("Course Name"; Rec."Course Name")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;
                }
                field(HousingName; HousingName)
                {
                    ApplicationArea = All;
                    Caption = 'Current Housing Name';
                }

                field("Room No."; Rec."Room No.")
                {
                    ApplicationArea = All;
                    Caption = 'Current Apartment No.';
                }
                field("Temporary Housing Name"; Rec."Temporary Housing Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'Strong';

                }
                Field("Temporary Apartment No."; Rec."Temporary Apartment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'Strong';

                }
                Field("Temporary Room No."; Rec."Temporary Room No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = 'Strong';

                }
                field("Housing Pref. 1 Name"; Rec."Housing Pref. 1 Name")
                {
                    ApplicationArea = All;
                }
                field("Housing Group Pref.1"; Rec."Housing Group Pref.1")
                {
                    ApplicationArea = All;
                }
                field("Room Category Pref.1"; Rec."Room Category Pref.1")
                {
                    ApplicationArea = All;
                }
                field("Pref. 1 Selected"; Rec."Pref. 1 Selected")
                {
                    ApplicationArea = All;
                }
                Field("Housing Pref. 2"; Rec."Housing Pref. 2")
                {
                    ApplicationArea = All;
                }
                Field("Housing Pref. 2 Name"; Rec."Housing Pref. 2 Name")
                {
                    ApplicationArea = All;
                }
                Field("Housing Group Pref.2"; Rec."Housing Group Pref.2")
                {
                    ApplicationArea = All;
                }
                Field("Room Category Pref.2"; Rec."Room Category Pref.2")
                {
                    ApplicationArea = All;
                }

                field("Pref. 2 Selected"; Rec."Pref. 2 Selected")
                {
                    ApplicationArea = All;
                }
                Field("Housing Pref. 3"; Rec."Housing Pref. 3")
                {
                    ApplicationArea = All;
                }
                Field("Housing Pref. 3 Name"; Rec."Housing Pref. 3 Name")
                {
                    ApplicationArea = all;
                }
                Field("Housing Group Pref.3"; Rec."Housing Group Pref.3")
                {
                    ApplicationArea = All;
                }
                Field("Room Category Pref.3"; Rec."Room Category Pref.3")
                {
                    ApplicationArea = All;
                }
                field("Pref. 3 Selected"; Rec."Pref. 3 Selected")
                {
                    ApplicationArea = All;
                }
                Field("Flight Arrival Date"; Rec."Flight Arrival Date")
                {
                    ApplicationArea = all;
                }
                Field("Flight Arrival Time"; Rec."Flight Arrival Time")
                {
                    ApplicationArea = all;
                }
                Field("Flight Number"; Rec."Flight Number")

                {
                    ApplicationArea = all;
                }
                Field("Airline/Carrier"; Rec."Airline/Carrier")
                {
                    ApplicationArea = all;
                }
                Field("Departure Date from Antigua"; Rec."Departure Date from Antigua")
                {
                    ApplicationArea = all;
                }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            ACtion("Show Detail")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                Var
                    HousingApplication: Record "Housing Application";
                    HousingAppCard: Page "Housing Application Card";
                begin
                    Clear(HousingAppCard);
                    HousingApplication.Reset();
                    HousingApplication.SetRange("Application No.", Rec."Application No.");
                    HousingAppCard.SetTableView(HousingApplication);
                    HousingAppCard.CurrUpcomingPer(true);
                    HousingAppCard.Run();
                end;
            }
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            action("Housing Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Card';
                Runobject = page "Housing Master Card";
                RunPageLink = "Housing ID" = FIELD("Housing ID");
            }
            action("Housing Ledger")
            {
                ApplicationArea = All;
                Image = List;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Housing Ledger';
                Runobject = page "Housing Ledger";
                // RunPageLink = "Student No." = FIELD("Student No.");
            }
        }
    }

    var
        HousingMaster: Record "Housing Master";
        HousingName: Text;

    trigger OnOpenPage()
    begin
        HousingName := '';
        HousingMaster.Reset();
        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
        IF HousingMaster.FindFirst() then
            HousingName := HousingMaster."Housing Name";
    end;

    Trigger OnAfterGetRecord()
    begin
        HousingName := '';
        HousingMaster.Reset();
        HousingMaster.SetRange("Housing ID", Rec."Housing ID");
        IF HousingMaster.FindFirst() then
            HousingName := HousingMaster."Housing Name";
    end;



}