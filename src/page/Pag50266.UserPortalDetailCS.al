page 50266 "User Portal Detail-CS"
{
    // version V.001-CS

    Caption = 'User Portal Detail-CS';
    PageType = ListPart;
    SourceTable = "Portal User Login-CS";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Login ID"; Rec."Login ID")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                }
                field("User Group"; Rec."User Group")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Student ID"; Rec.U_ID)
                {
                    ApplicationArea = All;
                }
                field(Role_Code; Rec.Role_Code)
                {
                    ApplicationArea = All;
                }
                field(WindowsAuthentication; Rec.WindowsAuthentication)
                {
                    ApplicationArea = All;
                }
                field(IsAdmin; Rec.IsAdmin)
                {
                    ApplicationArea = All;
                }
                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                }
                field(MobileNo; Rec.MobileNo)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field(Image_Path; Rec.Image_Path)
                {
                    ApplicationArea = All;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                }
                field(FileName; Rec.FileName)
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

