page 50461 "Student Room Wise Inventory"
{
    Caption = 'Student Apartment Wise Inventory';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Student Room Wise Inventory";

    layout
    {
        area(Content)
        {
            repeater(group)
            {
                field("Housing ID"; Rec."Housing ID")
                {
                    ApplicationArea = All;

                }
                field("Room No."; Rec."Room No.")
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
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;

                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                }

                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;

                }
                Field("Inventory Category"; Rec."Inventory Category")
                {
                    ApplicationArea = All;
                }
                field("Quantity Allotted"; Rec."Quantity Allotted")
                {
                    ApplicationArea = All;

                }
                field("Quantity Verified Alloment"; Rec."Quantity Verified Alloment")
                {
                    ApplicationArea = All;

                }
                field("Quantity Verified Vacate"; Rec."Quantity Verified Vacate")
                {
                    ApplicationArea = All;

                }
                field("Verified Alloment Date"; Rec."Verified Alloment Date")
                {
                    ApplicationArea = All;

                }
                field("Verified Vacate Date"; Rec."Verified Vacate Date")
                {
                    ApplicationArea = All;

                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Select All")
            {
                ApplicationArea = All;
                trigger OnAction()

                begin
                    IF CONFIRM('Do you want to select all "Quantity Verified Vacate" ', FALSE) THEN BEGIN
                        RecStuRoomWiseInventory.Reset();
                        RecStuRoomWiseInventory.SetRange("Student No.", Rec."Student No.");
                        RecStuRoomWiseInventory.SetRange("Application No.", Rec."Application No.");
                        RecStuRoomWiseInventory.SetRange("Quantity Verified Vacate", False);
                        IF RecStuRoomWiseInventory.FindSet() then begin
                            repeat
                                RecStuRoomWiseInventory.Validate("Quantity Verified Vacate", true);
                                RecStuRoomWiseInventory.Modify()
                            until RecStuRoomWiseInventory.Next() = 0;

                        end;

                    end;
                end;

            }
            action("&UnSelect")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you want to Unselect all "Quantity Verified Vacate" ', FALSE) THEN BEGIN
                        RecStuRoomWiseInventory.Reset();
                        RecStuRoomWiseInventory.SetRange("Student No.", Rec."Student No.");
                        RecStuRoomWiseInventory.SetRange("Application No.", Rec."Application No.");
                        RecStuRoomWiseInventory.SetRange("Quantity Verified Vacate", True);
                        IF RecStuRoomWiseInventory.FindSet() then begin
                            repeat
                                RecStuRoomWiseInventory.Validate("Quantity Verified Vacate", false);
                                RecStuRoomWiseInventory.Modify()
                        until RecStuRoomWiseInventory.Next() = 0;

                        end;

                    end;
                end;

            }

            action("Mail for Inventory Issue Resolution")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                begin
                    RecStuRoomWiseInventory.Reset();
                    RecStuRoomWiseInventory.SetRange("Application No.", Rec."Application No.");
                    RecStuRoomWiseInventory.SetFilter(RecStuRoomWiseInventory."Quantity Verified Alloment", '%1', false);
                    if RecStuRoomWiseInventory.FindFirst() then begin
                        // AvailabilityofMissingInventoryMail(Rec.Application No.");
                        Message('Notification for inventory sent to student.');
                    end else
                        Error('There is no inventory is missing or not verified');

                end;
            }
            action("&Create Financial Accountability")
            {
                ApplicationArea = All;
                Caption = '&Financial Accountability';
                Image = Create;
                PromotedCategory = Process;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                //      RunObject = Page "Financial Accountability List";
                //     RunPageLink = "Student No." = FIELD("Student No.");
                // trigger OnAction()
                // begin
                //     

                //     IF CONFIRM(Text001Lbl, FALSE, "Application No.") THEN BEGIN
                //         CreateFinancialAccountabilty("Student No.");
                //     END ELSE
                //         exit;
                // end;
                trigger OnAction()
                Var
                    FinancialAccountabilityRec: Record "Financial Accountability";
                    FinancialAccountabilityListPag: Page "Financial Accountability List";

                begin
                    RecStuRoomWiseInventory.Reset();
                    RecStuRoomWiseInventory.SetRange("Application No.", Rec."Application No.");
                    RecStuRoomWiseInventory.SetFilter(RecStuRoomWiseInventory."Quantity Verified Vacate", '%1', false);
                    if not RecStuRoomWiseInventory.FindFirst() then
                        Error('There is no missing or not verified inventory');

                    FinancialAccountabilityRec.Reset();
                    FinancialAccountabilityRec.SetRange("Student No.", Rec."Student No.");
                    FinancialAccountabilityListPag.SetTableView(FinancialAccountabilityRec);
                    FinancialAccountabilityListPag.Editable := False;
                    FinancialAccountabilityListPag.Run();
                END;
            }
            action("&Mail for Damage Clearance")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                Var
                    RecHousingChange: Record "Housing Change Request";
                begin
                    IF CONFIRM('Do you want to Send the Mail ?', FALSE) THEN BEGIN
                        RecHousingChange.reset();
                        RecHousingChange.SetRange("Original Application No.", Rec."Application No.");
                        RecHousingChange.SetFilter(Type, '%1', RecHousingChange.Type::Vacate);
                        IF RecHousingChange.FindFirst() then begin
                            RecStuRoomWiseInventory.Reset();
                            RecStuRoomWiseInventory.SetRange("Application No.", Rec."Application No.");
                            RecStuRoomWiseInventory.SetRange("Quantity Verified Vacate", false);
                            IF RecStuRoomWiseInventory.FindFirst() then begin
                                // VacateRequestRejectedInspectionCheck(Rec."Application No.");
                                Message('E-mail Sent');
                            end;
                        end;
                        RecHousingChange.reset();
                        RecHousingChange.SetRange("Original Application No.", Rec."Application No.");
                        RecHousingChange.SetFilter(Type, '%1', RecHousingChange.Type::"Change Request");
                        IF RecHousingChange.FindFirst() then begin
                            RecStuRoomWiseInventory.Reset();
                            RecStuRoomWiseInventory.SetRange("Application No.", Rec."Application No.");
                            RecStuRoomWiseInventory.SetRange("Quantity Verified Vacate", false);
                            IF RecStuRoomWiseInventory.FindFirst() then begin
                                // ChangeRequestRejectedInspectionCheck(Rec."Application No.");
                                Message('E-mail Sent');
                            end;
                        end;
                        // StudentInventoryVarifyMail(RecStuRoomWiseInventory."Application No.");
                    end;
                end;

            }
        }

    }

    // procedure VacateRequestRejectedInspectionCheck(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(Rec."Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Vacate Request Rejected after the Inspection check';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Application Number: ' + ApplicationNo);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that your Apartment vacate request has been rejected after the Inspection');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('check done by the Residential Services Team. It had been rejected due to:');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Financial Accountability Category: ');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Charges applicable are: ');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Attached the invoice for same. Kindly contact the Bursar department to clear the dues.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Vacate', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Vacate', 'Housing Vacate', "Room No.", Format("Created On", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure ChangeRequestRejectedInspectionCheck(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Change Request Rejected after the Inspection check';
    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."First Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Application Number: ' + ApplicationNo);
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('We would like to inform you that your old Apartment was not found in the manner handed to you by the');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Residential Services Team. Hence you would be charged on it, as it was not bought to our notice at');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('the time of Apartment change. It had been rejected due to :');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Financial Accountability Category : ');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Charges applicable are: ');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Attached the invoice for same. Kindly contact the Bursar department to clear the dues.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Change', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Change', 'Housing Change', "Room No.", Format("Created On", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure StudentInventoryVarifyMail(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     RecHousingMaster: Record "Housing Master";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin

    //     SmtpMailRec.Get();
    //     RecHousingMaster.Get("Housing ID");
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";

    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := 'Damage Inventory Clearance';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Name as on Certificate");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For Housing ' + RecHousingMaster."Housing Name" + ' and Apartment No. ' + "Room No." + ', please verify the Apartment inventory.');
    //     SmtpMail.AppendtoBody('<br>');
    //     SmtpMail.AppendtoBody('Thankyou');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('This is system generated mail. Please do not reply on this E-Mail ID.');
    //     SmtpMail.AppendtoBody('<br>');
    //     //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Inventory', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Inventory', 'Housing Inventory', "Room No.", Format("Created On", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure AvailabilityofMissingInventoryMail(ApplicationNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     RecHousingMaster: Record "Housing Master";
    //     UserSetupRec: Record "User Setup";
    //     CompanyInformationRec: Record "Company Information";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     CompanyInformationRec.Get();
    //     UserSetupRec.Get(UserId());
    //     RecHousingMaster.Get("Housing ID");
    //     Studentmaster.GET("Student No.");
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";

    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := ApplicationNo + ' ' + 'Housing Inventory Approval Update';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please be advised that your issue regarding Housing Inventory Alloment for Housing Application No.' + ' ' + ApplicationNo + ' ' + 'has been resolved.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Please acknowledge the remaining Inventory in your SLcM student portal.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For any clarifications, you may contact Residential Services team at' + ' ' + UserSetupRec."E-Mail" + ' ' + 'or on' + ' ' + UserSetupRec."Phone No.");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards,');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Residential Services Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     // SmtpMail.AppendtoBody('<br>');
    //     // //SmtpMail.AppendtoBody('THIS IS A TEST EMAIL FOR NEW SOFTWARE SYSTEM. PLEASE DISREGARD');
    //     BodyText := SmtpMail.GetBody();
    //     IF CompanyInformationRec."Send Email On/Off" then
    //         Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('Housing Inventory', 'MEA', SenderAddress, Format("Student Name"),
    //     "Student No.", Subject, BodyText, 'Housing Inventory', 'Housing Inventory', "Room No.", Format("Created On", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    var
        RecStuRoomWiseInventory: Record "Student Room Wise Inventory";
        // WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
        BodyText: text[2048];
    //   Text001Lbl: Label 'Do you want to Create Financial Accountabilty for Application No. %1?';



}