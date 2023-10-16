page 50766 "Room Category Fee Setup API"
{
    PageType = API;
    DelayedInsert = true;
    EntityName = 'rcfsAPI';
    EntitySetName = 'rcfsAPI';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Caption = 'Apartment Category fee Setup API';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Room Category Fee Setup";
APIPublisher = 'rcfsAPI01';
    APIGroup = 'rcfsAPI';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(housingGroup; Rec."Housing Group")
                {
                    ApplicationArea = All;

                }
                field(housingGroupName; Rec."Housing Group Name")
                {
                    ApplicationArea = all;
                }


                field(housingID; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field(housingName; Rec."Housing Name")
                {
                    ApplicationArea = All;

                }
                field(roomCategoryCode; Rec."Room Category Code")
                {
                    ApplicationArea = All;

                }
                field(roomCategoryName; Rec."Room Category Name")
                {
                    ApplicationArea = All;

                }

                field(effectiveFrom; Rec."Effective From")
                {
                    ApplicationArea = All;

                }
                field(cosT; Rec.Cost)
                {
                    ApplicationArea = All;

                }

                field(withSpouseCost; Rec."With Spouse Cost")
                {
                    ApplicationArea = All;
                }
                field(offCampus; Rec."Off Campus")
                {
                    ApplicationArea = All;
                }
                field(roomCategoryAvailbility; Rec."Room Category Availbility")
                {
                    ApplicationArea = all;
                }
                field(departmentCode; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
            }
        }
    }
}