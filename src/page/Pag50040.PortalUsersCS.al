page 50040 "Portal Users-CS"
{
    // version V.001-CS

    CardPageID = "Portal User Card-CS";
    Editable = false;
    Caption = 'Portal Users List';
    ModifyAllowed = false;

    PageType = List;
    UsageCategory = Administration;
    ApplicationArea = All;
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
                field(U_ID; Rec.U_ID)
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }
                field("Updated By"; Rec."Updated By")
                {
                    ApplicationArea = All;
                }
                field("Updated On"; Rec."Updated On")
                {
                    ApplicationArea = All;
                }
                field("Updated By Name"; Rec."Updated By Name")
                {
                    ApplicationArea = All;
                }
                field("Created By Name"; Rec."Created By Name")
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
                field("Shadow Login"; Rec."Shadow Login")
                {
                    ApplicationArea = All;
                }
                field(SU_ID; Rec.SU_ID)
                {
                    ApplicationArea = All;
                }
                field("Password Changed"; Rec."Password Changed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}

