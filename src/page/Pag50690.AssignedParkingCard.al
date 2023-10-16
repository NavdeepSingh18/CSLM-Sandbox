page 50690 "Assigned Housing Parking"
{

    PageType = Card;
    SourceTable = "Housing Parking Details";
    Caption = 'Assigned Parking Sticker Assignment Card';
    UsageCategory = None;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            Group(General)
            {
                field("Parking Application No."; Rec."Parking Application No.")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; Rec."Application Date")
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
                field("Enrolment No."; Rec."Enrolment No.")
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
                field("Approved In Days"; Rec."Approved In Days")
                {
                    ApplicationArea = All;
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Number"; Rec."Vehicle Number")
                {
                    ApplicationArea = All;
                }
                field("Name of Vehicle Owner"; Rec."Name of Vehicle Owner")
                {
                    ApplicationArea = All;
                }
                field("Number of Vehicle Owner"; Rec."Number of Vehicle Owner")
                {
                    ApplicationArea = All;
                }
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ApplicationArea = All;
                }
                field("License Expiration Date"; Rec."License Expiration Date")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field(Colour; Rec.Colour)
                {
                    ApplicationArea = All;
                }
                Field("Sticker Assigned Date"; Rec."Sticker Assigned Date")
                {
                    ApplicationArea = All;
                }
                field("Sticker Number"; Rec."Sticker Number")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Issued From"; Rec."Issued From")
                {
                    ApplicationArea = All;
                }
                field("Issued Upto"; Rec."Issued Upto")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                Field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

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
        }
    }

}