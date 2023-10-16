page 50865 "DME and Preceptor Update"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Roster Scheduling Header";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                group("Rotation Details")
                {
                    field("Rotation ID"; Rec."Rotation ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        Style = Strong;
                        ShowMandatory = true;
                    }
                    field("Clerkship Type"; Rec."Clerkship Type")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Course Code"; Rec."Course Code")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Elective Course Code"; Rec."Elective Course Code")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        Editable = false;
                    }
                    field("Rotation Description"; Rec."Rotation Description")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                    field("Hospital ID"; Rec."Hospital ID")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                        ShowMandatory = true;
                        LookupPageId = "Hospital Inventory Lookup";
                    }
                    field("Hospital Name"; Rec."Hospital Name")
                    {
                        ApplicationArea = All;
                        Style = Strong;
                        Editable = false;
                    }
                }
                group("DME Details")
                {
                    field("DME Contact No."; Rec."DME Contact No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("DME Name"; Rec."DME Name")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("DME Phone No."; Rec."DME Phone No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("DME Recipient"; Rec."DME Recipient")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                }
                group("Preceptor Details")
                {
                    field("Preceptor Contact No."; Rec."Preceptor Contact No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("Preceptor Name"; Rec."Preceptor Name")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("Preceptor Phone No."; Rec."Preceptor Phone No.")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                    field("Preceptor Recipient"; Rec."Preceptor Recipient")
                    {
                        ApplicationArea = All;
                        Style = Unfavorable;
                    }
                }
            }
        }
    }
}