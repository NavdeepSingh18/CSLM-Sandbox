page 50242 "Stud. Enquiry Card-CS"
{
    // version V.001-CS

    Caption = 'Stud. Enquiry Card';
    PageType = Card;
    SourceTable = "College Enquiry-CS";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Caption = 'Faculty Code';
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Caption = 'School Code';
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                }
                field(Months; Rec.Months)
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(Prequalification; Rec.Prequalification)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Name of the Previous Institute"; Rec."Name of the Previous Institute")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Medium of Instruction"; Rec."Medium of Instruction")
                {
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Address to"; Rec."Address to")
                {
                    ApplicationArea = All;
                }
                field(Addressee; Rec.Addressee)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Address 1"; Rec."Address 1")
                {
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field("Address 3"; Rec."Address 3")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }

                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ApplicationArea = All;
                }
                field("E-Mail Address"; Rec."E-Mail Address")
                {
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    ApplicationArea = All;
                }
                field("Mobile Number"; Rec."Mobile Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Follow Up Details")
            {
                Caption = '&Follow Up Details';
                action(FollowUp)
                {
                    Caption = 'Follow Up';
                    Image = AddWatch;
                    RunObject = Page "Event wise Update-CS";
                    ApplicationArea = All;
                }
            }
        }
    }

    var

}