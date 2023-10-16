page 50602 "Rotation Offer List"
{
    PageType = List;
    Caption = 'Elective Rotation Offers';
    CardPageId = "Rotation Offer Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Rotation Offers";
    SourceTableView = where(Status = filter(" "));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field("Offer No."; Rec."Offer No.")
                {
                    ApplicationArea = All;
                }
                field("Elective Course Code"; Rec."Elective Course Code")
                {
                    ApplicationArea = All;
                }
                field("Course Description"; Rec."Course Description")
                {
                    ApplicationArea = All;
                }
                field("Course Prefix"; Rec."Course Prefix")
                {
                    ApplicationArea = All;
                }
                field("Rotation Description"; Rec."Rotation Description")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Weeks"; Rec."No. of Weeks")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Hospital ID"; Rec."Hospital ID")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}