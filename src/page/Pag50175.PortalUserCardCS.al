page 50175 "Portal User Card-CS"
{
    // version V.001-CS

    // Sr.No  Emp.Id     Date      Trigger                  Remarks
    // -----------------------------------------------------------------------------------------------
    // 01.   CSPL-00174  07-05-19   Role_Code - OnLookup()   Code Added for Page Run and get Role_Code.

    PageType = Card;
    UsageCategory = None;
    SourceTable = "Portal User Login-CS";
    Caption = 'Portal User Card';

    layout
    {
        area(content)
        {
            group(General)
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
                field(Role_Code; Rec.Role_Code)
                {

                    ApplicationArea = All;
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        //Code added for page run & get value of Rol_Code::CSPL-00174::070519: Start
                        InstituteRoleCS.RESET();
                        InstituteRoleCS.FINDSET();
                        IF PAGE.RUNMODAL(50137, InstituteRoleCS) = ACTION::LookupOK THEN
                            Rec.Role_Code := InstituteRoleCS."Role Code";
                        //Code added for page run & get value of Rol_Code::CSPL-00174::070519: End
                    end;
                }
                field(WindowsAuthentication; Rec.WindowsAuthentication)
                {
                    ApplicationArea = All;
                }
                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Password Changed"; Rec."Password Changed")
                {
                    ApplicationArea = All;
                }
                field(MobileNo; Rec.MobileNo)
                {
                    ApplicationArea = All;
                }
                field(Updated; Rec.Updated)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        InstituteRoleCS: Record "Institute Role-CS";
}

